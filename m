Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2420CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F320520657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392164AbfAPKna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:43:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44637 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389215AbfAPKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:43:29 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjifN-0005Gq-5M; Wed, 16 Jan 2019 11:43:25 +0100
Message-Id: <20190116102651.489113812@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 16 Jan 2019 11:26:51 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [patch 0/2] LICENSES: Fix fallout from recent SPDX conversions
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent SPDX conversions introduced new wreckage:

 arch/sh/lib/ashiftrt.S: 1:42 Invalid Exception ID: GCC-exception-2.0
 ...
 arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt: 1:38 Invalid token: "
 ,,,

The first group is due to using an exception identifier without adding the
exception text to the LICENSES directory.

The second one is due to the magic conment format in the SuperH bootcode
files.

At least the first one could have been caught by checkpatch.pl:

WARNING: 'SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0' is not supported in LICENSES/...
#38: FILE: arch/sh/lib/ashiftrt.S:1:
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0

....

The following series addresses both issues.

Thanks,

	tglx

