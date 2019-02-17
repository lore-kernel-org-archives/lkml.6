Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F33C10F04
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27362196F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBQEmo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 23:42:44 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:50120 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBQEmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 23:42:43 -0500
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x1H4gGXg019408;
        Sun, 17 Feb 2019 04:42:17 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x1H4fuUS166969;
        Sun, 17 Feb 2019 01:41:56 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Tom Li <tomli@tomli.me>, Aaro Koskinen <aaro.koskinen@iki.fi>
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
Date:   Sun, 17 Feb 2019 01:41:56 -0300
In-Reply-To: <20190211125506.GA21280@localhost.localdomain> (Tom Li's message
        of "Mon, 11 Feb 2019 20:55:09 +0800")
Message-ID: <or36onkovf.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11, 2019, Tom Li <tomli@tomli.me> wrote:

> We've just identified and confirmed the source of the shutdown problem a
> few days ago on this mailing list.

> You can pick up the patch from:
> https://lore.kernel.org/lkml/20190207205812.GA11315@darkstar.musicnaut.iki.fi/

> A patch has been authored and submitted by Aaro Koskinen, but currently it
> seems stuck in the mailing list because the maintainer worries about regression
> and asks for testing on more MIPS systems, although we believe it's a trivial
> patch.

Thanks.  I've just brought it into my local copies of loongson-community
branches for 4.4, 4.9, 4.14, 4.19, and 4.20, and master, after verifying
that it enables at least 4.19, 4.20 and master to reboot without a power
cycle, and I'll include it in upcoming freeloong builds, except for 3.16
and 3.18, where it doesn't apply.


> In addition, I've discovered and fixed another bug preventing the machine from
> shutting down, this patch has already merged into the Linus tree.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a96669d77897ff3613157bf43f875739205d66d

Hmm, I don't think I've ever hit this one.  Do you happen to know how
far back it might be needed?


> I'll continue working on upstreaming these out-of-tree drivers as my personal
> project. I hope you'll be able to use a fully-functional machine with the mainline
> kernel soon, my current target is Linux 5.3.

Thanks!

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
