Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DC1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8492E26595
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8492E26595
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeFZG4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:56:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeFZG4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:56:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6uLbw1591550
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:56:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6uKEX1591547;
        Mon, 25 Jun 2018 23:56:20 -0700
Date:   Mon, 25 Jun 2018 23:56:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ezi5u0mmdqm0wfm0y2y8176r@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        nikolay@cumulusnetworks.com, eric@regit.org, hpa@zytor.com,
        ast@kernel.org, davem@davemloft.net, liuhangbin@gmail.com,
        mingo@kernel.org
Reply-To: liuhangbin@gmail.com, mingo@kernel.org, davem@davemloft.net,
          hpa@zytor.com, ast@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, eric@regit.org,
          nikolay@cumulusnetworks.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Update if_link.h to pick
 IFLA_{BRPORT_ISOLATED,VXLAN_TTL_INHERIT}
Git-Commit-ID: bb9a33cb8a807e5ae9906563f5c1533904651b8b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bb9a33cb8a807e5ae9906563f5c1533904651b8b
Gitweb:     https://git.kernel.org/tip/bb9a33cb8a807e5ae9906563f5c1533904651b8b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 15 Jun 2018 16:46:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:36 -0300

tools include uapi: Update if_link.h to pick IFLA_{BRPORT_ISOLATED,VXLAN_TTL_INHERIT}

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
