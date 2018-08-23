Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032702150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032702150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeHWNyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:54:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbeHWNyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:54:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4F7240241EE;
        Thu, 23 Aug 2018 10:25:33 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F345A9F02;
        Thu, 23 Aug 2018 10:25:27 +0000 (UTC)
Date:   Thu, 23 Aug 2018 12:25:25 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
Message-ID: <20180823122525.02fc4af3.cohuck@redhat.com>
In-Reply-To: <9ef5fcb9-02e0-88e3-007c-eedb14e6db80@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180820162317.08bd7d23.cohuck@redhat.com>
        <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
        <20180821172548.57a6c758.cohuck@redhat.com>
        <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
        <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
        <20180822114250.59a250aa.cohuck@redhat.com>
        <8bc5f207-f913-825c-f9fc-0a2c7fd280aa@linux.ibm.com>
        <e36abc22-9daf-e0f4-c6b3-7adbb28db4c3@de.ibm.com>
        <f84dbcc0-f627-be02-9933-3baa953adc09@linux.ibm.com>
        <219b352b-d5a2-189c-e205-82e7f9ae3d64@de.ibm.com>
        <dbb74c9c-93ab-ed05-fad4-ea2aa5f2b71e@linux.ibm.com>
        <9ef5fcb9-02e0-88e3-007c-eedb14e6db80@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 23 Aug 2018 10:25:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 23 Aug 2018 10:25:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 15:16:19 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> One of the things I suggested in a private conversation with Christian 
> earlier
> today was to provide an additional rw sysfs attribute - a boolean - that 
> indicates
> whether all usage domains should also be control domains. The default 
> could be
> true. This would allow one to configure guests with usage-only domains 
> as well
> as satisfy the convention.

Would this additional attribute then control "add usage domains to the
list of control domains automatically", or "don't allow to add a usage
domain if it has not already been added as a control domain"?

One thing I'm still unsure about is how libvirt comes into the picture
here. Will it consume the setting, or actively manipulate it?

[In general, I'm not very clear about how libvirt will interact with the
whole infrastructure...]
