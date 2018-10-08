Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B60C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE85920858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dH9gfm6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE85920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJIDIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:08:17 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:50180 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeJIDIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:08:16 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 626CB24E0927;
        Mon,  8 Oct 2018 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539028492; bh=e8Ng+w/b77oBTmT6lawsEHVnzff9uZbSscVOMMOGyZI=;
        h=From:To:CC:Subject:Date:From;
        b=dH9gfm6QpC+pzhpFXv/OWDObszJ3ZqdCGjpKUePY9aiMMUXYaNFwp2zm+q2TdVl4P
         YMAFmdy9MP5iN78zoMpHpq7LvoDLnVze7Eu3FRLqB0R0iQAnmEQi9cbORxiN3kL9/p
         cGUPAIH4876QGhjr4MxDCsjkaBGwgRqxn2NlPnYPheXninbHugq6JMtH/epQ4XA5xn
         BkGIj7SNEuajUbXydaljrU98ebahx5wSWtpo9UOtohpRR6jy4JgpVY0O38TyUnA0J5
         VPOt6yZ6rObDCcBfcw9HnwKHgihY4Lp8ephD6OV0Ms9lgvqwee9thBTzGHP/+2QWT9
         WpX8+JOvnBTCw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id D48E5342C;
        Mon,  8 Oct 2018 12:54:51 -0700 (PDT)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 8 Oct 2018 12:54:51 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Colin King <colin.king@canonical.com>
Subject: [GIT PULL] ARC updates for 4.19-rc8
Thread-Topic: [GIT PULL] ARC updates for 4.19-rc8
Thread-Index: AdRfQMTS1+3sidH+RtO+PHolD0JCcw==
Date:   Mon, 8 Oct 2018 19:54:50 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B0A4DEA@US01WEMBX2.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,=0A=
=0A=
Late in the cycle, but please pull ARC updates. We could have waited for ne=
xt=0A=
release had it not been for the the clone syscall fix which is stable mater=
ial.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=
--------------->=0A=
The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804=
:=0A=
=0A=
  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)=0A=
=0A=
are available in the git repository at:=0A=
=0A=
  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-4.=
19-rc8=0A=
=0A=
for you to fetch changes up to c58a584f05e35d1d4342923cd7aac07d9c3d3d16:=0A=
=0A=
  ARC: clone syscall to setp r25 as thread pointer (2018-10-05 14:33:29 -07=
00)=0A=
=0A=
----------------------------------------------------------------=0A=
ARC updates for 4.19-rc8=0A=
=0A=
 - Fix clone syscall to update Thread pointer register=0A=
=0A=
 - Make/build updates (needed for AGL/OE builds)   [Alexey]=0A=
=0A=
 - Typo fix [Colin Ian King]=0A=
=0A=
----------------------------------------------------------------=0A=
Alexey Brodkin (2):=0A=
      ARC: build: Get rid of toolchain check=0A=
      ARC: build: Don't set CROSS_COMPILE in arch's Makefile=0A=
=0A=
Colin Ian King (1):=0A=
      ARC: fix spelling mistake "entires" -> "entries"=0A=
=0A=
Vineet Gupta (2):=0A=
      ARCv2: build: use mcpu=3Dhs38 iso generic mcpu=3Darchs=0A=
      ARC: clone syscall to setp r25 as thread pointer=0A=
=0A=
 arch/arc/Kconfig          |  2 +-=0A=
 arch/arc/Makefile         | 26 ++------------------------=0A=
 arch/arc/kernel/process.c | 20 ++++++++++++++++++++=0A=
 3 files changed, 23 insertions(+), 25 deletions(-)=0A=
