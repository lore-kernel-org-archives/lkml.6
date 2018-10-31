Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8292EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9B520847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/EJ7PIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9B520847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbeKABpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbeKABpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:45:30 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A0C2081B;
        Wed, 31 Oct 2018 16:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004402;
        bh=jbNLX2xwG09t2YFvgRlBT6MPj05MytAg38EqWTAlehA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/EJ7PIOVA8Rd7suBrJGDpuGb6wzWbwT6Jgb1m0kfDmQDed93EeF4n3KMkWp/iwki
         UXlDxEd/cfePM+i7C21KKgC2vNhbvzwjFADpSvyN+nog9rRBk5nGpTkKrBZezgKBRJ
         ECIQ3L25gpkJvoCGfdVBtzXZ+R43zkoYXFW/mrkg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Leblond <eric@regit.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Subject: [PATCH 24/28] tools headers uapi: Update linux/if_link.h header copy
Date:   Wed, 31 Oct 2018 13:45:04 -0300
Message-Id: <20181031164508.4784-25-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  9163a0fc1f0c ("net: bridge: add support for per-port vlan stats")

And silence this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Leblond <eric@regit.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Link: https://lkml.kernel.org/n/tip-7p53ghippywz7fqkwo3nkzet@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 58faab897201..1debfa42cba1 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -287,6 +287,7 @@ enum {
 	IFLA_BR_MCAST_STATS_ENABLED,
 	IFLA_BR_MCAST_IGMP_VERSION,
 	IFLA_BR_MCAST_MLD_VERSION,
+	IFLA_BR_VLAN_STATS_PER_PORT,
 	__IFLA_BR_MAX,
 };
 
-- 
2.14.4

