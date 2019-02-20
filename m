Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0911C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0732146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DsNtbxUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfBTRLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:11:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43382 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfBTRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:11:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so41352214ota.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esoiL0zRtkoIhqgz3+K0ShHM1vB/8CWMDhEUxTj3zO8=;
        b=DsNtbxUOFXRcfEJV/wQJbgi+JWS95dNFGDJsZ/1pY4dVso9tuVVCjpQ2d6uaaLGJ/s
         xC6O9wTZJa4JePZGL/fzsZOConbkuiDLz396BNr/G85R5dlagGnJWHMqFgOfb8v4/EUC
         h2oS5vGE5ZS15vMWDdwmrLoRQVzz4TuqF50YQP+Fun+Wj9J4VOlxWBrDib1Ky0bJP2Tk
         2QZGpAQJRSUVSN777DDltdhBhxrC7b8rvBqyBuxQ/3xnXUkBzww2aeMTyUtxuyX1IkH7
         2tBBLXRjEZtYkstTNfwgNlmcFkBJs4sqfvZt9CIh0cqPhvSMEqr8BmcBWoVmpwdDepGb
         wokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esoiL0zRtkoIhqgz3+K0ShHM1vB/8CWMDhEUxTj3zO8=;
        b=EYUubAFlJ5X92DZVt17xTX7pstHQlLpx1K+nVvzGmHF/zEC1xfKKsfDfWqSA9O2i8q
         mWxt/VKY0UHO6Ex4is/NDCW16uaaNvoU4tK9gkh7p9TAcNFt2ge2Iyr9d9+tSms7lhxR
         XTDKsjyLwuN2SWp0Y7yX063E06rnfymisCweJwKZIi1uc4gPiu0QpwfBsB6QqNduEq+3
         xSdU3XojTNBu+wlRvBTOKhON5msWlpaVZcvT3l3XkULSw/otgKnC0Gb4Ye0aRbODYBjX
         0BBqGcK9jIYVX+tc5vC14/3qDj+wKwyiUUjpqD37IHQByjV4yPbgworQCCuVv/gxwXRz
         UHiA==
X-Gm-Message-State: AHQUAubD3KmaPSbwwCEW01u8E4BOzP/glQlpDAvEIQkG0elWFpwCwuoV
        CzBczaTPG9xYx6GwpmRakQTxJ1VtzD0KD1H8mPJG9w==
X-Google-Smtp-Source: AHgI3IaS4np5V2h8jLeUf4cneoR8yS2mouKyycJRlxa5aO3I0yZtK48KSmZn2Am/GHwvXfD87znE2lMG09f2gEnia6Q=
X-Received: by 2002:a9d:7554:: with SMTP id b20mr20879590otl.32.1550682675815;
 Wed, 20 Feb 2019 09:11:15 -0800 (PST)
MIME-Version: 1.0
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Feb 2019 09:11:04 -0800
Message-ID: <CAPcyv4j9uEn9j=Y0Vo3oQJaXo-d-Xf=2-=0ucufhcXWeYOb0Yg@mail.gmail.com>
Subject: Re: [PATCH 0/7] libnvdimm/pfn: Fix section-alignment padding
To:     linux-nvdimm <linux-nvdimm@lists.01.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 1:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Lately Linux has encountered platforms that collide Persistent Memory
> regions between each other, specifically cases where ->start_pad needed
> to be non-zero. This lead to commit ae86cbfef381 "libnvdimm, pfn: Pad
> pfn namespaces relative to other regions". That commit allowed
> namespaces to be mapped with devm_memremap_pages(). However dax
> operations on those configurations currently fail if attempted within the
> ->start_pad range because pmem_device->data_offset was still relative to
> raw resource base not relative to the section aligned resource range
> mapped by devm_memremap_pages().
>
> Luckily __bdev_dax_supported() caught these failures and simply disabled
> dax. However, to fix this situation a non-backwards compatible change
> needs to be made to the interpretation of the nd_pfn info-block.
> ->start_pad needs to be accounted in ->map.map_offset (formerly
> ->data_offset), and ->map.map_base (formerly ->phys_addr) needs to be
> adjusted to the section aligned resource base used to establish
> ->map.map formerly (formerly ->virt_addr).
>
> See patch 7 "libnvdimm/pfn: Fix 'start_pad' implementation" for more
> details, and the ndctl patch series "Improve support + testing for
> labels + info-blocks" for the corresponding regression test.

Hello valued reviewers, can I plead for a sanity check of at least
"libnvdimm/pfn: Introduce super-block minimum version requirements"
and "libnvdimm/pfn: Fix 'start_pad' implementation"? In particular
Jeff / Johannes this has end user / distro impact in that users may
lose access to namespaces that are upgraded to v1.3 info-blocks and
then boot an old kernel. I did not see a way around that sharp edge.

> ---
>
> Dan Williams (7):
>       libnvdimm/pfn: Account for PAGE_SIZE > info-block-size in nd_pfn_init()
>       libnvdimm/pmem: Honor force_raw for legacy pmem regions
>       dax: Check the end of the block-device capacity with dax_direct_access()
>       libnvdimm/pfn: Introduce super-block minimum version requirements
>       libnvdimm/pfn: Remove dax_label_reserve
>       libnvdimm/pfn: Introduce 'struct pfn_map_info'
>       libnvdimm/pfn: Fix 'start_pad' implementation
>
>
>  drivers/dax/pmem.c              |    9 +-
>  drivers/dax/super.c             |   39 ++++++--
>  drivers/nvdimm/namespace_devs.c |    4 +
>  drivers/nvdimm/nd.h             |   15 +++
>  drivers/nvdimm/pfn.h            |    4 +
>  drivers/nvdimm/pfn_devs.c       |  181 ++++++++++++++++++++++++++++-----------
>  drivers/nvdimm/pmem.c           |  111 +++++++++++-------------
>  drivers/nvdimm/pmem.h           |   12 ---
>  tools/testing/nvdimm/pmem-dax.c |   15 ++-
>  9 files changed, 244 insertions(+), 146 deletions(-)
