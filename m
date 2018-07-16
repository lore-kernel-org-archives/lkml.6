Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B9CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4AF20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXfan1LQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4AF20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeGPLw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:52:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40380 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbeGPLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:52:59 -0400
Received: by mail-it0-f67.google.com with SMTP id 188-v6so20722418ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/YPa6Sdy2/on0zZ7jbnftgKcU0iEKh1WX6C3i6WznqA=;
        b=cXfan1LQmXXmaW8pnKXTfbic1RY8UzmGBwDKrpvZWQDj8vb09wWNfwZijU2pzEDO4P
         bnEdgIh6mC4Px1ewjBflhJysSrDfg/OLDvwGmkWcdKxr4agyzilTuldxrpNujTEpLVMH
         1iPjIzi9CIakSr2XH89e+orIePlUqWtsDtvYX9waO7I5xpBPLfa071/IPVxVbNJnLkgk
         AIRqJcoeEzx0bGfsim9GjptKRxuGk+S9LrCFYY4tE7zj0eEbRB4JnwoGS4Vgn7q1TsNY
         ohmqdbXLQnZd4IU7aTbU3qeBVtRttZI/UYU8Dgl5vat/UQFOof/sohNMGgkUQcsgH1EA
         2acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/YPa6Sdy2/on0zZ7jbnftgKcU0iEKh1WX6C3i6WznqA=;
        b=GBj73P7xNH98NmITZmxLtsIzSm16lv5Rvz9j7pMhMfOHRM0AuPECC6beLBmnKKe4oA
         2XD2SqFFe6Bt6JBNKeSRIxVV8Qampq/OBLyt7Peqz5krFmGYDMbYEMkje1nLkOGrIVT/
         KNDw3GVG2pz2ZE912G4eYi/ChD3Eo0GDxUMQnS9yjVQ2egVZ0rqbJoGbQnP1prfHP9KE
         6a33m9bSqTs7gs9J4SftAwtDqi4D1SS/nXTC3YFzBZAYp87LdELNYFz7P8SP9V3ujOO+
         fEdkorKI/dUwjN6Q1GOcZKfVXS1ik3zWn7K8aVk7mFLnrmFZc9ZkfhkeeMCKDVL6/cMh
         OAcA==
X-Gm-Message-State: AOUpUlFYGgy9GumWp1grSC4ouWEqTmRQV1rEW3XLxD8jM2rZwOiqAtBV
        wEXDIzhOkwy/QnvGPvG9FOoPjdSYn6XQHq2R641qwA==
X-Google-Smtp-Source: AAOMgpeAjZ7RTjM0881IZwR67ZMAPa8PtFIUJSovJC0xyVDVZJIRHnA5WzMZ7kbdcidVy75aiQHFGI0jyDDaK+eJ89E=
X-Received: by 2002:a24:db05:: with SMTP id c5-v6mr13160080itg.44.1531740360422;
 Mon, 16 Jul 2018 04:26:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:918c:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 04:25:59
 -0700 (PDT)
In-Reply-To: <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
References: <cover.1529507994.git.andreyknvl@google.com> <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com> <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 16 Jul 2018 13:25:59 +0200
Message-ID: <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 9:30 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Wed, Jun 27, 2018 at 5:05 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> On Tue, Jun 26, 2018 at 7:29 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>>> While I support this work, as a maintainer I'd like to understand
>>> whether we'd be in a continuous chase of ABI breaks with every kernel
>>> release or we have a better way to identify potential issues. Is there
>>> any way to statically analyse conversions from __user ptr to long for
>>> example? Or, could we get the compiler to do this for us?
>>
>>
>> OK, got it, I'll try to figure out a way to find these conversions.
>
> I've prototyped a checker on top of clang static analyzer (initially
> looked at sparse, but couldn't find any documentation or examples).
> The results are here [1], search for "warning: user pointer cast".
> Sharing in case anybody wants to take a look, will look at them myself
> tomorrow.
>
> [1] https://gist.github.com/xairy/433edd5c86456a64026247cb2fef2115

So the checker reports ~100 different places where a __user pointer
being casted. I've looked through them and found 3 places where we
need to add untagging. Source code lines below come from 4.18-rc2+
(6f0d349d).

Place 1:

arch/arm64/mm/fault.c:302:34: warning: user pointer cast
current->thread.fault_address = (unsigned long)info->si_addr;

Compare a pointer with TASK_SIZE (1 << 48) to check whether it lies in
the kernel or in user space. Need to untag the address before
performing a comparison.

Place 2:

fs/namespace.c:2736:21: warning: user pointer cast
size = TASK_SIZE - (unsigned long)data;

A similar check performed by subtracting a pointer from TASK_SIZE.
Need to untag before subtracting.

Place 3:

drivers/usb/core/devio.c:1407:29: warning: user pointer cast
unsigned long uurb_start = (unsigned long)uurb->buffer;
drivers/usb/core/devio.c:1636:31: warning: user pointer cast
unsigned long uurb_start = (unsigned long)uurb->buffer;
drivers/usb/core/devio.c:1715:30: warning: user pointer cast
unsigned long uurb_start = (unsigned long)uurb->buffer;

The device keeps list of mmapped areas and searches them for provided
__user pointer. Need to untag before searching.

There are also a few cases of memory syscalls operating on __user
pointers instead of unsigned longs like mmap:

ipc/shm.c:1355:23: warning: user pointer cast
unsigned long addr = (unsigned long)shmaddr;
ipc/shm.c:1566:23: warning: user pointer cast
unsigned long addr = (unsigned long)shmaddr;
mm/migrate.c:1586:10: warning: user pointer cast
addr = (unsigned long)p;
mm/migrate.c:1660:24: warning: user pointer cast
unsigned long addr = (unsigned long)(*pages);

If we don't add untagging to mmap, we probably don't need it here.

The rest of reported places look fine as is. Full annotated results of
running the checker are here [2].

I'll add the 3 patches with fixes to v5 of this patchset.

Catalin, WDYT?

[2] https://gist.github.com/xairy/aabda57741919df67d79895356ba9b58
