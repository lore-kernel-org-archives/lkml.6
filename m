Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26236C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8D12084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRvH5pvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8D12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbeLJXnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:43:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40804 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbeLJXnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:43:14 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so805726ita.5;
        Mon, 10 Dec 2018 15:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8Oju/qNEdc3Exga3962tvQrW783ic9eTzPhr8jEUt0=;
        b=IRvH5pvm3yl2B5Jj9ZIJMcno3yvTAhD+t5/cU4+CSzk8+M2F97uYEBFu+r13MDMjHw
         7sMywOtOf6NxtbhE8TH6KsqQI274ujaRwHiRSnPWmsZKzzNLVGcUO0SYMRyhJv7zEpUj
         yeLt2/Det2fkfGaaQqSCX/kWWqPgYq8AooRM3O3WJKudja1eXQgYvu/5NvWOkD43jkGj
         +U2ydS/Yg8q6vqA2LMUT6koQZBXjkPfelai0mWLutK+P5IzmT4RB/2kNVkkFs5Hc0v5t
         kQKd/ukYzaDY2qdSsXF/ATEBaiW6qUiRE6O12kTWlxPrPPWNuD1wEidio2tlGJXdwXNF
         jtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8Oju/qNEdc3Exga3962tvQrW783ic9eTzPhr8jEUt0=;
        b=ZpvVGiBpXsq4BRNLvgIW7FyoLQBOujbv/EJfpLRzHibZcTThcvnm11aFh3ro28ZBW9
         H33aD9qG8s4d4uz8fNKYQuUtr+MX2m+Abw//EVoVnMX6WsyzeXs8JwQtaE1g01MCN+DC
         ldzM163BzsuH4aHVzCn5+LEKtS1EB9JRk3eoJ0g19tYolDMZ2+MAYo5dRc4jFDtubxdx
         5kaXoux2YePJ+4CXb02bXwUaj1NoGgMWY5kLf3PUqn/2fCv/Oed489Ah59S9b+JEEikm
         bhDwQ/kGaj6zUBVYK9jbEGLIwb24AleUHlLxQTgh9BVPcjbSQCQq7m0bSK19C6t8BCHi
         9vyg==
X-Gm-Message-State: AA+aEWafI6PCmimXzPiErvZeF8vdmc27kXv/rMh/vzEKkn1p1enbj7df
        ltJQpHi9Gvl6YeHJ+J9OqQ9MTSdIboI=
X-Google-Smtp-Source: AFSGD/X9itPei7iAmuMy1gWJSBWSkGVva6ScmOKYWmHCT8cwWZFM7PT6knWDrUdO4Tb3OQBzJxolNg==
X-Received: by 2002:a24:3a09:: with SMTP id m9mr378320itm.98.1544485392899;
        Mon, 10 Dec 2018 15:43:12 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::4:375a])
        by smtp.gmail.com with ESMTPSA id e68sm625346ite.7.2018.12.10.15.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:43:12 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     netdev@vger.kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: add btf annotations for cgroup_local_storage maps
Date:   Mon, 10 Dec 2018 15:43:02 -0800
Message-Id: <20181210234302.31327-4-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210234302.31327-1-guro@fb.com>
References: <20181210234302.31327-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add btf annotations to cgroup local storage maps (per-cpu and shared)
in the network packet counting example.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/netcnt_prog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/netcnt_prog.c b/tools/testing/selftests/bpf/netcnt_prog.c
index 1198abca1360..9f741e69cebe 100644
--- a/tools/testing/selftests/bpf/netcnt_prog.c
+++ b/tools/testing/selftests/bpf/netcnt_prog.c
@@ -16,12 +16,18 @@ struct bpf_map_def SEC("maps") percpu_netcnt = {
 	.value_size = sizeof(struct percpu_net_cnt),
 };
 
+BPF_ANNOTATE_KV_PAIR(percpu_netcnt, struct bpf_cgroup_storage_key,
+		     struct percpu_net_cnt);
+
 struct bpf_map_def SEC("maps") netcnt = {
 	.type = BPF_MAP_TYPE_CGROUP_STORAGE,
 	.key_size = sizeof(struct bpf_cgroup_storage_key),
 	.value_size = sizeof(struct net_cnt),
 };
 
+BPF_ANNOTATE_KV_PAIR(netcnt, struct bpf_cgroup_storage_key,
+		     struct net_cnt);
+
 SEC("cgroup/skb")
 int bpf_nextcnt(struct __sk_buff *skb)
 {
-- 
2.19.2

