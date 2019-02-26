Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FDAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5BE217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZl1WD6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfBZDMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:12:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42751 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZDMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 22:12:05 -0500
Received: by mail-io1-f67.google.com with SMTP id p196so9337896iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 19:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnyiY0V/XIFQAhhxKGDBNH5iFaxk4QCNlL4yg35RlfQ=;
        b=HZl1WD6xalCd96g/iJLntt/V9b69pTzUkDAmuhYmp7Nvg6pF+VU46pefhNjrsjgdPU
         pAJLCS0ojX34KkAWxr5NxivfeUffI/rIeUl9KxqbyTf5rWCw0yxXetScjJabtr1TYFAB
         qgxy7KPEjSCGKxQtYqVg8MBnywDO8z8QC0QPrlynStJZ1o0fGQDngh/0XCDRd1KHNkMu
         WdlgZ4rwyhxOOE/yiTjSWFC9f4/X8azb0fBaepJxiaTuJP8lumJjMvyqGNQccmhTsNpG
         dR9kv7yk7szrraTeYGp1/dErFOgiH2iHKAjtCikSpAGuaEobxPnxSHbRmDkSJeQZlR9x
         bR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnyiY0V/XIFQAhhxKGDBNH5iFaxk4QCNlL4yg35RlfQ=;
        b=Ucs/34AyHOuPedmFDnifcXrW0u0Qg9ceUm748lk+b8yWts0rw26zdQHQj76N5Buj0z
         8UEXNrYfG3vfgbTtHnWV3yCdAOBlA2rVWAlB8uWrJiW3xVc5544ILMOSSpA5tLBMNHUE
         SvsmI7nOUxh2k9ibv7auYNKG6w7W3BrTyT5Dj1F48f2koZvTyfNbnchQXBBgDUMqUK0S
         f1mPRIc+zsRd2Fv2hb5hLgXrP9dsMtmBSrj6YJoWpY8lGYiFtqYHrDqPBY/dz2M42U7Z
         GmL9pW719uRlR/STyyET8544oBPEhr79XYSRJpE7vHB96fGVlqQaHmpxvNwR/8t+tuIw
         LwNA==
X-Gm-Message-State: AHQUAuZJLzJwNt+cHlU9QbLpYOJBt8Upz2nMizvHI/3rWgDfidgCWypf
        u+S4XcK5k55iWCVDwDENWNhGXIhGwO3EjDT0VA==
X-Google-Smtp-Source: AHgI3Ib+0Yn5YJweSeNrN0WYtXJpRFL0pmAAYdtFB+KQXxAP/rS/8skDWMpYpFY4Op8oovQq+NWytRCacLyT8a4fOtY=
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr10454130iog.281.1551150724315;
 Mon, 25 Feb 2019 19:12:04 -0800 (PST)
MIME-Version: 1.0
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com> <20190225082318.GB9326@localhost.localdomain>
In-Reply-To: <20190225082318.GB9326@localhost.localdomain>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 26 Feb 2019 11:11:53 +0800
Message-ID: <CAFgQCTshGH8Q2jKEMY-SHC4mUkmcsLkHnpLUHiirWBdpC62hpA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved region
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 4:23 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Mon, Feb 25, 2019 at 03:59:56PM +0800, Pingfan Liu wrote:
> >crashkernel=x@y option may fail to reserve the required memory region if
> >KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
> >skip the required region.
> >
> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@redhat.com>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >Cc: Baoquan He <bhe@redhat.com>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Cc: Nicolas Pitre <nico@linaro.org>
> >Cc: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> >Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >Cc: linux-kernel@vger.kernel.org
> >---
> > arch/x86/boot/compressed/kaslr.c | 26 +++++++++++++++++++++++++-
> > 1 file changed, 25 insertions(+), 1 deletion(-)
> >
>
> Hi Pingfan,
>
> Some not important comments:
>
> >diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> >index 9ed9709..728bc4b 100644
> >--- a/arch/x86/boot/compressed/kaslr.c
> >+++ b/arch/x86/boot/compressed/kaslr.c
> >@@ -109,6 +109,7 @@ enum mem_avoid_index {
> >       MEM_AVOID_BOOTPARAMS,
> >       MEM_AVOID_MEMMAP_BEGIN,
> >       MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
> >+      MEM_AVOID_CRASHKERNEL,
> >       MEM_AVOID_MAX,
> > };
> >
> >@@ -240,6 +241,27 @@ static void parse_gb_huge_pages(char *param, char *val)
> >       }
> > }
> >
> >+/* parse crashkernel=x@y option */
> >+static int mem_avoid_crashkernel_simple(char *option)
> >+{
> >+      char *cur = option;
> >+      unsigned long long crash_size, crash_base;
>
> Change the position of two lines above.
>
Yes, it is better.
> >+
> >+      crash_size = memparse(option, &cur);
> >+      if (option == cur)
> >+              return -EINVAL;
> >+
> >+      if (*cur == '@') {
> >+              option = cur + 1;
> >+              crash_base = memparse(option, &cur);
> >+              if (option == cur)
> >+                      return -EINVAL;
> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> >+      }
> >+
> >+      return 0;
>
> You just call this function and don't use its return value.
> So why not change it as void type.
>
OK.
> >+}
> >
> > static void handle_mem_options(void)
>
> If you want to change this function, I think you could change the
> function name and the comment:
>
>         /* Mark the memmap regions we need to avoid */
>         handle_mem_options();
>
Yes, it is outdated, should fix the comment.
> > {
> >@@ -250,7 +272,7 @@ static void handle_mem_options(void)
> >       u64 mem_size;
> >
> >       if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
> >-              !strstr(args, "hugepages"))
> >+              !strstr(args, "hugepages") && !strstr(args, "crashkernel="))
> >               return;
> >
> >       tmp_cmdline = malloc(len + 1);
> >@@ -286,6 +308,8 @@ static void handle_mem_options(void)
> >                               goto out;
> >
> >                       mem_limit = mem_size;
> >+              } else if (strstr(param, "crashkernel")) {
> >+                      mem_avoid_crashkernel_simple(val);
>
> I am wondering why you call this function mem_avoid_crashkernel_*simple*().
>
It follows the name of parse_crashkernel_simple()

Thanks,
Pingfan
