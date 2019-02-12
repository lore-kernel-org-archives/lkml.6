Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F78C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8DC217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UO4cG8cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfBLArL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:47:11 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41624 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfBLArL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:47:11 -0500
Received: by mail-vs1-f68.google.com with SMTP id i64so540508vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1NgC8GXGyioSAhYQLIf5mJA4+toxCV5RE8n2dMeuvY=;
        b=UO4cG8clCIKQDK9/zmKwPZ8QIQZgcYQggmkiSOyvw22UGFAcR3kWcR6xbmQW9KMZeU
         D2dRym+fyDyZKSpGlJFk5Mu+zKSZXOKtzAwPx4ioyemVdvOIh0l9fUKc6FTZbcUgk2Up
         9ETqSmjk+xFILiwWDtUQRCPRRgTFWy/tcMKE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1NgC8GXGyioSAhYQLIf5mJA4+toxCV5RE8n2dMeuvY=;
        b=mZbAudjBLVyF/g0pMy9bql3hNUyTBxXbOqEIlJo82/Wl1N8VjCldmGmR1NvmikzDW0
         NPoX2H7KBCmsrhHT23C9vBlqshQi1bUy8WCWmihbkGcPdBoh7w7b8s3/VbtreX/5uglM
         PfH63p81ri/O+4qSP9tLVy8/ujeF2solX+i0BiL1I5VsDi6t1mC5iEnoTVYeKvYNOsw+
         Cm5hpw4zyamIXdvwsDj6DwEO/B1tBJYn7+hRZHycUbf2bACnTeiVNi1SyBzttXfBRxe0
         7LXYZ33CgkCsWdyFpqztZPvtUT3MJPNuQ/mOPw/daHSzlHpCEA1Ae0A7KshN3rPiE4fL
         gaJA==
X-Gm-Message-State: AHQUAuaEAPyrYg+nSSPotmAu0H2/AgJzJ+UW9ccmYUx3MK3i2Dqdmb7t
        AcO3rKYI8aebJRYSdUKn0sQnH9BctUM=
X-Google-Smtp-Source: AHgI3IaT04gjqjJ0KJE/bn6roBIcrs1dSR+nXk9jvX+NXsnquHHpdpTt2ijxTO50vH1g3qjMeEzwvA==
X-Received: by 2002:a67:d601:: with SMTP id n1mr472893vsj.208.1549932429522;
        Mon, 11 Feb 2019 16:47:09 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a68sm11898356vsd.24.2019.02.11.16.47.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 16:47:08 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id v26so308520uap.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:47:08 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr450189uac.122.1549932428183;
 Mon, 11 Feb 2019 16:47:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549927666.git.igor.stoppa@huawei.com> <CAGXu5j+n3ky2dOe4F+VyneQsM4VJbGPUw+DO55NkxxPhKzKHag@mail.gmail.com>
 <25bf3c63-c54c-f7ea-bec1-996a2c05d997@gmail.com>
In-Reply-To: <25bf3c63-c54c-f7ea-bec1-996a2c05d997@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 16:46:56 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLqmYRUVLb7-jPsN4onO5UNH+D6qOF=9TOiVjJa-=DnZQ@mail.gmail.com>
Message-ID: <CAGXu5jLqmYRUVLb7-jPsN4onO5UNH+D6qOF=9TOiVjJa-=DnZQ@mail.gmail.com>
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

On Mon, Feb 11, 2019 at 4:37 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
>
>
> On 12/02/2019 02:09, Kees Cook wrote:
> > On Mon, Feb 11, 2019 at 3:28 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:
> > It looked like only the memset() needed architecture support. Is there
> > a reason for not being able to implement memset() in terms of an
> > inefficient put_user() loop instead? That would eliminate the need for
> > per-arch support, yes?
>
> So far, yes, however from previous discussion about power arch, I
> understood this implementation would not be so easy to adapt.
> Lacking other examples where the extra mapping could be used, I did not
> want to add code without a use case.
>
> Probably both arm and x86 32 bit could do, but I would like to first get
> to the bitter end with memory protection (the other 2 thirds).
>
> Mostly, I hated having just one arch and I also really wanted to have arm64.

Right, I meant, if you implemented the _memset() case with put_user()
in this version, you could drop the arch-specific _memset() and shrink
the patch series. Then you could also enable this across all the
architectures in one patch. (Would you even need the Kconfig patches,
i.e. won't this "Just Work" on everything with an MMU?)

-- 
Kees Cook
