Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3655AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092BE21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cmcyGcTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeLRSyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:54:14 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:55336 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeLRSyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:54:13 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7002924E27C8;
        Tue, 18 Dec 2018 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545159252; bh=lZBJF0eSK4PbB8S4DFiN52gVQIxcaC2T7C6Fu8rsav8=;
        h=From:To:CC:Subject:Date:From;
        b=cmcyGcTLgny5y/21P6NafUzBr0J9Y/HpzyW2QkhFUNhUflaQBonubwAb3ooLE8otk
         eMtWPSrxI9vfy2g8TWV5f1lN/Cq0YiClgDV5gKgdt/h9/xyBl2HztKUFLUBoA5aveL
         b4zTPOF23oAJvi/JYpH0laTPF+oZ4zbVPjFLa5VLo7mOFakmTbGALh0p7M0b8cZu89
         DauFhb4+nedUNiZ0xA+XzkL5zovQymiitKKq3wrPwnXayvrQU4BTJq63JYM2RRZdnk
         +qS2eBLF2Th5aSFAt5v6GSWUZGwu+CIulHvo9MELXYmMZ61oUbOwSmoIFRXRzLZkay
         UXfSN6lUKnfWw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4003E444D;
        Tue, 18 Dec 2018 10:54:12 -0800 (PST)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 10:54:12 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Dec 2018 00:24:09 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Dec 2018 00:24:08 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>
Subject: [PATCH 0/2] ARC show_regs fixes
Date:   Tue, 18 Dec 2018 10:53:57 -0800
Message-ID: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vineet Gupta (2):
  ARC: show_regs: avoid page allocator
  ARC: show_regs: fix lockdep splat for good

 arch/arc/kernel/troubleshoot.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
2.7.4

