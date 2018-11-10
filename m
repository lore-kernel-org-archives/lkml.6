Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4258C2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="qak5gVGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4258C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeKKArE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:47:04 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:53337 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeKKArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:47:04 -0500
Date:   Sat, 10 Nov 2018 15:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1541862105;
        bh=2HqS+Ilr50Y7KOuUFnlARTDp450/g5pgpjskKMUtn8g=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=qak5gVGDSZ6WCVDZl/YPwh8VlpDHqqUdOCQgSS1iY5LAfxLoiTx1VmivZuSi02ZCA
         J1QSShYD51v/KWuZMa7G/PXi4yx8Z7UWmj7bYXSpPj5U0XQjl6pRdFeKBUzwSD01jd
         K2eDdIMBG//9S/qtK7AnJZklWU0YHyINdGEgO+lg=
To:     LKML <linux-kernel@vger.kernel.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [patch V3 05/11] x86/mm/cpa: Add debug mechanism
Message-ID: <CWE_cR1B3v4_tzoZ66Qlvfp-MxyVGJmbnz1gvpbRescCQJ2G7-2MR4D_tm2WwQWBSReaa8gf3S7PmvTC2ig4ZrrXzFGL9HcDKugMH37l18c=@protonmail.ch>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch  "x86/mm/cpa: Add debug mechanism" (https://lore.kernel.org/lkml/=
20180917143546.078998733@linutronix.de/) caused a thousands of messages dur=
ing boot on my machine.

They look like below:

kernel: CPA  protect    Text RO: 0xffffffff8affc000 - 0xffffffff8affcfff PF=
N 12cffc req 0000000000000063 prevent 0000000000000002
kernel: CPA  protect    Text RO: 0xffffffff8affd000 - 0xffffffff8affdfff PF=
N 12cffd req 0000000000000063 prevent 0000000000000002
kernel: CPA  protect    Text RO: 0xffffffff8affe000 - 0xffffffff8affefff PF=
N 12cffe req 0000000000000063 prevent 0000000000000002
kernel: CPA  protect    Text RO: 0xffffffff8afff000 - 0xffffffff8affffff PF=
N 12cfff req 0000000000000063 prevent 0000000000000002
kernel: CPA conflict  Rodata RO: 0xffffa2fbece00000 - 0xffffa2fbecffffff PF=
N 12ce00 req 80000000000000e3 prevent 0000000000000002
kernel: CPA  protect  Rodata RO: 0xffffa2fbece00000 - 0xffffa2fbece00fff PF=
N 12ce00 req 8000000000000063 prevent 0000000000000002
kernel: CPA  protect  Rodata RO: 0xffffa2fbece01000 - 0xffffa2fbece01fff PF=
N 12ce01 req 8000000000000063 prevent 0000000000000002
kernel: CPA  protect  Rodata RO: 0xffffa2fbece02000 - 0xffffa2fbece02fff PF=
N 12ce02 req 8000000000000063 prevent 0000000000000002


The exact reason for those may be related to some out-of-tree patches which=
 I use:

https://github.com/anthraxx/linux-hardened/commit/c492687efa253c32972115a5e=
110e51614af445e#diff-e1f7e9a10ed7feb8c32493438cff8456

https://github.com/anthraxx/linux-hardened/commit/266d16fc47257b2548e6fcbfa=
febcc5d84d46389#diff-e1f7e9a10ed7feb8c32493438cff8456

but I wonder if those messages shouldn't be rate-limited or hidden behind '=
CONFIG_CPA_DEBUG' in general as there may be a chance that someone will tri=
gger something like that with vanillia kernel.

Jordan
