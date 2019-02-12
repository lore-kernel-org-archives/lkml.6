Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F37C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86568214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kTOcJz2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBLB0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:26:23 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33916 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLB0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:26:23 -0500
Received: by mail-ua1-f67.google.com with SMTP id x15so342050uaq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 17:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjplqgKWE3Hxn72OdOjfAgA2B9kW+HOJdNRvmQcqtBU=;
        b=kTOcJz2ZF73lKlesFnKYD0iEmI0plfu6EuXCcoJ6kJKDZPfjpJGUSCp3DuhQ6OELVg
         5HhafM/ks7gDn02lvD5VacZAtMTrAu5New5ehqSGe1dBNc+0ZaBWBxgdfn5RgePWCruq
         I4VRoypIEvm6GzpzCYX3K/JnpeK7DLkQ7GF4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjplqgKWE3Hxn72OdOjfAgA2B9kW+HOJdNRvmQcqtBU=;
        b=fzxzgtaqw1aEl9PBsFnCPn2veoXFhU2b4MiNKDjkGBh1gICkPwujwPU3H94XNb8zqt
         pz5LL+MH0NGUYtLhuHGpkS9r9XOzHJyuXISgt1DEX8UNpaWNJAsvuu1Xl3Y1ArAH9ZKz
         7hCXUbLxlMR5ssQtYzqJXgM6KLYpSvRf2VD9v5Kq5sSkKe7CrUzF3x29Hwj3gKGhLD3u
         FzS5C473cFadV/wtyB5RZUFsfdkorJjpimTmp7dgouLitREdFbTPrL/bilklNWAHQjc7
         zyBTk0SHLwhC6OZ0xrMFQ1ZcQZY0t/7kXDFyN3xfn4BIWXkVzz5ycBeb37WMG/UB/9K+
         41hQ==
X-Gm-Message-State: AHQUAuZaG1D8yv10l7mgM++U0GJNkqsMUQLtnRWQXproiCLWS4NdEEuC
        NXB56CIh0gYALnHskSE7HecEht7QZAg=
X-Google-Smtp-Source: AHgI3IbqN6E1ouUUkfeADO9uQLvL8LBt2e/b9pdr9jdDdh22Vl6EoXXKLmrkYIO0OFbBk6absmGJew==
X-Received: by 2002:ab0:69ca:: with SMTP id u10mr470563uaq.57.1549934781065;
        Mon, 11 Feb 2019 17:26:21 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id q199sm2848914vke.23.2019.02.11.17.26.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 17:26:19 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id o130so220897vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 17:26:19 -0800 (PST)
X-Received: by 2002:a1f:4982:: with SMTP id w124mr512476vka.4.1549934779282;
 Mon, 11 Feb 2019 17:26:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549927666.git.igor.stoppa@huawei.com> <CAGXu5j+n3ky2dOe4F+VyneQsM4VJbGPUw+DO55NkxxPhKzKHag@mail.gmail.com>
 <25bf3c63-c54c-f7ea-bec1-996a2c05d997@gmail.com> <CAGXu5jLqmYRUVLb7-jPsN4onO5UNH+D6qOF=9TOiVjJa-=DnZQ@mail.gmail.com>
 <CAH2bzCRZ5xYOT0R8piqZx4mSGj1_8fNG=Ce4UU8i6F7mYD9m9Q@mail.gmail.com>
In-Reply-To: <CAH2bzCRZ5xYOT0R8piqZx4mSGj1_8fNG=Ce4UU8i6F7mYD9m9Q@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 17:26:06 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLRJZuWjnwEuK=7AMeCrj-eioVGksPL9dE9pbzHM=+Rmg@mail.gmail.com>
Message-ID: <CAGXu5jLRJZuWjnwEuK=7AMeCrj-eioVGksPL9dE9pbzHM=+Rmg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/12] hardening: statically allocated protected memory
To:     "igor.stoppa@gmail.com" <igor.stoppa@gmail.com>
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

On Mon, Feb 11, 2019 at 5:08 PM igor.stoppa@gmail.com
<igor.stoppa@gmail.com> wrote:
>
>
>
> On Tue, 12 Feb 2019, 4.47 Kees Cook <keescook@chromium.org wrote:
>>
>> On Mon, Feb 11, 2019 at 4:37 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>> >
>> >
>> >
>> > On 12/02/2019 02:09, Kees Cook wrote:
>> > > On Mon, Feb 11, 2019 at 3:28 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>> > > It looked like only the memset() needed architecture support. Is there
>> > > a reason for not being able to implement memset() in terms of an
>> > > inefficient put_user() loop instead? That would eliminate the need for
>> > > per-arch support, yes?
>> >
>> > So far, yes, however from previous discussion about power arch, I
>> > understood this implementation would not be so easy to adapt.
>> > Lacking other examples where the extra mapping could be used, I did not
>> > want to add code without a use case.
>> >
>> > Probably both arm and x86 32 bit could do, but I would like to first get
>> > to the bitter end with memory protection (the other 2 thirds).
>> >
>> > Mostly, I hated having just one arch and I also really wanted to have arm64.
>>
>> Right, I meant, if you implemented the _memset() case with put_user()
>> in this version, you could drop the arch-specific _memset() and shrink
>> the patch series. Then you could also enable this across all the
>> architectures in one patch. (Would you even need the Kconfig patches,
>> i.e. won't this "Just Work" on everything with an MMU?)
>
>
> I had similar thoughts, but this answer [1] deflated my hopes (if I understood it correctly).
> It seems that each arch needs to be massaged in separately.

True, but I think x86_64, x86, arm64, and arm will all be "normal".
power may be that way too, but they always surprise me. :)

Anyway, series looks good, but since nothing uses _memset(), it might
make sense to leave it out and put all the arch-enabling into a single
patch to cover the 4 archs above, in an effort to make the series even
smaller.

-- 
Kees Cook
