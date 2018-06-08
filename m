Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hMTHNdPTGls1IwAAmS7hNA
	; Fri, 08 Jun 2018 19:09:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EDD89607DC; Fri,  8 Jun 2018 19:09:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 75BC660275;
	Fri,  8 Jun 2018 19:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75BC660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeFHTJc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:09:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752693AbeFHTIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:08:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58J4pL5128913
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 15:08:54 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jfykw06xa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 15:08:53 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Fri, 8 Jun 2018 15:08:52 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 15:08:49 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58J8mHD4522418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 19:08:48 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B7242805A;
        Fri,  8 Jun 2018 15:08:34 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFAC72805E;
        Fri,  8 Jun 2018 15:08:33 -0400 (EDT)
Received: from alifm-ThinkPad-T470p.pok.ibm.com (unknown [9.56.58.93])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Jun 2018 15:08:33 -0400 (EDT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com,
        longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, alifm@linux.ibm.com
Subject: [RFC v1 1/2] crypto/virtio-crypto: Read crypto services and algorithm masks
Date: Fri,  8 Jun 2018 15:08:46 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528462918.git.alifm@linux.ibm.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1528462918.git.alifm@linux.ibm.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060819-0040-0000-0000-0000043D802B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009153; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01044097; UDB=6.00534601; IPR=6.00823136;
 MB=3.00021536; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-08 19:08:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060819-0041-0000-0000-000008438527
Message-Id: <e0fe84d1df4e0c2c88d7d29f94d621c988c22194.1528462918.git.alifm@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the crypto services and algorithm masks which provides
information about the services and algorithms supported by
virtio-crypto backend.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/crypto/virtio/virtio_crypto_common.h | 14 ++++++++++++++
 drivers/crypto/virtio/virtio_crypto_core.c   | 29 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 66501a5..05eca12e 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -55,6 +55,20 @@ struct virtio_crypto {
 	/* Number of queue currently used by the driver */
 	u32 curr_queue;
 
+	/*
+	 * Specifies the services mask which the device support,
+	 * see VIRTIO_CRYPTO_SERVICE_* above
+	 */
+	u32 crypto_services;
+
+	/* Detailed algorithms mask */
+	u32 cipher_algo_l;
+	u32 cipher_algo_h;
+	u32 hash_algo;
+	u32 mac_algo_l;
+	u32 mac_algo_h;
+	u32 aead_algo;
+
 	/* Maximum length of cipher key */
 	u32 max_cipher_key_len;
 	/* Maximum length of authenticated key */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 8332698..8f745f2 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -303,6 +303,13 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	u32 max_data_queues = 0, max_cipher_key_len = 0;
 	u32 max_auth_key_len = 0;
 	u64 max_size = 0;
+	u32 cipher_algo_l = 0;
+	u32 cipher_algo_h = 0;
+	u32 hash_algo = 0;
+	u32 mac_algo_l = 0;
+	u32 mac_algo_h = 0;
+	u32 aead_algo = 0;
+	u32 crypto_services = 0;
 
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		return -ENODEV;
@@ -339,6 +346,20 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 		max_auth_key_len, &max_auth_key_len);
 	virtio_cread(vdev, struct virtio_crypto_config,
 		max_size, &max_size);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		crypto_services, &crypto_services);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		cipher_algo_l, &cipher_algo_l);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		cipher_algo_h, &cipher_algo_h);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		hash_algo, &hash_algo);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		mac_algo_l, &mac_algo_l);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		mac_algo_h, &mac_algo_h);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		aead_algo, &aead_algo);
 
 	/* Add virtio crypto device to global table */
 	err = virtcrypto_devmgr_add_dev(vcrypto);
@@ -358,6 +379,14 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	vcrypto->max_cipher_key_len = max_cipher_key_len;
 	vcrypto->max_auth_key_len = max_auth_key_len;
 	vcrypto->max_size = max_size;
+	vcrypto->crypto_services = crypto_services;
+	vcrypto->cipher_algo_l = cipher_algo_l;
+	vcrypto->cipher_algo_h = cipher_algo_h;
+	vcrypto->mac_algo_l = mac_algo_l;
+	vcrypto->mac_algo_h = mac_algo_h;
+	vcrypto->hash_algo = hash_algo;
+	vcrypto->aead_algo = aead_algo;
+
 
 	dev_info(&vdev->dev,
 		"max_queues: %u, max_cipher_key_len: %u, max_auth_key_len: %u, max_size 0x%llx\n",
-- 
2.7.4
