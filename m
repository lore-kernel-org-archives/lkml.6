Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A565C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC3E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkvrL1pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC3E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeJWOf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:35:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33473 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJWOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:35:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id q50so230658otd.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rWeBSiRUyKS+1XL2yyUkud2i8xgQzAMG93Q8wyC85LY=;
        b=tkvrL1pvmYMqzggtMr2672YDmK4ClMJ5AbMUxc48Aq1KMGgBQowpuXMZVAo0+HHW7L
         P9pbYlWV2n1wmrrTPAtPjVg7iXqB+JXjItBP0bTiXhisVayxKBtdOYLkCx+cg8GE66WB
         gYDvJoZU5FTotdRNZtCeRNBqCF7l4DW/FKAfZllv9FMNuulsJPdv+/jsfIkmA2SxMeOW
         QTI4Jou94UiSS5EQklLoRT4D1uOQZnhZ/wmsMjXUkxBTJLf0KYcZ+CXdvMIbA6gi/rwR
         WITVtXqLkrhVk0L/RsIkWlrDCmUpt/yKhyITYaIvSNQGOZ49EgKD4u/aJ5N3F4glDXEx
         Xndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rWeBSiRUyKS+1XL2yyUkud2i8xgQzAMG93Q8wyC85LY=;
        b=LcRYlsx2WBiSlz/GQBf4EUdrBzgsXYFx704YsBLFuMYTkrXBNsYbp8a14XnsHaJCkc
         b9hzv1/rrAd+K9gsJOrVQa6BfQX2Vhy9U+yjrSRvMDa7U9Z1+SsBWSoAEYOO1G6SUu5W
         JnriGS1OHuqIU5R3tftApPhJ4cbfx+2yyhGnNmtpdnv3Qtv8QjGl+1NLP9O4Ff6oKB0n
         iuXgKkoIWGbr//ak/T3yqRRGQ/87RBXqcKVpyZr6hOxHyV/lSNMU+k/Jx0VTH6XA9dcT
         p3hg+dzC084N5g01CRn/QfIDgSpcPLwNmLVQZ7DcgXPlFOMNeXatZc/IkiVcj6bq+z2/
         2y+g==
X-Gm-Message-State: ABuFfojKRmik9AruRJCcA7ZYgtov1Xogm0PEH57he7sQU4R+Xg896Lh4
        ooW4WqBxcBDZK4vvqQsqseUOJbL1n1FuBLMNAy0=
X-Google-Smtp-Source: ACcGV622f8q5Y1WrMpjEnsr3KQ99pnRk0kI8QylZxzhw++QFNyhrUYi3Xue7rfBI6R8Q+q9OOAUaipayMnGGpV9vtR4=
X-Received: by 2002:a9d:cb0:: with SMTP id b45mr31561168otb.2.1540275212191;
 Mon, 22 Oct 2018 23:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMkWEXP4Mm5x9rdrKn9xRNVm7vxqoL62ftxb+UcJFAiJ+U9X3A@mail.gmail.com>
 <CAPM=9txnZaeUgYEauJF5eSidEsGS9DmT6M4O-PcTPtCFXL8adA@mail.gmail.com>
 <CAMkWEXN3v41hg70vjzygbJPK9==xZSBdeDPkSQNs85Sm4HFucQ@mail.gmail.com> <CAPM=9txOFw60VZZQYJnOg+BCXLoN8cUd+Ri_B8Bt4Lg0sYBH4A@mail.gmail.com>
In-Reply-To: <CAPM=9txOFw60VZZQYJnOg+BCXLoN8cUd+Ri_B8Bt4Lg0sYBH4A@mail.gmail.com>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Tue, 23 Oct 2018 01:47:20 +0000
Message-ID: <CAMkWEXP96mXnzrjQEYb7Km5K-5WqYxwKZBXEm1omj0AM9Rn-0Q@mail.gmail.com>
Subject: Re:
To:     Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That preprocessor define worked but I'm still confused about this
DRM_FILE_PAGE_OFFSET thing.  Check out drivers/gpu/drm/drm_gem.c
right above drm_gem_init.

---

/*
 * We make up offsets for buffer objects so we can recognize them at
 * mmap time.
 */

/* pgoff in mmap is an unsigned long, so we need to make sure that
 * the faked up offset will fit
 */

#if BITS_PER_LONG == 64
#define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFFUL >> PAGE_SHIFT) + 1)
#define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFFUL >> PAGE_SHIFT) * 16)
#else
#define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFUL >> PAGE_SHIFT) + 1)
#define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFUL >> PAGE_SHIFT) * 16)
#endif


---

Why is having a 64-bit file offsets critical, causing -EINVAL on mmap?
What problems might be associated with using (0x10000000UL >>
PAGE_SHIFT) ?
On Mon, Oct 22, 2018 at 1:50 AM Dave Airlie <airlied@gmail.com> wrote:
>
> On Mon, 22 Oct 2018 at 10:49, Michael Tirado <mtirado418@gmail.com> wrote:
> >
> > On Mon, Oct 22, 2018 at 12:26 AM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > This shouldn't be necessary, did someone misbackport the mmap changes without:
> > >
> > > drm: set FMODE_UNSIGNED_OFFSET for drm files
> > >
> > > Dave.
> >
> > The latest kernel I have had to patch was a 4.18-rc6.  I'll try with a
> > newer 4.19 and let you know if it decides to work.  If not I'll
> > prepare a test case for demonstration on qemu-system-i386.
>
> If you have custom userspace software, make sure it's using
> AC_SYS_LARGEFILE or whatever the equivalant is in your build system.
>
> 64-bit file offsets are important.
>
> Dave.
