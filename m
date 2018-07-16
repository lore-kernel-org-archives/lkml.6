Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D91ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9128C2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9128C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeGPEqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:46:52 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:41984 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbeGPEqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:46:52 -0400
X-Greylist: delayed 939 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 00:46:51 EDT
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 24C83696C36FA3BED885;
        Mon, 16 Jul 2018 12:05:48 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6G45eGc069464;
        Mon, 16 Jul 2018 12:05:40 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071612054242-485941 ;
          Mon, 16 Jul 2018 12:05:42 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        x86@kernel.org, albcamus@gmail.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: [PATCH 0/5] x86/pti: small fixes and cleanups for pti
Date:   Mon, 16 Jul 2018 12:03:35 +0800
Message-Id: <1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-16 12:05:42,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-16 12:05:40,
        Serialize complete at 2018-07-16 12:05:40
X-MAIL: mse01.zte.com.cn w6G45eGc069464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a short series of fixes and cleanups found when reading the
code, no functional changes.

Jiang Biao (5):
  x86/pti: check the return value of pti_user_pagetable_walk_p4d
  x86/pti: check the return value of pti_user_pagetable_walk_pmd
  x86/pti: make pti_set_kernel_image_nonglobal static
  x86/pti: warn for unknown pti boot options
  x86/pti: constify address parameters

 arch/x86/mm/pti.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

-- 
2.7.4

