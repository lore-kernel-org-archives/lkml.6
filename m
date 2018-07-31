Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10859C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA79520841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA79520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbeGaQcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:32:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732443AbeGaQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:32:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6VE95n9118031
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:51:19 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kjr2snb0w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:51:18 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Tue, 31 Jul 2018 08:51:18 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Jul 2018 08:51:13 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6VEpCtr11927966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Jul 2018 07:51:12 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C2C3BE056;
        Tue, 31 Jul 2018 08:51:12 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 186EFBE054;
        Tue, 31 Jul 2018 08:51:09 -0600 (MDT)
Received: from kermit-br-ibm-com.br.ibm.com (unknown [9.18.235.193])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jul 2018 08:51:08 -0600 (MDT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 9/9] powerpc/traps: Add line prefix in show_instructions()
Date:   Tue, 31 Jul 2018 11:50:20 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731145020.14009-1-muriloo@linux.ibm.com>
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18073114-0004-0000-0000-0000146B706F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009463; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068484; UDB=6.00549299; IPR=6.00846683;
 MB=3.00022427; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-31 14:51:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073114-0005-0000-0000-00008847E760
Message-Id: <20180731145020.14009-10-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=957 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "Instruction dump:" line by adding a prefix to display current->comm
and current->pid, along with the instructions dump.

The prefix can serve as a glue that links the instructions dump to its
originator, allowing messages to be interleaved in the logs.

Before this patch, a page fault looked like:

  pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd295100 code 2 in pandafault[10000000+10000]
  Instruction dump:
  4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
  392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

After this patch, it looks like:

  pandafault[10850]: segfault (11) at 100007d0 nip 1000061c lr 7fff9f3e5100 code 2 in pandafault[10000000+10000]
  pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
  pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/process.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e78799a8855a..d12143e7d8f9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1265,16 +1265,19 @@ static int instructions_to_print = 16;
 void show_instructions(struct pt_regs *regs)
 {
 	int i;
+	const char *prefix = KERN_INFO "%s[%d]: code: ";
 	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
 			sizeof(int));
 
-	printk("Instruction dump:");
+	printk(prefix, current->comm, current->pid);
 
 	for (i = 0; i < instructions_to_print; i++) {
 		int instr;
 
-		if (!(i % 8))
+		if (!(i % 8) && (i > 0)) {
 			pr_cont("\n");
+			printk(prefix, current->comm, current->pid);
+		}
 
 #if !defined(CONFIG_BOOKE)
 		/* If executing with the IMMU off, adjust pc rather
-- 
2.17.1

