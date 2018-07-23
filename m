Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8465EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9C020875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9C020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbeGWOqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:46:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388037AbeGWOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:46:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NDi0fd140869
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 09:45:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdd9x0mmu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 09:45:13 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 23 Jul 2018 14:45:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 14:45:08 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NDj7fX42336330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 13:45:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D130B4C04A;
        Mon, 23 Jul 2018 16:45:23 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 796244C059;
        Mon, 23 Jul 2018 16:45:23 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jul 2018 16:45:23 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, wangnan0@huawei.com
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf build: Build error in libbpf with EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
Date:   Mon, 23 Jul 2018 15:45:01 +0200
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072313-0020-0000-0000-000002A9F313
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072313-0021-0000-0000-000020F67EAF
Message-Id: <20180723134501.11180-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their own sections")

cause a compiler error when building the perf tool in the linux-next tree.
I compile it using a FEDORA 28 installation, my gcc compiler version:
gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)

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

