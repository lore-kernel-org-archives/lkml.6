Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5732C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A1020844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A1020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeGYIcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:32:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728316AbeGYIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:32:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6P7EQ84083020
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 03:21:47 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kejttcxw2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 03:21:47 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 25 Jul 2018 08:21:45 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 08:21:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6P7LhaH37421204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 07:21:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B706AE055;
        Wed, 25 Jul 2018 10:21:51 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EE0DAE061;
        Wed, 25 Jul 2018 10:21:51 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jul 2018 10:21:51 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, wangnan0@huawei.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf build: Build error in libbpf with EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
Date:   Wed, 25 Jul 2018 09:21:26 +0200
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072507-0016-0000-0000-000001EB1B08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072507-0017-0000-0000-0000323FFC34
Message-Id: <20180725072126.2232-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their own sections")

causes a compiler error when building the perf tool in the linux-next tree.
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

Since this is the only occurance of strerror_r() replace it
by strerror(). The additional functionality of strerror_r() to
copy the error message into the supplied buffer is not needed.
This is also consistant with all the other pr_warning() statements
in this file which all use strerror().

Also fixes a possible initialization issue.

Cc: Wang Nan <wangnan0@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 955f8eafbf41..f9eb68ff2f4f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -806,11 +806,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			err = bpf_object__add_program(obj, data->d_buf,
 						      data->d_size, name, idx);
 			if (err) {
-				char errmsg[STRERR_BUFSIZE];
-
-				strerror_r(-err, errmsg, sizeof(errmsg));
 				pr_warning("failed to alloc program %s (%s): %s",
-					   name, obj->path, errmsg);
+					   name, obj->path, strerror(-err));
 			}
 		} else if (sh.sh_type == SHT_REL) {
 			void *reloc = obj->efile.reloc;
@@ -2334,7 +2331,7 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
 	__u64 data_tail = header->data_tail;
 	__u64 data_head = header->data_head;
 	void *base, *begin, *end;
-	int ret;
+	int ret = 0;
 
 	asm volatile("" ::: "memory"); /* in real code it should be smp_rmb() */
 	if (data_head == data_tail)
-- 
2.16.4

