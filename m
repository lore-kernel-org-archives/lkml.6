Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E1FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766EA20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766EA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeGXQRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:17:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388300AbeGXQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:17:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6OF6pwN086453
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 11:10:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ke61x1vgk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 11:10:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Tue, 24 Jul 2018 16:10:30 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 16:10:27 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6OFAQKn32833634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 15:10:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 226B9A4040;
        Tue, 24 Jul 2018 18:10:41 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1142A4055;
        Tue, 24 Jul 2018 18:10:40 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 18:10:40 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, wangnan0@huawei.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf build: Build error in libbpf with EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
Date:   Tue, 24 Jul 2018 17:10:11 +0200
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072415-0012-0000-0000-0000028E2951
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072415-0013-0000-0000-000020C00B5E
Message-Id: <20180724151011.36495-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their own sections")

cause a compiler error when building the perf tool in the linux-next tree.
I compile it using a FEDORA 28 installation, my gcc compiler version:
gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)

The file that causes the error is tools/lib/bpf/libbpf.c

Here is the error message:

[root@p23lp27] # make V=1 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
[...]
make -f /home6/tmricht/linux-next/tools/build/Makefile.build
	dir=./util/scripting-engines obj=libperf
libbpf.c: In function ‘bpf_object__elf_collect’:
libbpf.c:811:15: error: ignoring return value of ‘strerror_r’,
		declared with attribute warn_unused_result [-Werror=unused-result]
     strerror_r(-err, errmsg, sizeof(errmsg));
               ^
cc1: all warnings being treated as errors
mv: cannot stat './.libbpf.o.tmp': No such file or directory
/home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for target 'libbpf.o' failed

Fix this by using strerror_r return value in pr_warning statement.
Also fixes a possible initialization issue.

Cc: Wang Nan <wangnan0@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 955f8eafbf41..c70785ea903c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -808,9 +808,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			if (err) {
 				char errmsg[STRERR_BUFSIZE];
 
-				strerror_r(-err, errmsg, sizeof(errmsg));
 				pr_warning("failed to alloc program %s (%s): %s",
-					   name, obj->path, errmsg);
+					   name, obj->path,
+					   strerror_r(-err, errmsg, sizeof(errmsg)));
 			}
 		} else if (sh.sh_type == SHT_REL) {
 			void *reloc = obj->efile.reloc;
@@ -2334,7 +2334,7 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
 	__u64 data_tail = header->data_tail;
 	__u64 data_head = header->data_head;
 	void *base, *begin, *end;
-	int ret;
+	int ret = 0;
 
 	asm volatile("" ::: "memory"); /* in real code it should be smp_rmb() */
 	if (data_head == data_tail)
-- 
2.16.4

