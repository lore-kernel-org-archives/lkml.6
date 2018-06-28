Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982FDC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6342724D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by2hPx6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6342724D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeF1KqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:46:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33055 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbeF1KqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:46:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id l23-v6so4887011edq.0;
        Thu, 28 Jun 2018 03:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JS8M5+WHZ4q9lqry4nTCR0zThe+sGjPnruBV6R0+5Q=;
        b=by2hPx6rXcfMwJ5vI3bwiCxF8qRFmLT4mXXGfAYWU3Yfr6xyHRN9C5JTTvxZhU1pAQ
         siW4nYflexTY08sL9F/m0sCjahiMHHs3iAgToXUiDWO65tsFT0GBd1jw59PemaUS9p8B
         gy/+u+LaOfSHpSHTM3H44ez7ZfAwGToqx04nb8lTLAG3imCzWZlO8Bl+dueSKsQ/nv/s
         2e/QzhQfshy2rvQsrbGnJqASULLg/79axf+sh9GdJoJ3vexIgr16CUrM0NZen7eVs4Nf
         0KePLpEjQOfusfynR/8Tgk3O6fG6lwN1swhJ2m/TbXCoi/6nsGhAOcwSgXqHdeHTbopY
         f8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JS8M5+WHZ4q9lqry4nTCR0zThe+sGjPnruBV6R0+5Q=;
        b=UhpQEigFc79uOKfaJPxuQ8dfVSXL/zgihO1IGZ5OlY9tZFRVoHUG8Nl4z4AzfzXO7V
         Fgy3hoLn4RPHP8T5Y6LYvqSLpyp7FTOe8hr0m9CC+x7dPQEPUiyGOWTPhkS9fU1CQEtW
         HAszd7i8jabnfbvBQvGWvGSyYDEuTXevXM4RYAAQkc1PL57qaRK4KrxTo0VqfVJN2SzD
         rv4b9f9nJ9PPflhoz0gHnwmDy6bKLBJAraouhFDYs65CXXQ2VZ6btWNC6rkl626tzIo0
         fzuTh5VMS4RW2GD7b6bJIVso6S/sAqiBzS+a7QSpOr6sLFs6vopUQUE59M51Pag5Lh4r
         6jrg==
X-Gm-Message-State: APt69E2DVlQgnbW82kpevOy8ihE4cr08TigY95eqA0771vbkVWgXQ3sX
        y4F3c6pm0G0N62psALb41skmQijY
X-Google-Smtp-Source: AAOMgpcj9gEuMx5woISDBJ2lXXAyqqRC7xNMKMJpulqh3gkV+B3Z2yei2LzWfIoE1j5WZwkimF0NPA==
X-Received: by 2002:a50:b0c2:: with SMTP id j60-v6mr9198296edd.188.1530182773883;
        Thu, 28 Jun 2018 03:46:13 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40dc:3d00:cc54:7de1:e161:def7])
        by smtp.gmail.com with ESMTPSA id p30-v6sm3703882edc.5.2018.06.28.03.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 03:46:13 -0700 (PDT)
Date:   Thu, 28 Jun 2018 12:46:11 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Message-ID: <20180628104610.czsnq4w3lfhxrn53@ltop.local>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
 <20180628061758.j6bytsaj5jk4aocg@ltop.local>
 <20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:27:42AM +0100, Catalin Marinas wrote:
> On Thu, Jun 28, 2018 at 08:17:59AM +0200, Luc Van Oostenryck wrote:
> > On Wed, Jun 27, 2018 at 06:17:58PM +0100, Catalin Marinas wrote:
> > > sparse is indeed an option. The current implementation doesn't warn on
> > > an explicit cast from (void __user *) to (unsigned long) since that's a
> > > valid thing in the kernel. I couldn't figure out if there's any other
> > > __attribute__ that could be used to warn of such conversion.
> > 
> > sparse doesn't have such attribute but would an new option that would warn
> > on such cast be a solution for your case?
> 
> I can't tell for sure whether such sparse option would be the full
> solution but detecting explicit __user pointer casts to long is a good
> starting point. So far this patchset pretty much relies on detecting
> a syscall failure and trying to figure out why, patching the kernel. It
> doesn't really scale.

OK, I'll add such an option this evening.
 
> As a side note, we have cases in the user-kernel ABI where the user
> address type is "unsigned long": mmap() and friends. My feedback on an
> early version of this patchset was to always require untagged pointers
> coming from user space on such syscalls, so no need for explicit
> untagging.

Mmmm yes.
I tend to favor a sort of opposite approach. When we have an address
that must not be dereferenced as-such (and sometimes when the address
can be from both __user & __kernel space) I prefer to use a ulong
which will force the use of the required operation before being
able to do any sort of dereferencing and this won't need horrible
casts with __force (it, of course, all depends on the full context).

-- Luc
