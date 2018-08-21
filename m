Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F742C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ED8217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4ED8217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeHUTN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:13:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbeHUTN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D89987916;
        Tue, 21 Aug 2018 15:53:17 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6677B2166BA1;
        Tue, 21 Aug 2018 15:53:11 +0000 (UTC)
Date:   Tue, 21 Aug 2018 17:53:09 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
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
Subject: Re: [PATCH v9 22/22] s390: doc: detailed specifications for AP
 virtualization
Message-ID: <20180821175309.55b774ca.cohuck@redhat.com>
In-Reply-To: <6b83b4da-00eb-c690-e965-a4398dadd0e5@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180820180359.38cc4af3.cohuck@redhat.com>
        <6b83b4da-00eb-c690-e965-a4398dadd0e5@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 21 Aug 2018 15:53:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 21 Aug 2018 15:53:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 11:00:00 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 20.08.2018 18:03, Cornelia Huck wrote:
> > On Mon, 13 Aug 2018 17:48:19 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> >> +* AP Instructions:
> >> +
> >> +  There are three AP instructions:
> >> +
> >> +  * NQAP: to enqueue an AP command-request message to a queue
> >> +  * DQAP: to dequeue an AP command-reply message from a queue
> >> +  * PQAP: to administer the queues  
> > So, NQAP/DQAP need usage domains, while PQAP needs a control domain? Or
> > is it that all of them need usage domains, but PQAP can target a control
> > domain as well?
> >
> > [I don't want to dive deeply into the AP architecture here, just far
> > enough to really understand the design implications.]  
> Well, to be honest, nobody ever tried this under Linux. Theoretically
> one should be able to send a CPRB to a usage domain where inside
> the CPRB another domain (the control domain) is addressed. However,
> as of now I am only aware of applications controlling the same usage
> domain. I don't know any application which is able to address another
> control domain and I am not sure if the zcrypt device driver would
> handle such a CPRB correctly. NQAP, DQAP and PQAP always address
> a usage domain. But the CPRB send down the pipe via NQAP may
> address some control thing on another domain. I am not sure which
> code and where do the sorting out here. There are two candidates:
> the firmware layer in the CEC and the crypto card code.

OK, so it's possible as by the architecture, but at least Linux does
not (currently) do it?

Perhaps we should simply not overthink that whole control domain
thingy :) It's mostly yet another knob, and as long as the design does
not go against the general architecture, it's probably fine, I guess.
