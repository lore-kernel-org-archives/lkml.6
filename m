Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5A9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCC02156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCC02156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeI0TbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:31:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727487AbeI0TbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:31:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RD9wLD006060
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:12:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mrxt7kk0s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:12:49 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 27 Sep 2018 07:12:48 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 07:12:45 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8RDCgpd59113660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 06:12:42 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55B3078063;
        Thu, 27 Sep 2018 07:12:42 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FAC27805E;
        Thu, 27 Sep 2018 07:12:39 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.201.36])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Sep 2018 07:12:39 -0600 (MDT)
Subject: Re: [PATCH v11 26/26] s390: doc: detailed specifications for AP
 virtualization
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-27-akrowiak@linux.vnet.ibm.com>
 <20180926164222.74731b74@t450s.home>
 <c4caf272-f9ef-ce61-bb0d-0b94bbf3ea84@linux.ibm.com>
 <20180927135141.0fa87f2c.cohuck@redhat.com>
 <c18dbe70-63eb-1f6d-8470-124e967b0bfa@de.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 27 Sep 2018 09:12:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <c18dbe70-63eb-1f6d-8470-124e967b0bfa@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092713-8235-0000-0000-00000E07CB64
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009781; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094400; UDB=6.00565721; IPR=6.00874436;
 MB=3.00023530; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-27 13:12:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092713-8236-0000-0000-000042CA4BB2
Message-Id: <0c036788-9d0e-90b2-8708-98f7ff4036ad@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 07:59 AM, Christian Borntraeger wrote:
> 
> 
> On 09/27/2018 01:51 PM, Cornelia Huck wrote:
>> On Thu, 27 Sep 2018 13:29:43 +0200
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> On 09/27/2018 12:42 AM, Alex Williamson wrote:
>>>> On Tue, 25 Sep 2018 19:16:41 -0400
>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>> +   This is how the matrix is configured for Guest2:
>>>>> +
>>>>> +      echo 5 > assign_adapter
>>>>> +      echo 0x47 > assign_domain
>>>>> +      echo 0xff > assign_domain
>>>>> +
>>>>> +   This is how the matrix is configured for Guest3:
>>>>> +
>>>>> +      echo 6 > assign_adapter
>>>>> +      echo 0x47 > assign_domain
>>>>> +      echo 0xff > assign_domain
>>>>> +
>>>>
>>>> I'm curious why this interface didn't adopt the +/- notation invented
>>>> above for consistency.  Too difficult to do rollbacks with a string on
>>>> entries?
>>>>    
>>>
>>> I remember that we did discuss that possibility around v9, but I can't
>>> tell why did we decide to not implement it. Maybe Tony has an answer.
>>
>> IIRC, that was a discussion on the base ap driver interfaces rather
>> than vfio-ap.
>>
>>>
>>> Anyway, if we were to do that, we would use different attribute names
>>> (e.g. just domain_mask, or something similar instead of
>>> (assign|unassign)_xxx). So I think such an interface can still be added
>>> on top of the existing one. Having that said having multiple interfaces
>>> for the very same thing is usually not so nice IMHO.
>>
>> Nod to all of your points.
>>
>> As we do the configuration while the guest is not running anyway, the
>> different interfaces probably do not make that much difference in
>> practice. It should be fine to stick to the current interface for now
>> and only add a new one if we really think it is significantly better.
> 
> Tony, can you maybe provide a quick on-top patch that clarifies Alex
> comments regarding the documentation? (State that is is big endian,
> fixup the small things etc).
> I can then either fold it in or provide it as an on top patch depending
> on how much has changed.

Will do.

> 

