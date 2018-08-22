Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A4AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466F821480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466F821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeHVNeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:34:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726849AbeHVNeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:34:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50B2F4023ECB;
        Wed, 22 Aug 2018 10:09:47 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB89A2157F49;
        Wed, 22 Aug 2018 10:09:41 +0000 (UTC)
Date:   Wed, 22 Aug 2018 12:09:39 +0200
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
Message-ID: <20180822120939.0e08e68b.cohuck@redhat.com>
In-Reply-To: <856de167-478f-f6e0-c706-1f9b87bed7f5@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180820180359.38cc4af3.cohuck@redhat.com>
        <6b83b4da-00eb-c690-e965-a4398dadd0e5@linux.ibm.com>
        <20180821175309.55b774ca.cohuck@redhat.com>
        <856de167-478f-f6e0-c706-1f9b87bed7f5@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 22 Aug 2018 10:09:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 22 Aug 2018 10:09:47 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 09:04:13 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> Well, sooner or later this has to work. Yesterday we tested the control
> domain thing with trying to pull some simple data from a 'controlled' domain
> to the TKE - doesn't work with a Linux LPAR. I will investigate the details in the
> next weeks. However, long-term it should be possible to run scenarios
> like having one KVM guest control all the domains used by other KVM guests.
> With respect to the KVM vfio driver, currently there should be just the
> rule that for a guest the control domain mask should be equal or a superset
> of the usage domain mask. This is by convention as the architecture is
> not so clear here, but this is enforced on every place which deals with
> usage and control domains (SE, TKE).

Thanks for the update; this makes me think we really should fiddle with
the masks in the kernel (as opposed to doing it higher up in the stack).
