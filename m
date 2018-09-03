Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88429C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3232086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3232086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbeICVpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:45:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbeICVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:45:08 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8DB79D24;
        Mon,  3 Sep 2018 17:24:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ofer Levi <oferle@mellanox.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 064/165] ARC: [plat-eznps] Add missing struct nps_host_reg_aux_dpc
Date:   Mon,  3 Sep 2018 18:55:50 +0200
Message-Id: <20180903165658.329599603@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ofer Levi <oferle@mellanox.com>

[ Upstream commit 05b466bf846d2e8d2f0baf8dfd81a42cc933e237 ]

Fixing compilation issue caused by missing struct nps_host_reg_aux_dpc
definition.

Fixes: 3f9cd874dcc87 ("ARC: [plat-eznps] avoid toggling of DPC register")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ofer Levi <oferle@mellanox.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/plat-eznps/include/plat/ctop.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/arc/plat-eznps/include/plat/ctop.h
+++ b/arch/arc/plat-eznps/include/plat/ctop.h
@@ -143,6 +143,15 @@ struct nps_host_reg_gim_p_int_dst {
 };
 
 /* AUX registers definition */
+struct nps_host_reg_aux_dpc {
+	union {
+		struct {
+			u32 ien:1, men:1, hen:1, reserved:29;
+		};
+		u32 value;
+	};
+};
+
 struct nps_host_reg_aux_udmc {
 	union {
 		struct {


