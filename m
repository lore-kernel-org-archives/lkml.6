Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C56C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AC5214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzacM5gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AC5214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbeJICDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbeJICDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE036204FD;
        Mon,  8 Oct 2018 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024596;
        bh=bgzrKcFqtpfVasW1HnzG+8+fss6gibb24FHIxT91lw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzacM5gD7EXlDugW/cXcMvDoWGn1sIqsEzEvODJrbjZmMvJGtPDAZJESC3R+HQ18w
         yTYynD6Q9gMwnDtervVHFLfzeJnciSuggRmKoun9HSpptoisgjRnO1vuPy+L3Vtcbr
         oy/8aes/oXgM7NuZMnAjxhUIqCFFrMznru8kqECk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zong Li <zong@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 068/168] nds32: Fix empty call trace
Date:   Mon,  8 Oct 2018 20:30:48 +0200
Message-Id: <20181008175622.645568863@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zong Li <zong@andestech.com>

[ Upstream commit c17df7960534357fb74074c2f514c831d4a9cf5a ]

The compiler predefined macro 'NDS32_ABI_2' had been removed, it should
use the '__NDS32_ABI_2' here.

Signed-off-by: Zong Li <zong@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nds32/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -137,7 +137,7 @@ static void __dump(struct task_struct *t
 		       !((unsigned long)base_reg & 0x3) &&
 		       ((unsigned long)base_reg >= TASK_SIZE)) {
 			unsigned long next_fp;
-#if !defined(NDS32_ABI_2)
+#if !defined(__NDS32_ABI_2)
 			ret_addr = base_reg[0];
 			next_fp = base_reg[1];
 #else


