Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A94C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C49820834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NWJYWjNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C49820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLEBML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:12:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59852 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeLEBML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qsxik1dvJAYMIiIG3FyD4gxkbNyCTBskx/v19tpbex8=; b=NWJYWjNKCKs7TpPIK8Zf+yU59a
        17NYEigx9EiO7eJB1U+Dd7+cljGFonVUv0eARWUWQZEaUGsdnmSwjb1eIx6QaRtBJNeItplK17YhO
        +BSxwyRQWQFtAC678wZvJMX5oZeOzIjCY525RdblWTZC+yKmoB/Q/nouIsxsAadFbG+pmqxdt19+c
        ETdr/aT00GYA3q2HFgtxvUYzrDXOhIS1FkHLVtufFz9T20oQxIh2nc/5XhKCmxxDYRImfSVSC/7Ed
        voJmai60ZHRX+TxHSMoGdO2BkhE+hsMOeNy9YwXG7JcdbrvQo9Gp8MrTh0RJj7kiV4G3Na1vDHetv
        edm7VSag==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gULjT-0007Iu-PJ; Wed, 05 Dec 2018 01:12:07 +0000
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
Message-ID: <9f44b8a5-57bf-5dbf-1854-85c732708d02@infradead.org>
Date:   Tue, 4 Dec 2018 17:12:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204220224.27324-2-TheSven73@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 2:02 PM, Sven Van Asbroeck wrote:
> Fieldbus device (client) adapters allow data exchange with a PLC aka.
> "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
> 
> They are typically used when a Linux device wants to expose itself
> as an actuator, motor, console light, switch, etc. over the fieldbus.
> 
> This framework is designed to provide a generic interface to Fieldbus
> Devices from both the Linux Kernel and the userspace.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> ---
> 

> diff --git a/Documentation/fieldbus_dev/fieldbus_dev.txt b/Documentation/fieldbus_dev/fieldbus_dev.txt
> new file mode 100644
> index 000000000000..40ab4de0f019
> --- /dev/null
> +++ b/Documentation/fieldbus_dev/fieldbus_dev.txt
> @@ -0,0 +1,66 @@
> +                       Fieldbus-Device Subsystem
> +               ============================================
> +
> +Part 0 - What is a Fieldbus Device ?
> +------------------------------------
> +
> +Fieldbus is the name of a family of industrial computer network protocols used
> +for real-time distributed control, standardized as IEC 61158.
> +
> +A complex automated industrial system — such as manufacturing assembly line —
> +usually needs a distributed control system—an organized hierarchy of controller

"system-an" looks like a hyphenated word, but it's not.  It would be better
to use either "--" or " - " (as in the line above it).

> +systems—to function. In this hierarchy, there is usually a

Same for "systems-to".

> +Human Machine Interface (HMI) at the top, where an operator can monitor or
> +operate the system. This is typically linked to a middle layer of programmable
> +logic controllers (PLC) via a non-time-critical communications system
> +(e.g. Ethernet). At the bottom of the control chain is the fieldbus that links
> +the PLCs to the components that actually do the work, such as sensors,
> +actuators, electric motors, console lights, switches, valves and contactors.
> +
> +(Source: Wikipedia)
> +
> +A "Fieldbus Device" is such an actuator, motor, console light, switch, ...
> +controlled via the Fieldbus by a PLC aka. "Fieldbus Controller".

a.k.a. or just "aka", but not "aka."

> +
> +Communication between PLC and device typically happens via process data memory,
> +separated into input and output areas. The Fieldbus then cyclically transfers
> +the PLC's output area to the device's input area, and vice versa.
> +
> +Part I - Why do we need this subsystem?
> +---------------------------------------
> +
> +Fieldbus device (client) adapters are commercially available. They allow data
> +exchange with a PLC aka. "Fieldbus Controller" via process data memory.

                       aka

> +
> +They are typically used when a Linux device wants to expose itself as an
> +actuator, motor, console light, switch, etc. over the fieldbus.
> +
> +The purpose of this subsystem is:
> +a) present a general, standardized, extensible API/ABI to userspace; and
> +b) present a convenient interface to drivers.
> +
> +Part II - How can drivers use the subsystem?
> +--------------------------------------------
> +
> +Any driver that wants to register as a Fieldbus Device should allocate and
> +populate a 'struct fieldbus_dev' (from include/linux/fieldbus_dev.h).
> +Registration then happens by calling fieldbus_dev_register().
> +
> +Part III - How can userspace use the subsystem?
> +-----------------------------------------------
> +
> +Fieldbus protocols and adapters are diverse and varied. However, they share
> +a limited few common behaviours and properties. This allows us to define
> +a simple interface consisting of a character device and a set of sysfs files:
> +
> +See:
> +Documentation/ABI/testing/sysfs-class-fieldbus-dev
> +Documentation/ABI/testing/fieldbus-dev-cdev
> +
> +Note that this simple interface does not provide a way to modify adapter
> +configuration settings. It is therefore useful only for adapters that get their
> +configuration settings some other way, e.g. non-volatile memory on the adapter,
> +through the network, ...
> +
> +At a later phase, this simple interface can easily co-exist with a future
> +(netlink-based ?) configuration settings interface.


-- 
~Randy
