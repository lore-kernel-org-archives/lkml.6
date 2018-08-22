Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3CCC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17402147A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17402147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeHVLCU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:02:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728521AbeHVLCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:02:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07276804BAAC;
        Wed, 22 Aug 2018 07:38:38 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D1B42166BA1;
        Wed, 22 Aug 2018 07:38:32 +0000 (UTC)
Date:   Wed, 22 Aug 2018 09:38:30 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
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
        frankja@linux.ibm.com
Subject: Re: [PATCH v9 22/22] s390: doc: detailed specifications for AP
 virtualization
Message-ID: <20180822093830.185998c2.cohuck@redhat.com>
In-Reply-To: <af7d64a8-23fb-7953-57e8-18683a4f334d@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180820180359.38cc4af3.cohuck@redhat.com>
        <a305a39b-1196-ae64-97fd-f970387d82d4@linux.ibm.com>
        <af7d64a8-23fb-7953-57e8-18683a4f334d@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 22 Aug 2018 07:38:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 22 Aug 2018 07:38:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 20:54:49 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 08/20/2018 10:16 PM, Tony Krowiak wrote:
> >> Does the SIE complain if you specify a control
> >> domain that the host does not have access to (I'd guess so)?  
> > 
> > The SIE does not complain if you specify a domain to which the host - or a
> > lower level guest - does not have access. The firmware performs a logical
> > AND of the guest's and hosts's - or lower level guest's - APMs, AQMs and ADMs  
> 
> Rather a bit-wise AND, I guess (of the same type masks corresponding to Guest 1 and
> Guest 2). The result of a logical AND is a logical value (true or false) as
> far as I remember.
> 
> > to create effective masks EAPM, EAQM and EADM. Only devices corresponding to
> > the bits set in the EAPM, EAQM and EADM will be accessible by the guest.  
> 
> I'm not sure what is the intended meaning of 'the SIE complains'. If it means
> getting out of (SIE when interpreting lets say an NQAP under the discussed
> circumstances) with some sort of error code, I think Tony's answer, ' SIE does not complain'
> makes a lot of sense. It's the guest that's is trying to stretch further than
> the blanket reaches, and it's the guest that needs to be educated on this fact.

Yep, that's what I meant. If the hypervisor can call the SIE with that
config, but the guest gets an error if it tries to use something that
it cannot use, that's fine.
