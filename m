Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F87C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1DF204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="r/77uaws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1DF204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeKGFdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:33:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41110 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeKGFdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:33:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so12626612ljb.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 12:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7KNBT5u2FpdE9ddKtjUHG9Vamfl6XScoxgvK/qV5gY=;
        b=r/77uawsFZbyZTeCVUbPwrZv505elxTg42SrdWG576eXWyWEWgygXWj8fF+jFAXATB
         qvPlpEAZoJ9aeYgfrElrw7mzcJsBGFcLCIukhSnZMpcejSxyAMROAZaAgVlnUZ93JPkt
         w/OuU+lN6ufozZzv9+Wf+23i0QPwXaLBGLqjZJz3BGUIv/woCes5f2Uh4eLRMbFxuB0I
         QdU6uNeTlIFWGNkVhXeykDCCdaswbO1FJaAMJLrRtE7VF3hGiXHg6ZiweUquEUw2S7c7
         mXlKJ39i4hY7/tM1NoiVHvJO0o4ai8i7B/H22Ms1FFDW1I0QN8a5jwtfjFpXbheP0HQU
         tbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7KNBT5u2FpdE9ddKtjUHG9Vamfl6XScoxgvK/qV5gY=;
        b=AfKZ3FgiMKrpgEnRrG+DJvvT1KdECBCV+9plsxRTsdGUTvv8OkoAYqiUCgzBAe1DeX
         6xGZQ72Ho9zYOwLjSF2l8qYUURSipWLdt0d4pNzo6OIi+nlNdPA83Uq5xZi87jcoQeBv
         GqVH710WnWbbV8kf9rAEwg+D5jOP3WZ15mD3eTg8+4c4NmXDo2p4UgKaa9oXjd3U99Fk
         e6Lt786EbaNkDTAxUuaH5wko0JgJQcWZY46ejr6R/BA2ccT6UsletzC+fzur1o4LPGCP
         BOzh5rTa7LZeg844Ra8T5kqUD5gVDIWZVtOyHITcrq5Alnt6jJoR+DgAr0QSyYLkGYND
         RU0A==
X-Gm-Message-State: AGRZ1gLKUx2C+qCOEwrUU7v17aHlKtlWiLW4EinaDJwCBJtCme/mpgxm
        r/qFWrYRNWmpK0TRkZIJaa1/ivF1pycLXk3TlFr7
X-Google-Smtp-Source: AJdET5dkPxfA4aC5IeVlYNHaCx9ZzDlDvaPPkxZ6LDJnTWV+2dTY88dy4CRRtzq/LQ2q+2zfFr1Ck5t5rL92DAjejBw=
X-Received: by 2002:a2e:8884:: with SMTP id k4-v6mr17773328lji.145.1541534772365;
 Tue, 06 Nov 2018 12:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20181029104854.17432-1-david.abdurachmanov@gmail.com>
In-Reply-To: <20181029104854.17432-1-david.abdurachmanov@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Nov 2018 15:06:01 -0500
Message-ID: <CAHC9VhSaGo0BmX5AsTcnppiVz2Lz8BFkjRA0jg_uuPix3Ziiog@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: add audit support
To:     david.abdurachmanov@gmail.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 6:49 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
> This patchset adds system call audit support on riscv (riscv32 &
> riscv64).
>
> The pachset was prepared on top of v4.19 tag.
>
> audit-userspace changes were submitted. See:
> https://github.com/linux-audit/audit-userspace/pull/73
>
> Tested the following manually:
> - auditctl (checked several different example rules from internet)
> - aulast
> - aulastlog
> - ausearch
> - ausyscall
> - aureport
> - autrace (compared some syscalls to strace: order and return
>   value/input arguments seem to be correct)
> - /proc/self/loginuid (required by DNF [package manager])
>
> I looked into audit-testsuite and with some adjustments results are:
>
> Failed 4/14 test programs. 19/88 subtests failed.

I realize that the test suite failures are likely not due to your
code, but rather shortcomings in the test suite itself, but I think it
is important to resolve these problems before we commit the kernel
changes.

You mention Fedora 29/RISCV below, is that the distro you are using
for testing?  Also, are you using a stock kernel config from the
distro or your own?

> The failing tests were due to missing CONFIG_IP_NF_MANGLE ...

Assuming a general purpose like Fedora, that seems like an odd
omission.  Any chance you can rebuild your kernel with the mangle
table?

> ... 'id -Z' not printing categories (don't know why) ...

Are you seeing the MLS/MCS sensitivity level, s0, or are you not
seeing any of the MLS/MCS fields?

> ... not having loadable kernel module support enablled ...

Much like the netfilter config, any chance you can enable this in your kernel?

> ... and syscall_socketcall not being relevant for new arches.

We will probably need to make that ABI dependent in the test suite.

> audit-testsuite with adjustments:
> https://github.com/davidlt/audit-testsuite/tree/riscv64
>
> Depends on:
> [PATCH 1/2] Move EM_RISCV into elf-em.h
> http://lists.infradead.org/pipermail/linux-riscv/2018-October/001885.html
>
> This should solve DNF issues in Fedora 29/RISCV.

-- 
paul moore
www.paul-moore.com
