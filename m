Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E4A9AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0CD208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0CD208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934595AbeFLRGp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:06:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934177AbeFLRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:06:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5CH4c5E047001
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:06:42 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jjh7xb277-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:06:41 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Tue, 12 Jun 2018 13:06:40 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 13:06:36 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5CH6ZcH18415956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 17:06:35 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31E50112061;
        Tue, 12 Jun 2018 13:06:35 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20FBF112063;
        Tue, 12 Jun 2018 13:06:35 -0400 (EDT)
Received: from [9.56.58.93] (unknown [9.56.58.93])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 13:06:35 -0400 (EDT)
Subject: Re: [RFC v1 1/2] crypto/virtio-crypto: Read crypto services and
 algorithm masks
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        longpeng <longpeng2@huawei.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
 <e0fe84d1df4e0c2c88d7d29f94d621c988c22194.1528462918.git.alifm@linux.ibm.com>
 <33183CC9F5247A488A2544077AF19020DB015842@dggeml511-mbx.china.huawei.com>
From:   Farhan Ali <alifm@linux.ibm.com>
Date:   Tue, 12 Jun 2018 13:06:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB015842@dggeml511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18061217-0052-0000-0000-000002FD9946
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009177; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01045966; UDB=6.00535647; IPR=6.00824944;
 MB=3.00021606; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-12 17:06:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061217-0053-0000-0000-00005CFE709C
Message-Id: <226dad9f-8931-3886-eb00-352a190c5b5b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arei

On 06/11/2018 02:43 AM, Gonglei (Arei) wrote:
> 
>> -----Original Message-----
>> From: Farhan Ali [mailto:alifm@linux.ibm.com]
>> Sent: Saturday, June 09, 2018 3:09 AM
>> To: linux-kernel@vger.kernel.org; kvm@vger.kernel.org
>> Cc: mst@redhat.com; qemu-devel@nongnu.org; Gonglei (Arei)
>> <arei.gonglei@huawei.com>; longpeng <longpeng2@huawei.com>;
>> pasic@linux.ibm.com; frankja@linux.ibm.com; borntraeger@de.ibm.com;
>> alifm@linux.ibm.com
>> Subject: [RFC v1 1/2] crypto/virtio-crypto: Read crypto services and algorithm
>> masks
>>
>> Read the crypto services and algorithm masks which provides
>> information about the services and algorithms supported by
>> virtio-crypto backend.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/crypto/virtio/virtio_crypto_common.h | 14 ++++++++++++++
>>   drivers/crypto/virtio/virtio_crypto_core.c   | 29
>> ++++++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h
>> b/drivers/crypto/virtio/virtio_crypto_common.h
>> index 66501a5..05eca12e 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_common.h
>> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
>> @@ -55,6 +55,20 @@ struct virtio_crypto {
>>   	/* Number of queue currently used by the driver */
>>   	u32 curr_queue;
>>
>> +	/*
>> +	 * Specifies the services mask which the device support,
>> +	 * see VIRTIO_CRYPTO_SERVICE_* above
>> +	 */
> 
> Pls update the above comments. Except that:
> 
> Acked-by: Gonglei <arei.gonglei@huawei.com>
> 

Sure will update the comment. How about " Specifies the services mask 
which the device support, * see VIRTIO_CRYPTO_SERVICE_*" ?

or should I specify the file where the VIRTIO_CRYPTO_SERVICE_* are defined?

Thanks
Farhan

>> +	u32 crypto_services;
>> +
>> +	/* Detailed algorithms mask */
>> +	u32 cipher_algo_l;
>> +	u32 cipher_algo_h;
>> +	u32 hash_algo;
>> +	u32 mac_algo_l;
>> +	u32 mac_algo_h;
>> +	u32 aead_algo;
>> +
>>   	/* Maximum length of cipher key */
>>   	u32 max_cipher_key_len;
>>   	/* Maximum length of authenticated key */
>> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
>> b/drivers/crypto/virtio/virtio_crypto_core.c
>> index 8332698..8f745f2 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_core.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
>> @@ -303,6 +303,13 @@ static int virtcrypto_probe(struct virtio_device *vdev)
>>   	u32 max_data_queues = 0, max_cipher_key_len = 0;
>>   	u32 max_auth_key_len = 0;
>>   	u64 max_size = 0;
>> +	u32 cipher_algo_l = 0;
>> +	u32 cipher_algo_h = 0;
>> +	u32 hash_algo = 0;
>> +	u32 mac_algo_l = 0;
>> +	u32 mac_algo_h = 0;
>> +	u32 aead_algo = 0;
>> +	u32 crypto_services = 0;
>>
>>   	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>>   		return -ENODEV;
>> @@ -339,6 +346,20 @@ static int virtcrypto_probe(struct virtio_device *vdev)
>>   		max_auth_key_len, &max_auth_key_len);
>>   	virtio_cread(vdev, struct virtio_crypto_config,
>>   		max_size, &max_size);
>> +	virtio_cread(vdev, struct virtio_crypto_config,
>> +		crypto_services, &crypto_services);
>> +	virtio_cread(vdev, struct virtio_crypto_config,
>> +		cipher_algo_l, &cipher_algo_l);
>> +	virtio_cread(vdev, struct virtio_crypto_config,
>> +		cipher_algo_h, &cipher_algo_h);
>> +	virtio_cread(vdev, struct virtio_crypto_config,
>> +		hash_algo, &hash_algo);
>> +	virtio_cread(vdev, struct virtio_crypto_config,
>> +		mac_algo_l, &mac_algo_l);
>> +	virtio_cread(vdev, struct virtio_crypto_config,
>> +		mac_algo_h, &mac_algo_h);
>> +	virtio_cread(vdev, struct virtio_crypto_config,
>> +		aead_algo, &aead_algo);
>>
>>   	/* Add virtio crypto device to global table */
>>   	err = virtcrypto_devmgr_add_dev(vcrypto);
>> @@ -358,6 +379,14 @@ static int virtcrypto_probe(struct virtio_device *vdev)
>>   	vcrypto->max_cipher_key_len = max_cipher_key_len;
>>   	vcrypto->max_auth_key_len = max_auth_key_len;
>>   	vcrypto->max_size = max_size;
>> +	vcrypto->crypto_services = crypto_services;
>> +	vcrypto->cipher_algo_l = cipher_algo_l;
>> +	vcrypto->cipher_algo_h = cipher_algo_h;
>> +	vcrypto->mac_algo_l = mac_algo_l;
>> +	vcrypto->mac_algo_h = mac_algo_h;
>> +	vcrypto->hash_algo = hash_algo;
>> +	vcrypto->aead_algo = aead_algo;
>> +
>>
>>   	dev_info(&vdev->dev,
>>   		"max_queues: %u, max_cipher_key_len: %u, max_auth_key_len: %u,
>> max_size 0x%llx\n",
>> --
>> 2.7.4
> 
> 

