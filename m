Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE7FC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47DA214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xLNh3BXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47DA214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJJEif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:38:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34154 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeJJEif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:38:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id v69-v6so2437916oif.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0f0hMX+gSDGnKkxqDYZS5nIHXdII+6YNR+G/UkZ8PA=;
        b=xLNh3BXuq2lr5G5nAdaZT13aTzzGdDHThU/0tCt5MwWwzmdBJx3hxjLz1EjiaOC52v
         iLDmxDuoOsxz7bEkt/EiNjgTZ+zeWv9a0JpxFNYUAeaidJK9r7YE4IFwjomgiCYaildp
         KwEor73uKjdIxn5bg5KYiVAA03AY82TLCvJyLU4K0A1cl9GiMwX88buvaNoHEdAKNcAy
         frbyNnUpPyu+LIh3UCxVhkZZCF6N0TSbzhO+9zzJfKtiNJ344aju9UWJqEPsMMRJes6D
         Wk0l4Dt8KDqD71GelOdOULrNiSW2EMnteWxKXoMda52SrYPuy0j8yKchTwzK43BQd7zz
         Zjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0f0hMX+gSDGnKkxqDYZS5nIHXdII+6YNR+G/UkZ8PA=;
        b=bvNvygCLuLusWf8qCykZUqiyAZP82WHpC1hXQhyZd+sRfbpMzlwJVC24u75T4PutI5
         UjkEvXknTcL11FQCFb6TGHun+07yn0TsYjS4Q31lGsMLwG34SR/64McQ8X+SExv2A3Iy
         1/QTz+PsbpatKM4o4DvWWnmeeOrAImXbTxu6Wv0Xjl5GE7JJxDJ/dXT+WS43m1dra99Q
         ppP/OdAqJ/CssQxDPXLSfNgGJ4sz6C/OOI/5uutXPkf51ARDdGSfMxGD4QlKZjrzMSO+
         38zonFAySFu/mySuNnPrh3CXNMZDErktNAPwfc6S/XEYzOjCEqye/iwuvomBG8/ug6+W
         22oA==
X-Gm-Message-State: ABuFfogdxnGcXbG6Ejzma8WKzb9DZ51/xQV1kc9M3fIN29Pxvevau5/W
        jmWUoU9IiDad6WjDHwezLYBF9NJBwAhah2bL8C1YPw==
X-Google-Smtp-Source: ACcGV62kVpz9sohBOmJHvZObl0Kkou3p7vYTjgLuK3zKw7FrcQmMORLKHJxZ6KhX2j7bqyyArZZbD+agMSJQUWTEiRQ=
X-Received: by 2002:a54:4516:: with SMTP id l22-v6mr119577oil.0.1539119983079;
 Tue, 09 Oct 2018 14:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain> <20181009170051.GA40606@tiger-server>
 <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com> <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com>
In-Reply-To: <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Oct 2018 14:19:32 -0700
Message-ID: <CAPcyv4gZV_V=iY0mHiiAWwbynqtPxLTwdZ0j0vQ0F95ZZ4nTZg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 1:34 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On 10/9/2018 11:04 AM, Dan Williams wrote:
> > On Tue, Oct 9, 2018 at 3:21 AM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
[..]
> > That comment is incorrect, device-pages are never onlined. So I think
> > we can just skip that call to __SetPageReserved() unless the memory
> > range is MEMORY_DEVICE_{PRIVATE,PUBLIC}.
> >
>
> When pages are "onlined" via __free_pages_boot_core they clear the
> reserved bit, that is the reason for the comment. The reserved bit is
> meant to indicate that the page cannot be swapped out or moved based on
> the description of the bit.

...but ZONE_DEVICE pages are never onlined so I would expect
memmap_init_zone_device() to know that detail.

> I would think with that being the case we still probably need the call
> to __SetPageReserved to set the bit with the expectation that it will
> not be cleared for device-pages since the pages are not onlined.
> Removing the call to __SetPageReserved would probably introduce a number
> of regressions as there are multiple spots that use the reserved bit to
> determine if a page can be swapped out to disk, mapped as system memory,
> or migrated.

Right, this is what Yi is working on... the PageReserved flag is
problematic for KVM. Auditing those locations it seems as long as we
teach hibernation to avoid ZONE_DEVICE ranges we can safely not set
the reserved flag for DAX pages. What I'm trying to avoid is a local
KVM hack to check for DAX pages when the Reserved flag is not
otherwise needed.
