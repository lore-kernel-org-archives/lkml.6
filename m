Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45738C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0163A206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfKbyhqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0163A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJBUDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:03:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42617 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeJBUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:03:18 -0400
Received: by mail-io1-f68.google.com with SMTP id n18-v6so2014241ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Lp/kJGNqhFpx8BEof00JNCRHPhkJWkbKrlOP/9fLXw=;
        b=qfKbyhqn+1WcftoTtwmaCnHXwNU4V3pFa67OC8ALKTadTDCtjwcNmvHiHH+tLhsqPf
         k8lGM5N9Jqf4OAOaVHEm2iB1gW0kA/bL/O51hazE8eA+h45zmW/JSSZtSkZ8UZ50CgRS
         DHUrUGzlRtwIS3Tl7PLbR7bLsKNzxn/X6nUQbaikyEXw4IzjMWL5kkpezGXJK4UHIc2T
         s17tm8MjwtjNB3jID/S+U/XWZRGC3pPsigZMfz+fasgSl9SpLgxO8OD6yIJS160bFYR6
         gixGgCbkL16ejQvvLhTx69/YbrZhRULgE5c6oTA7/PVqDt9taiRud4hRYxHlRdl5gcWq
         Dzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Lp/kJGNqhFpx8BEof00JNCRHPhkJWkbKrlOP/9fLXw=;
        b=HrCSkQ0c/o4GhNiV5qfDSIPH0O0Fd0hyZQzmka5YOWVKGA+q3qqVKkNzaF5k0k3Djx
         mwILreON/47ZcdDhGi2pavQk/JEqrv4xyrs4xB20t2a5qY0nTk6Fjnuqb9wDrw3t7KQA
         uJrWSQdO90xOeUaBBYYmCU2dONuAZwqT5e99TWMl+EVAg18sDEXNnQwq4jx8FugHBkTn
         qmG184wQRkiIqp1lyrV3Hsbm5+9SrsMvTwhTHpiRcyxVB7q5Vz7p2d3l3ax4bo9ZfPnN
         4Je4PIFnKs44t11nIE3L5ADaTADa7r4h5KurGJ/10tit+PDEpgD7r2jK1CljqHHXUEM9
         9UcA==
X-Gm-Message-State: ABuFfojSSkPX5JYcrYNCvdTfV7FNMIyEwrFqV7gof9EvJVb+XwQUcz1I
        g91KMitKFGIEa9SlCqQUbgmlQx9XJxmIIAAHFNiFqw==
X-Google-Smtp-Source: ACcGV61NzjS599wd3RA+ESDDD6TH5B9lTg+ftlPINo3q8Uq/hkIAux+m8dDK0qS1r1NhE1imbg6RxrF+f2jN3AsSL3g=
X-Received: by 2002:a6b:ece:: with SMTP id 197-v6mr10334356ioo.192.1538486398400;
 Tue, 02 Oct 2018 06:19:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 06:19:57 -0700 (PDT)
In-Reply-To: <20180928175013.GC193149@arrakis.emea.arm.com>
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
 <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
 <20180907152600.myidisza5o4kdmvf@armageddon.cambridge.arm.com>
 <CA+55aFzQ+ykLu10q3AdyaaKJx8SDWWL9Qiu6WH2jbN_ugRUTOg@mail.gmail.com>
 <20180911164152.GA29166@arrakis.emea.arm.com> <CAAeHK+z4HOF_PobxSys8svftWt8dhbuUXEpq2sdXBTCXwTEH2g@mail.gmail.com>
 <20180928175013.GC193149@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 2 Oct 2018 15:19:57 +0200
Message-ID: <CAAeHK+xK2Nb6J6YbvUJdXaZoecB0GS2UyY6pgGwrfCoOQJ34xg@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 7:50 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, Sep 17, 2018 at 07:01:00PM +0200, Andrey Konovalov wrote:

>> Looking at patch #8 ("usb, arm64: untag user addresses in devio") in
>> this series, it seems that that devio ioctl actually accepts a pointer
>> into a vma, so we shouldn't actually be untagging its argument and the
>> patch needs to be dropped.
>
> You are right, the pointer seems to have originated from the kernel as
> already untagged (mmap() on the driver), so we would expect the user to
> pass it back an untagged pointer.

OK, dropped this patch in v7.

>> As for case 1, the places where pointers are compared with TASK_SIZE
>> and others can be found with grep. Maybe it makes sense to introduce
>> some kind of routine like is_user_pointer() that handles tagged
>> pointers and refactor the existing code to use it? And maybe add a
>> rule to checkpatch.pl that forbids the direct usage of TASK_SIZE and
>> others.
>>
>> So I think detecting direct comparisons with TASK_SIZE and others
>> would more useful than finding __user pointer casts (it seems that the
>> latter requires a lot of annotations to be fixed/added), and I should
>> just drop this patch with annotations.
>
> I think point (1) is not too bad, usually found with grep.
>
> As I've said in my previous reply, I kind of came to the same conclusion
> that searching __user pointer casts to long may not actually scale. If
> we could add an __untagged annotation to ulong where it matters (e.g.
> find_vma()), we could identify a ulong (default tagged) and annotate
> some of those.
>
> However, this analysis on __user * casting was useful even if we don't
> end up using it. If we come up with a clearer definition of the ABI
> (which syscalls accept tagged pointers), we may conclude that the only
> places where untagging matters are a few find_vma() calls in the arch
> and mm code and can ignore the rest.

So what exactly should I do now?

For now I've posted v7 with the sparse annotation patch dropped (to
have the most up-do-date version posted).
