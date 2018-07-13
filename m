Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1007ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBAC2147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HHCXsGKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBAC2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeGME5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 00:57:34 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46611 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeGME5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 00:57:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so59955017oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 21:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hO7vOXF2yx5CWHwlLp5+eN9pUvefHgEWo1HreKP2sKI=;
        b=HHCXsGKW/TpVRFU1jRLCLbfZ5WfKNzz4plLcDP+bpqdi2XGya34cMoDXvW1MBBdWSf
         KJBsxPY0NNidpTYFEday31d8nHrEtaHy2PRjO2hd7zpsQaG9u6Jnt6RGoEPfmYNVbjad
         RKoYnU4WOtbiVSmuM6DI9FN264Hctn2SGtH11+3pS5Ek1lUIuhSp4oBDtPZZzFXQrlZ+
         9uraA9bPugBgQwH0cRg14IgVFbAxMx5sB4u7xhjMA/jeq54WVcwT1pcV8qVCVyMGcH/f
         3DHpVSqyCHKXg14LAv7K9BlNfW0ni4sS8l+cBZ0G7FuCFplW4mLVPEP5qOIow/nts971
         TFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hO7vOXF2yx5CWHwlLp5+eN9pUvefHgEWo1HreKP2sKI=;
        b=qLGPFU8uVrpiWuBEtJJRO9u+KwN+vviF9qvLAd8TolLYEiGyfhAJ9fL5v1m1VV7kEw
         v/362XhI8si+xyn34bTWlTp7CLbiy3VJYMRDOMRXzcF6jutWuHtBFO59Ny4fgWlGui0O
         h9t36xTYg0nXKarI0l5PMSkNRUZ/R94tmQ5k813bVY9Zodj1+Hg89l2Ru8k0hQuSEB6g
         /m+9cPGrwBgcqY5O4QXzRknltvfZYCvCdPpr1sbCJJPNiG/Zh9hNXgsgf6HW6Q5LCPr0
         Mk4SJLSGgbINCwQJ01/ftz1bnC5nKG/sv4c1TrqGJ7bOjdSkpE0lSUHP7t/XMUNj8oNp
         JnUg==
X-Gm-Message-State: AOUpUlGwykrsftX4FdEUneLR5CS7F27NPLmJjGxJZzuF4Wu37uzCHd8j
        IKdfO/FRKA6soaCRsdKIeNR7bKN3EFXZWWk3dGgMVw==
X-Google-Smtp-Source: AAOMgpemSHsSrGDq41aPQSXeKmzU3gsQRm6l1jwb9APUtWijcDAnFcWVFviR6a0ybVL+oBXqByQBpgLug4SQbYVQpe8=
X-Received: by 2002:aca:5f56:: with SMTP id t83-v6mr5675386oib.115.1531457084868;
 Thu, 12 Jul 2018 21:44:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 21:44:44
 -0700 (PDT)
In-Reply-To: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 12 Jul 2018 21:44:44 -0700
Message-ID: <CAPcyv4gxt3iT_Y11WVHXZfctcf_i2MWpe=jc0WB2JrsVcOk7MQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] mm: Teach memory_failure() about ZONE_DEVICE pages
To:     linux-nvdimm <linux-nvdimm@lists.01.org>
Cc:     linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 2:40 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> Changes since v4 [1]:
> * Rework dax_lock_page() to reuse get_unlocked_mapping_entry() (Jan)
>
> * Change the calling convention to take a 'struct page *' and return
>   success / failure instead of performing the pfn_to_page() internal to
>   the api (Jan, Ross).
>
> * Rename dax_lock_page() to dax_lock_mapping_entry() (Jan)
>
> * Account for the case that a given pfn can be fsdax mapped with
>   different sizes in different vmas (Jan)
>
> * Update collect_procs() to determine the mapping size of the pfn for
>   each page given it can be variable in the dax case.
>
> [1]: https://lists.01.org/pipermail/linux-nvdimm/2018-June/016279.html
>
> ---
>
> As it stands, memory_failure() gets thoroughly confused by dev_pagemap
> backed mappings. The recovery code has specific enabling for several
> possible page states and needs new enabling to handle poison in dax
> mappings.
>
> In order to support reliable reverse mapping of user space addresses:
>
> 1/ Add new locking in the memory_failure() rmap path to prevent races
> that would typically be handled by the page lock.
>
> 2/ Since dev_pagemap pages are hidden from the page allocator and the
> "compound page" accounting machinery, add a mechanism to determine the
> size of the mapping that encompasses a given poisoned pfn.
>
> 3/ Given pmem errors can be repaired, change the speculatively accessed
> poison protection, mce_unmap_kpfn(), to be reversible and otherwise
> allow ongoing access from the kernel.
>
> A side effect of this enabling is that MADV_HWPOISON becomes usable for
> dax mappings, however the primary motivation is to allow the system to
> survive userspace consumption of hardware-poison via dax. Specifically
> the current behavior is:
>
>     mce: Uncorrected hardware memory error in user-access at af34214200
>     {1}[Hardware Error]: It has been corrected by h/w and requires no further action
>     mce: [Hardware Error]: Machine check events logged
>     {1}[Hardware Error]: event severity: corrected
>     Memory failure: 0xaf34214: reserved kernel page still referenced by 1 users
>     [..]
>     Memory failure: 0xaf34214: recovery action for reserved kernel page: Failed
>     mce: Memory error not recovered
>     <reboot>
>
> ...and with these changes:
>
>     Injecting memory failure for pfn 0x20cb00 at process virtual address 0x7f763dd00000
>     Memory failure: 0x20cb00: Killing dax-pmd:5421 due to hardware memory corruption
>     Memory failure: 0x20cb00: recovery action for dax page: Recovered
>
> Given all the cross dependencies I propose taking this through
> nvdimm.git with acks from Naoya, x86/core, x86/RAS, and of course dax
> folks.
>

Hi,

Any comments on this series? Matthew is patiently waiting to rebase
some of his Xarray work until the dax_lock_mapping_entry() changes hit
-next.
