Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C886C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACF620882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ArNyHXr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACF620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeILTtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:49:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6NZpT2LhrT31KqbBYWGcxfuS5U6cN+1ZajDWkfsUfPI=; b=ArNyHXr0ROqQfHVdNQhrT8W3+
        PnLlZtJpmSLmCRd5j5ZwdWYpS80mrykfIo7ALfNgNStg7MMClZR7KORyUTPsbmFnaM3Ktfg2Djrl7
        6BmnEJKC2C9J+MOgwPWSFEGSdVZh39wwgIcJUbF0pEUHe9rCXYab1K0gNUR81NdKimtWGmQSgeBLm
        KtRDlPAEALSQbYoeiZpXzebb1Yei8qqsZ74vxbae1kWqnsITJ1ghGtpvMDJ5pfAd1g6xwEBFqMp7U
        fZgk7RlhqkMIIvYZcFKjZOzzrKvtGCKxHratlrF70y3sq1dJaBs2l5cMOJtoOJLOw8sVqsA04++i4
        UKZNCnjQw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g06Nq-0007d9-T2; Wed, 12 Sep 2018 14:44:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Subject: [PATCH 0/2] Use named address spaces for percpu data
Date:   Wed, 12 Sep 2018 07:44:40 -0700
Message-Id: <20180912144442.29271-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rth wrote a patch back in 2016 that uses gcc's address space machinery
to improve code generation for percpu accesses.  Ingo asked for some
minor changes to be made, but Richard didn't respond.  While looking at
something related, I came across them, and asked Richard's permission
to resurrect and resend the patch, with the changes Ingo asked for at
the time.

The important information about why we want these patch is in 1/2.

Richard Henderson (2):
  x86: Use named address spaces in asm/percpu.h
  x86: Enable named address spaces for percpu data

 arch/x86/include/asm/percpu.h | 147 ++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 59 deletions(-)

-- 
2.18.0

