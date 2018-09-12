Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA3C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E902146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNSIfOAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E902146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeIMABn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeIMABm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:01:42 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA0D21473;
        Wed, 12 Sep 2018 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536778551;
        bh=rSO9TSSyHPK5l0h/fsQudeUh5Ozgi4+0YoGtjk1i1dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNSIfOAwU/xqhNx937V2Z0QBcKt9aNQ9pFZmQMY6ViBlKZLxDUM51KQe8IQYniTXu
         Bli8piX7XfV7jSgQTGuXG9nN+gUny8KHx7ctmr2HHxd/KL0BEnquAMTO2nTwTz6gxu
         i06xAQZJcUO/OtqtzoiJuxt9PCnZAvfNErAAOV0Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 6/7] tools headers uapi: Update tools's copy of linux/if_link.h
Date:   Wed, 12 Sep 2018 15:55:08 -0300
Message-Id: <20180912185509.32187-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

	3e7a50ceb11e ("net: report min and max mtu network device settings")
	2756f68c3149 ("net: bridge: add support for backup port")
	a25717d2b604 ("xdp: support simultaneous driver and hw XDP attachment")
	4f91da26c811 ("xdp: add per mode attributes for attached programs")
	f203b76d7809 ("xfrm: Add virtual xfrm interfaces")

Silencing this libbpf build warning:

	Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xd9ztioa894zemv8ag8kg64u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index cf01b6824244..43391e2d1153 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -164,6 +164,8 @@ enum {
 	IFLA_CARRIER_UP_COUNT,
 	IFLA_CARRIER_DOWN_COUNT,
 	IFLA_NEW_IFINDEX,
+	IFLA_MIN_MTU,
+	IFLA_MAX_MTU,
 	__IFLA_MAX
 };
 
@@ -334,6 +336,7 @@ enum {
 	IFLA_BRPORT_GROUP_FWD_MASK,
 	IFLA_BRPORT_NEIGH_SUPPRESS,
 	IFLA_BRPORT_ISOLATED,
+	IFLA_BRPORT_BACKUP_PORT,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
@@ -459,6 +462,16 @@ enum {
 
 #define IFLA_MACSEC_MAX (__IFLA_MACSEC_MAX - 1)
 
+/* XFRM section */
+enum {
+	IFLA_XFRM_UNSPEC,
+	IFLA_XFRM_LINK,
+	IFLA_XFRM_IF_ID,
+	__IFLA_XFRM_MAX
+};
+
+#define IFLA_XFRM_MAX (__IFLA_XFRM_MAX - 1)
+
 enum macsec_validation_type {
 	MACSEC_VALIDATE_DISABLED = 0,
 	MACSEC_VALIDATE_CHECK = 1,
@@ -920,6 +933,7 @@ enum {
 	XDP_ATTACHED_DRV,
 	XDP_ATTACHED_SKB,
 	XDP_ATTACHED_HW,
+	XDP_ATTACHED_MULTI,
 };
 
 enum {
@@ -928,6 +942,9 @@ enum {
 	IFLA_XDP_ATTACHED,
 	IFLA_XDP_FLAGS,
 	IFLA_XDP_PROG_ID,
+	IFLA_XDP_DRV_PROG_ID,
+	IFLA_XDP_SKB_PROG_ID,
+	IFLA_XDP_HW_PROG_ID,
 	__IFLA_XDP_MAX,
 };
 
-- 
2.14.4

