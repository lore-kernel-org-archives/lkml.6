Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5XLuGa/oGlusawAAmS7hNA
	; Fri, 08 Jun 2018 20:40:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0CAEE607DC; Fri,  8 Jun 2018 20:40:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 63653602FC;
	Fri,  8 Jun 2018 20:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63653602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbeFHUku (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:40:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752694AbeFHUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:40:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58KXvgt118392
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 16:40:47 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jfv3abnqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 16:40:47 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 8 Jun 2018 21:40:45 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 21:40:42 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58KeecW32768006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 20:40:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D8BEA404D;
        Fri,  8 Jun 2018 21:31:38 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB8A2A4053;
        Fri,  8 Jun 2018 21:31:37 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.145.169.119])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 21:31:37 +0100 (BST)
Subject: Re: [qemu-s390x] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
        Dong Jia Shi <bjsdjshi@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
 <20180509154822.23510-3-cohuck@redhat.com>
 <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
 <20180515181006.0cb1dfc2.cohuck@redhat.com>
 <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
 <20180522145208.310143ea.cohuck@redhat.com>
 <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
 <20180605151449.22aafbfc.cohuck@redhat.com>
 <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
 <20180606142131.74ea2eb7.cohuck@redhat.com>
 <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
 <20180607115442.6a779ed9.cohuck@redhat.com>
 <10c8a0ac-fe61-d7c7-c7bb-0fffc6909cb3@linux.ibm.com>
 <20180607183407.1ea5ab89.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 8 Jun 2018 22:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180607183407.1ea5ab89.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18060820-0008-0000-0000-00000245AE0C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060820-0009-0000-0000-000021ABC737
Message-Id: <0c1e1b26-0c6a-fdc2-0c1a-2e2d58c2cb73@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=891 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2018 06:34 PM, Cornelia Huck wrote:
> On Thu, 7 Jun 2018 18:17:57 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 06/07/2018 11:54 AM, Cornelia Huck wrote:
>>> Hm, I think we need to be more precise as to what scsw we're talking
>>> about. Bad ascii art time:
>>>
>>> --------------
>>> |   scsw(g)  |  ssch
>>> --------------   |
>>>                    |                                       guest
[..]

>> (5) AFAIK this is how the current implementation works. We don't wait
>> for the I/O interrupt on the host to present a cc to the guest for it's
>> ssch.
> 
> But the vfio code does wait, no? We just signal the interrupt via
> eventfd as well.
> 

We have sorted this out in the other thread.

>>
>>>
>>> If the guest now does a hsch, it would trap in the same way as the ssch
>>> before. When qemu gets control, it adds the halt bit in scsw(q) (which
>>> is in accordance with the architecture).
>>
>> (7) Again it's when is fctl set according to the architecture...
> 
> Same comment as above. If we do a hsch for a subchannel with the start
> function set, we'll set cc 0.
> 
>>
>>> My proposal is to do the same
>>> copying to scsw(r) again, which would mean we get a request with both
>>> the halt and the start bit set.
>>
>> (8) IMHO when receiving the 'request' we are and should be in instruction
>> context -- opposed to basic io function context. So we should not set fctl
>> before we know what will our guest cc be. But since scsw(r) is not a real
>> scsw it is just strange.
> 
> I think what we are doing is really 'performing the start function' -
> it's just not asynchronous in the current implementation. 

The code is written as if, especially in QEMU. But this was in my current
understanding a bad decision. The why is the following. It makes reasoning
both about architectural correctness and the code a lot trickier compared
to the interpretation of the guest instruction finishes after the host
instruction finishes (unless we can prove we don't need any) approach.


> So we already know that ssch will return with cc 0.
> 

I will use your example, and another example to explain what I mean
by tricky.

One can probably argue that setting cc 0 even if the host device
responds to the host ssch with cc 3 because the device is not any more
on the given subchannel or simply just disabled. It is probably true
that the guest would not have any means to prove that we were 'lying'
to it.

But AFAIR this is not how the current implementation works. The pwrite
in qemu basically depends on the cc of the host ssch. So if the host
ssch completes with cc 3 the vfio-ccw kernel module map ist to pwrite
reporting -ENODEV and vfio_ccw_handle_request makes sure that the
guest instruction completes with cc 3 by mapping it to return code
IOINST_CC_NOT_OPERATIONAL.

I mentioned xsch in the other thread. I don't think we can tell if
cc 0 or cc 2. In my reading xsch in simple words xsch completes with
cc 2 and does nothing else if the channel subsystem already started talking
to the cu/device. If in time it makes sure we don't start talking to the
device, and clear away stuff. So if we don't consider cc of the xsch
to be issued by the host the only safe bet seems to be cc 2. But that's
effectively getting around implementing the desired functionality of
xsch and still staying architecturally correct. Which however might
be good enough for vfio-ccw. But I think I demonstrated it's kinda
tricky business.

I prefer to avoid tricky if there is no good reason not to.

[..]

> 
> Thanks for reading!
> 

Your welcome. The discussion is kind of taking place all over the
place. I'm actively trying to find the best place to answer, and avoid
overtalking topics -- but it does not seem to work. Please bear with me.

Regards,
Halil
  
[..]
