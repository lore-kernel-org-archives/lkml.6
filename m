Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2C5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C577C23FA5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj7CRrlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C577C23FA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964826AbeFYRn4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964934AbeFYRlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:37 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE46C25F7E;
        Mon, 25 Jun 2018 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948496;
        bh=RXxVhMVlz1lVCnnuVvr993HHqHuAg6QkVP/dbRI4Vmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tj7CRrlxLfut8WWNt33/Buax9hVEX14uvl5UyPTsSWGD1SRbXlNCItis6oQj8xXmi
         zI/WBpiVLVbt46Q233kmQXJJuvb2/r/qkmpJviQf1Y328GCecDz/K40cBq8AzMJX38
         Gt1ICayRk6AEumbggcStvgaTiIoQOG0NrcOVXgmM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Leblond <eric@regit.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Subject: [PATCH 10/19] tools include uapi: Update if_link.h to pick IFLA_{BRPORT_ISOLATED,VXLAN_TTL_INHERIT}
Date:   Mon, 25 Jun 2018 14:40:36 -0300
Message-Id: <20180625174045.25765-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The IFLA_BRPORT_ISOLATED and IFLA_VXLAN_TTL_INHERIT defines were added in:

  7d850abd5f4e ("net: bridge: add support for port isolation")
  72f6d71e491e ("vxlan: add ttl inherit support")

Pick them, silencing this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Leblond <eric@regit.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Link: https://lkml.kernel.org/n/tip-ezi5u0mmdqm0wfm0y2y8176r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 68699f654118..cf01b6824244 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -333,6 +333,7 @@ enum {
 	IFLA_BRPORT_BCAST_FLOOD,
 	IFLA_BRPORT_GROUP_FWD_MASK,
 	IFLA_BRPORT_NEIGH_SUPPRESS,
+	IFLA_BRPORT_ISOLATED,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
@@ -516,6 +517,7 @@ enum {
 	IFLA_VXLAN_COLLECT_METADATA,
 	IFLA_VXLAN_LABEL,
 	IFLA_VXLAN_GPE,
+	IFLA_VXLAN_TTL_INHERIT,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
-- 
2.14.3

