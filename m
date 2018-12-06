Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DCAC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEDF2054F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="xKkKzYaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEDF2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeLFCFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:05:47 -0500
Received: from vern.gendns.com ([98.142.107.122]:50740 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbeLFCFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BOdMFKZ72p4czGdSY/bO1kNcd/5iu5zf0jWWy7i5MA0=; b=xKkKzYaIuHXfDJFhN7myhlbKv2
        KzZa9yYWZlLwHm9f35wZHQg3f53Sc9Sfg/BRO1suKB5r+6+M/b4wwSZKhWUPk4w0X/9hX/Fhm5KAS
        UY41GZI1g/DLjyRRkmKs0w7ucEvNZfYLIuwJGTBsYJl3wH0gt0lUjAwTNpbTlVupiA3XrQMNlgwpX
        8HyZ1AHuZ/fH3KXnCkRK01En2siu7ihSfTf2ugQI97+/RdQkIlH6ylvxtjGMP0SzF4GS2ojxJvUWg
        DFRgzqxskI8+np3fkTU4xvNhdOGlQVJMc7+88CUck2TjGwqGYFjNieMoxfcXkLcmUNbTep1tEE4UQ
        y63cQYig==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:39624 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gUj1b-00058p-QB; Wed, 05 Dec 2018 21:04:23 -0500
Subject: Re: [PATCH v5 0/6] Add Fieldbus subsystem + support HMS Profinet card
To:     Sven Van Asbroeck <thesven73@gmail.com>, svendev@arcx.com,
        robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181204220224.27324-1-TheSven73@googlemail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <3b0b4c5c-23a6-428c-6060-3e5c314bd9e7@lechnology.com>
Date:   Wed, 5 Dec 2018 20:05:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204220224.27324-1-TheSven73@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 4:02 PM, Sven Van Asbroeck wrote:
> This patch:
>    1. adds a Fieldbus subsystem
>    2. adds support for the HMS Industrial Networks AB Profinet card.

Does this actually need a new fieldbus subsystem or could it just be
implemented as a new network protocol?

> 
> 1. Fieldbus subsystem
> ---------------------
> 
> Fieldbus device (client) adapters allow data exchange with a PLC aka.
> "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
> They are typically used when a Linux device wants to expose itself
> as an actuator, motor, console light, switch, etc. over the fieldbus.
> The framework is designed to provide a generic interface to Fieldbus
> Devices from both the Linux Kernel and the userspace.

Then this generic interface to a fieldbus device could just be a socket.

> 
> 2. Add support for HMS Profinet Card
> ------------------------------------
> 
> Profinet is an industry technical standard for data communication over
> Industrial Ethernet, designed for collecting data from, and controlling,
> equipment in industrial systems, with a particular strength in delivering data
> under tight time constraints (on the order of 1ms or less).
> 
> The profinet card itself is connected to the system via an industrial bus
> called 'anybus'.
> 
> I have followed the bus driver/client driver pattern, and created an anybus
> bus driver, plus a client driver for the profinet card.
> 
> In case this patch set gets (eventually) accepted, drivers for other anybus
> client cards may follow: flnet, cc-link, ...
> 
> The anybus slot on the host is located on an 'anybus controller', which is
> custom h/w designed by arcx. It exposes a dual anybus host implementation,
> plus a power readout unrelated to the anybus.
> 
