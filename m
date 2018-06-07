Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EVWeAwpfGVvLNQAAmS7hNA
	; Thu, 07 Jun 2018 16:37:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 84F2E607E7; Thu,  7 Jun 2018 16:37:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CC0F7601B4;
	Thu,  7 Jun 2018 16:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC0F7601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeFGQh1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:37:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932822AbeFGQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:37:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57GYWEX120011
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 12:37:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jf6vhd4pb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:37:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 7 Jun 2018 17:37:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 17:37:19 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57GbHqK22937642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 16:37:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A77F52043;
        Thu,  7 Jun 2018 16:26:54 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D3A2752041;
        Thu,  7 Jun 2018 16:26:53 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x@nongnu.org, qemu-devel@nongnu.org
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
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 7 Jun 2018 18:37:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607115442.6a779ed9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060716-0028-0000-0000-000002CE5A3B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060716-0029-0000-0000-000023855F62
Message-Id: <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=840 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 11:54, Cornelia Huck wrote:
> On Wed, 6 Jun 2018 16:15:31 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 06/06/2018 14:21, Cornelia Huck wrote:
>>> On Tue, 5 Jun 2018 17:23:02 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>   
>>>> On 05/06/2018 15:14, Cornelia Huck wrote:
>>>>> On Tue, 22 May 2018 17:10:44 +0200
>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>      
>>>>>> On 22/05/2018 14:52, Cornelia Huck wrote:
>>>>>>> On Wed, 16 May 2018 15:32:48 +0200
>>>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>>>         
>>>>>>>> On 15/05/2018 18:10, Cornelia Huck wrote:
>>>>>>>>> On Fri, 11 May 2018 11:33:35 +0200
>>>>>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>>>>>            
>>>>>>>>>> On 09/05/2018 17:48, Cornelia Huck wrote:
>>

snip

>> sub-channel at the same time?
>>
>> If QEMU, once asynchronous, can do this, it could just
>> halt the start before asking this to the backend. Don't it?
>>
>> Another point is that the start must have been accepted by the
>> sub-channel for the start bit in the fc field of the SCSW to be set.
> Hm, I think we need to be more precise as to what scsw we're talking
> about. Bad ascii art time:
>
> --------------
> |   scsw(g)  |  ssch
> --------------   |
>                   |                                       guest
> --------------------------------------------------------------
>                   |                                        qemu
> --------------   v
> |   scsw(q)  | emulate
> --------------   |
>                   |
> --------------   v
> |   scsw(r)  | pwrite()
> --------------   |
>                   |
> --------------------------------------------------------------
>                   |                                        vfio
>                   v
>                  ssch
>                   |
> --------------------------------------------------------------
>                   |                                    hardware
> --------------   v
> |   scsw(h)  | actually do something
> --------------
>
> The guest issues a ssch (which gets intercepted; it won't get control
> back until ssch finishes with a cc set.) scsw(g) won't change, unless
> the guest does a stsch for the subchannel on another vcpu, in which
> case it will get whatever information qemu holds in scsw(q) at that
> point in time.
>
> When qemu starts to emulate the guest's ssch, it will set the start
> function bit in the fctl field of scsw(q). It then copies scsw(q) to
> scsw(r) in the vfio region.
>
> The vfio code will then proceed to call ssch on the real subchannel.
> This is the first time we get really asynchronous, as the ssch will
> return with cc set and the start function will be performed at some
> point in time. If we would do a stsch on the real subchannel, we would
> see that scsw(h) now has the start function bit set.
>
> Currently, we won't return back up the chain until we get an interrupt
> from the hardware, at which time we update the scsw(r) from the irb.

I do not find where the thread waits for interrupt inside the
write->fsm_io_request->fsm_io_helper->ssch chain.

I must have miss it ten times. Can you point it to me?

> This will propagate into the scsw(q). At the time we finish handling
> the guest's ssch and return control to it, we're all done and if the
> guest does a stsch to update its scsw(g), it will get the current
> scsw(q) which will already contain the scsw from the interrupt's irb
> (indicating that the start function is already finished).
>
> Now let's imagine we have a future implementation that handles actually
> performing the start on the hardware asynchronously, i.e. it returns
> control to the guest without the interrupt having been posted (let's
> say that it is a longer-running I/O request). If the guest now did a
> stsch to update scsw(g), it would get the current state of scsw(q),
> which would be "start function set, but not done yet".
>
> If the guest now does a hsch, it would trap in the same way as the ssch
> before. When qemu gets control, it adds the halt bit in scsw(q) (which
> is in accordance with the architecture).

This I agree.
The scsw(q) is part of the QEMU device.

>   My proposal is to do the same
> copying to scsw(r) again, which would mean we get a request with both
> the halt and the start bit set. The vfio code now needs to do a hsch
> (instead of a ssch). The real channel subsystem should figure this out,
> as we can't reliably check whether the start function has concluded
> already (there's always a race window).

This I do not agree scsw(r) is part of the driver.
The interface here is not a device interface anymore but a driver 
interface.
SCSW is a status, it is at its place in QEMU device interface with the 
guest
but here pwrite() sends a command.


Since we do not do a STSCH on each command, scsw(q), should be
updated by QEMU depending on syscall return value.
This is not done currently, only the success path is right
because it is set before the call.

If I read right and the IRQ is asynchronous, the scsw(q) is not right,
because not updated, after the interrupt is received from the guest.

>
> For csch, things are a bit different (which the code posted here did
> not take into account). The qemu emulation of csch needs to clear any
> start/halt bits in scsw(q) when setting the clear bit there, and
> therefore scsw(r) will only have the clear bit set in that case. We
> still should do an unconditional csch for the same reasons as above;
> the hardware will do the same things (clearing start/halt, setting
> clear) in the scsw(h).
>
> Congratulations, you've reached the end :) I hope that was helpful and
> not too confusing.
>
Yes it was, thank you, and it is clear, but still... questions ... ;)

Best regards,

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
