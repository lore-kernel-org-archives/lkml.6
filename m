Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E29DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CAB20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QhPvVtgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CAB20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeLAAEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:04:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40702 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLAAEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:04:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so2773014plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 04:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKds6rNpspkDTr2LIhhuAY5+8Tr4GYAAAU9n31DCOAk=;
        b=QhPvVtgRFjAavQn4beDykDWAJvtU/BjSEuctDTi+0SEQJe8MZCJkScbnqFDq04JOkY
         syqm+zdwAsDh+slytPV+5w6gzDfiX6abBZe5b2nnv/TRvsGaWWYNXXWrp1LqCWwVGAai
         +NVabOmZEmHwb9ma7DnNsNK88qkhfCqVr4ij9vz/vjtIde0EPs99fCIEzhzjZTuPOkiH
         sLFxakj8aur1J4rREs5+LzGVxZ2yARGD+B/mHyElCHqFTqOfpeIKdlcGo6ydS3hHLMFa
         2nH+FJD6KbbNYpnEsAVap5kCAUlo62BgUisOK3Azm/2qg08mAqEZElxh9aKmm8BFRb9Q
         Xh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKds6rNpspkDTr2LIhhuAY5+8Tr4GYAAAU9n31DCOAk=;
        b=Pf/T4IICaM0TA9cpcvoxuPdzUXaxOhdaKsDzJkptw6u4jklVQRFhTBzgBdF14V7yyA
         LtQk/frJpPuqbZpzelIYfjXvIbV/f6CboPKRylb7vweCEtPoCRcz6vWgXMqqpR3F4Hz9
         Cdsy88kinlr3krMLcm6UJW7b3CRPEpvrcwVNihv703slZYtuKmsvI5volE1aG9T42fRq
         ENeZh66uXVZYL6zpuI9lD/NK9qs58dpx2mUozh5SqK2ZNxpJvUQq8ZuaUaTiBkblS3tY
         lIvS3KzvZNO7hTZilH8H/Q8G2Q6NN5i1YiuVC5pFpasNBOw0aAid9/t5KRg5pScgjzXE
         dvkg==
X-Gm-Message-State: AA+aEWbMY/Ir0bt/3b7TBxxTV5tlxWjt4rcluVoYEgrV20+E8CEEetva
        lJ0H7QI4cvteYHfo3WIN2EROgg==
X-Google-Smtp-Source: AFSGD/X1T8SvdXDzm/BeeANpbO1rMz8CCz+0jkq1KHLa7+otIm5eq8cDSzHcMM6tNTg2Z9zXkhXQrQ==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr5636985plo.210.1543582535128;
        Fri, 30 Nov 2018 04:55:35 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id v13sm7252341pff.20.2018.11.30.04.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 04:55:34 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A6A7B30042C; Fri, 30 Nov 2018 15:55:29 +0300 (+03)
Date:   Fri, 30 Nov 2018 15:55:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-mm@kvack.org,
        lersek@redhat.com, alex.williamson@redhat.com, aarcange@redhat.com,
        rientjes@google.com, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: page_mapped: don't assume compound page is huge
 or THP
Message-ID: <20181130125529.6lw2xqiccnoddrvj@kshutemo-mobl1>
References: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
 <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
 <20181130121851.GI6923@dhcp22.suse.cz>
 <20181130123651.5qrdrw3i5ergbuzl@kshutemo-mobl1>
 <20181130124546.GJ6923@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130124546.GJ6923@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:45:46PM +0100, Michal Hocko wrote:
> On Fri 30-11-18 15:36:51, Kirill A. Shutemov wrote:
> > On Fri, Nov 30, 2018 at 01:18:51PM +0100, Michal Hocko wrote:
> > > On Fri 30-11-18 13:06:57, Jan Stancek wrote:
> > > > LTP proc01 testcase has been observed to rarely trigger crashes
> > > > on arm64:
> > > >     page_mapped+0x78/0xb4
> > > >     stable_page_flags+0x27c/0x338
> > > >     kpageflags_read+0xfc/0x164
> > > >     proc_reg_read+0x7c/0xb8
> > > >     __vfs_read+0x58/0x178
> > > >     vfs_read+0x90/0x14c
> > > >     SyS_read+0x60/0xc0
> > > > 
> > > > Issue is that page_mapped() assumes that if compound page is not
> > > > huge, then it must be THP. But if this is 'normal' compound page
> > > > (COMPOUND_PAGE_DTOR), then following loop can keep running
> > > > (for HPAGE_PMD_NR iterations) until it tries to read from memory
> > > > that isn't mapped and triggers a panic:
> > > >         for (i = 0; i < hpage_nr_pages(page); i++) {
> > > >                 if (atomic_read(&page[i]._mapcount) >= 0)
> > > >                         return true;
> > > > 	}
> > > > 
> > > > I could replicate this on x86 (v4.20-rc4-98-g60b548237fed) only
> > > > with a custom kernel module [1] which:
> > > > - allocates compound page (PAGEC) of order 1
> > > > - allocates 2 normal pages (COPY), which are initialized to 0xff
> > > >   (to satisfy _mapcount >= 0)
> > > > - 2 PAGEC page structs are copied to address of first COPY page
> > > > - second page of COPY is marked as not present
> > > > - call to page_mapped(COPY) now triggers fault on access to 2nd
> > > >   COPY page at offset 0x30 (_mapcount)
> > > > 
> > > > [1] https://github.com/jstancek/reproducers/blob/master/kernel/page_mapped_crash/repro.c
> > > > 
> > > > Fix the loop to iterate for "1 << compound_order" pages.
> > > 
> > > This is much less magic than the previous version. It is still not clear
> > > to me how is mapping higher order pages to page tables other than THP
> > > though. So a more detailed information about the source would bre really
> > > welcome. Once we know that we can add a Fixes tag and also mark the
> > > patch for stable because that sounds like a stable material.
> > 
> > IIRC, sound subsystem can producuce custom mapped compound pages.
> 
> Do I assume correctly that consecutive ptes simply point to subpages?

Yes. No huge pages there.

-- 
 Kirill A. Shutemov
