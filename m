Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fXuWL8gaHlutGgAAmS7hNA
	; Mon, 11 Jun 2018 06:46:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F957606FA; Mon, 11 Jun 2018 06:46:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2F01F607BB;
	Mon, 11 Jun 2018 06:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F01F607BB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeFKGqh convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 20 others);
        Mon, 11 Jun 2018 02:46:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753974AbeFKGqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:46:35 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id D84A3DF32A6D;
        Mon, 11 Jun 2018 14:43:08 +0800 (CST)
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.61]) by
 dggeml406-hub.china.huawei.com ([10.3.17.50]) with mapi id 14.03.0382.000;
 Mon, 11 Jun 2018 14:43:01 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Farhan Ali <alifm@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        longpeng <longpeng2@huawei.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>
Subject: RE: [RFC v1 1/2] crypto/virtio-crypto: Read crypto services and
 algorithm masks
Thread-Topic: [RFC v1 1/2] crypto/virtio-crypto: Read crypto services and
 algorithm masks
Thread-Index: AQHT/1wog5TEYt3+pEuMF7dtBztmiKRan3qw
Date: Mon, 11 Jun 2018 06:43:01 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB015842@dggeml511-mbx.china.huawei.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
 <e0fe84d1df4e0c2c88d7d29f94d621c988c22194.1528462918.git.alifm@linux.ibm.com>
In-Reply-To: <e0fe84d1df4e0c2c88d7d29f94d621c988c22194.1528462918.git.alifm@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.18.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Farhan Ali [mailto:alifm@linux.ibm.com]
> Sent: Saturday, June 09, 2018 3:09 AM
> To: linux-kernel@vger.kernel.org; kvm@vger.kernel.org
> Cc: mst@redhat.com; qemu-devel@nongnu.org; Gonglei (Arei)
> <arei.gonglei@huawei.com>; longpeng <longpeng2@huawei.com>;
> pasic@linux.ibm.com; frankja@linux.ibm.com; borntraeger@de.ibm.com;
> alifm@linux.ibm.com
> Subject: [RFC v1 1/2] crypto/virtio-crypto: Read crypto services and algorithm
> masks
> 
> Read the crypto services and algorithm masks which provides
> information about the services and algorithms supported by
> virtio-crypto backend.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_common.h | 14 ++++++++++++++
>  drivers/crypto/virtio/virtio_crypto_core.c   | 29
> ++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h
> b/drivers/crypto/virtio/virtio_crypto_common.h
> index 66501a5..05eca12e 100644
> --- a/drivers/crypto/virtio/virtio_crypto_common.h
> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
> @@ -55,6 +55,20 @@ struct virtio_crypto {
>  	/* Number of queue currently used by the driver */
>  	u32 curr_queue;
> 
> +	/*
> +	 * Specifies the services mask which the device support,
> +	 * see VIRTIO_CRYPTO_SERVICE_* above
> +	 */

Pls update the above comments. Except that:

Acked-by: Gonglei <arei.gonglei@huawei.com>

> +	u32 crypto_services;
> +
> +	/* Detailed algorithms mask */
> +	u32 cipher_algo_l;
> +	u32 cipher_algo_h;
> +	u32 hash_algo;
> +	u32 mac_algo_l;
> +	u32 mac_algo_h;
> +	u32 aead_algo;
> +
>  	/* Maximum length of cipher key */
>  	u32 max_cipher_key_len;
>  	/* Maximum length of authenticated key */
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
> b/drivers/crypto/virtio/virtio_crypto_core.c
> index 8332698..8f745f2 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -303,6 +303,13 @@ static int virtcrypto_probe(struct virtio_device *vdev)
>  	u32 max_data_queues = 0, max_cipher_key_len = 0;
>  	u32 max_auth_key_len = 0;
>  	u64 max_size = 0;
> +	u32 cipher_algo_l = 0;
> +	u32 cipher_algo_h = 0;
> +	u32 hash_algo = 0;
> +	u32 mac_algo_l = 0;
> +	u32 mac_algo_h = 0;
> +	u32 aead_algo = 0;
> +	u32 crypto_services = 0;
> 
>  	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>  		return -ENODEV;
> @@ -339,6 +346,20 @@ static int virtcrypto_probe(struct virtio_device *vdev)
>  		max_auth_key_len, &max_auth_key_len);
>  	virtio_cread(vdev, struct virtio_crypto_config,
>  		max_size, &max_size);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		crypto_services, &crypto_services);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		cipher_algo_l, &cipher_algo_l);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		cipher_algo_h, &cipher_algo_h);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		hash_algo, &hash_algo);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		mac_algo_l, &mac_algo_l);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		mac_algo_h, &mac_algo_h);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		aead_algo, &aead_algo);
> 
>  	/* Add virtio crypto device to global table */
>  	err = virtcrypto_devmgr_add_dev(vcrypto);
> @@ -358,6 +379,14 @@ static int virtcrypto_probe(struct virtio_device *vdev)
>  	vcrypto->max_cipher_key_len = max_cipher_key_len;
>  	vcrypto->max_auth_key_len = max_auth_key_len;
>  	vcrypto->max_size = max_size;
> +	vcrypto->crypto_services = crypto_services;
> +	vcrypto->cipher_algo_l = cipher_algo_l;
> +	vcrypto->cipher_algo_h = cipher_algo_h;
> +	vcrypto->mac_algo_l = mac_algo_l;
> +	vcrypto->mac_algo_h = mac_algo_h;
> +	vcrypto->hash_algo = hash_algo;
> +	vcrypto->aead_algo = aead_algo;
> +
> 
>  	dev_info(&vdev->dev,
>  		"max_queues: %u, max_cipher_key_len: %u, max_auth_key_len: %u,
> max_size 0x%llx\n",
> --
> 2.7.4
