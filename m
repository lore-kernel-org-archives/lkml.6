Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44549C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF022083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBGRxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:53:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726576AbfBGRxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:53:20 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17HjAAd135378
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 12:53:18 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qgqfvq7fq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:53:18 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 7 Feb 2019 17:53:17 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 17:53:16 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x17HrFxH23265416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 17:53:15 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5E4B28060;
        Thu,  7 Feb 2019 17:53:14 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D723328059;
        Thu,  7 Feb 2019 17:53:14 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Feb 2019 17:53:14 +0000 (GMT)
From:   Paul Clarke <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, mpe@ellerman.id.au, cel@us.ibm.com
Subject: [PATCH v2 0/4] [powerpc] perf vendor events: Add JSON metrics for POWER8
Date:   Thu,  7 Feb 2019 12:53:10 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19020717-0040-0000-0000-000004BE2DF1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010555; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157696; UDB=6.00593882; IPR=6.00938227;
 MB=3.00025481; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-07 17:53:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020717-0041-0000-0000-000008C94986
Message-Id: <20190207175314.31813-1-pc@us.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=865 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches define metrics and metric groups for computation by "perf" for
POWER8 processors.

Paul Clarke (4):
  [powerpc] perf vendor events: Add JSON metrics for POWER8 1/4
  [powerpc] perf vendor events: Add JSON metrics for POWER8 2/4
  [powerpc] perf vendor events: Add JSON metrics for POWER8 3/4
  [powerpc] perf vendor events: Add JSON metrics for POWER8 4/4

v2:
The content of these patches was sent previously, to LKML and linux-perf-users,
but never showed up at linux-perf-users, so I split it into smaller patches
and am resending.

 .../arch/powerpc/power8/metrics.json          | 2245 +++++++++++++++++
 1 file changed, 2245 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json

-- 
2.17.1

