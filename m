Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2278C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5C924B36
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5C924B36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeGCLwQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:52:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752342AbeGCLwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:52:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAC5787927;
        Tue,  3 Jul 2018 11:52:13 +0000 (UTC)
Received: from gondolin (ovpn-117-158.ams2.redhat.com [10.36.117.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B9502026D76;
        Tue,  3 Jul 2018 11:52:09 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:52:05 +0200
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
Message-ID: <20180703135205.2ebb107f.cohuck@redhat.com>
In-Reply-To: <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
        <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
        <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
        <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 11:52:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 11:52:14 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 11:22:10 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 07/03/2018 09:46 AM, Harald Freudenberger wrote:
> > On 02.07.2018 18:28, Halil Pasic wrote:  
> >>
> >>
> >> On 06/29/2018 11:11 PM, Tony Krowiak wrote:  
> >>> This patch provides documentation describing the AP architecture and
> >>> design concepts behind the virtualization of AP devices. It also
> >>> includes an example of how to configure AP devices for exclusive
> >>> use of KVM guests.
> >>>
> >>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >>> ---  
> >> [..]  
> >>> +
> >>> +Reserve APQNs for exclusive use of KVM guests
> >>> +---------------------------------------------
> >>> +The following block diagram illustrates the mechanism by which APQNs are
> >>> +reserved:
> >>> +
> >>> +                              +------------------+
> >>> +                 remove       |                  |   unbind
> >>> +         +------------------->+ cex4queue driver +<-----------+
> >>> +         |                    |                  |            |
> >>> +         |                    +------------------+            |
> >>> +         |                                                    |
> >>> +         |                                                    |
> >>> +         |                                                    |
> >>> ++--------+---------+ register +------------------+      +-----+------+
> >>> +|                  +<---------+                  | bind |            |
> >>> +|      ap_bus      |          |  vfio_ap driver  +<-----+    admin   |
> >>> +|                  +--------->+                  |      |            |
> >>> ++------------------+  probe   +---+--------+-----+      +------------+
> >>> +                                  |        |
> >>> +                           create |        | store APQN
> >>> +                                  |        |
> >>> +                                  v        v
> >>> +                              +---+--------+-----+
> >>> +                              |                  |
> >>> +                              |  matrix device   |
> >>> +                              |                  |
> >>> +                              +------------------+
> >>> +
> >>> +The process for reserving an AP queue for use by a KVM guest is:
> >>> +
> >>> +* The vfio-ap driver during its initialization will perform the following:
> >>> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
> >>> +  * Create the 'matrix' device in the 'vfio_ap' root
> >>> +  * Register the matrix device with the device core
> >>> +* Register with the ap_bus for AP queue devices of type 10 devices (CEX4 and
> >>> +  newer) and to provide the vfio_ap driver's probe and remove callback
> >>> +  interfaces. The reason why older devices are not supported is because there
> >>> +  are no systems available on which to test.
> >>> +* The admin unbinds queue cc.qqqq from the cex4queue device driver. This results
> >>> +  in the ap_bus calling the the device driver's remove interface which
> >>> +  unbinds the cc.qqqq queue device from the driver.  
> >>
> >> What if the queue cc.qqqq is already in use? AFAIU unbind is almost as radical as
> >> pulling a cable. What is the proper procedure an admin should follow before doing
> >> the unbind?  
> > What do you mean on this level with 'in use'? A unbind destroys the association
> > between device and driver. There is no awareness of 'in use' or 'not in use' on this
> > level. This is a hard unbind.  
> >>  
> 
> 
> Let me try to invoke the DASD analogy. If one for some reason wants to detach
> a DASD the procedure to follow seems to be (see
> https://www.ibm.com/support/knowledgecenter/en/linuxonibm/com.ibm.linux.z.lgdd/lgdd_t_dasd_online.html)
> the following:
> 1) Unmount.
> 2) Offline possibly using safe_offline.
> 3) Detach.
> 
> Detaching a disk that is currently doing I/O asks for trouble, so the admin is encouraged
> to make sure there is no pending I/O.

I don't think we can use dasd (block devices) as a good analogy for
every kind of device (for starters, consider network devices).

> In case of AP you can interpret my 'in use' as the queue is not empty. In my understanding
> unbind is supposed to be hard (I used the word radical). That's why I compared it to pulling
> a cable. So that's why I ask is there stuff the admin is supposed to do before doing the
> unbind.

Are you asking for a kind of 'quiescing' operation? I would hope that
the crypto drivers already can deal with that via flushing the queue,
not allowing new requests, or whatever. This is not the block device
case.

Anyway, this is an administrative issue. If you don't have a clear
concept which devices are for host usage and which for guest usage, you
already have problems.

Speaking of administrative issues, is there libvirt support for vfio-ap
under development? It would be helpful to validate the approach.
