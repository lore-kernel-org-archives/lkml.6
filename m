Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401A4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3A320854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3A320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIIX7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:59:36 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:16448 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeIIX7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:59:36 -0400
Received: from belgarion ([90.89.234.36])
        by mwinf5d02 with ME
        id ZX8t1y00B0nnJME03X8tSS; Sun, 09 Sep 2018 21:08:55 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 09 Sep 2018 21:08:55 +0200
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Colin King <colin.king@canonical.com>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Mark Brown <broonie@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-input@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: wm97xx: only unregister wm97xx_driver if it has been registered
References: <20180904183505.10693-1-colin.king@canonical.com>
        <20180905091609.GC1653@imbe.wolfsonmicro.main>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sun, 09 Sep 2018 21:08:53 +0200
In-Reply-To: <20180905091609.GC1653@imbe.wolfsonmicro.main> (Charles Keepax's
        message of "Wed, 5 Sep 2018 10:16:09 +0100")
Message-ID: <87o9d65vzu.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Keepax <ckeepax@opensource.cirrus.com> writes:

> On Tue, Sep 04, 2018 at 07:35:05PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>> 
>> In the case where IS_BUILTIN(CONFIG_AC97_BUS)) is not true, the
>> wm97xx_driver driver is being unregistered even it has not been
>> previously registered.  Fix this by only unregistering it if
>> IS_BUILTIN(CONFIG_AC97_BUS)) is true.  This fixes the warning
>> message:
>> 
>> [  834.111248] ------------[ cut here ]------------
>> [  834.111248] Unexpected driver unregister!
>> [  834.111319] WARNING: CPU: 2 PID: 11749 at drivers/base/driver.c:193 driver_unregister+0x3b/0x40
>> [  834.111319] Modules linked in: wm97xx_ts(-) ....
>> 
>> ..and a stack trace.
>> 
>> To easily reproduce this, load and unload the module on a system where
>> the hardware is not supported.
>> 
>> Fixes: ae9d1b5fbd7b ("Input: wm97xx: add new AC97 bus support")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
