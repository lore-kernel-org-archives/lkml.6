Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614F2C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12064208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12064208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404596AbeHGVPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:15:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403938AbeHGVPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:15:16 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3542B74;
        Tue,  7 Aug 2018 18:59:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 33/85] powerpc/8xx: fix invalid register expression in head_8xx.S
Date:   Tue,  7 Aug 2018 20:51:35 +0200
Message-Id: <20180807172358.562522081@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit e4ccb1dae6bdef228d729c076c38161ef6e7ca34 ]

New binutils generate the following warning

  AS      arch/powerpc/kernel/head_8xx.o
arch/powerpc/kernel/head_8xx.S: Assembler messages:
arch/powerpc/kernel/head_8xx.S:916: Warning: invalid register expression

This patch fixes it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/head_8xx.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -722,7 +722,7 @@ start_here:
 	tovirt(r6,r6)
 	lis	r5, abatron_pteptrs@h
 	ori	r5, r5, abatron_pteptrs@l
-	stw	r5, 0xf0(r0)	/* Must match your Abatron config file */
+	stw	r5, 0xf0(0)	/* Must match your Abatron config file */
 	tophys(r5,r5)
 	stw	r6, 0(r5)
 


