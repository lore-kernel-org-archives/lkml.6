Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41B8208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lKmnqqec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41B8208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbeGKOAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:00:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGKOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:00:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BDrnVb130780;
        Wed, 11 Jul 2018 13:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=K7Ipe/zCpuDyneBa1oOY3POXWGgBowTI6HGp12byqNQ=;
 b=lKmnqqecFdh1cv6o4+xUbb6f8yePKi50761vB5EywoVGydWQOojFpv71BIqjDJxRfVeC
 4MnagtVAGdDvoBgHDb2Kge0MNTKQGhhQTWEPnRDo1K6DjBivtHNsxOhWmAYUMaR462BT
 yxSFOAmP+IJ2575QgYtZA1zrTfZE0d03K7nIO1g2dKOryVsVJrlsZ3WQYEEUnnKxh/D+
 IjAdxevPzaWnw/dXyVeWalu7ZkEqBPjWOF2kEdsG/Vpc1Hevh7w1EelL1dZPMs4BUTIR
 8aHGH1IyokZ32Z/5mAxvlx5KK+MVyAyv1nYVOqqXOqUDOHW+QK2BhSR3VzaHShD9ES/m 4g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k2p7dxa34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 13:56:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6BDu0nP003916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 13:56:00 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6BDtxOl000471;
        Wed, 11 Jul 2018 13:55:59 GMT
Received: from mail-oi0-f53.google.com (/209.85.218.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 06:55:59 -0700
Received: by mail-oi0-f53.google.com with SMTP id s198-v6so49372713oih.11;
        Wed, 11 Jul 2018 06:55:59 -0700 (PDT)
X-Gm-Message-State: APt69E2cn2zcUnlq7dkEez9aT7Vb9Ogv/GajWH7UhUZjGuaUOkg+1eqn
        jp+527wrbLdYIlPjrAcCCmjP2CZ25U8oDzmzK2E=
X-Google-Smtp-Source: AAOMgpdqEu1rBscDLOI3GNBghnsmaZCZbitAh4U5NEa+OZxneoadA8cl1mmK/qe+AXnzDWTjaWu2GQk8yRQHFLMruTk=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr34302786oia.229.1531317359180;
 Wed, 11 Jul 2018 06:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
 <87lgai9bt5.fsf@concordia.ellerman.id.au> <20180711133737.GA29573@techadventures.net>
In-Reply-To: <20180711133737.GA29573@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 11 Jul 2018 09:55:59 -0400
X-Gmail-Original-Message-ID: <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
Message-ID: <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
Subject: Re: Boot failures with "mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER"
 on powerpc (was Re: mmotm 2018-07-10-16-50 uploaded)
To:     osalvador@techadventures.net
Cc:     mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>,
        broonie@kernel.org, mhocko@suse.cz,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
        aneesh.kumar@linux.ibm.com, khandual@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am OK, if this patch is removed from Baoquan's series. But, I would
still like to get rid of CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER, I
can work on this in my sparse_init re-write series. ppc64 should
really fallback safely to small chunks allocs, and if it does not
there is some existing bug. Michael please send the config that you
used.

Thank you,
Pavel
On Wed, Jul 11, 2018 at 9:37 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> On Wed, Jul 11, 2018 at 10:49:58PM +1000, Michael Ellerman wrote:
> > akpm@linux-foundation.org writes:
> > > The mm-of-the-moment snapshot 2018-07-10-16-50 has been uploaded to
> > >
> > >    http://www.ozlabs.org/~akpm/mmotm/
> > ...
> >
> > > * mm-sparse-add-a-static-variable-nr_present_sections.patch
> > > * mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
> > > * mm-sparsemem-defer-the-ms-section_mem_map-clearing-fix.patch
> > > * mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch
> > > * mm-sparse-optimize-memmap-allocation-during-sparse_init.patch
> > > * mm-sparse-optimize-memmap-allocation-during-sparse_init-checkpatch-fixes.patch
> >
> > > * mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch
> >
> > This seems to be breaking my powerpc pseries qemu boots.
> >
> > The boot log with some extra debug shows eg:
> >
> >   $ make pseries_le_defconfig
>
> Could you please share the config?
> I was not able to find such config in the kernel tree.
> --
> Oscar Salvador
> SUSE L3
>
