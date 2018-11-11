Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A72AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C04520818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaTocbD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C04520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403757AbeKLIyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:54:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390481AbeKLIWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:18 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED3C21508;
        Sun, 11 Nov 2018 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975541;
        bh=1DYQzYOoL+7MHKqAfqothTKRMIBoXDAinC+a5UBPc44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaTocbD+rUj4kTLZ0FQHu8Psp8TR42CftX3nVHaTSvdIc/V7GP6lNH6RTwp+7eYpw
         +5PXSM6BfpesidVhArY1g6nmMcmJ+oIz39xYfzrRgk+zNr+EFDmfOPr2dHFPrAJA7T
         6m1vGL6k09XUiCAyazy6VhbIIj26cw6pZw37k3sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 031/222] sparc64: Make proc_id signed.
Date:   Sun, 11 Nov 2018 14:22:08 -0800
Message-Id: <20181111221651.013014265@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
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

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit b3e1eb8e7ac9aaa283989496651d99267c4cad6c ]

So that when it is unset, ie. '-1', userspace can see it
properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/include/asm/cpudata_64.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -28,7 +28,7 @@ typedef struct {
 	unsigned short	sock_id;	/* physical package */
 	unsigned short	core_id;
 	unsigned short  max_cache_id;	/* groupings of highest shared cache */
-	unsigned short	proc_id;	/* strand (aka HW thread) id */
+	signed short	proc_id;	/* strand (aka HW thread) id */
 } cpuinfo_sparc;
 
 DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);


