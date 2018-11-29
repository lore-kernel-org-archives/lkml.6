Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DFCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16292081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16292081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeK2XuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:50:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbeK2XuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:50:15 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wATCdr4E123981
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 07:44:59 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p2f2vkq9r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 07:44:59 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 29 Nov 2018 12:44:57 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Nov 2018 12:44:53 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wATCipNd57278598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 12:44:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF692A4040;
        Thu, 29 Nov 2018 12:44:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DC14A4051;
        Thu, 29 Nov 2018 12:44:51 +0000 (GMT)
Received: from [9.152.224.168] (unknown [9.152.224.168])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Nov 2018 12:44:51 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 3/3] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
 <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
 <20181129123726.62b04690.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 29 Nov 2018 13:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129123726.62b04690.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112912-0020-0000-0000-000002EF8E4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112912-0021-0000-0000-0000213EEE36
Message-Id: <8a0946c9-5c43-2f06-1ed0-c9ea9aeaa5fb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 12:37, Cornelia Huck wrote:
> On Thu, 22 Nov 2018 18:11:15 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> This is the implementation of the VFIO ioctl calls to handle
>> the AQIC interception and use GISA to handle interrupts.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 110 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 272ef42..f6e942f 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -895,12 +895,121 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>>   	return copy_to_user((void __user *)arg, &info, minsz);
>>   }
>>   
>> +static unsigned long vfio_ap_get_nib(struct kvm *kvm, struct vfio_ap_aqic *parm)
>> +{
>> +	struct s390_io_adapter *adapter;
>> +	struct s390_map_info *map;
>> +	unsigned long nib;
>> +	int found = 0;
>> +
>> +	/* find the adapter */
>> +	if (parm->adapter_id > MAX_S390_IO_ADAPTERS)
>> +		return 0;
>> +
>> +	adapter = kvm->arch.adapters[parm->adapter_id];
>> +	if (!adapter)
>> +		return 0;
>> +
>> +	down_write(&adapter->maps_lock);
>> +	list_for_each_entry(map, &adapter->maps, list) {
>> +		if (map->guest_addr == parm->nib) {
>> +			found = 1;
>> +			break;
>> +		}
>> +	}
>> +	up_write(&adapter->maps_lock);
> 
> Regardless of which user space interface you ultimately use: I think
> you should leave poking the adapter handling innards to the adapter
> code and instead create and use an interface to look up the mapping
> from the guest address.

Right...
Thanks

Pierre

> 
>> +
>> +	if (!found)
>> +		return 0;
>> +
>> +	nib = (unsigned long) page_address(map->page);
>> +	nib += (map->guest_addr & 0x0fff);
>> +
>> +	return nib;
>> +}
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

