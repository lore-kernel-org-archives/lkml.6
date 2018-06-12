Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B70BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AB4208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AB4208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933974AbeFLRHu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:07:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754056AbeFLRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:07:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5CH4dKA194063
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:07:47 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jjff5gy64-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:07:47 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Tue, 12 Jun 2018 13:07:47 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 13:07:42 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5CH7fM910748228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 17:07:41 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37878112063;
        Tue, 12 Jun 2018 13:07:41 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32C0E112062;
        Tue, 12 Jun 2018 13:07:41 -0400 (EDT)
Received: from [9.56.58.93] (unknown [9.56.58.93])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 13:07:41 -0400 (EDT)
Subject: Re: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if it's
 supported
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
 <a9a06d82df69387bf1e66975b520d9049e9976e8.1528462918.git.alifm@linux.ibm.com>
 <33183CC9F5247A488A2544077AF19020DB015ABF@dggeml511-mbx.china.huawei.com>
From:   Farhan Ali <alifm@linux.ibm.com>
Date:   Tue, 12 Jun 2018 13:07:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB015ABF@dggeml511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18061217-0040-0000-0000-0000043F3961
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009177; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01045967; UDB=6.00535647; IPR=6.00824944;
 MB=3.00021606; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-12 17:07:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061217-0041-0000-0000-0000084541E4
Message-Id: <7957a36b-6881-1967-fa60-eaeaa38256c0@linux.ibm.com>
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



On 06/11/2018 04:48 AM, Gonglei (Arei) wrote:
> 
> 
>> -----Original Message-----
>> From: Farhan Ali [mailto:alifm@linux.ibm.com]
>> Sent: Saturday, June 09, 2018 3:09 AM
>> To: linux-kernel@vger.kernel.org; kvm@vger.kernel.org
>> Cc: mst@redhat.com; qemu-devel@nongnu.org; Gonglei (Arei)
>> <arei.gonglei@huawei.com>; longpeng <longpeng2@huawei.com>;
>> pasic@linux.ibm.com; frankja@linux.ibm.com; borntraeger@de.ibm.com;
>> alifm@linux.ibm.com
>> Subject: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if it's supported
>>
>> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>>
>> Register a crypto algo with the Linux crypto layer only if
>> the algorithm is supported by the backend virtio-crypto
>> device.
>>
>> Also route crypto requests to a virtio-crypto
>> device, only if it can support the requested service and
>> algorithm.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/crypto/virtio/virtio_crypto_algs.c   | 110
>> ++++++++++++++++++---------
>>   drivers/crypto/virtio/virtio_crypto_common.h |  11 ++-
>>   drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 ++++++++++++++++++--
>>   3 files changed, 158 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c
>> b/drivers/crypto/virtio/virtio_crypto_algs.c
>> index ba190cf..fef112a 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_algs.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_algs.c
>> @@ -49,12 +49,18 @@ struct virtio_crypto_sym_request {
>>   	bool encrypt;
>>   };
>>
>> +struct virtio_crypto_algo {
>> +	uint32_t algonum;
>> +	uint32_t service;
>> +	unsigned int active_devs;
>> +	struct crypto_alg algo;
>> +};
>> +
>>   /*
>>    * The algs_lock protects the below global virtio_crypto_active_devs
>>    * and crypto algorithms registion.
>>    */
>>   static DEFINE_MUTEX(algs_lock);
>> -static unsigned int virtio_crypto_active_devs;
>>   static void virtio_crypto_ablkcipher_finalize_req(
>>   	struct virtio_crypto_sym_request *vc_sym_req,
>>   	struct ablkcipher_request *req,
>> @@ -312,13 +318,19 @@ static int virtio_crypto_ablkcipher_setkey(struct
>> crypto_ablkcipher *tfm,
>>   					 unsigned int keylen)
>>   {
>>   	struct virtio_crypto_ablkcipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
>> +	uint32_t alg;
>>   	int ret;
>>
>> +	ret = virtio_crypto_alg_validate_key(keylen, &alg);
>> +	if (ret)
>> +		return ret;
>> +
>>   	if (!ctx->vcrypto) {
>>   		/* New key */
>>   		int node = virtio_crypto_get_current_node();
>>   		struct virtio_crypto *vcrypto =
>> -				      virtcrypto_get_dev_node(node);
>> +				      virtcrypto_get_dev_node(node,
>> +				      VIRTIO_CRYPTO_SERVICE_CIPHER, alg);
>>   		if (!vcrypto) {
>>   			pr_err("virtio_crypto: Could not find a virtio device in the
>> system\n");
> 
> We'd better change the above error message now. What about:
>   " virtio_crypto: Could not find a virtio device in the system or unsupported algo" ?
> 
> Regards,
> -Gonglei


Sure, I will update the error message. But other than that does the rest 
of the code looks good to you?

Thanks
Farhan

> 
> 
> 
> 

