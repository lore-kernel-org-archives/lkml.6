Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1B1C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31CE248A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31CE248A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967579AbeF1RiT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:38:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37044 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967479AbeF1RiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:38:17 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SEVBtt_KE2vW; Thu, 28 Jun 2018 19:38:15 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD08A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6F751EC03AD;
        Thu, 28 Jun 2018 19:38:15 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     KVM <kvm@vger.kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] x86/kvm: Enable MCE injection in the guest v2
Date:   Thu, 28 Jun 2018 19:38:06 +0200
Message-Id: <20180628173808.25885-1-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here's v2, dropping patch 3 and incorporating hopefully all of Radim's
feedback.

Thx.

v1 cover letter:

there's this mce-inject.ko module in the kernel which allows for
injecting real MCEs and thus test the MCE handling code.

It is doubly useful to be able to inject same MCEs in a guest so that
testing of the MCE handling code can happen even easier/faster. In order
to be able to do that on an AMD guest, we need to emulate some bits
and pieces like the HWCR[McStatusWrEn] bit which allows writes to the
MCi_STATUS registers without a #GP.

The below does that and with it I'm able to properly inject MCEs in said
guest.

Borislav Petkov (2):
  kvm/x86: Move MSR_K7_HWCR to svm.c
  x86/kvm: Implement MSR_HWCR support

 arch/x86/kvm/svm.c | 20 ++++++++++++++++++++
 arch/x86/kvm/x86.c | 46 +++++++++++++++++++++++++++++++---------------
 2 files changed, 51 insertions(+), 15 deletions(-)

-- 
2.17.0.582.gccdcbd54c

