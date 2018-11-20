Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C53C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D985206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D985206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeKTUbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:31:02 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56414 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeKTUbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:31:02 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42zh8f1sM9z1qxVH;
        Tue, 20 Nov 2018 11:02:42 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42zh8f0PqLz1qrn7;
        Tue, 20 Nov 2018 11:02:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id bQdbdZVPVkx8; Tue, 20 Nov 2018 11:02:35 +0100 (CET)
X-Auth-Info: THz1PUJYvGanoOaGpah04NLfeUmkXy7yeAc8abl4o+TJEulGRFXlivWBytyz5UG5
Received: from hawking (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 20 Nov 2018 11:02:35 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     fthain@telegraphics.com.au,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, schivers@csc.com.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        schmitzmic@gmail.com, John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 07/14] m68k: atari: Convert to clocksource API
References: <cover.1542589838.git.fthain@telegraphics.com.au>
        <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au>
        <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com>
X-Yow:  I'm CONTROLLED by the CIA!!  EVERYONE is controlled by the CIA!!
Date:   Tue, 20 Nov 2018 11:02:35 +0100
In-Reply-To: <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com>
        (Linus Walleij's message of "Tue, 20 Nov 2018 09:10:36 +0100")
Message-ID: <mvmk1l8m5hg.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20 2018, Linus Walleij <linus.walleij@linaro.org> wrote:

> Yes you already see the same as I see: this chip MK68901 has
> no less than four timers. I bet the kernel is just using one of them,
> out of habit.

Note that not all timers can be used freely.  Some of them are hardwired
to generate the clock for the serial interfaces.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
