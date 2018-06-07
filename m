Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Qn4EEx9ZGVubBgAAmS7hNA
	; Thu, 07 Jun 2018 16:18:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4BA7E6074D; Thu,  7 Jun 2018 16:18:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9B0CB60590;
	Thu,  7 Jun 2018 16:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B0CB60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935618AbeFGQSH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:18:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932940AbeFGQSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:18:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57G9jDp053377
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 12:18:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf4uyjgkv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:18:04 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 7 Jun 2018 17:18:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 17:17:59 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57GHv7V33030164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 16:17:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF51E5204B;
        Thu,  7 Jun 2018 16:07:34 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.179])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 571E35203F;
        Thu,  7 Jun 2018 16:07:34 +0100 (BST)
Subject: Re: [qemu-s390x] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
To: Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>
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
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 7 Jun 2018 18:17:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180607115442.6a779ed9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18060716-0020-0000-0000-000002985A60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060716-0021-0000-0000-000020E46041
Message-Id: <10c8a0ac-fe61-d7c7-c7bb-0fffc6909cb3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2018 11:54 AM, Cornelia Huck wrote:
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

(1) I think BQL make other cpu or not other kind of the same. We will
effectively start processing the stsch in QEMU after we are done
with the ssch in QEMU.

> 
> When qemu starts to emulate the guest's ssch, it will set the start
> function bit in the fctl field of scsw(q). It then copies scsw(q) to
> scsw(r) in the vfio region.
> 

(2) This is architecturally wrong AFAIK. The fctl bit is supposed to be set on
cc 0. But because of (1) this might not be a observable by the guest --
we can fix it up.

(3)IMHO scsw(r) is not a real scsw as defined by the architecture but
a strange communication structure (not) defined vfio-ccw.

> The vfio code will then proceed to call ssch on the real subchannel.
> This is the first time we get really asynchronous, as the ssch will
> return with cc set and the start function will be performed at some
> point in time. If we would do a stsch on the real subchannel, we would
> see that scsw(h) now has the start function bit set.
> 

(4) I guess only if cc 0.

> Currently, we won't return back up the chain until we get an interrupt
> from the hardware, at which time we update the scsw(r) from the irb.
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

(5) AFAIK this is how the current implementation works. We don't wait
for the I/O interrupt on the host to present a cc to the guest for it's
ssch.

> 
> If the guest now does a hsch, it would trap in the same way as the ssch
> before. When qemu gets control, it adds the halt bit in scsw(q) (which
> is in accordance with the architecture).

(7) Again it's when is fctl set according to the architecture...

> My proposal is to do the same
> copying to scsw(r) again, which would mean we get a request with both
> the halt and the start bit set.

(8) IMHO when receiving the 'request' we are and should be in instruction
context -- opposed to basic io function context. So we should not set fctl
before we know what will our guest cc be. But since scsw(r) is not a real
scsw it is just strange.

> The vfio code now needs to do a hsch
> (instead of a ssch). The real channel subsystem should figure this out,
> as we can't reliably check whether the start function has concluded
> already (there's always a race window).
> 

(9) Yes we can't tell for sure if the start function is still being performed
by the stuff below.

Regards,
Halil

> For csch, things are a bit different (which the code posted here did
> not take into account). The qemu emulation of csch needs to clear any
> start/halt bits in scsw(q) when setting the clear bit there, and
> therefore scsw(r) will only have the clear bit set in that case. We
> still should do an unconditional csch for the same reasons as above;
> the hardware will do the same things (clearing start/halt, setting
> clear) in the scsw(h).
> 
> Congratulations, you've reached the end:)  I hope that was helpful and
> not too confusing.
> 
