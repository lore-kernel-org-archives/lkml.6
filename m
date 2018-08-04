Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A509C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFF9217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFF9217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeHDNyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:54:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726588AbeHDNyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:54:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1CCA4646A0DC;
        Sat,  4 Aug 2018 19:53:24 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Sat, 4 Aug 2018 19:53:20 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <wensong@linux-vs.org>,
        <horms@verge.net.au>, <ja@ssi.bg>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: Remove some unneeded semicolon
Date:   Sat, 4 Aug 2018 19:41:41 +0800
Message-ID: <1533382901-17922-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That semicolon is not unneeded , Just remove them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/core/utils.c               | 2 +-
 net/netfilter/ipvs/ip_vs_ctl.c | 2 +-
 net/packet/af_packet.c         | 4 ++--
 net/sunrpc/auth_gss/auth_gss.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/utils.c b/net/core/utils.c
index d47863b..2a597ac 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -397,7 +397,7 @@ int inet_pton_with_scope(struct net *net, __kernel_sa_family_t af,
 		break;
 	default:
 		pr_err("unexpected address family %d\n", af);
-	};
+	}
 
 	return ret;
 }
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index dd21782..62eefea 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -134,7 +134,7 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 		} else {
 			atomic_set(&ipvs->dropentry, 0);
 			ipvs->sysctl_drop_entry = 1;
-		};
+		}
 		break;
 	case 3:
 		atomic_set(&ipvs->dropentry, 1);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e3e00d3..345e380 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1582,7 +1582,7 @@ static int fanout_set_data(struct packet_sock *po, char __user *data,
 		return fanout_set_data_ebpf(po, data, len);
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 static void fanout_release_data(struct packet_fanout *f)
@@ -1591,7 +1591,7 @@ static void fanout_release_data(struct packet_fanout *f)
 	case PACKET_FANOUT_CBPF:
 	case PACKET_FANOUT_EBPF:
 		__fanout_set_data_bpf(f, NULL);
-	};
+	}
 }
 
 static bool __fanout_id_is_free(struct sock *sk, u16 candidate_id)
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 3e192e2..846ea65 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -517,7 +517,7 @@ static int gss_encode_v1_msg(struct gss_upcall_msg *gss_msg,
 		err = gss_encode_v1_msg(gss_msg, service_name, gss_auth->target_name);
 		if (err)
 			goto err_put_pipe_version;
-	};
+	}
 	kref_get(&gss_auth->kref);
 	return gss_msg;
 err_put_pipe_version:
-- 
1.7.12.4

