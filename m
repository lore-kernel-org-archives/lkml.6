Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46F8C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B73D21473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXZm+zBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B73D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbeKZVxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbeKZVxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:53:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D2B21104;
        Mon, 26 Nov 2018 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229973;
        bh=oLxjS1tafNok7kM8yg3c5aiXyNNc9CixV6cgruovbO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXZm+zBcQDXyTQLLFh1e/wuehYYH5JFeLkx8886+j3o7oed/y3SD9AkCnYYSExLZT
         8F0yy5imRW4iZvNXbHFD65aNfH5B0YFqg0eqyPSlQ+5X8dPegYTImAFCOw07paN1eu
         snqu4/wowvKVLcVU8sL5eXDQHvyzOORzL+qvv9go=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 23/62] s390/mm: Fix ERROR: "__node_distance" undefined!
Date:   Mon, 26 Nov 2018 11:51:04 +0100
Message-Id: <20181126105052.715456166@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
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

[ Upstream commit a541f0ebcc08ed8bc0cc492eec9a86cb280a9f24 ]

Fixes:
ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
make: *** [Makefile:1275: modules] Error 2
+ exit 1

Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/numa/numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index 5bd374491f94..6c151b42e65d 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -54,6 +54,7 @@ int __node_distance(int a, int b)
 {
 	return mode->distance ? mode->distance(a, b) : 0;
 }
+EXPORT_SYMBOL(__node_distance);
 
 int numa_debug_enabled;
 
-- 
2.17.1



