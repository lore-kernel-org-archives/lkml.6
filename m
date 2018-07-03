Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BDBC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A521241B2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A521241B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeGCN0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:26:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752494AbeGCN0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C12D572634;
        Tue,  3 Jul 2018 13:26:03 +0000 (UTC)
Received: from gondolin (ovpn-117-158.ams2.redhat.com [10.36.117.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24E7A2026D76;
        Tue,  3 Jul 2018 13:26:00 +0000 (UTC)
Date:   Tue, 3 Jul 2018 15:25:57 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
Message-ID: <20180703152557.08d10223.cohuck@redhat.com>
In-Reply-To: <18532145-abeb-1251-926e-edbc6fa0bcb0@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
        <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
        <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
        <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
        <20180703135205.2ebb107f.cohuck@redhat.com>
        <18532145-abeb-1251-926e-edbc6fa0bcb0@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 13:26:03 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 13:26:03 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 14:20:11 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 07/03/2018 01:52 PM, Cornelia Huck wrote:
> > On Tue, 3 Jul 2018 11:22:10 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> [..]
> >>
> >> Let me try to invoke the DASD analogy. If one for some reason wants to detach
> >> a DASD the procedure to follow seems to be (see
> >> https://www.ibm.com/support/knowledgecenter/en/linuxonibm/com.ibm.linux.z.lgdd/lgdd_t_dasd_online.html)
> >> the following:
> >> 1) Unmount.
> >> 2) Offline possibly using safe_offline.
> >> 3) Detach.
> >>
> >> Detaching a disk that is currently doing I/O asks for trouble, so the admin is encouraged
> >> to make sure there is no pending I/O.  
> > 
> > I don't think we can use dasd (block devices) as a good analogy for
> > every kind of device (for starters, consider network devices).
> >   
> 
> I did not use it for every kind of device. I used it for AP. I'm
> under the impression you find the analogy inappropriate. If, could
> you please explain why?

I don't think block devices (which are designed to be more or less
permanently accessed, e.g. by mounting a file system) have the same
semantics as ap devices (which exist as a backend for crypto requests).
Not everything that makes sense for a block device makes sense for
other devices as well, and I don't think it makes sense here.

> 
> >> In case of AP you can interpret my 'in use' as the queue is not empty. In my understanding
> >> unbind is supposed to be hard (I used the word radical). That's why I compared it to pulling
> >> a cable. So that's why I ask is there stuff the admin is supposed to do before doing the
> >> unbind.  
> > 
> > Are you asking for a kind of 'quiescing' operation? I would hope that
> > the crypto drivers already can deal with that via flushing the queue,
> > not allowing new requests, or whatever. This is not the block device
> > case.
> >   
> 
> The current implementation of vfio-ap which is a crypto driver too certainly
> can not deal 'with that'. Whether the rest of the drivers can, I don't
> know. Maybe Tony can tell.

If the current implementation of vfio-ap cannot deal with it (by
cleaning up, blocking, etc.), it needs at the very least be documented
so that it can be implemented later. I do not know what the SIE will or
won't do to assist here (e.g., if you're removing it from some masks,
the device will already be inaccessible to the guest). But the part you
were referring to was talking about the existing host driver anyway,
wasn't it?

> 
> I'm aware of the fact that AP adapters are not block devices. But
> as stated above I don't understand what is the big difference regarding
> the unbind operation.
> 
> > Anyway, this is an administrative issue. If you don't have a clear
> > concept which devices are for host usage and which for guest usage, you
> > already have problems.  
> 
> I'm trying to understand the whole solution. I agree, this is an administrative
> issue. But the document is trying to address such administrative issues.

I'd assume "know which devices are for the host and which devices are
for the guests" to be a given, no?

> > 
> > Speaking of administrative issues, is there libvirt support for vfio-ap
> > under development? It would be helpful to validate the approach.  
> 
> I full-heartedly agree. I guess Tony will have to answer this one too.
> 
> Regards,
> Halil
> 

