Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BE8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F62A2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfBVJrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:47:51 -0500
Received: from ozlabs.org ([203.11.71.1]:48625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfBVJrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:49 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RN24dKKz9sB3; Fri, 22 Feb 2019 20:47:46 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1b58a975be36994a572ae3b3fb3e023272bc299f
X-Patchwork-Hint: ignore
In-Reply-To: <20190131103022.10218-1-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Mark Hairgrove <mhairgrove@nvidia.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Alistair Popple <alistair@popple.id.au>,
        linuxppc-dev@lists.ozlabs.org, Jason Wang <jasowang@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc/powernv/npu: Remove redundant change_pte() hook
Message-Id: <445RN24dKKz9sB3@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:46 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-31 at 10:30:22 UTC, Peter Xu wrote:
> The change_pte() notifier was designed to use as a quick path to
> update secondary MMU PTEs on write permission changes or PFN changes.
> For KVM, it could reduce the vm-exits when vcpu faults on the pages
> that was touched up by KSM.  It's not used to do cache invalidations,
> for example, if we see the notifier will be called before the real PTE
> update after all (please see set_pte_at_notify that set_pte_at was
> called later).
> 
> All the necessary cache invalidation should all be done in
> invalidate_range() already.
> 
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Alistair Popple <alistair@popple.id.au>
> CC: Alexey Kardashevskiy <aik@ozlabs.ru>
> CC: Mark Hairgrove <mhairgrove@nvidia.com>
> CC: Balbir Singh <bsingharora@gmail.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Andrea Arcangeli <aarcange@redhat.com>
> CC: Jerome Glisse <jglisse@redhat.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
> Reviewed-by: Alistair Popple <alistair@popple.id.au>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1b58a975be36994a572ae3b3fb3e0232

cheers
