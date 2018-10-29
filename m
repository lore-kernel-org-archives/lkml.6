Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8517C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A325D2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ERmFGWaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A325D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJ3CYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:24:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35428 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJ3CYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:24:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id v198-v6so5072177oif.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8MprY7VTm9p0yfpD9lSRFyDxBGNr193lmRNNx0JyUg=;
        b=ERmFGWaTpLpbrDnTCFAtYXkC/eW6TfOmgw+UVU0niqOQl1nqY7oY4xy8BA2Nm1G1Dr
         GJI01ajNUXjuX5XI3rgsdn+9f9okIePdkFynNm5u4lXTbPX24q1T15a6p8ipmQVOBUoW
         3FO50j4MeIzri8HTFM1SFqtXsPqb+TKBytjoCuooCkyjVZsfJDyjGy/b6STmrVcMUIgr
         UP49h8F4xq31VPHOMcfKbaGZr3mtaT0Tih4hRKuIq1ke4F5E0nJOLwgRjVIeMMejpNwX
         l8rIEQHZ2QRX8Mq/oz3qe+r+VKhbbbFTSElOv98B5bzhfk3LEdiB+5IXbjovIIk4tQU1
         D2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8MprY7VTm9p0yfpD9lSRFyDxBGNr193lmRNNx0JyUg=;
        b=n6Z7A2XCeRncCTu1v+VZq9HTe/BnmrLG9mLrYI52QPvbgZgxBzIba/Y9HvnZvpEpup
         DR1vqFWVmtJhM5tpKG4Lixb9ztsLab2TiesnC3a9GWeHoLP024MrB9DY17EHzYVxx8Md
         cFpnr9p0Eet1/HXDtcFruAO6xalz+49ur/uJ+KUbF+eKZj/+HP/aZRNEVjwjOwxdqxI0
         DnJDRjURHTBNO6KE8Xb9q/fcO+7g/M1J1SrkF/36ioWa9Zf7cjYx3x0xbJIxq+4ZWz+d
         N4lpWkwpGk9R16SrMKsJxI5hWDTNu+kTJBo0MMghIHsDWKREoL1NXeHhEVDWBpNXq6nC
         8wgw==
X-Gm-Message-State: AGRZ1gLfY0GPPgXkeT+417Bu5FT4nj/pZaPods0N7Jp5v7Glt/Gx4Rhv
        E+pRDqIvZKoOW/FAtfxnq2+3nC/LiorFDl8uxyf2kw==
X-Google-Smtp-Source: AJdET5dYRgdsJxLd35A8W4PXnvrIiU9m4oaIFPeiC1x+cr62TnKUOCtu6wj3ipimPv2lXmmp94F0K5JuFvhaLmHLINc=
X-Received: by 2002:aca:590b:: with SMTP id n11-v6mr8492487oib.232.1540834474488;
 Mon, 29 Oct 2018 10:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <98c35e19-13b9-0913-87d9-b3f1ab738b61@linux.intel.com>
 <20181010185242.GP5873@dhcp22.suse.cz> <20181011085509.GS5873@dhcp22.suse.cz>
 <6f32f23c-c21c-9d42-7dda-a1d18613cd3c@linux.intel.com> <20181017075257.GF18839@dhcp22.suse.cz>
 <971729e6-bcfe-a386-361b-d662951e69a7@linux.intel.com> <20181029141210.GJ32673@dhcp22.suse.cz>
 <84f09883c16608ddd2ba88103f43ec6a1c649e97.camel@linux.intel.com>
 <20181029163528.GL32673@dhcp22.suse.cz> <18dfc5a0db11650ff31433311da32c95e19944d9.camel@linux.intel.com>
 <20181029172415.GM32673@dhcp22.suse.cz>
In-Reply-To: <20181029172415.GM32673@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Oct 2018 10:34:22 -0700
Message-ID: <CAPcyv4goFsZR=O-P_KGrjV8hz0H=nqgYPGSGGLEnmtcagoTYrA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Michal Hocko <mhocko@kernel.org>
Cc:     alexander.h.duyck@linux.intel.com, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:24 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 29-10-18 10:01:28, Alexander Duyck wrote:
> > On Mon, 2018-10-29 at 17:35 +0100, Michal Hocko wrote:
[..]
> > > You are already doing per-page initialization so I fail to see a larger
> > > unit to operate on.
> >
> > I have a patch that makes it so that we can work at a pageblock level
> > since all of the variables with the exception of only the LRU and page
> > address fields can be precomputed. Doing that is one of the ways I was
> > able to reduce page init to 1/3 to 1/4 of the time it was taking
> > otherwise in the case of deferred page init.
>
> You still have to call set_page_links for each page. But let's assume we
> can do initialization per larger units. Nothing really prevent to hide
> that into constructor as well.

A constructor / indirect function call makes sense when there are
multiple sub-classes of object initialization, on the table I only see
3 cases: typical hotplug, base ZONE_DEVICE, ZONE_DEVICE + HMM. I think
we can look to move the HMM special casing out of line, then we're
down to 2. Even at 3 cases we're better off open-coding than a
constructor for such a low number of sub-cases to handle. I do not
foresee more cases arriving, so I struggle to see what the constructor
buys us in terms of code readability / maintainability?
