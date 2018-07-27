Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D6C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1504020673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1504020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeG0JmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:42:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729472AbeG0JmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:42:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6R8JU4J014066
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 04:21:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kfy2ea7jv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 04:21:36 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 27 Jul 2018 09:21:34 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 09:21:30 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6R8LTHU30605454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 08:21:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3486911C050;
        Fri, 27 Jul 2018 11:21:42 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDB1C11C04A;
        Fri, 27 Jul 2018 11:21:41 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 11:21:41 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, jakub.kicinski@netronome.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf build: Build error in libbpf missing initialization
Date:   Fri, 27 Jul 2018 10:21:26 +0200
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072708-0028-0000-0000-000002E0FAAF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072708-0029-0000-0000-00002398F1EF
Message-Id: <20180727082126.87530-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-next tree compiling the perf tool with additional make flags
"EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
causes a compiler error. It is the warning
	'variable may be used uninitialized'
which is treated as error:

I compile it using a FEDORA 28 installation, my gcc compiler version:
gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)

The file that causes the error is tools/lib/bpf/libbpf.c

Here is the error message:

[root@p23lp27] # make V=1 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
[...]
Makefile.config:849: No openjdk development package found, please
   install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h'
        differs from latest version at 'include/uapi/linux/if_link.h'
  CC       libbpf.o
libbpf.c: In function ‘bpf_perf_event_read_simple’:
libbpf.c:2342:6: error: ‘ret’ may be used uninitialized in this
			function [-Werror=maybe-uninitialized]
  int ret;
      ^
cc1: all warnings being treated as errors
mv: cannot stat './.libbpf.o.tmp': No such file or directory
/home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for target 'libbpf.o' failed

Fix this warning and add an addition check at the beginning
of the while loop.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>

Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 73465caa33ba..66965ca96113 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2349,6 +2349,8 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
 
 	begin = base + data_tail % size;
 	end = base + data_head % size;
+	if (begin == end)
+		return LIBBPF_PERF_EVENT_ERROR;
 
 	while (begin != end) {
 		struct perf_event_header *ehdr;
-- 
2.16.4

