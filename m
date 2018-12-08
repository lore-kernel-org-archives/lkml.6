Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56BFC07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E6C2081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCo7OLNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E6C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLHAxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:53:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33870 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLHAxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:53:33 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so2836471itd.1;
        Fri, 07 Dec 2018 16:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8Oju/qNEdc3Exga3962tvQrW783ic9eTzPhr8jEUt0=;
        b=LCo7OLNVlrdE2QRYoMYkUuOy2fULaEth03wrkmiCs92dPAO2PanFD0rCVUhLOUtwXu
         bAZiHPeJZu4KuY71Z58w5qs5dOCY3f8k0DPXulo1RX98UAimVScfXoWYFbxx7/7nFR/y
         jRtX5pxR8BfHKuqH3Ovw+5YvKsLoPneUcLyfd/g0b8EezlafsqvbR9CjJneFKSx9xoAB
         R4gQxrKU3qo6qhhoBTrTq6OS6pRfy1NU9EVeV8j2iYyzbT2rfYs50CL+OgoWHaQ6MbA8
         qaJ0RAGCEkkLNEPkBuUu4Vqdga1yYC3BKHRAyQpEJ5GVFYUrDZtYF1t4sZfv6xLoZ8NN
         9Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8Oju/qNEdc3Exga3962tvQrW783ic9eTzPhr8jEUt0=;
        b=lE3X35pWzmJnBbZFHDWaabo/bSZoQlUdBUBYs8E3t7kxZivaRPxPzwACd7By/OZSqm
         CqM+OGaeBU63/PG1TLOX40wjt9EsScz2vtY7iKUpAeW1Zw3OgHHPFECSgVHbN/7dBh7B
         Ja6ZfGuu2cosD/K9qQ9Bn0Qi/5+nT7reDTRIzNz2afmdEdCxuA6Zf0FAlVxXBHNgGyG9
         yf2QBz25P4mAh+12TFtVfG3P1U4RORrND3cdcBOk1vFbmeq5uugjJaB9zy4B7z6oPoe5
         /XLXWhYl1eV8iPfcHUqwlIIQ3PazNvxQSDBovOdm+cap3h2+XgzUL6ge5ecZhgTwbOJ6
         CRxQ==
X-Gm-Message-State: AA+aEWbyzUk3XSbbuo5VMvkxA7jffouZtyGHL3oH6qOGUn8jCPm5I93J
        gAUqDSqM43P1Ey/9v0BgxTZzQDGL6GU=
X-Google-Smtp-Source: AFSGD/V1PGv0puhNj1AOgbby9uvTT2BJ0C+YPDobUKN0PyrNM5rnCUa/1Gmu8Q1lLSPm83HJLuoSHw==
X-Received: by 2002:a24:fe06:: with SMTP id w6mr4019040ith.108.1544230411445;
        Fri, 07 Dec 2018 16:53:31 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::6:9a2e])
        by smtp.gmail.com with ESMTPSA id 21sm2069769iou.79.2018.12.07.16.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 16:53:30 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     netdev@vger.kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add btf annotations for cgroup_local_storage maps
Date:   Fri,  7 Dec 2018 16:53:15 -0800
Message-Id: <20181208005315.3500-3-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208005315.3500-1-guro@fb.com>
References: <20181208005315.3500-1-guro@fb.com>
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

