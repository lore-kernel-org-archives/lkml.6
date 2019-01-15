Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EDAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56368205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547584087;
	bh=bTeBJ98wO/06oAXlo/Jjh8qyfbz+bUhnskRhaU7yNDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gAf8/BNCl7+zPgP3VaHoQiYwx1AxJIBqdMbk/HzULNCNgX/5mdb2NHS2iRYoe8Qkc
	 vlpe4L6Swu6Sh2vmXGxH34ConYBI598qbk++O272CZLaO+u1EnQ/bKsHGocc3Xt26C
	 ok7g9sMikYecp53DZp9l2fmoZccnQVtGElWpJ7XI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbfAOU2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:28:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37521 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbfAOU2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:28:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so3212172oia.4;
        Tue, 15 Jan 2019 12:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ML6L9EJQ9F/ewqA/pMz/yO2vKjQ+u9rsJNws7hr2pMo=;
        b=D2K8pupPhf4Qis6yInSzm+/pHqHVUByDNS3D/k+l2FBvVUu7EKQZ0a+olmJA4BgD/Y
         5zGAQC7nwCvKCDg+HnG24BYHb3nsW5G8la1djJTHA/kg6LZKMnS3mkTiu+WOOOJwOBqJ
         Yjlcm6P1MdQeMEXrllp1Z/B0b33gl05f8tPHk+CuwcvVMxcP66/8d9N/p7LaDIkTULAU
         ZMdbp6AW2GC42oM/yPrb04WqRZ9BRvSv8dwshSb1oBSnhXmkZ9w8XH19GAll3vIGQZXq
         kyVtdu9jgbg89mZ3ljWnkVOsDv9BePubODEm52bJYTeNWJ1t6APY0IQDXQqK9JpC4cAw
         3XFQ==
X-Gm-Message-State: AJcUukcSoW5QrK/BMP5HKD3YjPvf96sCRADHDFk8r31vyIOV1ftc2CR0
        y8qVNt9TuthpLgpVkAf/1Q==
X-Google-Smtp-Source: ALg8bN5uN8aaGt1pmzzYYf1Ib2nQ+W2XYcfZc7MlNqSpJDydvoUNMW8R/vv5Rf6tNsfgJF5TIJX6Cg==
X-Received: by 2002:aca:654a:: with SMTP id j10mr2799591oiw.301.1547584084157;
        Tue, 15 Jan 2019 12:28:04 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id z9sm1959278oiz.21.2019.01.15.12.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:28:03 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:28:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, himanshujha199640@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: chemical: Add bindings for
 bme680
Message-ID: <20190115202802.GA26149@bogus>
References: <20190114201914.24572-1-sebastien.bourdelin@gmail.com>
 <20190114201914.24572-2-sebastien.bourdelin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114201914.24572-2-sebastien.bourdelin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 15:19:14 -0500, Sebastien Bourdelin wrote:
> BME680 is a pressure/temperature/humidity/voc sensor.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> ---
> v2 -> v3:
>   - change i2c address to 0x76 as it seems more reliable: Suggested by Himanshu Jha <himanshujha199640@gmail.com>
>   - rebase on master
> ---
>  .../devicetree/bindings/iio/chemical/bme680.txt       | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
