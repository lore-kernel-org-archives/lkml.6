Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zPCqBEPSGlvDHAAAmS7hNA
	; Fri, 08 Jun 2018 19:09:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B00ED607DC; Fri,  8 Jun 2018 19:09:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 36D0760275;
	Fri,  8 Jun 2018 19:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36D0760275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeFHTIz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:08:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752662AbeFHTIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:08:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58J5Awa049374
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 15:08:52 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jfw7mwq16-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 15:08:52 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Fri, 8 Jun 2018 15:08:52 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 15:08:49 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58J8mlZ19857888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 19:08:48 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED5FA2805C;
        Fri,  8 Jun 2018 15:08:33 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3E1F2805A;
        Fri,  8 Jun 2018 15:08:33 -0400 (EDT)
Received: from alifm-ThinkPad-T470p.pok.ibm.com (unknown [9.56.58.93])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Jun 2018 15:08:33 -0400 (EDT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com,
        longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, alifm@linux.ibm.com
Subject: [RFC v1 0/2] Detect & register virtio-crypto algos only if it can be supported by backend
Date: Fri,  8 Jun 2018 15:08:45 -0400
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18060819-0064-0000-0000-000003186562
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009153; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01044097; UDB=6.00534600; IPR=6.00823135;
 MB=3.00021536; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-08 19:08:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060819-0065-0000-0000-0000398745CE
Message-Id: <cover.1528462918.git.alifm@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=623 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently the Linux virtio-crypto driver registers the crypto
algorithm without verifying if the backend actually supports the
algorithm.

This kernel patch series adds support for registering algorithm
with Linux crypto layer, only if the algorithm is supported by
the backend device. This also makes the driver more compliant with
the virtio-crypto spec [1].

I would appreciate any feedback or comments on this.

Thank you
Farhan

Reference
---------
[1] Virtio crypto spec proposal https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00816.html

Farhan Ali (2):
  crypto/virtio-crypto: Read crypto services and algorithm masks
  crypto/virtio-crypto: Register an algo only if it's supported

 drivers/crypto/virtio/virtio_crypto_algs.c   | 110 ++++++++++++++++++---------
 drivers/crypto/virtio/virtio_crypto_common.h |  25 +++++-
 drivers/crypto/virtio/virtio_crypto_core.c   |  29 +++++++
 drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 ++++++++++++++++++--
 4 files changed, 201 insertions(+), 44 deletions(-)

-- 
2.7.4
