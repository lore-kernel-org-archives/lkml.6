Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA9EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC702147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfBULeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:34:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbfBULeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:34:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LBYEe5031884
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:34:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qst9ntq9g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:34:18 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 21 Feb 2019 11:34:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 11:34:14 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LBYCsg53477490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 11:34:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADF9B4C040;
        Thu, 21 Feb 2019 11:34:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BB744C046;
        Thu, 21 Feb 2019 11:34:12 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 11:34:12 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
 <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
 <20190219102204.5e050b76.cohuck@redhat.com>
 <c23816b4-e24d-7cf7-8018-a3c085eef9f3@de.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 21 Feb 2019 12:34:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c23816b4-e24d-7cf7-8018-a3c085eef9f3@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022111-0016-0000-0000-0000025925A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022111-0017-0000-0000-000032B3751A
Message-Id: <9c7bcc08-815f-5eac-5540-d3969b4ca33c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 10:44, Christian Borntraeger wrote:
> 
> 
> On 19.02.2019 10:22, Cornelia Huck wrote:
>> On Mon, 18 Feb 2019 19:08:48 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>

...snip...

>>> +static struct bus_type matrix_bus = {
>>> +	.name = "vfio_ap",
>>> +	.match = &matrix_bus_match,
>>> +};
>>> +
>>> +static int matrix_probe(struct device *dev)
>>> +{
>>> +	return 0;
>>> +}
>>
>> I don't think you need this (the important function is the match
>> function of the bus).
> 
> Yes, with
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 8e45559795429..8ceec41afe322 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -68,15 +68,9 @@ static struct bus_type matrix_bus = {
>          .match = &matrix_bus_match,
>   };
>   
> -static int matrix_probe(struct device *dev)
> -{
> -       return 0;
> -}
> -
>   static struct device_driver matrix_driver = {
>          .name = "vfio_ap",
>          .bus = &matrix_bus,
> -       .probe = matrix_probe,
>   };
>   
>   static int vfio_ap_matrix_dev_create(void)
> 
> on top things still look fine.

OK, simpler is better, I remove the probe.

Thanks,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

