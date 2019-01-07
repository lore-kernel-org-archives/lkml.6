Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BC2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCDD2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546888849;
	bh=eJ3IjrPuH6a6vRnUyw0oAg4caCnfu/YdC4nXPzuYPnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rwhJoJrRJh8yzJLMK7jIkUUKpXQJljFkResoHM1p4fwfSZ+686r0E0VBC/5lGfCNX
	 XLbY3Z05glOWZNJ316hGYlW7ty+qxewrKofOdBmrQkYzWWLHIdo9HQmb/V6PP4wNJS
	 IivkZtw+6bX64tydrsAfV+2MRUlbHUGTeIGJ6Fws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfAGTUs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:20:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36095 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfAGTUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:20:47 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so1982446edb.3;
        Mon, 07 Jan 2019 11:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nl0Z9EafKqQqrKQci4F+vWW4MhrhhwLk1NoFDyQP8pE=;
        b=iDD4yjBseWjtYpAYlJR/dJlxx5eVLtq7yaoLzzHW5K2cAdzMzv9awnoQSz54S+rNy9
         frWMpOATd7oyVpiGWKNYcAxaRpzBO0Oeb98JJbFtmYbjYfYOXSA8aoMcXGHPSzrbzbIM
         kd2BUNkd3DmpSXKH0ObADo4pGfeMbhqNxoCDGrBhr1aN6cqS2oeNp+ZpwY/5V6E/wKr1
         D3pFQwV+oYQVH+EbDqgUzRAGJsqM9N6PYoAL0Smcqb+04/DR/1x3AY8dS5P02XF9gYA+
         fS/YRivrpwvhoeyvyl1TVaA4cPIGwO8TKd5Hx50khERt1E2aMDwt2XGpoAf0MHY63ldX
         PYZA==
X-Gm-Message-State: AA+aEWbM6xcssy34q9Uk+9YFbgb+WuI8x07WfeZsvt28LiGkPJgg2u+I
        N1hs/RZEKfRTbGOcAZf7ijE=
X-Google-Smtp-Source: AFSGD/UWXXYdSPjrWpbPYJ4eV30SIQWA/9R7v+ETW3S5KZ6FgWgby8fC9zyE+kLB1wn16OKOd4S44w==
X-Received: by 2002:a50:b7ad:: with SMTP id h42mr57616117ede.210.1546888845683;
        Mon, 07 Jan 2019 11:20:45 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id f6sm36926894ede.53.2019.01.07.11.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:20:45 -0800 (PST)
Date:   Mon, 7 Jan 2019 20:20:42 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, xc-racer2@live.ca,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] ARM: dts: s5pv210: fascinate4g: Remove hardcoded
 bootargs
Message-ID: <20190107192042.GB3313@kozik-lap>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181228161819.18931-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 05:18:16PM +0100, Paweł Chmiel wrote:
> Since we have uboot (flashed in place of stock kernel),
> it's not needed anymore to hardcode bootargs.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 7 -------

Thanks, applied (squashed with previous one).

Best regards,
Krzysztof

