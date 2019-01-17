Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C52C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF1020856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfAQRlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:41:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729129AbfAQRln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:41:43 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HHXhDD081787
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:41:42 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2whja960-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:41:41 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Thu, 17 Jan 2019 17:41:41 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 17:41:38 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HHfbjv21233898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 17:41:37 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A506528060;
        Thu, 17 Jan 2019 17:41:37 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EB112805A;
        Thu, 17 Jan 2019 17:41:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 17:41:37 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/5] Extend TPM PPI interface to support revision 1.3
Date:   Thu, 17 Jan 2019 12:41:30 -0500
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19011717-0052-0000-0000-0000037A06D2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010425; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01147865; UDB=6.00597964; IPR=6.00928163;
 MB=3.00025175; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-17 17:41:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011717-0053-0000-0000-00005F80BC88
Message-Id: <20190117174135.2117937-1-stefanb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches extends the TPM subsystem's PPI support to
support TPM PPI revision 1.3 where more commands are supported (up to 101)
and the TPM 2 command code '23' takes an additional parameter.

For the command code '23' see this document here on document page 39:
https://trustedcomputinggroup.org/wp-content/uploads/Physical-Presence-Interface_1-30_0-52.pdf

   Stefan

v1->v2:
  - reformatted badly aligned code
  - changed TPM_PPI_REVISION_1 to TPM_PPI_REVISION_ID_1
  - Added R-b's and T-b's

Stefan Berger (5):
  tpm: ppi: pass function revision ID to tpm_eval_dsm()
  tpm: ppi: rename TPM_PPI_REVISION_ID to TPM_PPI_REVISION_ID_1
  tpm: ppi: Display up to 101 operations as define for version 1.3
  tpm: ppi: Possibly show command parameter if TPM PPI 1.3 is used
  tpm: ppi: Enable submission of optional command parameter for PPI 1.3

 drivers/char/tpm/tpm_ppi.c | 78 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 20 deletions(-)

-- 
2.13.6

