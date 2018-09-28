Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1EAC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7079721571
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7079721571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeI1UFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:05:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727676AbeI1UFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:05:37 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SDdexe102658
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:41:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2msm0ecbg4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:41:46 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 28 Sep 2018 14:41:43 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Sep 2018 14:41:39 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8SDfbS462586952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Sep 2018 13:41:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1962E4204B;
        Fri, 28 Sep 2018 16:41:20 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 071F342049;
        Fri, 28 Sep 2018 16:41:19 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.152.224.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Sep 2018 16:41:18 +0100 (BST)
Subject: Re: [FIXUP v11] fixup! s390: vfio-ap: implement mediated device open
 callback
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <20180928121429.7323d78b.cohuck@redhat.com>
 <20180928133321.31884-1-akrowiak@linux.vnet.ibm.com>
 <20180928153506.3521bc33.cohuck@redhat.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pasic@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date:   Fri, 28 Sep 2018 15:41:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928153506.3521bc33.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092813-0016-0000-0000-0000020BD7CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092813-0017-0000-0000-000032630427
Message-Id: <9da2f32b-2d58-fcd1-a830-1fba0ed8bc0c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=954 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/28/2018 03:35 PM, Cornelia Huck wrote:
> On Fri, 28 Sep 2018 09:33:21 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Fixes case statement in vfio_ap_mdev_copy_masks() function in
>> vfio-ap-ops.c.
>> ---
>>  drivers/s390/crypto/vfio_ap_ops.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index e1e1beaaeba5..86b42487a51c 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -741,11 +741,12 @@ static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
>>  		break;
>>  	case CRYCB_FORMAT1:
>>  	case CRYCB_FORMAT0:
>> -	default:
>>  		apm = (unsigned long *)crycb->apcb0.apm;
>>  		aqm = (unsigned long *)crycb->apcb0.aqm;
>>  		adm = (unsigned long *)crycb->apcb0.adm;
>>  		break;
>> +	default:
>> +		return;
> 
> /* cannot happen */
> 
> ?

Or use something like BUG(). Without conveying that default is illegal we
don't gain anything over the previous version IMHO.

> 
>>  	}
>>  
>>  	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.apm_max + 1, BITS_PER_BYTE);
> 

