Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF45ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B6C2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B6C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGTDUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 23:20:06 -0400
Received: from ozlabs.org ([203.11.71.1]:39203 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbeGTDUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 23:20:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Ww1p571fz9s7Q;
        Fri, 20 Jul 2018 12:34:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: linux-next: manual merge of the powerpc tree with the powerpc-fixes tree
In-Reply-To: <20180720095138.275cc9aa@canb.auug.org.au>
References: <20180720095138.275cc9aa@canb.auug.org.au>
Date:   Fri, 20 Jul 2018 12:34:06 +1000
Message-ID: <87r2jybppd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>
>   drivers/vfio/vfio_iommu_spapr_tce.c
>
> between commit:
>
>   1463edca6734 ("vfio/spapr: Use IOMMU pageshift rather than pagesize")
>
> from the powerpc-fixes tree and commit:
>
>   00a5c58d9499 ("KVM: PPC: Make iommu_table::it_userspace big endian")
>
> from the powerpc tree.

Thanks.

That has turned into a real mess, with conflicting code in next, fixes
and topic/ppc-kvm.

I'll fix it all up before the merge window.

cheers
