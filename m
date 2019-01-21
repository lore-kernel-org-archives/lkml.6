Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CABC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C62920663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfAURQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:16:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbfAURQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:16:07 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LHAFjb096872
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:16:06 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q5grqvdr7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:16:06 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 21 Jan 2019 17:16:05 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 17:16:03 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LHG2SB22544566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 17:16:02 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 495176A054;
        Mon, 21 Jan 2019 17:16:02 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EACA6A04D;
        Mon, 21 Jan 2019 17:16:01 +0000 (GMT)
Received: from oc6728276242.ibm.com (unknown [9.85.171.190])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jan 2019 17:16:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     joel@jms.id.au, andrew@aj.id.au, benh@kernel.crashing.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: sbefifo: Don't fail operations when in SBE IPL state
Date:   Mon, 21 Jan 2019 11:15:58 -0600
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19012117-0036-0000-0000-00000A7F1022
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010449; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01149751; UDB=6.00599111; IPR=6.00930075;
 MB=3.00025224; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-21 17:16:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012117-0037-0000-0000-00004A6E36EE
Message-Id: <1548090958-25908-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBE fifo operations should be allowed while the SBE is in any of the
"IPL" states. Operations should succeed in this state.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-sbefifo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index c7d13ac..f7665b3 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -290,11 +290,11 @@ static int sbefifo_check_sbe_state(struct sbefifo *sbefifo)
 	switch ((sbm & CFAM_SBM_SBE_STATE_MASK) >> CFAM_SBM_SBE_STATE_SHIFT) {
 	case SBE_STATE_UNKNOWN:
 		return -ESHUTDOWN;
+	case SBE_STATE_DMT:
+		return -EBUSY;
 	case SBE_STATE_IPLING:
 	case SBE_STATE_ISTEP:
 	case SBE_STATE_MPIPL:
-	case SBE_STATE_DMT:
-		return -EBUSY;
 	case SBE_STATE_RUNTIME:
 	case SBE_STATE_DUMP: /* Not sure about that one */
 		break;
-- 
1.8.3.1

