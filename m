Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFCC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7532083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UV0FTEJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7532083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLHSJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:09:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46787 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeLHSJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:09:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so6766558otm.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 10:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZCyliucxVS/DkKnL8Hdv/o+piVzGFZjY+QblPifbY0=;
        b=UV0FTEJZ6mZi/l0fvO71PCLobw5gcd4BynUrOvx+lp2va7XNq6y0f81hOE3LuVtQF+
         gn5lWZbcnDIGSMBkQ+8FSMrZuCqsvhdyxk7MO6hQrIuySQ+UJUhCvSGabAoNssVJlOjx
         XU6X6HS08LJhc2zopArTj8vB/ImrKKYtRQc6IOaHTG6M9IPDZunneH6qHZSakKEgWwPe
         5G3no0AYXUDLYuja9Y1oh1TsMO612wZmHW6qEfiMh9Xv+ixK3fdNU38go40jH4g9wInp
         4euyaAppslWgZ7VdVcdl5Av2TTsSTgLjKRHG+CoXTmGVcaalaoVrXwGSnXRp8BgrCVyv
         OfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZCyliucxVS/DkKnL8Hdv/o+piVzGFZjY+QblPifbY0=;
        b=VY2LGgQv4SZWMvd8PtYQeqF2PJvSi80gz0LhhqNCcaANNXqLj0Z30/89AH+TMzjgo6
         ynhTClkGfhl/q5PbM+7UTnIAnTNOf/o5CiCINSzllWlKasgo2SEbVjD01w00b5JR1Fja
         UBZJwZ8Hs459kzl3+dN954Ba1hfx4sO1xFRIGWz8ddIK607nsaP5l4JWPgmEP2/ysiEO
         LPg0myBJV97k7JF5xbPqLrqdiK+zbhbhZxhTKiR/mph0dU4bqmGO6wMRI2MSNZ38Pz1Y
         O0seHZjlf6GYmruwRYJRY1IVPQby8OFTh5zHbQegt9RsU0+Ftz3tKRa5MMK/GezbKVD+
         h/XQ==
X-Gm-Message-State: AA+aEWZQGZY5bvduMNWORjCZ34pvA5LtoYU2K9hvMkH3zRlBNgim9Rjq
        xZB3R/AjPhbCbDbV0oGvz4taGfhmhsvQSQmn8fn1jA==
X-Google-Smtp-Source: AFSGD/XODYMV6UTKBcbElVYvawuwPXwZrT2P56nJDaEMB5o4kGhXXpETXGClkp/GSSyXXcJwhgSD8FcASUQQAUkiMrs=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr4237257otn.95.1544292577193;
 Sat, 08 Dec 2018 10:09:37 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com> <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com> <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com> <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com> <CAPcyv4hwtMA+4qc6500ucn5vf6fRrNdfyMHru_Jhzx86=1Wwww@mail.gmail.com>
 <20181208163353.GA2952@redhat.com> <20181208164825.GA26154@infradead.org>
In-Reply-To: <20181208164825.GA26154@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 8 Dec 2018 10:09:26 -0800
Message-ID: <CAPcyv4hP1XrheKTrapANmrg10xz6dpG7cj=qEG8La9L34bCKDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 8:48 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Dec 08, 2018 at 11:33:53AM -0500, Jerome Glisse wrote:
> > Patchset to use HMM inside nouveau have already been posted, some
> > of the bits have already made upstream and more are line up for
> > next merge window.
>
> Even with that it is a relative fringe feature compared to making
> something like get_user_pages() that is literally used every to actually
> work properly.
>
> So I think we need to kick out HMM here and just find another place for
> it to store data.
>
> And just to make clear that I'm not picking just on this - the same is
> true to a just a little smaller extent for the pgmap..

Fair enough, I cringed as I took a full pointer for that use case, I'm
happy to look at ways of consolidating or dropping that usage.

Another fix that may put pressure 'struct page' is resolving the
untenable situation of dax being incompatible with reflink, i.e.
reflink currently requires page-cache pages. Dave has talked about
silently establishing page-cache entries when a dax-page is cow'd for
reflink, but I wonder if we could go the other way and introduce the
mechanism of a page belonging to multiple mappings simultaneously and
managed by the filesystem.

Both HMM and ZONE_DEVICE in general are guilty of side-stepping the mm
and I'm in favor of undoing that as much as possible,
