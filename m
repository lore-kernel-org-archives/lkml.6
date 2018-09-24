Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8A3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D37214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D37214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbeIXSDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730031AbeIXSDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7105C307DA25;
        Mon, 24 Sep 2018 12:01:27 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 385922010D70;
        Mon, 24 Sep 2018 12:01:23 +0000 (UTC)
Date:   Mon, 24 Sep 2018 14:01:20 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 10/26] KVM: s390: interfaces to clear CRYCB masks
Message-ID: <20180924140120.398a3293.cohuck@redhat.com>
In-Reply-To: <42b23a01-bee1-0c87-3f81-320c40bcb7c9@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-11-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180924130153.766eaec7.cohuck@redhat.com>
        <42b23a01-bee1-0c87-3f81-320c40bcb7c9@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 24 Sep 2018 12:01:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 13:50:36 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 09/24/2018 01:01 PM, Cornelia Huck wrote:
> > On Wed, 12 Sep 2018 15:43:00 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >   
> >> From: Tony Krowiak <akrowiak@linux.ibm.com>
> >>
> >> Introduces two new KVM interface to clear the APM, AQM and ADM masks in
> >> the guest's CRYCB.  The VCPUs are taken out of SIE to ensure the VCPUs do
> >> not get out of sync.  
> > 
> > Hm, that patch description does not quite match what the patch actually
> > does...
> >   
> 
> You mean it is not obvious where the masks get cleared? Well the APCB is
> defined to contain exactly the three masks. As far as I can tell the patch
> description is correct.

No, I was referring to "two new KVM interface[s]". The patch just
introduces a new function that clears the masks (well, maybe you can
call this an "interface"). So

s/two new KVM interface/a function in KVM/

and I'd be happy :) (sorry for being too vague)
