Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA99C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8DB21783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547139410;
	bh=2ksbNhhslga8WE4WLD/QW+TVIGxtC5vydoklfem4ujI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZVnL/wekFPxIPR6AuOeXL3Tx0uYpeILs/xKBNtxXhPfClhXFTwV2w2gtdl0EiHBg0
	 ln/7NzgxxCqlsGcHsffJgd9H1CwjIbbkI73SSKoshGnl4esdxrSFnZ3MVZYXeDNYHI
	 Q/HFevcOq47ruH/zpigSFCPmq5TggJx3DXbJNnJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfAJQ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:56:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbfAJQ4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:56:47 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8404214DA;
        Thu, 10 Jan 2019 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547139406;
        bh=2ksbNhhslga8WE4WLD/QW+TVIGxtC5vydoklfem4ujI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpfxDp0duMISZFMR+l+F8ttV5EFKOVz7Lnf9GWK0N7C6geWM6nEr6/HFx2kEBluEJ
         OZbB1ig8jwU8YwVQtr/ft3qM+2hOkJT3iCh/uH7AIL7knihhc8bjHYKsKoRm95bbdY
         pKSFvY+2rDmk4rCzZ5KCKf9H7T/soJPsRxNKe3T0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Stefano Brivio <sbrivio@redhat.com>
Subject: [PATCH 1/4] tools include uapi: Sync linux/if_link.h copy with the kernel sources
Date:   Thu, 10 Jan 2019 13:56:33 -0300
Message-Id: <20190110165636.19338-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110165636.19338-1-acme@kernel.org>
References: <20190110165636.19338-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  a428afe82f98 ("net: bridge: add support for user-controlled bool options")
  a025fb5f49ad ("geneve: Allow configuration of DF behaviour")
  b4d3069783bc ("vxlan: Allow configuration of DF behaviour")

Silencing this tools/ build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Stefano Brivio <sbrivio@redhat.com>
Link: https://lkml.kernel.org/n/tip-wq410s2wuqv5k980bidw0ju8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 1debfa42cba1..d6533828123a 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -288,6 +288,7 @@ enum {
 	IFLA_BR_MCAST_IGMP_VERSION,
 	IFLA_BR_MCAST_MLD_VERSION,
 	IFLA_BR_VLAN_STATS_PER_PORT,
+	IFLA_BR_MULTI_BOOLOPT,
 	__IFLA_BR_MAX,
 };
 
@@ -533,6 +534,7 @@ enum {
 	IFLA_VXLAN_LABEL,
 	IFLA_VXLAN_GPE,
 	IFLA_VXLAN_TTL_INHERIT,
+	IFLA_VXLAN_DF,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -542,6 +544,14 @@ struct ifla_vxlan_port_range {
 	__be16	high;
 };
 
+enum ifla_vxlan_df {
+	VXLAN_DF_UNSET = 0,
+	VXLAN_DF_SET,
+	VXLAN_DF_INHERIT,
+	__VXLAN_DF_END,
+	VXLAN_DF_MAX = __VXLAN_DF_END - 1,
+};
+
 /* GENEVE section */
 enum {
 	IFLA_GENEVE_UNSPEC,
@@ -557,10 +567,19 @@ enum {
 	IFLA_GENEVE_UDP_ZERO_CSUM6_RX,
 	IFLA_GENEVE_LABEL,
 	IFLA_GENEVE_TTL_INHERIT,
+	IFLA_GENEVE_DF,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
 
+enum ifla_geneve_df {
+	GENEVE_DF_UNSET = 0,
+	GENEVE_DF_SET,
+	GENEVE_DF_INHERIT,
+	__GENEVE_DF_END,
+	GENEVE_DF_MAX = __GENEVE_DF_END - 1,
+};
+
 /* PPP section */
 enum {
 	IFLA_PPP_UNSPEC,
-- 
2.20.1

