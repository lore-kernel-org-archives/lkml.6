Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F20C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9091C2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ePp8uOPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfBKWzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:55:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40395 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfBKWzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:55:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so1112070oth.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PipVbT9feF+A/+kcKPeIiPlxJtq1FDRuiYejP4/jlTM=;
        b=ePp8uOPBs0N6VpZBCYMwGPAoIqlDaY2gC7lJUFZR/emNWOFMvtmbPs6f040V04VIGC
         2vRJz4SREJwH25cT7NuHossKvHgNe1HVHIe4RYI/rASiNarU1LckLx4eEfDZvjb0thx5
         95FeQMZoZJwdy8Fz6vfMEsazvyaO8uwnV0OomuH0G93F+yXCodj1y+8dNhbFMc3xcHjj
         OENj/rh1qIdkhkrjf9fweC7gDSPKiOjSlixCFT7GE5XpgEAOYi7gVmGdy3sFw/3Jid76
         9N7K4Ti/pNGy7OV0X2wloFXKpVeG9i7EijmNrr5HU6fF6bXCxsauJi5TVlMZi/82WpPV
         Lm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PipVbT9feF+A/+kcKPeIiPlxJtq1FDRuiYejP4/jlTM=;
        b=mvtcayrMX5OrpPJS5gOntqUT+8HqLLNaaL3A5ulTi1ZR4UR3sM31oPUZAthxzoG92m
         yZSPcU7QyaretDopAOKwIdSdmd3znSL+DOuEI6JgXd0sj+vZuMbQ0ZuHs8+2a6XWIfkK
         NUeNzLITW9wqBQF/uqZRU3FcsCPWysY0KR65bFq+0DQAwW2FShtAp5uiiqpEtcpAmeLS
         WCrsI9nvf/i7dMwSjuA53cbKKwOOpG4Pmty92Z+T+uCCjb+glH0ujVJLiFsqVowXX9dX
         plSBzJ2K92rGtZIg3grSL1MoN1MhZ73w8hcHJLmKRiE/uO1cEmVPEh1qLwiLUtmZK1Y9
         n6yg==
X-Gm-Message-State: AHQUAuYiqvnB0BuouU4n0CkhjfnAOv5xOiC7W1IhFU6wrjayWN6CHjnt
        s0XVKP/JNCGTAptHgJts5lC1lzzn0ybguRUbl2TvlA==
X-Google-Smtp-Source: AHgI3IYGo/qsdTLuha3YNsAwQUDrumeNrBs1vI6bpgPeNvmzCn7YXX3I4hUjf+8RHy+iEYulENdHYtDfW2xsnfGRu4c=
X-Received: by 2002:a05:6830:1c1:: with SMTP id r1mr584180ota.229.1549925722592;
 Mon, 11 Feb 2019 14:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20190211201643.7599-1-ira.weiny@intel.com> <20190211201643.7599-3-ira.weiny@intel.com>
 <20190211203916.GA2771@ziepe.ca> <bcc03ee1-4c42-48c3-bc67-942c0f04875e@nvidia.com>
 <20190211212652.GA7790@iweiny-DESK2.sc.intel.com> <fc9c880b-24f8-7063-6094-00175bc27f7d@nvidia.com>
 <20190211215238.GA23825@iweiny-DESK2.sc.intel.com> <20190211220658.GH24692@ziepe.ca>
In-Reply-To: <20190211220658.GH24692@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Feb 2019 14:55:10 -0800
Message-ID: <CAPcyv4htDHmH7PVm_=HOWwRKtpcKTPSjrHPLqhwp2vhBUWL4-w@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/gup: Introduce get_user_pages_fast_longterm()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Netdev <netdev@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 2:07 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Feb 11, 2019 at 01:52:38PM -0800, Ira Weiny wrote:
> > On Mon, Feb 11, 2019 at 01:39:12PM -0800, John Hubbard wrote:
> > > On 2/11/19 1:26 PM, Ira Weiny wrote:
> > > > On Mon, Feb 11, 2019 at 01:13:56PM -0800, John Hubbard wrote:
> > > >> On 2/11/19 12:39 PM, Jason Gunthorpe wrote:
> > > >>> On Mon, Feb 11, 2019 at 12:16:42PM -0800, ira.weiny@intel.com wrote:
> > > >>>> From: Ira Weiny <ira.weiny@intel.com>
> > > >> [...]
> > > >> It seems to me that the longterm vs. short-term is of questionable value.
> > > >
> > > > This is exactly why I did not post this before.  I've been waiting our other
> > > > discussions on how GUP pins are going to be handled to play out.  But with the
> > > > netdev thread today[1] it seems like we need to make sure we have a "safe" fast
> > > > variant for a while.  Introducing FOLL_LONGTERM seemed like the cleanest way to
> > > > do that even if we will not need the distinction in the future...  :-(
> > >
> > > Yes, I agree. Below...
> > >
> > > > [...]
> > > > This is also why I did not change the get_user_pages_longterm because we could
> > > > be ripping this all out by the end of the year...  (I hope. :-)
> > > >
> > > > So while this does "pollute" the GUP family of calls I'm hoping it is not
> > > > forever.
> > > >
> > > > Ira
> > > >
> > > > [1] https://lkml.org/lkml/2019/2/11/1789
> > > >
> > >
> > > Yes, and to be clear, I think your patchset here is fine. It is easy to find
> > > the FOLL_LONGTERM callers if and when we want to change anything. I just think
> > > also it's appopriate to go a bit further, and use FOLL_LONGTERM all by itself.
> > >
> > > That's because in either design outcome, it's better that way:
> > >
> > > is just right. The gup API already has _fast and non-fast variants, and once
> > > you get past a couple, you end up with a multiplication of names that really
> > > work better as flags. We're there.
> > >
> > > the _longterm API variants.
> >
> > Fair enough.   But to do that correctly I think we will need to convert
> > get_user_pages_fast() to use flags as well.  I have a version of this series
> > which includes a patch does this, but the patch touched a lot of subsystems and
> > a couple of different architectures...[1]
>
> I think this should be done anyhow, it is trouble the two basically
> identical interfaces have different signatures. This already caused a
> bug in vfio..
>
> I also wonder if someone should think about making fast into a flag
> too..
>
> But I'm not sure when fast should be used vs when it shouldn't :(

Effectively fast should always be used just in case the user cares
about performance. It's just that it may fail and need to fall back to
requiring the vma.

Personally I thought RDMA memory registration is a one-time / upfront
slow path so that non-fast-GUP is tolerable.

The workloads that *need* it are O_DIRECT users that can't tolerate a
vma lookup on every I/O.
