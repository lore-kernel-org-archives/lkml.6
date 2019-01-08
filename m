Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD5AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F462146F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RINc9Z/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfAHXbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:31:06 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43895 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAHXbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:31:05 -0500
Received: by mail-ua1-f68.google.com with SMTP id z11so1842946uaa.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fj1hGcIq46+n7srV6RvX7Dt1TPMiykx9jEzwUwjBvIY=;
        b=RINc9Z/oBU9n/IiWeg9VoFbkVbXqBq4w0FD27eLdMWabbZLjrmSBNFOsGpEFa8A/bR
         oYiqTw2sln/Iowse0uRNjuG2y4+5aTOizsgcRPXrqzqsZY6a6Z+un43x6oNHNJO1rgLh
         z61iNZSHdc4T96fhOcPNU3UmZiId8PLEGRMso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fj1hGcIq46+n7srV6RvX7Dt1TPMiykx9jEzwUwjBvIY=;
        b=rINDWisjt1j+cxTh1LycQ84Oj+5SQnvWAr/lfvCgY4qkknC/gR3tVLZ2TMednkGbTc
         4/qY+9P04CuPng0G3OkdMkgmpe0d+Lko4ikEtY09Se6kkcBNItqnqQ8lI/brEWNFK4wW
         UpONGfYF3mKEdjV1OOLJAATQrxTrQJeQDMRWH8BEt6lZfhJLmBgcw7MZbyNsbeq8/ICZ
         rqqtBQoa+eX2SfZTI5hha1eDF9We8uvkIafz3o+mu7KpmMbA7fhvEyKAvwDUmx3BNqVv
         CjHsUC9MTiO2kppr7IkOo+qXXlEY4BS8DXLYqJImMB29g5E0bolSOPcBXAzgGkhckyQx
         EMVw==
X-Gm-Message-State: AJcUukc0ukoKp4Wr43sS+u3vnqmYwqs0tNmD+VZ5Xp0czz4Wk1mxuuAd
        RzXb+5QKfAqqZC9776fUDvh3F0b3N5Q=
X-Google-Smtp-Source: ALg8bN5StJbk4dC+Jp+R3c1/4drZi1zS9LltDw+kRU2kB0zLFi14KkgvSZgKMF48DxU3wWQ9atOfKw==
X-Received: by 2002:ab0:1393:: with SMTP id m19mr1323419uae.75.1546990263112;
        Tue, 08 Jan 2019 15:31:03 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id q193sm23541023vsd.0.2019.01.08.15.31.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:31:01 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id s184so1276353vkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:31:01 -0800 (PST)
X-Received: by 2002:a1f:3d10:: with SMTP id k16mr1401233vka.13.1546990261237;
 Tue, 08 Jan 2019 15:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20181212081712.32347-1-mic@digikod.net> <20181212081712.32347-4-mic@digikod.net>
 <CAG48ez3SAW8EyaJ9T1U3qPoRhYwe4CCyL9bAxuc3GxjrXipi-A@mail.gmail.com>
 <f13bf750-f418-343c-baa6-9eee6e0f5e19@ssi.gouv.fr> <CAG48ez00CpXOOJPLgpQd_e0gG2KgYb1p8bwssA8FDOugHTxRAA@mail.gmail.com>
 <0f7d39f8-035b-8566-94c9-ea836b280e24@ssi.gouv.fr>
In-Reply-To: <0f7d39f8-035b-8566-94c9-ea836b280e24@ssi.gouv.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 15:30:49 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKHPE6WfbXpiwzm=vRbgJ-rCePxsrYmVzZ1+RURp-6nJg@mail.gmail.com>
Message-ID: <CAGXu5jKHPE6WfbXpiwzm=vRbgJ-rCePxsrYmVzZ1+RURp-6nJg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/5] Yama: Enforces noexec mounts or file
 executability through O_MAYEXEC
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>
Cc:     Jann Horn <jannh@google.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        philippe.trebuchet@ssi.gouv.fr, Shuah Khan <shuah@kernel.org>,
        thibaut.sautereau@ssi.gouv.fr, vincent.strubel@ssi.gouv.fr,
        Perez Yves-Alexis <yves-alexis.perez@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 5:29 AM Micka=C3=ABl Sala=C3=BCn
<mickael.salaun@ssi.gouv.fr> wrote:
>
>
> On 03/01/2019 12:17, Jann Horn wrote:
> > On Thu, Dec 13, 2018 at 3:49 PM Micka=C3=ABl Sala=C3=BCn
> > <mickael.salaun@ssi.gouv.fr> wrote:
> >> On 12/12/2018 18:09, Jann Horn wrote:
> >>> On Wed, Dec 12, 2018 at 9:18 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod=
.net> wrote:
> >>>> Enable to either propagate the mount options from the underlying VFS
> >>>> mount to prevent execution, or to propagate the file execute permiss=
ion.
> >>>> This may allow a script interpreter to check execution permissions
> >>>> before reading commands from a file.
> >>>>
> >>>> The main goal is to be able to protect the kernel by restricting
> >>>> arbitrary syscalls that an attacker could perform with a crafted bin=
ary
> >>>> or certain script languages.  It also improves multilevel isolation
> >>>> by reducing the ability of an attacker to use side channels with
> >>>> specific code.  These restrictions can natively be enforced for ELF
> >>>> binaries (with the noexec mount option) but require this kernel
> >>>> extension to properly handle scripts (e.g., Python, Perl).

I like this idea, but I think it shouldn't live in Yama (since it is
currently intended to be a ptrace-policy-only LSM). It was
_originally_ designed to do various DAC improvements, but the
agreement was that those should live directly in the VFS instead (i.e.
the symlink, hardlink and now fifo and regular file defenses).

This should likely go in similarly. (But if not, it could also be its own L=
SM.)

--=20
Kees Cook
