Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A48C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439C1213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439C1213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJDJtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:49:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54942 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbeJDJtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:49:02 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w942qJtH008245
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 19:57:54 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mw7708g4a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 19:57:54 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.13) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Oct
 2018 19:57:54 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)  id
 232C5760B5C; Wed,  3 Oct 2018 19:57:51 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     "David S . Miller" <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <luto@amacapital.net>,
        <viro@zeniv.linux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 4/6] trace/bpf: allow %o modifier in bpf_trace_printk
Date:   Wed, 3 Oct 2018 19:57:48 -0700
Message-ID: <20181004025750.498303-5-ast@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004025750.498303-1-ast@kernel.org>
References: <20181004025750.498303-1-ast@kernel.org>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow %o modifier in bpf_trace_printk() helper

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 08fcfe440c63..b993efef1a4b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -233,7 +233,7 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 			i++;
 		}
 
-		if (fmt[i] != 'i' && fmt[i] != 'd' &&
+		if (fmt[i] != 'i' && fmt[i] != 'd' && fmt[i] != 'o' &&
 		    fmt[i] != 'u' && fmt[i] != 'x')
 			return -EINVAL;
 		fmt_cnt++;
-- 
2.17.1

