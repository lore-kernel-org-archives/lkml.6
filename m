Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC220C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE2520882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE2520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeG2Tui convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:50:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:19097 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeG2Tuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:50:37 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5gpw91kgwllS1BmEjh4="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6TIJ9qqj
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 29 Jul 2018 20:19:09 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by returning EPROBE_DEFER
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180729180804.GA18468@lenoch>
Date:   Sun, 29 Jul 2018 20:19:08 +0200
Cc:     Andreas Kemnade <andreas@kemnade.info>, linux-pwm@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <920A2836-9266-46F8-9A3F-111C01999C9E@goldelico.com>
References: <20180728165914.15871-1-andreas@kemnade.info> <20180728203501.GA16194@lenoch> <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com> <20180729180804.GA18468@lenoch>
To:     Ladislav Michl <ladis@linux-mips.org>,
        David Rivshin <drivshin@allworx.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 29.07.2018 um 20:08 schrieb Ladislav Michl <ladis@linux-mips.org>:
> 
> On Sun, Jul 29, 2018 at 08:32:41AM +0200, H. Nikolaus Schaller wrote:
>> Hi,
>> 
>>> Am 28.07.2018 um 22:35 schrieb Ladislav Michl <ladis@linux-mips.org>:
>>> 
>>> Hi Andreas,
>>> 
>>> On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote:
>>>> I got this in the kernel log:
>>>> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
>>>> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
>>>> 
>>>> the probe function has to wait until omap_dm_timer_probe() in
>>>> clocksource/timer-ti-dm.c has initialized pdata, so defer probing
>>> 
>>> There already is a patch by David Rivshin addressing the same issue...
>> 
>> Here it is:
>> 
>> https://patchwork.ozlabs.org/patch/943148/
>> 
>> but hasn't arrived in linux-next.
> 
> That's because there'll be v3.
> 
>> But it is questionable if a driver should dev_info() about doing deferred probing.
>> IMHO, it should just do it which is how Andreas' patch works.
> 
> See here: https://patchwork.ozlabs.org/patch/949659/

Ah, I see (neither Andreas nor me did follow the original discussions
and therefore came up independently with the same thoughts).

So we will wait for the v3.

BR and thanks,
Nikolaus

