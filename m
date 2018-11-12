Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CCAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147002243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147002243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbeKLXay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:30:54 -0500
Received: from 8bytes.org ([81.169.241.247]:39668 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbeKLXay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:30:54 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8F7B3533; Mon, 12 Nov 2018 14:37:33 +0100 (CET)
Date:   Mon, 12 Nov 2018 14:37:32 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Wei Wang <wawei@amazon.de>,
        Amadeusz Juskowiak <ajusk@amazon.de>,
        Julian Stecklina <jsteckli@amazon.de>
Subject: Re: [PATCH] svm: Add mutex_lock to protect apic_access_page_done on
 AMD systems
Message-ID: <20181112133731.lwje2hzibd64cvc3@8bytes.org>
References: <20181112122255.128953-1-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112122255.128953-1-Suravee.Suthikulpanit@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:23:14PM +0000, Suthikulpanit, Suravee wrote:
> From: Wei Wang <wawei@amazon.de>
> 
> There is a race condition when accessing kvm->arch.apic_access_page_done.
> Due to it, x86_set_memory_region will fail when creating the second vcpu
> for a svm guest.
> 
> Add a mutex_lock to serialize the accesses to apic_access_page_done.
> This lock is also used by vmx for the same purpose.
> 
> Signed-off-by: Wei Wang <wawei@amazon.de>
> Signed-off-by: Amadeusz Juskowiak <ajusk@amazon.de>
> Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Joerg Roedel <jroedel@suse.de>

