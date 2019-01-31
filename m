Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64E9C282D8
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8E120989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NHd8Q0gA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfAaD20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:28:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44321 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaD20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:28:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id m6so1542486oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKR8wCp+72QzShfXC1ccPYHbtEsCxEmpDS1UMRW0uQ4=;
        b=NHd8Q0gA+XED7qxPiMKJXGVHXZIoZZlQI/QO1qMb0suplz1GTmOybVqFc0dl21ScHZ
         B9W9YkvPx3zI5v1m1a0V3eZZIAfH+72OAkvwHnpwFRSvR3+qU4BKWXQvoU1bb89pPN7z
         oo9ghPe0jEqzJnu+Rx13QI9RiON8jHwrPtYroXNSb691XgB5xJCSYw6bZ4QQPKUWoKvB
         BuCN/tBEhqrIwsWV97Xb/eGd3KSrXuoNHxykRGCTkVGY7GLXtxSjUynuB/Z1x94v1A6G
         Qt5oB00Pq6BzewF96AkF9DbJK2I6TOBmTLmpiDL2bRVP/3P7eHWqR6QmAuKkz4ZcZ8Yd
         RSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKR8wCp+72QzShfXC1ccPYHbtEsCxEmpDS1UMRW0uQ4=;
        b=WuMyIJh6G9M+kdngWlSsYllg8ez1n/XiDfRNne6Tqd5cVo3tBqu4bYONcrrEYi9iCd
         /wPRFnY5i90PbAGg95zN47ady9OxaThs+cUxCspAmv0W9R0npNFSGfjTVzM8x/CIU4aI
         nf6I0m8sbdm3Na0je/LNrDUhUm7TfPURjhEyxK8PL3rrEOrQ07f+KrBc/5hrwjMIeaii
         Xb/dgSHhg+7HFCP4AO8qLyhvYIL5J5JD2YoXH8ucTti4Iy1okLDnmN41LKbYjg8kPQ45
         vZxqRkNZnXo/gd/IfbJqyXZiSvgCUdAUGmdSLytlrAhBfeNmRmJR7fwH9LA4l3JvcZJa
         3lUQ==
X-Gm-Message-State: AJcUukfKkefgOwTGq60BRNlS6tz8gXB01OEjRPKDd88CbxDLIgnZgAxu
        U42zrjX2uYgGRIa4WrhaermYal08rwxA2mpL/gjRxQ==
X-Google-Smtp-Source: ALg8bN7cjiZrwHF036Im4cVIYRvgSt6s9CiP7Z1vDb0+J9ahKednROx5JuDby2jPMltGGv1GU6huMF/VdL52/MDG0cQ=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr13551287oit.235.1548905305200;
 Wed, 30 Jan 2019 19:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190129165428.3931-10-jglisse@redhat.com>
 <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com>
 <20190129193123.GF3176@redhat.com> <CAPcyv4gkYTZ-_Et1ZriAcoHwhtPEftOt2LnR_kW+hQM5-0G4HA@mail.gmail.com>
 <20190129212150.GP3176@redhat.com> <CAPcyv4hZMcJ6r0Pw5aJsx37+YKx4qAY0rV4Ascc9LX6eFY8GJg@mail.gmail.com>
 <20190130030317.GC10462@redhat.com> <CAPcyv4jS7Y=DLOjRHbdRfwBEpxe_r7wpv0ixTGmL7kL_ThaQFA@mail.gmail.com>
 <20190130183616.GB5061@redhat.com>
In-Reply-To: <20190130183616.GB5061@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 30 Jan 2019 19:28:12 -0800
Message-ID: <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:36 AM Jerome Glisse <jglisse@redhat.com> wrote:
[..]
> > > This
> > > is one of the motivation behind HMM ie have it as an impedence layer
> > > between mm and device drivers so that mm folks do not have to under-
> > > stand every single device driver but only have to understand the
> > > contract HMM has with all device driver that uses it.
> >
> > This gets to heart of my critique of the approach taken with HMM. The
> > above statement is antithetical to
> > Documentation/process/stable-api-nonsense.rst. If HMM is trying to set
> > expectations that device-driver projects can write to a "stable" HMM
> > api then HMM is setting those device-drivers up for failure.
>
> So i am not expressing myself correctly. If someone want to change mm
> in anyway that would affect HMM user, it can and it is welcome too
> (assuming that those change are wanted by the community and motivated
> for good reasons). Here by understanding HMM contract and preserving it
> what i mean is that all you have to do is update the HMM API in anyway
> that deliver the same result to the device driver. So what i means is
> that instead of having to understand each device driver. For instance
> you have HMM provide X so that driver can do Y; then what can be Z a
> replacement for X that allow driver to do Y. The point here is that
> HMM define what Y is and provide X for current kernel mm code. If X
> ever need to change so that core mm can evolve than you can and are
> more than welcome to do it. With HMM Y is defined and you only need to
> figure out how to achieve the same end result for the device driver.
>
> The point is that you do not have to go read each device driver to
> figure out Y.driver_foo, Y.driver_bar, ... you only have HMM that
> define what Y means and is ie this what device driver are trying to
> do.
>
> Obviously here i assume that we do not want to regress features ie
> we want to keep device driver features intact when we modify anything.

The specific concern is HMM attempting to expand the regression
boundary beyond drivers that exist in the kernel. The regression
contract that has priority is the one established for in-tree users.
If an in-tree change to mm semantics is fine for in-tree mm users, but
breaks out of tree users the question to those out of tree users is
"why isn't your use case upstream?". HMM is not that use case in and
of itself.

[..]
> Again HMM API can evolve, i am happy to help with any such change, given
> it provides benefit to either mm or device driver (ie changing the HMM
> just for the sake of changing the HMM API would not make much sense to
> me).
>
> So if after converting driver A, B and C we see that it would be nicer
> to change HMM in someway then i will definitly do that and this patchset
> is a testimony of that. Converting ODP to use HMM is easier after this
> patchset and this patchset changes the HMM API. I will be updating the
> nouveau driver to the new API and use the new API for the other driver
> patchset i am working on.
>
> If i bump again into something that would be better done any differently
> i will definitly change the HMM API and update all upstream driver
> accordingly.
>
> I am a strong believer in full freedom for internal kernel API changes
> and my intention have always been to help and facilitate such process.
> I am sorry this was unclear to any body :( and i am hopping that this
> email make my intention clear.''

A simple way to ensure that out-of-tree consumers don't come beat us
up over a backwards incompatible HMM change is to mark all the exports
with _GPL. I'm not requiring that, the devm_memremap_pages() fight was
hard enough, but the pace of new exports vs arrival of consumers for
those exports has me worried that this arrangement will fall over at
some point.

Another way to help allay these worries is commit to no new exports
without in-tree users. In general, that should go without saying for
any core changes for new or future hardware.
