Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13647ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FCE2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FCE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbeGRQyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:54:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730987AbeGRQyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:54:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IGEsQB049306
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:16:15 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ka73ydadt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:16:15 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 18 Jul 2018 12:16:14 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 12:16:09 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6IGG9vd1180102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 16:16:09 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B56D6AE05C;
        Wed, 18 Jul 2018 12:15:32 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94CD0AE064;
        Wed, 18 Jul 2018 12:15:28 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.83.190])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jul 2018 12:15:28 -0400 (EDT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/prom_init: remove linux,stdout-package property
Date:   Wed, 18 Jul 2018 13:15:44 -0300
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18071816-0052-0000-0000-000003103EC8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009387; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062639; UDB=6.00545614; IPR=6.00840494;
 MB=3.00022186; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-18 16:16:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071816-0053-0000-0000-00005D68B14F
Message-Id: <20180718161544.12134-1-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property was added in 2004 and the only use of it, which was already inside
`#if 0`, was removed a month later.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/prom_init.c | 2 --
 1 file changed, 2 deletions(-)

v1..v2:
- Move github.com links to this section so they can still end up in the mail
  archive.
- Remove Fixes: tag from commit message.
- Add Link: tag here.
- Link to v1: https://lkml.kernel.org/r/20180712171904.18971-1-muriloo@linux.ibm.com

This property was added in 2004 by

    https://github.com/mpe/linux-fullhistory/commit/689fe5072fe9a0dec914bfa4fa60aed1e54563e6

and the only use of it, which was already inside `#if 0`, was removed a month
later by

    https://github.com/mpe/linux-fullhistory/commit/1fbe5a6d90f6cd4ea610737ef488719d1a875de7

Link: https://github.com/linuxppc/linux/issues/125

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 5425dd3d6a9f..c45fb463c9e5 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2102,8 +2102,6 @@ static void __init prom_init_stdout(void)
 	stdout_node = call_prom("instance-to-package", 1, 1, prom.stdout);
 	if (stdout_node != PROM_ERROR) {
 		val = cpu_to_be32(stdout_node);
-		prom_setprop(prom.chosen, "/chosen", "linux,stdout-package",
-			     &val, sizeof(val));
 
 		/* If it's a display, note it */
 		memset(type, 0, sizeof(type));
-- 
2.17.1

