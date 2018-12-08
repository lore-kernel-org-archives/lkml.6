Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CCDC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 07:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C72208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 07:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rfIdSzmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C72208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLHHQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 02:16:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36368 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeLHHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 02:16:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so5979544otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3H6N6h2pzHR9OK+frkAK7GAwYbsLQzo4rb364b097U=;
        b=rfIdSzmJgJl+9k7qSCRMoqm5IzqvPdFFbgt3urW1engf5UV6h51aYVxAFMmy8RXQRk
         Vnb3VjqQ881bUOAD/eKJ+/UtoI8XGTeaSkni9gXQgx4iqsTOQKRwYTitrE4mnipZX5mT
         19UYMAjgYnN8vpcaiKZaw1mzCA1CAzE5Z/dFXk1Rg57qhw7/7hy7XcPyIuhfo+PJTSVf
         nNPxKJKQBqqGoSz+q62NEVqsVHDd+sUOV9NiWBAFHjasIXHyy1zlDhPzziojV2LxG/l+
         i+WnLRCR9dGUM823CIhO7BrQWjHrXCphoDxwFmWJpRdunt8PVWqgSBhsbr+OUt/HpyM1
         4wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3H6N6h2pzHR9OK+frkAK7GAwYbsLQzo4rb364b097U=;
        b=tVBl7bZOilPMWkl2dEB5yL9i9Ws9UphZAHCHzg9QmqCFbqPy11P0W8haMgwVS5c8If
         4ZESEI8diJtEV1g/5ks3/So7+HuZyYVNXOsk4/BP+19cqilh9V+hcNxfYLl+ZW0mGz6f
         l7pFpyETwnhpJDEgI452cJSORv/Rai/Ae+5/SDwagT2NyK1grYz/uHRySGwhkE3vMDDE
         /n7V3N4py4P8sKIS+mDGiSGoXx3BmIcI3KRvlodMdxdiyejHJuPB5tVNRO5bEEXme4WW
         /wpndsiX8jOHbCe8KBWjJl9AHxnUBDhMYp/rhSlYBr/nSMBF8Aif+fIWSN0snsp7CMch
         GtyA==
X-Gm-Message-State: AA+aEWaovDfSsIwOSd831I7w31z52NWB9/zBO3ZSsPbLFCsYWL7Xmfa9
        ex3SmoigsfPMYGl5m6vzkEoMer7m716V5DEeC/K8GQ==
X-Google-Smtp-Source: AFSGD/XOAgubOhoMN0drX+UMPxy4te6wp21AbEL7xrIylrlHKTXItgaZlWZzROiZ7/YZUoL05LI70u8hJEwX4SnIMKw=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr3331738otq.353.1544253403739;
 Fri, 07 Dec 2018 23:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20181204001720.26138-1-jhubbard@nvidia.com> <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com> <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com> <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com> <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com> <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
In-Reply-To: <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Dec 2018 23:16:32 -0800
Message-ID: <CAPcyv4hwtMA+4qc6500ucn5vf6fRrNdfyMHru_Jhzx86=1Wwww@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
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

On Fri, Dec 7, 2018 at 4:53 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 12/7/18 11:16 AM, Jerome Glisse wrote:
> > On Thu, Dec 06, 2018 at 06:45:49PM -0800, John Hubbard wrote:
[..]
> I see. OK, HMM has done an efficient job of mopping up unused fields, and now we are
> completely out of space. At this point, after thinking about it carefully, it seems clear
> that it's time for a single, new field:
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ed8f6292a53..1c789e324da8 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -182,6 +182,9 @@ struct page {
>         /* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
>         atomic_t _refcount;
>
> +       /* DMA usage count. See get_user_pages*(), put_user_page*(). */
> +       atomic_t _dma_pinned_count;
> +
>  #ifdef CONFIG_MEMCG
>         struct mem_cgroup *mem_cgroup;
>  #endif
>
>
> ...because after all, the reason this is so difficult is that this fix has to work
> in pretty much every configuration. get_user_pages() use is widespread, it's a very
> general facility, and...it needs fixing.  And we're out of space.

HMM seems entirely too greedy in this regard. Especially with zero
upstream users. When can we start to delete the pieces of HMM that
have no upstream consumers? I would think that would be 4.21 / 5.0 as
there needs to be some forcing function. We can always re-add pieces
of HMM with it's users when / if they arrive.
