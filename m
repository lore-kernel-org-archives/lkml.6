Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2595AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A8E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217147;
	bh=ZZFknj9E2Vwv6TnMZIKfaqSi/tNVRom2b6shpf2YmLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q4TDXGtyEqqBie32BJi/SrZIWe+A2ayUz6pohN5Mm3R6lURR4wVKz1HJfbhijlMmL
	 SNbVlaKlI9Rphh1DRvv3nc1lbiDD5lpgeE7emU3xeONXyApSy1jzdQNe73gFlnqiFy
	 rjaGPgCeaa1bshLQKhKSnO7Nxig0cVIHIug23RPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbfAKOc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37144 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389325AbfAKOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so12339483oia.4;
        Fri, 11 Jan 2019 06:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c/5PGGuNUrYxYF25nW76PtUrceWqNEjcAjUMnA9CS9c=;
        b=enSofcrQGJQA9aufcxAwg/1+g+WeA9Ov7+llCc8lYwoUnnqrMkdfq0KD9Nn0BKXMWl
         S1qy441V8kv0uwuYVrZ05I6aFlgd9kE8jD2sxrx8Ff6JDyuAX2WM31pMLlhJv77c1dqT
         y3OC61ilxB72sg03nQUR0xjLkUtk40hHZtFDzfv+PxuhyY1y+Eqoow3bh5TuXZF1L+R1
         xG6ovdnkkeRmwW85W8cGrbbtHZDKi9uHWE8bKHssDSqqkOp/QaZmp5xgUO21Ey1mun05
         x3nr3kTYrALL7fz93kzhAgBsOooSaWoFenu1at1DgV1KtI972hKdY8cNemQFOwiv3i8I
         sk5Q==
X-Gm-Message-State: AJcUukcMGv4hISpEFQHXo3S3wTn97/3hZKowp+lEh+GyIiW3bqD7Pndr
        3He+H+/Hczk4yCrfAWfgNA==
X-Google-Smtp-Source: ALg8bN5emJ8H2OtwGVKRoKICXy3QmiFfQIWl/RfYmOPPRnblBXBE7NAWD1t+7vyoCqG1KbTafmjbjQ==
X-Received: by 2002:aca:5681:: with SMTP id k123mr9675480oib.106.1547217140624;
        Fri, 11 Jan 2019 06:32:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e8sm35374190otq.17.2019.01.11.06.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:32:19 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:32:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7 1/2] dt-bindings: iio: accel: mma8452: add power
 supplies  property
Message-ID: <20190111143219.GA8867@bogus>
References: <1546938556-26969-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546938556-26969-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 09:14:01 +0000, Anson Huang wrote:
> The accelerometer's power supplies could be controllable on some
> platforms, add property "vdd/vddio" power supply to let device tree
> to pass phandles to the regulators to driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/mma8452.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
