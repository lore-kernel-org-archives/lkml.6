Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0027C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F38F21508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7zssYli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F38F21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbeKLIRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732069AbeKLIRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:49 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E830C223C8;
        Sun, 11 Nov 2018 22:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975274;
        bh=966Nmbpjf3r2N3XJyIY2vFvvHtTrhjsn5jiFb+pj15k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7zssYli+sw3kFSN0BvqihYeUxpbZhoM+dYlmMfp+6/8FyJUWLzS8AbL4xpIzH7sg
         v0ADhLk+kxC8YLe02sKTmPCrxUnGdlgC3Rn/BRYLIVekIoFIgIMxrztM67YYiQGJOV
         QKjfSoVQR9i30uynNG54kwa9BEfxnSxVOFFCI9wY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/361] of: Add missing exports of node name compare functions
Date:   Sun, 11 Nov 2018 14:18:03 -0800
Message-Id: <20181111221639.528358770@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit 173ee3962959a1985a109f81539a403b5cd07ae7 ]

Commit f42b0e18f2e5 ("of: add node name compare helper functions")
failed to add the module exports to of_node_name_eq() and
of_node_name_prefix(). Add them now.

Fixes: f42b0e18f2e5 ("of: add node name compare helper functions")
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/base.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -67,6 +67,7 @@ bool of_node_name_eq(const struct device
 
 	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
 }
+EXPORT_SYMBOL(of_node_name_eq);
 
 bool of_node_name_prefix(const struct device_node *np, const char *prefix)
 {
@@ -75,6 +76,7 @@ bool of_node_name_prefix(const struct de
 
 	return strncmp(kbasename(np->full_name), prefix, strlen(prefix)) == 0;
 }
+EXPORT_SYMBOL(of_node_name_prefix);
 
 int of_n_addr_cells(struct device_node *np)
 {


