Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65991ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED7920685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkqAmba/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED7920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbeGWJoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:44:09 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39074 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387925AbeGWJoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:44:09 -0400
Received: by mail-io0-f196.google.com with SMTP id o22-v6so13818750ioh.6;
        Mon, 23 Jul 2018 01:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XFsO39SPjj0EE/0cI9U1A70uJwOmOJzbqyIi7/g7uDo=;
        b=tkqAmba/s7vNYWjbgbzNKT0kwBOHVze9VUxqeTW9/7LSBn+OSArUqYGzS0VlVrvqu3
         +4USCK7hppjmqPSBsp06pfB3TzBZSALleqd+UuVLzxCCUpTI51SVfE6cWc0cDUjakBJQ
         hYNHqyrLPaeJN374yyPFunSRkfnjF58mQYgRHjZdfCylSyxdCqvqBytFCfwLKpiVS2ml
         G9fQ2KFgZT9hHD23xscX/dbPBh2WMZYvWDP4+qO2fBCpZOZQJenBlbWY0BX69D1C8GFw
         6HOzDW7OQneV3izhOXXu3s5uzK56ao0Xip0hlFAksjR1fIE+q66tc9rgfb6gTqk2YmQQ
         q1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XFsO39SPjj0EE/0cI9U1A70uJwOmOJzbqyIi7/g7uDo=;
        b=iZXJpQsBLBlmDN+JAa4vncHNqXoAWwhfcbNBHxF6MuDa6K2Wq6VAFaf4b0+XpFdx2+
         mCB2eh399ol0PyTEZ3y42FwlJaX6oMM1onXigUE8Ty32RmRXYk0uaI9jPRA/o3uhe8st
         4Zk5fC9xNeZXn8ztHRENt/ii++Y5GccYdyURznTHw3n0XArClNwnkeaFexB4cAZj3t8X
         bojWBocE86ufK9KYCtvH1kJ1wA6qZd+CU9dmGm3/kbjDB46M95tzqon3YmiS71qOCMoY
         l8IDfpWCrIVyIulqivrjW9EFuEV/YHayqLFtHGiwae+sO05wxquNyxc/9dn3kjCIad37
         RJIg==
X-Gm-Message-State: AOUpUlGjuOvA+CmuB7vcfQyFnpr6YdDNFRVajhNpO/BAbaPZGsFyLZm6
        yL2S+SxYD8JngyIXeFhHUN4=
X-Google-Smtp-Source: AAOMgpdFFCkUe239s5+57aImfed8p1xHCoQ5Vo9FVM8WtFnzHxe/GClUHXIb6MSZG2eECFPOPBDPaQ==
X-Received: by 2002:a5e:c90e:: with SMTP id z14-v6mr9631623iol.268.1532335441699;
        Mon, 23 Jul 2018 01:44:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:e422:450a:e730:728b])
        by smtp.gmail.com with ESMTPSA id p25-v6sm4424124itf.42.2018.07.23.01.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 01:44:01 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, arei.gonglei@huawei.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] crypto: virtio: Replace GFP_ATOMIC with GFP_KERNEL in __virtio_crypto_ablkcipher_do_req()
Date:   Mon, 23 Jul 2018 16:43:46 +0800
Message-Id: <20180723084346.16488-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__virtio_crypto_ablkcipher_do_req() is never called in atomic context.

__virtio_crypto_ablkcipher_do_req() is only called by 
virtio_crypto_ablkcipher_crypt_req(), which is only called by 
virtcrypto_find_vqs() that is never called in atomic context.

__virtio_crypto_ablkcipher_do_req() calls kzalloc_node() with GFP_ATOMIC,
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/crypto/virtio/virtio_crypto_algs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index ba190cfa7aa1..83bcc83dae43 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -371,12 +371,12 @@ __virtio_crypto_ablkcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
 
 	/* Why 3?  outhdr + iv + inhdr */
 	sg_total = src_nents + dst_nents + 3;
-	sgs = kzalloc_node(sg_total * sizeof(*sgs), GFP_ATOMIC,
+	sgs = kzalloc_node(sg_total * sizeof(*sgs), GFP_KERNEL,
 				dev_to_node(&vcrypto->vdev->dev));
 	if (!sgs)
 		return -ENOMEM;
 
-	req_data = kzalloc_node(sizeof(*req_data), GFP_ATOMIC,
+	req_data = kzalloc_node(sizeof(*req_data), GFP_KERNEL,
 				dev_to_node(&vcrypto->vdev->dev));
 	if (!req_data) {
 		kfree(sgs);
@@ -432,7 +432,7 @@ __virtio_crypto_ablkcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
 	 * Avoid to do DMA from the stack, switch to using
 	 * dynamically-allocated for the IV
 	 */
-	iv = kzalloc_node(ivsize, GFP_ATOMIC,
+	iv = kzalloc_node(ivsize, GFP_KERNEL,
 				dev_to_node(&vcrypto->vdev->dev));
 	if (!iv) {
 		err = -ENOMEM;
-- 
2.17.0

