Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49796C282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128DB20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548877786;
	bh=jt5EqLxLDRkblvBxX981tGRhwPBdHsZhHw2lzsx4a1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O79HAH88+1+TkBAD+0RH82u0+ywP2+Esnb5SJd4c56ta0VSX1P/wf3WN9EEkWDn3R
	 RHT/dIoNeIh99Wi1nRwBUcrc6tQnOdkaYFFHGi7gat0foBbx41kKqGLotumoxKNJ29
	 nNEV7iP9+uF0zZz3BojlKnGeel1j8qj5Ba0qUbUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbfA3Tto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:49:44 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43997 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfA3Tto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:49:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so668765otr.10;
        Wed, 30 Jan 2019 11:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OvardPA1uBvO82uMchFXr5jTvrFamqjB5tZrxQ4qH+o=;
        b=ti0A51TZsCcd5R8sO4tnS0ZjLsKBw4cs5L4VhS3vZVkWmvEWGiScFkEmjDS5Phff4n
         +tKTleaiL3Lje9o5xxi7dh4z2AIGd7NfxhKhC06edwG7/KIkZZ2eqJut8h1EQFMS05xX
         IplKkoJ02hjX/va2bAeP4tqfEPYZrtVnz7dUHHXNJ0VJy0IAMdZYRDjT0MJAtUJtaNtj
         x/oW4TRSA8/zwCj1wbAYqgWthecz7hLo5byas0JMRL3bINan2oolVfDjxuJYvqrlYFFa
         VJ/0qyD9OgV1zkjBqyLS1+Kt/7c6/wfM6LTq7rNeOVLrsR2etJ4015ohRaWUTFwI1t3Z
         9U9Q==
X-Gm-Message-State: AJcUukcCTTPcohUwuZahVVsEeFkJptKY6x/ga/Nu3ECY5zJ9uO5S9zYt
        yYjLRckX1NXoZvOTotbr0w==
X-Google-Smtp-Source: ALg8bN49//Hsgm0n//ZYZ1UVNyKQkT3EtuqgTComqJoiYvXrZ4h40CPNmDJk28x3ekod6KQre6SjeQ==
X-Received: by 2002:a9d:ac8:: with SMTP id 66mr25212420otq.315.1548877783670;
        Wed, 30 Jan 2019 11:49:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w5sm1001046oif.48.2019.01.30.11.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:49:42 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:49:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Randolph =?iso-8859-1?Q?Maa=DFen?= <gaireg@gaireg.de>
Cc:     gaireg@gaireg.de, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: add icm20602 bindings to
 mpu6050
Message-ID: <20190130194942.GA30767@bogus>
References: <20190128185010.8275-1-gaireg@gaireg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128185010.8275-1-gaireg@gaireg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 19:50:02 +0100, =?UTF-8?q?Randolph=20Maa=C3=9Fen?= wrote:
> Adding the invensense ICM-20602 to the compatible list of the mpu6050
> driver
> 
> Signed-off-by: Randolph Maaﬂen <gaireg@gaireg.de>
> 
> ---
> Changes in v2:
> - write i2c disable register using reg_set instead of define
> - decide to write to i2c disable register based on reg_set instead of
>   chip type
> ---
>  Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
