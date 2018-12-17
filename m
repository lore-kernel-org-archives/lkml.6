Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3105C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBSWepjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbeLQSLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:11:11 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:43991 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbeLQSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:11:11 -0500
Received: by mail-io1-f45.google.com with SMTP id l3so10679016ioc.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtTtww2J+GCnUCdOOfNCDZywfZrp26+t2LoIbv9W3/w=;
        b=PBSWepjtdhOkOuXXkRyafBYBnFtcmnG4Ry5qumN25JpFGmpOCp66379L9MU1I63HYO
         ZthhNX/m4KDplzzfZ+3xFmjQccl/Q29uewHEr1Qd5UyfK4HZJy0nWWKhiC81Whg1fO/D
         SFPIf1+UkIerXxbZ32h58I01tAP8giom9ZFys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtTtww2J+GCnUCdOOfNCDZywfZrp26+t2LoIbv9W3/w=;
        b=ATSu98b2wiOqgRgbwvbDxDzubg/pg+YagZlcHwK03odI6QEirLfGvXOIB1NIDjtrwT
         YanoaNWH1R6ETHMMAF2YWvpcbAMSkgtIqQF4Jz9APjazRwu2F3itOiqiar0yT0VrAI4c
         XjiaSRI7UNvmxpITQvts4f7BtXmATuvN5/ci+93haZ0R43FHJs70Dw4kq+Lq+MdtP9xb
         5GPGLscu5rauuxtN6IJeVGZykgZjiQvMCVCVAKiGOTZDfSAC02hD6mbROU0y7diDMcxr
         QhC9oxeU1ttDkBWwi3bTBTj3MPmAecrYeCxAsUngmqzLggjkYe3y4l7bHrSltm43OXb3
         Y+wg==
X-Gm-Message-State: AA+aEWbOTXL7PmYXkqhrWfLCpAPBd8Q5ajtuCd5lhSE0SN6T7pc7nE6d
        d4TQwH7rIDx45DtDpDjZMy8/wyf+aQ2yj+XznaLi22FVetI=
X-Google-Smtp-Source: AFSGD/UbS8AHfTAvFp+0/UyY7FkNFm073wdmFKg6Q9As639fuMMRJJm+k80v9/qepWHpx9E85iCR6Yp4hYpduKM8nNs=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr11468580iob.170.1545070269491;
 Mon, 17 Dec 2018 10:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org> <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Dec 2018 19:10:58 +0100
Message-ID: <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
Subject: Re: [tip:efi/core] x86/efi: Unmap EFI boot services code/data regions
 from efi_pgd
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "bhsharma@redhat.com" <bhsharma@redhat.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "joe@perches.com" <joe@perches.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        "zhuyifei1999@gmail.com" <zhuyifei1999@gmail.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 at 19:06, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>
> > Commit-ID:  08cfb38f3ef49cfd1bba11a00401451606477d80
> > Gitweb:
> > https://git.kernel.org/tip/08cfb38f3ef49cfd1bba11a00401451606477d80
> > Author:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > AuthorDate: Thu, 29 Nov 2018 18:12:24 +0100
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Fri, 30 Nov 2018 09:10:30 +0100
> >
> > x86/efi: Unmap EFI boot services code/data regions from efi_pgd
> >
> > efi_free_boot_services(), as the name suggests, frees EFI boot services
> > code/data regions but forgets to unmap these regions from efi_pgd. This means
> > that any code that's running in efi_pgd address space (e.g:
> > any EFI runtime service) would still be able to access these regions but the
> > contents of these regions would have long been over written by someone else.
> > So, it's important to unmap these regions. Hence, introduce efi_unmap_pages()
> > to unmap these regions from efi_pgd.
> >
> > After unmapping EFI boot services code/data regions, any illegal access by
> > buggy firmware to these regions would result in page fault which will be handled
> > by EFI specific fault handler.
>
> Hi Thomas and Ingo,
>
> I recently noticed that the below commits [1] and [2] are broken when kernel command line
> argument "efi=old_map" is passed. Sorry! I missed to test this condition prior to sending
> these patches to mailing list. I am working on a fix and will send it to mailing list as
> soon as it's ready.
>

Could you elaborate on the problem please?

> Meanwhile, could you please drop these patches before sending pull request to Linus?
>
> [1] Commit 08cfb38f3ef4 ("x86/efi: Unmap EFI boot services code/data regions from efi_pgd")
> [2] Commit 7e0dabd3010d ("x86/mm/pageattr: Introduce helper function to unmap EFI boot services")
>

I'd like to understand what the issue is before we drop anything.
