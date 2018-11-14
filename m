Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1940C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9587C2245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9587C2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeKOOHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 09:07:10 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:42825 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbeKOOHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 09:07:04 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 14 Nov 2018 20:00:26 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id D02F71B8038;
        Wed, 14 Nov 2018 23:00:54 -0500 (EST)
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>
CC:     Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 0/2] x86: Asm macros fixes
Date:   Wed, 14 Nov 2018 12:43:07 -0800
Message-ID: <20181114204309.18645-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been a complaint that the recent use of assembly macros in C
files broke distcc. The first patch fixes this issue.

The second patch adds a dependency for all C files on macros.S, to
trigger their recompilation when the relevant macros change.

I think it will be better to get the patches through tip. Please advise
if you disagree.

v1->v2:
* Remove whitespaces [Ingo]
* Automatically enable split compilation when distcc or icecc are used

Nadav Amit (2):
  Makefile: Fix distcc compilation with x86 macros
  x86: set a dependency on macros.S

 Makefile               |  4 +++-
 arch/x86/Makefile      |  7 +++++--
 scripts/Makefile.build | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.17.1

