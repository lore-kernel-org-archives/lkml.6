Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E836C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158FF2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EgE2Sy5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158FF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeLEBB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:01:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59696 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeLEBB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H3fx0RXiVEgxWPNTCtVDWyt4kjfwSJUTpJ3IjLKyytI=; b=EgE2Sy5jZUU/Z1ZKOYPcfG2ge2
        uD4KwLf6xpojSkYkoYaJKkzcpsQWroAXypccFSW+eNB1PpDXxogBENmeQigPj7ldIbi7i8HChYCyw
        mmo6jasOu+e0kpM9eLawy54q8KPHcRwaIvC2lGs1BINxD3fN33Pglr0YUvZWHH7BhRl6un+Rz5jMD
        SNYvTQCA5/vJYFMuBIdzxKwzB+TQGBSZY2jxkyLUbbmeufPms7iWD+S+/U1lCAcVvF8JyREcqjMQX
        i09nmXmvufxw8fCckXFHzbSfp7IjLrgCjPQCuWYr6/L/ZyhiO7s4WXkZTdLWIhScohGIqXdSkiUDx
        m3ORLC1w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gULYx-0007Du-2B; Wed, 05 Dec 2018 01:01:15 +0000
Subject: Re: [PATCH v5 1/6] fieldbus_dev: add Fieldbus Device subsystem.
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
 <20181204220224.27324-2-TheSven73@googlemail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <54b830ec-4968-3dd0-af2f-5559059b6e4c@infradead.org>
Date:   Tue, 4 Dec 2018 17:01:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204220224.27324-2-TheSven73@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 2:02 PM, Sven Van Asbroeck wrote:
> diff --git a/drivers/fieldbus/Kconfig b/drivers/fieldbus/Kconfig
> new file mode 100644
> index 000000000000..1d1929ba7e27
> --- /dev/null
> +++ b/drivers/fieldbus/Kconfig
> @@ -0,0 +1,19 @@
> +menuconfig FIELDBUS_DEV
> +        bool "Fieldbus Device Support"
> +        help
> +          Support for Fieldbus Device Adapters.
> +
> +	  Fieldbus device (client) adapters allow data exchange with a PLC aka.
> +	  "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
> +
> +	  They are typically used when a Linux device wants to expose itself
> +	  as an actuator, motor, console light, switch, etc. over the fieldbus.
> +
> +          This framework is designed to provide a generic interface to Fieldbus
> +          Devices from both the Linux Kernel and the userspace.
> +
> +          If unsure, say no.
> +
> +if FIELDBUS_DEV
> +
> +endif

Hi,
Please consistently use one tab + 2 spaces to indent Kconfig help text,
as documented in Documentation/process/coding-style.rst.

-- 
~Randy
