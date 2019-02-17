Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EA8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE522192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbfBQFAS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 00:00:18 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:50136 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfBQFAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 00:00:17 -0500
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x1H4xint019653;
        Sun, 17 Feb 2019 04:59:45 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x1H4xQuv167541;
        Sun, 17 Feb 2019 01:59:26 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>, Tom Li <tomli@tomli.me>
Cc:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform Drivers
Organization: Free thinker, not speaking for FSF Latin America
References: <20190208083038.GA1433@localhost.localdomain>
        <orbm3i5xrn.fsf@lxoliva.fsfla.org>
        <20190211125506.GA21280@localhost.localdomain>
        <orimxq3q9j.fsf@lxoliva.fsfla.org>
        <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
Date:   Sun, 17 Feb 2019 01:59:26 -0300
In-Reply-To: <20190211230614.GB22242@darkstar.musicnaut.iki.fi> (Aaro
        Koskinen's message of "Tue, 12 Feb 2019 01:06:14 +0200")
Message-ID: <orva1jj9ht.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11, 2019, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> ATA (libata) CS5536 driver is having issues with spurious IRQs and often
> disables IRQs completely during the boot. You should see a warning
> in dmesg. This was the reason for slowness on my FuLoong mini-PC. A
> workaround is to switch to old IDE driver.

Thanks.  I see a NIEN quirk in ide-iops.c that's enabled for the hard
drive model I've got on my yeeloong, but that's not even compiled in my
freeloong builds.  I don't see any changes in libata between 4.19 and
4.20 that could explain the regression either.

I'm afraid there's no observable change in behavior after installing the
proposed patch at
https://lore.kernel.org/linux-mips/20190106124607.GK27785@darkstar.musicnaut.iki.fi/

The kernel still disables irq14 early on, and then runs slow.


Tom, why do you say bisecting this is impossible?  I realize you wrote
you did so for 24 hours non-stop, but...  I'm curious as to what
obstacles you ran into.  It's such a reproducible problem for me that I
can't see how bisecting it might be difficult.

Or were by any chance you talking about the reboot/shutdown problem
then?

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
