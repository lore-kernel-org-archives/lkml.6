Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4603820657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dZbUmsP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405638AbfAPQa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:30:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50924 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730221AbfAPQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:29:57 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0GGRZ5O012576
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:29:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=4wXp/c/Qq3o/hgNoqZmm2HN5rTcKkiYixDqf13d4Ti4=;
 b=dZbUmsP7olQfhnewvE3tm9x3D4qltLfHk0DuJWipVG7fcZrxn6U6xouveBx5OaVCOJ1x
 4DPSt6f/Cd//hiC2p56NGoWcsVSs2sECCnpMPpxl6IDlI37MeD4on+7+eLWXeqDaXpCV
 IAqtwuf7MsIs/WJf8tFAnqJiLV4nZ6PEswE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q26x0g98t-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:29:56 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 16 Jan 2019 08:29:50 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 58F4862E1D0D; Wed, 16 Jan 2019 08:29:50 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <dsahern@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v10 perf, bpf-next 9/9] bpf: add module name [bpf] to ksymbols for bpf programs
Date:   Wed, 16 Jan 2019 08:29:31 -0800
Message-ID: <20190116162931.1542429-10-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116162931.1542429-1-songliubraving@fb.com>
References: <20190116162931.1542429-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, /proc/kallsyms will show BPF programs as

  <addr> t bpf_prog_<tag>_<name> [bpf]

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index f3a04994e063..14934afa9e68 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -494,7 +494,7 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 
 static int get_ksymbol_bpf(struct kallsym_iter *iter)
 {
-	iter->module_name[0] = '\0';
+	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
 	return bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			       &iter->value, &iter->type,
-- 
2.17.1

