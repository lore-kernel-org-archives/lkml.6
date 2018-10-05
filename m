Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B914C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D780620875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D780620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeJEPmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbeJEPmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:42:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43BB03082A26;
        Fri,  5 Oct 2018 08:44:27 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7E25EDEF;
        Fri,  5 Oct 2018 08:44:22 +0000 (UTC)
Date:   Fri, 5 Oct 2018 10:44:20 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v1 0/2] KVM: s390: Tracing APCB changes
Message-ID: <20181005104420.62792eed.cohuck@redhat.com>
In-Reply-To: <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
        <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 05 Oct 2018 08:44:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 10:31:08 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> In the first patch we define kvm_arch_crypto_set_masks,
> a new function to centralize the setup the APCB masks
> inside the CRYCB SIE satelite and add KVM_EVENT() to
> kvm_arch_crypto_set_masks and kvm_arch_crypto_clear_masks.
> 
> In the second patch we replace the vfio_ap_mdev_copy_masks()
> by the new kvm_arch_crypto_set_masks() function.
> 
> 
> Pierre Morel (2):
>   KVM: s390: Tracing APCB changes
>   s390: vfio-ap: setup APCB mask using KVM dedicated function
> 
>  arch/s390/include/asm/kvm_host.h  |  2 ++
>  arch/s390/kvm/kvm-s390.c          | 41 +++++++++++++++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_ops.c | 33 +++----------------------------
>  3 files changed, 46 insertions(+), 30 deletions(-)
> 

I like this version better: it moves the mask-setting next to the
mask-clearing, and, as a bonus, adds a trace event for clearing as
well :)
