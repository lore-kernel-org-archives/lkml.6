Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A8CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F49F2150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F49F2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeI0SJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:09:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbeI0SJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:09:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCBCDC0587D2;
        Thu, 27 Sep 2018 11:51:52 +0000 (UTC)
Received: from gondolin (ovpn-117-60.ams2.redhat.com [10.36.117.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9718A611A5;
        Thu, 27 Sep 2018 11:51:44 +0000 (UTC)
Date:   Thu, 27 Sep 2018 13:51:41 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v11 26/26] s390: doc: detailed specifications for AP
 virtualization
Message-ID: <20180927135141.0fa87f2c.cohuck@redhat.com>
In-Reply-To: <c4caf272-f9ef-ce61-bb0d-0b94bbf3ea84@linux.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-27-akrowiak@linux.vnet.ibm.com>
        <20180926164222.74731b74@t450s.home>
        <c4caf272-f9ef-ce61-bb0d-0b94bbf3ea84@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 27 Sep 2018 11:51:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 13:29:43 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 09/27/2018 12:42 AM, Alex Williamson wrote:
> > On Tue, 25 Sep 2018 19:16:41 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >> +   This is how the matrix is configured for Guest2:
> >> +
> >> +      echo 5 > assign_adapter
> >> +      echo 0x47 > assign_domain
> >> +      echo 0xff > assign_domain
> >> +
> >> +   This is how the matrix is configured for Guest3:
> >> +
> >> +      echo 6 > assign_adapter
> >> +      echo 0x47 > assign_domain
> >> +      echo 0xff > assign_domain
> >> +  
> > 
> > I'm curious why this interface didn't adopt the +/- notation invented
> > above for consistency.  Too difficult to do rollbacks with a string on
> > entries?
> >   
> 
> I remember that we did discuss that possibility around v9, but I can't
> tell why did we decide to not implement it. Maybe Tony has an answer.

IIRC, that was a discussion on the base ap driver interfaces rather
than vfio-ap.

> 
> Anyway, if we were to do that, we would use different attribute names
> (e.g. just domain_mask, or something similar instead of
> (assign|unassign)_xxx). So I think such an interface can still be added
> on top of the existing one. Having that said having multiple interfaces
> for the very same thing is usually not so nice IMHO.

Nod to all of your points.

As we do the configuration while the guest is not running anyway, the
different interfaces probably do not make that much difference in
practice. It should be fine to stick to the current interface for now
and only add a new one if we really think it is significantly better.
