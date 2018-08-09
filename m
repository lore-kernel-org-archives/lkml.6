Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9F7C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3E321524
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3E321524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeHILld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:41:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729848AbeHILlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:41:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w799DtBE042152
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 05:17:35 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2krfwrxpk1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:17:35 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Thu, 9 Aug 2018 10:17:32 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 10:17:29 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w799HRi634996256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 09:17:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB4D842045;
        Thu,  9 Aug 2018 12:17:35 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 520134204D;
        Thu,  9 Aug 2018 12:17:33 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.152.224.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 12:17:33 +0100 (BST)
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180809110645.33b20c1f.cohuck@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Thu, 9 Aug 2018 11:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809110645.33b20c1f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080909-0016-0000-0000-000001F44D64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080909-0017-0000-0000-0000324A5FF0
Message-Id: <aec0af21-270f-c4c5-3aea-f6854ca2fb07@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2018 11:06, Cornelia Huck wrote:
> On Wed,  8 Aug 2018 10:44:14 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Harald Freudenberger <freude@de.ibm.com>
>>
>> Move all the inline functions from the ap bus header
>> file ap_asm.h into the in-kernel api header file
>> arch/s390/include/asm/ap.h so that KVM can make use
>> of all the low level AP functions.
>>
>> Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> You should add your own s-o-b if you are sending on patches written by
> others (even if it does not matter in the end, when they are merged
> through a different path anyway.)
>
>> ---
>>  arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
>>  drivers/s390/crypto/ap_asm.h   |  261 ------------------------------------
>>  drivers/s390/crypto/ap_bus.c   |   21 +---
>>  drivers/s390/crypto/ap_bus.h   |    1 +
>>  drivers/s390/crypto/ap_card.c  |    1 -
>>  drivers/s390/crypto/ap_queue.c |    1 -
>>  6 files changed, 259 insertions(+), 310 deletions(-)
>>  delete mode 100644 drivers/s390/crypto/ap_asm.h
>>
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index c1bedb4..046e044 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -47,6 +47,50 @@ struct ap_queue_status {
>>  };
>>  
>>  /**
>> + * ap_intructions_available() - Test if AP instructions are available.
>> + *
>> + * Returns 0 if the AP instructions are installed.
> Stumbled over this when I was looking at the usage in patch 7: if I see
> a function called '_available' return 0, I'd assume that whatever the
> function tests for is *not* available.
>
> Rather call this function ap_instructions_check_availability() (and
> keep the return code convention), or switch this to return 0 if not
> available and !0 if available?
Good catch, Cony you are right. I'll fix this to return 1 if AP instructions
are available and 0 if not. However, this patch will come via Martin's pipe
to the Linus Torwald kernel sources.
>
>> + */
>> +static inline int ap_instructions_available(void)
>> +{
>> +	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
>> +	register unsigned long reg1 asm ("1") = -ENODEV;
>> +	register unsigned long reg2 asm ("2");
>> +
>> +	asm volatile(
>> +		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
>> +		"0: la    %0,0\n"
>> +		"1:\n"
>> +		EX_TABLE(0b, 1b)
>> +		: "+d" (reg1), "=d" (reg2)
>> +		: "d" (reg0)
>> +		: "cc");
>> +	return reg1;
>> +}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

