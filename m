Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB565C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE86218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220866;
	bh=x8kid+CprA8Cm2noFMD7SV8E6AirguAZDJJXINX6xG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wllBmYIsrjYdY0Pf6yD8jceMnucvexyKzWoWYfLqoiHdShYCbZZGaPOrHfFJq2xWL
	 PUKbX6cTWFesVYQUZkaCYDpWNn3nCO5KjlQt9/KnbCmo5RhA1JmQpNwTqala1c0LdO
	 SCwZ/67wPLrPlSiuSUP4KGnIS5hdYvHmgQxKiEzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfBZWlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:41:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43257 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:41:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so11793549oib.10;
        Tue, 26 Feb 2019 14:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+52ZZM3yeSZwRUqWKm9UTBF6XhDQMC32Yt8EXu/Mfh0=;
        b=Ow1SlDG+rT9wBQS/boOEyW9DidrG8FLl63FR0Kqrk6X0yp3PAf6D7pdNqWQRj0VMz9
         m4eb2HXyS0DVUD6V74A8uCbTy8R6SXfIzPb1WL7v2hQWX6en3aF+3YoklCURhCtRjtuS
         KVmD7WxDcoQTD4EFLXWngHZSf8wgt2XnDyIQ2MEJke5rDBcsVWBboP70zGTDX54t5Bea
         +iE5IapjsXa/DQi3EIxNo6HXD8WNsL09+4Kb8JR4fk1qbi2pd0RkUVZ9aRaPOumQS8Md
         RydehkWqUDvyQe7eO8uYHMlODeBX0U0tk6uMemVNKgdmNMukXcUQImGmWnDu/BgVpKik
         uh2g==
X-Gm-Message-State: AHQUAubkGaqkrQePyXTNcSwOcLiTIZjcqV4qdoOJ4ryuxAknn6ds26CT
        a4D2DCKkgXc4/dnRbpNqyw==
X-Google-Smtp-Source: AHgI3IYVmK7vYv92577wuNAIuiVd8mokHDYzaS3n1SI3zJsRwjJzgOdD0C6Y08AnAIAL0RkXJ1jNNA==
X-Received: by 2002:aca:857:: with SMTP id 84mr3664509oii.125.1551220864254;
        Tue, 26 Feb 2019 14:41:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d17sm7234411oih.51.2019.02.26.14.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 14:41:03 -0800 (PST)
Date:   Tue, 26 Feb 2019 16:41:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     bobbyeshleman@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: light: Add ap3216c
Message-ID: <20190226224103.GA14508@bogus>
References: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
 <b1689e99c868d19aa33932b0a96944852e91db45.1551037168.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1689e99c868d19aa33932b0a96944852e91db45.1551037168.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2019 12:33:51 -0800, Robert Eshleman wrote:
> Adds device tree bindings for the ap3216c ambient light and proximity
> sensor.
> 
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/ap3216c.txt | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ap3216c.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
