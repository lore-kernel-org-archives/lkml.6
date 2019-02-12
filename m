Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8920C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71DE20844
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CGu974ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfBLAJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:09:28 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43482 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfBLAJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:09:27 -0500
Received: by mail-ua1-f67.google.com with SMTP id z11so270406uaa.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/Z6SBwrxte/a4eWZAeqhxzhggVunUiGqztKV9/JXHs=;
        b=CGu974hoK3qP86sgob0OClO6eAsop4HseTV9JTbKVeiqaBLUM5o0AJ7lJeGzgm6smk
         tAlVEoo+FwIFniOTpEqDcX1lgNW9qkWl7yjBm56ZbPytAgs1hbBMF8BdYK+TZ70Tpz6Q
         nj5tq0wHe+RI5HlX2EVJoumKbZw8Ryk1ApACQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/Z6SBwrxte/a4eWZAeqhxzhggVunUiGqztKV9/JXHs=;
        b=o7MoXRNZ15ty0eDP95SH9OX5F/xM6Is9vfTNgnWdzULZIXCHekTMMk3PdqCPBBJ0qT
         GtE3K/M1Xx6ZXAnB4e6mDZx1NYZ+lbV/CCKUHg4B5lA6xoaCBOpwPiVCptCSn5rGZM/k
         FgL79oDxcMDXDkby9zqRCYlKyCYx9KzqGxnSbbzeTRhZ/CwLi57F5o+WWzB2jX1nrAiG
         hOAur5bG8IYzq2p4LDXQwgDwB9oMowjO3SRHxwfuIUgJtBIYxpAR0x72alO0BJZkZKxF
         uprBhqUCLXLeXuJ7qJ1xrJ++49sph1tS25Xe+84jk92GTk+2ergs2pFdc/UdqQljPgvX
         6biw==
X-Gm-Message-State: AHQUAub/LokyKK4tyRN9CHW65thZZCtH04jNwbnhqRjrKWc55kh970NB
        vO68KfELDnRYbe5ylZaI600l0/pwBSE=
X-Google-Smtp-Source: AHgI3IYZmG8mOx316WOxVCxNyv/oiJ9eu4n42JQ9diUHFYE77nqvQMYCefL3BrPwtfZvFgjiu72mdQ==
X-Received: by 2002:ab0:148e:: with SMTP id d14mr382297uae.23.1549930165558;
        Mon, 11 Feb 2019 16:09:25 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id i6sm1862923vkd.7.2019.02.11.16.09.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 16:09:24 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id e10so526752vsp.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:09:24 -0800 (PST)
X-Received: by 2002:a67:c00a:: with SMTP id v10mr427593vsi.66.1549930163604;
 Mon, 11 Feb 2019 16:09:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549927666.git.igor.stoppa@huawei.com>
In-Reply-To: <cover.1549927666.git.igor.stoppa@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 16:09:10 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+n3ky2dOe4F+VyneQsM4VJbGPUw+DO55NkxxPhKzKHag@mail.gmail.com>
Message-ID: <CAGXu5j+n3ky2dOe4F+VyneQsM4VJbGPUw+DO55NkxxPhKzKHag@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/12] hardening: statically allocated protected memory
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 3:28 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:
> at last I'm able to resume work on the memory protection patchset I've
> proposed some time ago. This version should address comments received so
> far and introduce support for arm64. Details below.

Cool!

> Patch-set implementing write-rare memory protection for statically
> allocated data.

It seems like this could be expanded in the future to cover dynamic
memory too (i.e. just a separate base range in the mm).

> Its purpose is to keep write protected the kernel data which is seldom
> modified, especially if altering it can be exploited during an attack.
>
> There is no read overhead, however writing requires special operations that
> are probably unsuitable for often-changing data.
> The use is opt-in, by applying the modifier __wr_after_init to a variable
> declaration.
>
> As the name implies, the write protection kicks in only after init() is
> completed; before that moment, the data is modifiable in the usual way.
>
> Current Limitations:
> * supports only data which is allocated statically, at build time.
> * supports only x86_64 and arm64;other architectures need to provide own
>   backend

It looked like only the memset() needed architecture support. Is there
a reason for not being able to implement memset() in terms of an
inefficient put_user() loop instead? That would eliminate the need for
per-arch support, yes?

> - I've added a simple example: the protection of ima_policy_flags

You'd also looked at SELinux too, yes? What other things could be
targeted for protection? (It seems we can't yet protect page tables
themselves with this...)

> - the x86_64 user space address range is double the size of the kernel
>   address space, so it's possible to randomize the beginning of the
>   mapping of the kernel address space, but on arm64 they have the same
>   size, so it's not possible to do the same

Only the wr_rare section needs mapping, though, yes?

> - I'm not sure if it's correct, since it doesn't seem to be that common in
>   kernel sources, but instead of using #defines for overriding default
>   function calls, I'm using "weak" for the default functions.

The tradition is to use #defines for easier readability, but "weak"
continues to be a thing. *shrug*

This will be a nice addition to protect more of the kernel's static
data from write-what-where attacks. :)

-- 
Kees Cook
