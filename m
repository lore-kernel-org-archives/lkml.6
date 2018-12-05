Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577F02082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xamn7jVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577F02082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeLEBDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:03:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeLEBDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IjHY7AVpB4H2KxQj3YZU74Xk9phStzqzBystJrONwz0=; b=Xamn7jVo0m0b84iE/mpkLQOQhm
        0sE6dbB3vm2w2KsYL+OQ4UgRm4SKlvA+4xMFZ3NPHcQ9zLC4mSMj2oT5AJR7Xw/BQC5H3vzACQuAW
        F4IZazOH+PP3KIZsr6IhqSAGdGjiDkwe9rSH33i6CJhW1fjOt7hKqlbLn4FZx8l5lK3qjMNzRPXWX
        UvdPGFUXUTnyBvAcn9sTVCloZKVFn24Ul7FIK1VEW+xlv8x+Pw/Gi8nGRlwoniGFUCDrf1YEtIXR5
        mGQ/1fe7hjgza1rTGGgnb3OoRGEDdhiPjxdlXl2vMSe4/WFH08if0Zaok/N8xsgCTWAr8MP5VTd1n
        Su1nT8hg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gULbS-0007En-CN; Wed, 05 Dec 2018 01:03:50 +0000
Subject: Re: [PATCH v5 6/6] fieldbus_dev: support HMS Profinet IRT industrial
 controller
To:     Sven Van Asbroeck <thesven73@gmail.com>, svendev@arcx.com,
        robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181204220224.27324-1-TheSven73@googlemail.com>
 <20181204220224.27324-7-TheSven73@googlemail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d941b95-3580-46c9-1148-4333898d88d6@infradead.org>
Date:   Tue, 4 Dec 2018 17:03:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204220224.27324-7-TheSven73@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 2:02 PM, Sven Van Asbroeck wrote:
> diff --git a/drivers/fieldbus/anybuss/Kconfig b/drivers/fieldbus/anybuss/Kconfig
> index 7e563a78be13..1d0e7516b18e 100644
> --- a/drivers/fieldbus/anybuss/Kconfig
> +++ b/drivers/fieldbus/anybuss/Kconfig
> @@ -20,4 +20,20 @@ config ARCX_ANYBUS_CONTROLLER
>  	  There is also a CAN power readout, unrelated to the Anybus,
>  	  modelled as a regulator.
>  
> +config HMS_PROFINET
> +	tristate "HMS Profinet IRT Controller (Anybus-S)"
> +	depends on FIELDBUS_DEV && HMS_ANYBUSS_BUS
> +	help
> +	 If you say yes here you get support for the HMS Industrial
> +	 Networks Profinet IRT Controller.
> +
> +	 It will be registered with the kernel as a fieldbus_dev,
> +	 so userspace can interact with it via the fieldbus_dev userspace
> +	 interface(s).
> +
> +	 This driver can also be built as a module. If so, the module
> +	 will be called hms-profinet.
> +
> +	 If unsure, say N.
> +
>  endif

Indent with tab + 2 spaces.

-- 
~Randy
