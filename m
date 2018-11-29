Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD96C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57E82082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCgWBlW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57E82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbeK3CJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:09:41 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35219 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeK3CJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:09:41 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so4085822itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 07:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bI4HsTozHcvKlx21ofCkvErvo0kkxXchTu8M4Q9Rfmk=;
        b=aCgWBlW6r7XnKBwCC3+p8hUPwbQ95DiUjF3m0afpyzSd1x17E/g2hKvmuK144deVSb
         azA78b5dTtBRjtWGTACS5ysMnNFNYTTqI8x3VEW4XWV2pvQr/Kv7bLeEuDYHdie/zxg/
         PyO8oknLC/PwONOTZRzuK0LO7WLWWMhK4Z/o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bI4HsTozHcvKlx21ofCkvErvo0kkxXchTu8M4Q9Rfmk=;
        b=f4AQ680S9XAhVqeQAVj+K7wr8K/sLi6AVkMSWBgXV2EKkAprDqcpcO13jjQqHLFj9z
         fixC8XwH2kbi37LspchiGk6epmRbrCUOB8tSqQ8vIADFIXnjSDETI95a+gqXiMJO2cW0
         FXPWHOFIP37VI0MsbYDpOPbfKoAUkOeBTJXfyaiFMCs16I6+DlaVRbsQBJxL4oBsoN56
         v3k4aWq1WZ9WM4N4ny9gIqjgg8zsPehCKxfi6oPnJnF2SJLxvGjV5Efngz7tU+oM/AzW
         97rZ1+Zx3f12UWcu33cyYIMvwT5XPPmNOnLly5dUOZvGOgTmurYOuk/yJJfiHrWJl5tM
         qteQ==
X-Gm-Message-State: AA+aEWbU8GusFFyPszcs9Mw98dt9F8+PiVqSIZfLHrup/BuBPKvi+yLm
        7bnsA/jH+OJyv6asLwQVGr+2Hjf7m2BoOCSga8gu6g==
X-Google-Smtp-Source: AFSGD/W921UxSsr3bc4M3MOI6/4YeTYBvkC9815aidhVWpA4SuOdsw83LI/5JSWupQHyzFJ7KdsOvd8cW8/L9HBIPuI=
X-Received: by 2002:a24:710:: with SMTP id f16mr1586772itf.121.1543503841377;
 Thu, 29 Nov 2018 07:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20181129140106.520639693@linuxfoundation.org> <20181129140109.438834361@linuxfoundation.org>
 <CAKv+Gu8cPOQaYY_KH3dq+2U517z7j67Od+Cxe+wB4gkEOqnQTA@mail.gmail.com> <20181129150221.GB22451@kroah.com>
In-Reply-To: <20181129150221.GB22451@kroah.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 29 Nov 2018 16:03:49 +0100
Message-ID: <CAKv+Gu9PwKALUChvihoSASMzwo4d4N+YXLoDovRKgG9A2WZsSw@mail.gmail.com>
Subject: Re: [PATCH 4.9 39/92] efi/arm: Revert deferred unmap of early memmap mapping
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 16:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 29, 2018 at 03:28:44PM +0100, Ard Biesheuvel wrote:
> > On Thu, 29 Nov 2018 at 15:21, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > [ Upstream commit 33412b8673135b18ea42beb7f5117ed0091798b6 ]
> > >
> > > Commit:
> > >
> > >   3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory map longer for BGRT")
> > >
> > > deferred the unmap of the early mapping of the UEFI memory map to
> > > accommodate the ACPI BGRT code, which looks up the memory type that
> > > backs the BGRT table to validate it against the requirements of the UEFI spec.
> > >
> > > Unfortunately, this causes problems on ARM, which does not permit
> > > early mappings to persist after paging_init() is called, resulting
> > > in a WARN() splat. Since we don't support the BGRT table on ARM anway,
> > > let's revert ARM to the old behaviour, which is to take down the
> > > early mapping at the end of efi_init().
> > >
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: linux-efi@vger.kernel.org
> > > Fixes: 3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory ...")
> >
> > This commit is only in v4.19 as far as I know. Does it even apply?
>
> This commit is in the following releases:
>         4.9.129 4.14.72 4.18.10 4.19
>
> so it should apply :)
>

Ah, of course.

I didn't realize (or failed to remember) that it had been taken into -stable.

Thanks,
