Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD220C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747A82086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543746;
	bh=j/fhuNoYIGxQvufnvxWnE4T0+mGYXA/87YN/ZHNzR9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNbA+apiZqjRRi1jQHE/vMT1vfkLtBB9xIFHNCwDla9uMuJv8EeUbf/4jWjA2Vopw
	 NIGIni2ieUr0lmCTYMhozXCLnVmukZ2mULtIvo4tMKjHScGtlW5h6sxY8bpk2Fiscz
	 4g9iZAhSUhzbAeVcfeKec5yu34VaZakJvzTtnzWU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747A82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbeLKPzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730427AbeLKPzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98666208E7;
        Tue, 11 Dec 2018 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543742;
        bh=j/fhuNoYIGxQvufnvxWnE4T0+mGYXA/87YN/ZHNzR9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jcm4kWImAOpbYab+xEQG3Lz6Zdudu7Pq2h5+LXx3xPP4Vbdi+/ZhO6T4EkjeUTu5u
         OL/6O0SPj4bWmuOOtXt8i+F7QrJBJq7TVZfkBghBs3eF/zkySKXbqmhayQRUg2atXE
         W6aVX7kwcwGjG88eKBBZlhjtX1fFuP1J7TetMznU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 047/118] riscv: fix warning in arch/riscv/include/asm/module.h
Date:   Tue, 11 Dec 2018 16:41:06 +0100
Message-Id: <20181211151646.142691676@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0138ebb90c633f76bc71617f8f23635ce41c84fd ]

Fixes warning: 'struct module' declared inside parameter list will not be
visible outside of this definition or declaration

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Acked-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/module.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
index 349df33808c4..cd2af4b013e3 100644
--- a/arch/riscv/include/asm/module.h
+++ b/arch/riscv/include/asm/module.h
@@ -8,6 +8,7 @@
 
 #define MODULE_ARCH_VERMAGIC    "riscv"
 
+struct module;
 u64 module_emit_got_entry(struct module *mod, u64 val);
 u64 module_emit_plt_entry(struct module *mod, u64 val);
 
-- 
2.19.1



