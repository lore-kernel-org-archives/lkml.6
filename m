Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765C4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9342087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9342087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeH1Uob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:44:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:42190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbeH1Uob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:44:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 477BEAF49;
        Tue, 28 Aug 2018 16:51:59 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id B13DCA0C37; Tue, 28 Aug 2018 18:51:58 +0200 (CEST)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next] genetlink: constify genl_err_attr() argument
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20180828165158.B13DCA0C37@unicorn.suse.cz>
Date:   Tue, 28 Aug 2018 18:51:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

genl_err_attr() sets netlink_ext_ack::bad_attr which is a pointer to const
struct nlattr so make the attr argument also const.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 include/net/genetlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index decf6012a401..aa2e5888f18d 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -112,7 +112,7 @@ static inline void genl_info_net_set(struct genl_info *info, struct net *net)
 #define GENL_SET_ERR_MSG(info, msg) NL_SET_ERR_MSG((info)->extack, msg)
 
 static inline int genl_err_attr(struct genl_info *info, int err,
-				struct nlattr *attr)
+				const struct nlattr *attr)
 {
 	info->extack->bad_attr = attr;
 
-- 
2.18.0

