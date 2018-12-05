Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798F42081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwtlLnWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798F42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbeLEM5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:57:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46548 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLEM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:57:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so8981748pgp.13;
        Wed, 05 Dec 2018 04:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u76+uaJNmqXBcbceRtv700OhUJyEBshLq/RzDGn/tQ8=;
        b=QwtlLnWPalsUTRJz5VNP9FWi/5KUPvYerh7DSbuxcjS98bszAtGmc1AsQDml8MbE/X
         EFXlgsJtIARud/VQjrGz58y8kL58cmUt+Kd66/UqybwAm3IcAXPRslgSgh3sxjElHZks
         baEPB0sZBO93QN9OGgtnMS4JAjTJefAhtXB/ePtCOqeYbOw+nAdVqs6EG8cjxZfwV4WE
         lMIPxicRiBdyR+szcN0wE3H2EZwrFKohq2FWtq0qE+XxI14zC2ylOkFqCsST4DZ0GgdN
         zkUfguKxlj+hjDZmWCfv7vcNudMmSOeaCtQytk3Q8Tl63Dn20/Jh7ZT/a/My5TCWXrcr
         B/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u76+uaJNmqXBcbceRtv700OhUJyEBshLq/RzDGn/tQ8=;
        b=NNH8nPlDHixtWB4KkHKLOGW+z1I/DAQAOGM4gqN3NxpasnH+o5YVBbbS3yIz9gfVz0
         8awvA+RBlh8E9lGxpPbOrGvxsl+Xccx9ZSoH+/mZu8Z/04x/+bAAwBLfcI1xTTs4wH/r
         OQ9qIZwRz+k0+szE5WhAsu8mvJzRdc+wX+VGqN17SyKAj80EirTDVC6LqdNaemjDgtTg
         yEhZZYvlLsaBDzQm77spex8vt8NbcSCVN0kn1cUd94lsBb8fJdLKPnsfWcKgSyXzSsPp
         YDFgOAz57m0TynsqvD0WhfGebZE4Y6TOVTNtaLes06gkmmK1ieMQrWpY+qcI7olGbIEg
         VdWg==
X-Gm-Message-State: AA+aEWYv9Sj9/GgWXc/88WgbhS6jb0c7uPx8flfcD9RLA+07O3/DkSKt
        FrrRfhact/iXwwsVREr/BUM=
X-Google-Smtp-Source: AFSGD/V5NYHbmTSX6BiiZ7e47Qxl1ctsOSqC/yERI/CuE0YNmmRAYOCAYoAFXDLTbwTXqG5BZ1MssQ==
X-Received: by 2002:a63:f444:: with SMTP id p4mr20124182pgk.124.1544014643684;
        Wed, 05 Dec 2018 04:57:23 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q1sm26348898pfb.96.2018.12.05.04.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:57:23 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, adobriyan@gmail.com, akpm@linux-foundation.org
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 2/5] netfilter: register sysctl table for gre
Date:   Wed,  5 Dec 2018 20:56:27 +0800
Message-Id: <1544014590-14429-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
References: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After this patch, there will be two sysctl knobs for GRE.

	net.netfilter.nf_conntrack_gre_timeout_replied = 180
	net.netfilter.nf_conntrack_gre_timeout_unreplied = 30

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/netfilter/nf_conntrack_proto_gre.c | 43 +++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_proto_gre.c b/net/netfilter/nf_conntrack_proto_gre.c
index 2a5e56c..a70894e 100644
--- a/net/netfilter/nf_conntrack_proto_gre.c
+++ b/net/netfilter/nf_conntrack_proto_gre.c
@@ -320,9 +320,50 @@ static int gre_timeout_nlattr_to_obj(struct nlattr *tb[],
 };
 #endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table gre_sysctl_table[] = {
+	{
+		.procname       = "nf_conntrack_gre_timeout_unreplied",
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_jiffies,
+	},
+	{
+		.procname       = "nf_conntrack_gre_timeout_replied",
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_jiffies,
+	},
+	{}
+};
+#endif /* CONFIG_SYSCTL */
+
+static int gre_kmemdup_sysctl_table(struct net *net, struct nf_proto_net *nf,
+				    struct netns_proto_gre *net_gre)
+{
+#ifdef CONFIG_SYSCTL
+	int i;
+
+	if (nf->ctl_table)
+		return 0;
+
+	nf->ctl_table = kmemdup(gre_sysctl_table,
+				sizeof(gre_sysctl_table),
+				GFP_KERNEL);
+	if (!nf->ctl_table)
+		return -ENOMEM;
+
+	for (i = 0; i < GRE_CT_MAX; i++)
+		nf->ctl_table[i].data = &net_gre->gre_timeouts[i];
+#endif
+
+	return 0;
+}
+
 static int gre_init_net(struct net *net)
 {
 	struct netns_proto_gre *net_gre = gre_pernet(net);
+	struct nf_proto_net *nf = &net_gre->nf;
 	int i;
 
 	rwlock_init(&net_gre->keymap_lock);
@@ -330,7 +371,7 @@ static int gre_init_net(struct net *net)
 	for (i = 0; i < GRE_CT_MAX; i++)
 		net_gre->gre_timeouts[i] = gre_timeouts[i];
 
-	return 0;
+	return gre_kmemdup_sysctl_table(net, nf, net_gre);
 }
 
 /* protocol helper struct */
-- 
1.8.3.1

