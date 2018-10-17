Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728A6ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354A1214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pl68ASzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354A1214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeJQWQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:16:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40104 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQWQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:16:37 -0400
Received: by mail-io1-f68.google.com with SMTP id w16-v6so18888729iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KPdp+rW27wHQyFO6nfUOPLD9Kud1YSjqrG6RP/U4vO4=;
        b=pl68ASzFVQ+2xtpAA8zTjWi98A1rIKG9CJKpMk/r36jQ01qiPPVVMZePVU0kwz9ZbD
         p/Gh/hAwsRS4EODiilGDQay0utTHcfNUNBwtaf7jckHnBJdC529id2E/dxYPNZ3FluEk
         jknc0oKbCw902OVFq6yNx+V5nC5TXvksJsy8TB1tnC/iU4ZxEPl2tuo+lzZzL/hAMCvW
         8SRkdMXzCaHy11+nA582qx9/ZCZx/YrKqkIGQVyDDp7forlvZiyCuSxF7FSE95Qoy2/l
         Ts2mjnPRSUUzmuGjHgQqUKQxTbyZfQF2ew+jLNEpHSD/EJzBmhFxNoqB+yR3cOUmMVg8
         X07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KPdp+rW27wHQyFO6nfUOPLD9Kud1YSjqrG6RP/U4vO4=;
        b=m2XGCSsqlxMbeirbxlZLCZhDsveVgt6y7uNGi0sSh/MRNUXV3nik7m15xQUcwuBdlR
         +31SwNpQrWwTEVlpmKhv7Yj/BRZTIxxvkFtys7YWUnizuzVmOSKEP78mPMdYkwj2zfG/
         O0vXt4ks+K65kLDv+fM4c095GnEV5Gtegye8crEqZg2cZCQTdia4vE7QdOyPvJhhN+H1
         7yGzFukZO6pOf8Qxh6GD3PvKWLGWnqeElwuEz5QacRNa5parTPOCSbvHaYve/HrWbnFI
         zd1rMVCrgPH1TaTI0Msw2dDBBxgFL9Ur5MrdqIpE27O3js51jE7n8leiNExhPKyykTtE
         LIcw==
X-Gm-Message-State: ABuFfogXNnySW3df87UrYeYOf8L+WBwwMbQ/4PzNmUHl5+xUTKuq1ROl
        Ijl3f65KtukCWHiWMFg5qBo4KGzlNkb5XGpL/WhnVg==
X-Google-Smtp-Source: ACcGV60oSk5FJagld0c+Bt5OLedbhdgTdWMGc2Mf46UABi07ksiLuwrLx+XXE5SdNsBKUciqn2miuFV1RaXycpZu2GM=
X-Received: by 2002:a6b:93d6:: with SMTP id v205-v6mr16087356iod.192.1539786041605;
 Wed, 17 Oct 2018 07:20:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 07:20:41
 -0700 (PDT)
In-Reply-To: <be684ce5-92fd-e970-b002-83452cf50abd@arm.com>
References: <cover.1538485901.git.andreyknvl@google.com> <be684ce5-92fd-e970-b002-83452cf50abd@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 17 Oct 2018 16:20:41 +0200
Message-ID: <CAAeHK+yEZTLjgSj8YUzeJec9Pp2TwuLT5nCa1OpfBLXJkx_hhg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] arm64: untag user pointers passed to the kernel
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 4:06 PM, Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> Hi Andrey,
> I have been thinking a bit lately on how to address the problem of user t=
agged pointers passed to the kernel through syscalls, and IMHO probably the=
 best way we have to catch them all and make sure that the approach is main=
tainable in the long term is to introduce shims that tag/untag the pointers=
 passed to the kernel.
>
> In details, what I am proposing can live either in userspace (preferred s=
olution so that we do not have to relax the ABI) or in kernel space and can=
 be summarized as follows:
>  - A shim is specific to a syscall and is called by the libc when it need=
s to invoke the respective syscall.
>  - It is required only if the syscall accepts pointers.
>  - It saves the tags of a pointers passed to the syscall in memory (same =
approach if the we are passing a struct that contains pointers to the kerne=
l, with the difference that all the tags of the pointers in the struct need=
 to be saved singularly)
>  - Untags the pointers
>  - Invokes the syscall
>  - Retags the pointers with the tags stored in memory
>  - Returns
>
> What do you think?

Hi Vincenzo,

If I correctly understand what you are proposing, I'm not sure if that
would work with the countless number of different ioctl calls. For
example when an ioctl accepts a struct with a bunch of pointer fields.
In this case a shim like the one you propose can't live in userspace,
since libc doesn't know about the interface of all ioctls, so it can't
know which fields to untag. The kernel knows about those interfaces
(since the kernel implements them), but then we would need a custom
shim for each ioctl variation, which doesn't seem practical.

Thanks!
