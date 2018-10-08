Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE228C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A999B214C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDe6yR6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A999B214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeJIB5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbeJIB5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:57:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C34A214C2;
        Mon,  8 Oct 2018 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024238;
        bh=MJI9kw0D9wKVY/uxCvFjJRiZqN20jWJ7d9X0PoKTYyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDe6yR6gHYL6f1BQVj4/qx0XJIosId7zafRXwQ5sr60ajDApQMNX/0A5/AW0sEIkP
         6nKTSMqdndGKtb6LhvJ+K0OOlaTC1xPi5ahM0GZ5pr7aYXlIiLWkOwwcPX2GOuEvuY
         rnIHiOYyBvnWMEkWx7ILlFWC/RE4N6nCLdNV0TtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Richard Kuo <rkuo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 68/94] arch/hexagon: fix kernel/dma.c build warning
Date:   Mon,  8 Oct 2018 20:31:49 +0200
Message-Id: <20181008175609.763484523@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 200f351e27f014fcbf69b544b0b4b72aeaf45fd3 ]

Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
to unsigned long to match the function parameter type.

../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool_add' makes integer from pointer without a cast [enabled by default]
../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but argument is of type 'void *'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Patch-mainline: linux-kernel @ 07/20/2018, 20:17
[rkuo@codeaurora.org: fixed architecture name]
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/hexagon/kernel/dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -59,7 +59,7 @@ static void *hexagon_dma_alloc_coherent(
 			panic("Can't create %s() memory pool!", __func__);
 		else
 			gen_pool_add(coherent_pool,
-				pfn_to_virt(max_low_pfn),
+				(unsigned long)pfn_to_virt(max_low_pfn),
 				hexagon_coherent_pool_size, -1);
 	}
 


