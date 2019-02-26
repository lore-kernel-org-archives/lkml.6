Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1491C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADA920C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrniw8KQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfBZOjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:39:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfBZOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:39:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id n125so6349384pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfiBLpo8ppzHN31Df3pK9Pue7IUmmemEwHEq/+qIHW8=;
        b=qrniw8KQBsnVcBdkLwXYTHP1tzALWjLL3wqY47zLDB86u7VpyXqsBCFNMPUvx2rcQ5
         tleEIn43VcQEIxdaz5Lq3qoXKxfo59ovHYPtXDa7JwcKInE8AMfYDGNxNizwMWMWQjde
         EhSO6jW2VXILtMDY8JQSd+bipZZVCQ+CR0EOZ2zJgqQHGK2gbFfefcVUCOF/9F/FdN4j
         khe0Gzu8tDmq3gffWUNVCHAG7gYifd/AMvfrRv8bNWrE6v7GDGV6bjcxEvsAriDj0zwX
         9ukzSjG/hOjO6EfG3Aixqm8fiGMNQyIAiftpSDpkdyIWPy343s9BUOUiQ9YAblVGHraC
         nJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfiBLpo8ppzHN31Df3pK9Pue7IUmmemEwHEq/+qIHW8=;
        b=eQzH4wb35v4yPQjWJucbA2ihhhDevCE++xHrbXZ2oVR7HHgSLG5Zn8mOFEd2ZW9P0d
         LMVk3fSlx5OuEsWR7vq90KMMqPUmbCxIJi4BOaSBmbk2/Q51aFavx/1WRd4vsJqNWuOf
         kEfPyRrJLXemk0tX2N/wOdu5JrZQKc0ndcyvwqpxJseKJ3MU9E9rcWLRggpZbQWJHcwy
         BuT/kgkFBFC/HpAlLKYpKYMHbyViEEWzvPaev4jAUlqEzo7785ALEHmjiAcSITcVU0yQ
         LRafi00g6SApIvx3wyEHuXcz8NvR5V84IWVBVY5yi+Eyu1ip/4H0BIKLb+IeJk+lICpJ
         ooGQ==
X-Gm-Message-State: AHQUAuaPheGDxAObTQjxBX2lV5b6QYTX3fniXoDmAbooZez8gyhT3A2C
        FfLr+qQ2zELeKOGghWb7zK5mAfOMHTnZ8qsvSBecXA==
X-Google-Smtp-Source: AHgI3IbzQ3IeJ3DdtureLg8xHbfzWl4k26RcwSMIdPdFZQbQ2oXfH0JWdLJfU9vlDhlDrZoE5TP5lbkNIdumuA65DBY=
X-Received: by 2002:a65:6651:: with SMTP id z17mr23465185pgv.95.1551191958932;
 Tue, 26 Feb 2019 06:39:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com> <8343cd77ca301df15839796f3b446b75ce5ffbbf.1550839937.git.andreyknvl@google.com>
 <73f2f3fe-9a66-22a1-5aae-c282779a75f5@intel.com>
In-Reply-To: <73f2f3fe-9a66-22a1-5aae-c282779a75f5@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 26 Feb 2019 15:39:08 +0100
Message-ID: <CAAeHK+yQU8khtOoyDKqmHterCa16P7oWe9AMiPnrxE+Gyb_7aw@mail.gmail.com>
Subject: Re: [PATCH v10 07/12] fs, arm64: untag user pointers in fs/userfaultfd.c
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 12:06 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > userfaultfd_register() and userfaultfd_unregister() use provided user
> > pointers for vma lookups, which can only by done with untagged pointers.
>
> So, we have to patch all these sites before the tagged values get to the
> point of hitting the vma lookup functions.  Dumb question: Why don't we
> just patch the vma lookup functions themselves instead of all of these
> callers?

That might be a working approach as well. We'll still need to fix up
places where the vma fields are accessed directly. Catalin, what do
you think?
