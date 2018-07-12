Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C5EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B320C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B320C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeGLEn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:43:57 -0400
Received: from ozlabs.org ([203.11.71.1]:45215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbeGLEn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:43:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41R36L3J6Pz9s01;
        Thu, 12 Jul 2018 14:36:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
        pasha.tatashin@oracle.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: Boot failures with "mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER" on powerpc (was Re: mmotm 2018-07-10-16-50 uploaded)
In-Reply-To: <20180711133737.GA29573@techadventures.net>
References: <20180710235044.vjlRV%akpm@linux-foundation.org> <87lgai9bt5.fsf@concordia.ellerman.id.au> <20180711133737.GA29573@techadventures.net>
Date:   Thu, 12 Jul 2018 14:36:10 +1000
Message-ID: <87h8l58405.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@techadventures.net> writes:

> On Wed, Jul 11, 2018 at 10:49:58PM +1000, Michael Ellerman wrote:
>> akpm@linux-foundation.org writes:
>> > The mm-of-the-moment snapshot 2018-07-10-16-50 has been uploaded to
>> >
>> >    http://www.ozlabs.org/~akpm/mmotm/
>> ...
>> 
>> > * mm-sparse-add-a-static-variable-nr_present_sections.patch
>> > * mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
>> > * mm-sparsemem-defer-the-ms-section_mem_map-clearing-fix.patch
>> > * mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch
>> > * mm-sparse-optimize-memmap-allocation-during-sparse_init.patch
>> > * mm-sparse-optimize-memmap-allocation-during-sparse_init-checkpatch-fixes.patch
>> 
>> > * mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch
>> 
>> This seems to be breaking my powerpc pseries qemu boots.
>> 
>> The boot log with some extra debug shows eg:
>> 
>>   $ make pseries_le_defconfig
>
> Could you please share the config?
> I was not able to find such config in the kernel tree.

It's a generated config, see:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?commit=021c91791a5e7e85c567452f1be3e4c2c6cb6063#n315


It's based on pseries_defconfig, which is an actual file in the tree,
but with the endian flipped.

You can see the generated result from a recent build here:

  http://kisskb.ellerman.id.au/kisskb/buildresult/13428803/config/


cheers
