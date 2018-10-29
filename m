Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E86EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174E220664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wm/kKtn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174E220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeJ3AjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:39:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38696 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeJ3AjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:39:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id f24so2271350otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duYz9LNrMOXoXadn5+7+oaK0yEDjDAczP3WxFyxcsY8=;
        b=wm/kKtn6L48gKJInY8K5H48oSU6RBRWy/fyeHOsoWeXdTL9wI5PSPHM/jTg9pZ7LPS
         Lzcr7cyZU2YbUnN87JjxI3nsK1gKPclS7fRhUn3HXHgPMMqVbcaIBgbBMvilr+BwwPOk
         fR0wc0UsqFu9sxx42EhZYXFXUKYFLGQP29szd8vEwhrTgk+OIGKhawW7+DyfeGHMJd7/
         IZ4w/aaP2kqtnKPC+sCS/NqqIV/IuikG4AtIr8ke6cJii8cRObzV8nWIXAlCNQXi6Syt
         Hl33l7aejb7145oLd67tmK0juy4Kic7+7rzxiyN1ePQ07YwB3kJ7Bu1H27QD87AYAHmD
         F06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duYz9LNrMOXoXadn5+7+oaK0yEDjDAczP3WxFyxcsY8=;
        b=VrINt5rkWu1AO6vqxKZuBmSuZV+pVKc/hZqKFecHgsfj+qyR9gxPwdQm+jEJsupMVR
         Zc1kiFbXZEYX5wO8/Ux/STPd+604ty78YYlQumvX1gFtSSmzlYWNW5IApu7z5wd/INXr
         rA6SSQJSFhKA/w3B7F6YcLzdmLpd/JnSaSFx2CIjnHjc2VeToi+IdxQd74OAl/Hmvdf8
         mGq+FQjyaGh2765t0PWOS+iO8LeyKw/Ja9w8blf64tGqJhZDOypXPkTUILajW9dPV3Tc
         exGScu3eqJ6QKA6ZnUi+NUD7ysYuDZty8E5PY0dk5wDW2VSjA+nkJFUkFP8CCSYF5IVc
         6tPA==
X-Gm-Message-State: AGRZ1gK3tSyOh7k/0XmK0Ofl4SI3P3i0CmEGs8fjzpJrO7z00vKLtB1x
        zPTL+cH3Gb2pzluojkL/r+ag5OWYh8ZL5GQWZAj2ZA==
X-Google-Smtp-Source: AJdET5cE8YddcrKtYtihDW5iVGN2D6WY8fvWPXODMvebPzUp1cj+e40ubYmfKwG8wX9DAd+whMPPhpRBDoZyyhTFiVc=
X-Received: by 2002:a9d:41ef:: with SMTP id v44mr8310559oti.95.1540828198137;
 Mon, 29 Oct 2018 08:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181009170051.GA40606@tiger-server> <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com>
 <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com> <20181010095838.GG5873@dhcp22.suse.cz>
 <f97de51c-67dd-99b2-754e-0685cac06699@linux.intel.com> <20181010172451.GK5873@dhcp22.suse.cz>
 <98c35e19-13b9-0913-87d9-b3f1ab738b61@linux.intel.com> <20181010185242.GP5873@dhcp22.suse.cz>
 <20181011085509.GS5873@dhcp22.suse.cz> <6f32f23c-c21c-9d42-7dda-a1d18613cd3c@linux.intel.com>
 <20181017075257.GF18839@dhcp22.suse.cz> <971729e6-bcfe-a386-361b-d662951e69a7@linux.intel.com>
In-Reply-To: <971729e6-bcfe-a386-361b-d662951e69a7@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Oct 2018 08:49:46 -0700
Message-ID: <CAPcyv4gZZcuWFLzRpyJcAxtGEPTDkpwkG3J0Z4Q1u790+7W2Ag@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     alexander.h.duyck@linux.intel.com
Cc:     Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
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

On Wed, Oct 17, 2018 at 8:02 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On 10/17/2018 12:52 AM, Michal Hocko wrote:
> > On Thu 11-10-18 10:38:39, Alexander Duyck wrote:
> >> On 10/11/2018 1:55 AM, Michal Hocko wrote:
> >>> On Wed 10-10-18 20:52:42, Michal Hocko wrote:
> >>> [...]
> >>>> My recollection was that we do clear the reserved bit in
> >>>> move_pfn_range_to_zone and we indeed do in __init_single_page. But then
> >>>> we set the bit back right afterwards. This seems to be the case since
> >>>> d0dc12e86b319 which reorganized the code. I have to study this some more
> >>>> obviously.
> >>>
> >>> so my recollection was wrong and d0dc12e86b319 hasn't really changed
> >>> much because __init_single_page wouldn't zero out the struct page for
> >>> the hotplug contex. A comment in move_pfn_range_to_zone explains that we
> >>> want the reserved bit because pfn walkers already do see the pfn range
> >>> and the page is not fully associated with the zone until it is onlined.
> >>>
> >>> I am thinking that we might be overzealous here. With the full state
> >>> initialized we shouldn't actually care. pfn_to_online_page should return
> >>> NULL regardless of the reserved bit and normal pfn walkers shouldn't
> >>> touch pages they do not recognize and a plain page with ref. count 1
> >>> doesn't tell much to anybody. So I _suspect_ that we can simply drop the
> >>> reserved bit setting here.
> >>
> >> So this has me a bit hesitant to want to just drop the bit entirely. If
> >> nothing else I think I may wan to make that a patch onto itself so that if
> >> we aren't going to set it we just drop it there. That way if it does cause
> >> issues we can bisect it to that patch and pinpoint the cause.
> >
> > Yes a patch on its own make sense for bisectability.
>
> For now I think I am going to back off of this. There is a bunch of
> other changes that need to happen in order for us to make this work. As
> far as I can tell there are several places that are relying on this
> reserved bit.

When David Hildebrand and I looked it was only the hibernation code
that we thought needed changing. We either need to audit the removal
or go back to adding a special case hack for kvm because this is a
blocking issue for them.

What do you see beyond the hibernation change?
