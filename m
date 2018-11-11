Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB4F208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqxE64Ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB4F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeKLALn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:11:43 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43052 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeKLALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:11:43 -0500
Received: by mail-vk1-f194.google.com with SMTP id o130so1419378vke.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 06:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KrysmyYMbW4M3poQmJsdob51BBK+q0cfR1H2tPSxMxk=;
        b=UqxE64AgHl9RGpmJfyjyFyVrbLvOOpKOu4FCgQHVO4MrVth8QtdzDfLH0HJ1dkFFa4
         qo4DJUYReyqChLYZqzBozXTG13CJrRCqgYZzcPsQjxRPbI98ctXHg2C2m6FgYPCIfbaK
         D+6Lu5vs/RdqNQRIvQ5s3uCHCVJP+X0W05BM/x0tUeYVDMLhXbYwqyEw6ciWhAMTJ8zN
         mtEGTeXSjoeLMjEqcqHAkCnB+joyWlWqdzQx3Ul0zCb5zTZrf+2h9cJZS7qznAOoJyAh
         xJCp1rXqkGNXbCYMt0XdkJEoKOqZo8hqIa7o+XHM+SqVlGn9AQZpP8K7mq4CdE0rGmc5
         cbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KrysmyYMbW4M3poQmJsdob51BBK+q0cfR1H2tPSxMxk=;
        b=GWM9qOQ6r33lJF/uFKB4mencKntwFxSmByTOcxbPBvvWcqn6VKrJ8UzfW+YuPEJKQC
         pGJjsoJGLyl2Fw1y9fRpZ69uzUKG3lfNYZjmNrOaM+JRyDUFpfq94rMzwGFdGrrXEc/p
         FR/DiCUVHD2e9vO1NcvXYfUzHmRgBnkyXpBt731G39eQSYqQAflyvskZ2aQvXlMkc80V
         Rppqofu7CbJaHq6rpf5s36Rd2+E6kVfTDSIacMrd0ROejKJLrbzFoxKMThdNy5c6IXlf
         hoLZqei6hnIp5H7JCOMqszjw1D9mExzbp1KJg+3Pl2MZ6Ra2YvtZ1OownerCCPFScvQa
         lCPg==
X-Gm-Message-State: AGRZ1gKIPkZ0Qhfs+sTregMRJdJtAvhnSa4foF+3YJkGi5LdEu21Ptm+
        JL/thWstrFYcVg7jNQFYIUPJJ7RhiTboFmI7VMch4A==
X-Google-Smtp-Source: AJdET5fk0sFjKt9P2d6mnvff7/G7dZoNGznFhs6FQ8dnh4KaEIEraAmb+lb+4qi2+utK6GNrHWps6UONjVzofovpZnE=
X-Received: by 2002:a1f:7cca:: with SMTP id x193mr7063563vkc.89.1541946179923;
 Sun, 11 Nov 2018 06:22:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 11 Nov 2018 06:22:59
 -0800 (PST)
In-Reply-To: <877ehjx447.fsf@oldenburg.str.redhat.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 11 Nov 2018 06:22:59 -0800
Message-ID: <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 3:09 AM, Florian Weimer <fweimer@redhat.com> wrote:
> We had a patch for the membarrier system call, but the kernel developers
> could not tell us what the system call does in therms of the C/C++
> memory model
[snip]
> A lot of the new system calls lack clear specifications or are just
> somewhat misdesigned.  For example, pkey_alloc
[snip]
> getrandom still causes boot delays
[snip]
> For copy_file_range, we still have debates whether the system call (and
> the glibc emulation) should preserve holes or not,
[snip]

These objections illustrate my point. glibc development is not the
proper forum for raising post-hoc objections to system call design.
Withholding wrappers will not un-ship these system calls. Applications
are already using them, via syscall(2). Developers and users would be
better served by providing access to the system as it is, with
appropriate documentation caveats, than by holding out for some
alternate and more ideal set of system calls that may or may not
appear in the future. This resistance to exposing the capabilities of
the system as they are, even in flawed and warty form, is what I meant
by "misplaced idealism" in my previous message. If the kernel provides
a system call, libc should provide a C wrapper for it, even if in the
opinion of the libc maintainers, that system call is flawed.

I agree with the proposals mentioned above to split system interface
responsibility, having glibc handle higher-level concerns like stdio
while punting system call wrappers and other low-level facilities to a
kernel-provided userspace library that can move faster and more
explicitly conform to the Linux kernel's userspace ABI.
