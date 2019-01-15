Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C89C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804A420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547586256;
	bh=2G14thsV7VK8ku6znqsGRS2YeGQVIssKE/jBBhRO/zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NVkhNqxUt1t5vLxNWkcpJVpzEm4DMi+d507+bfmRZ9ErqYBSnbeMtdixnnXv+Ptqb
	 307qHktdopE7L5qz1Aztt1CF69k0TgP0a6NaAtByBFLXi6B4kTtzD3BoIu9NG/CJ8R
	 78A5jzDr4orAGpgoJr1qFr5jJ2ZKESLIFNaLSNGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbfAOVEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:04:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38571 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbfAOVEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:04:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so3281447oii.5;
        Tue, 15 Jan 2019 13:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=41LWhu9KRQuKZuhEzoCMPDkpklHnMT26ftYWkcOtT4Q=;
        b=T0LTDG6XUSA5s4pO37Syh82symcU0UTkSbGHkCMOM4nyFACQC4ZnDmEvk7tuYhnIEj
         +mypzyhQVRrRXQ1Me3I4/eqsVEWEDfhOtONpM4j0/krGeDWwBxkv9J1MPbL6wQJJCYXv
         cb+THQ/ywzgNpB5GZwq4Q60Bzjcp0fFbBqeU3PbpTwCipTDEbmv7ikwl6iRlIzPal6Kd
         g32+sRtSmytOQrD0ba/NgEMxEf0BddK6cLQiVsNHoOg2tisw8KTirauSZ0MufYV/Q3VW
         6RY4ACF6M9vapLfRFLcISgXAhnPTZRmPDDzdjIP9/B4Qy0FYBAcNHZ/yLc6h77HdeQNU
         olvQ==
X-Gm-Message-State: AJcUukdDb46JbjMdmS4lco4VqQQ1Tcff+bjuCCHBl6dxRJHeLYxQTbyh
        w5uufPM10Gzghdk5i7aVIJc1tVI=
X-Google-Smtp-Source: ALg8bN6ja0m8B1qtSnc4zWjm6Mqw+/Hkqb8mNmbdhi9OxxKuvwKeSJZXVnIDaD1Ebg4KtK+/PSpCBA==
X-Received: by 2002:aca:408b:: with SMTP id n133mr2580318oia.44.1547586253514;
        Tue, 15 Jan 2019 13:04:13 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id 187sm2161092oic.12.2019.01.15.13.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 13:04:12 -0800 (PST)
Date:   Tue, 15 Jan 2019 15:04:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/5] devicetree: property-units: Add femtofarads unit
Message-ID: <20190115210411.GA20241@bogus>
References: <20190108185414.26922-1-sam@ravnborg.org>
 <20190108185414.26922-2-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108185414.26922-2-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Jan 2019 19:54:10 +0100, Sam Ravnborg wrote:
> When dealing with capacitance of 0.5 pF then
> a smaller unit is preferred.
> Add femtofarads to deal with this.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/property-units.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
