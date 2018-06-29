Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F50EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A1428041
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNr+QTTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A1428041
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936526AbeF2PUr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:20:47 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39985 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeF2PUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:20:44 -0400
Received: by mail-io0-f194.google.com with SMTP id t135-v6so8782792iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aohNzgrJXBl0ZatvDWqPC2Ou5sYGXyt0QkujjAcpxVQ=;
        b=nNr+QTTPy8TPD0niDZbYy3WzUs+SAf596/xMsRbeKjKXDYzQz+QfZV/I3AsBe0g412
         66I+nmir7/uQD3X8gMUwyOHqN10UiTSzp5vptrJ1kjYpy+0c0vFBkQZZx/0bjFot36GC
         7fGmo4DcjUR0pgI2+NLLYhWWfBTH/cCVKqkOZzE6Mu5Pv4gsSPbMhQzbEvS/XDEqT1Ie
         xRdXDXoRHITpZKaamfspNLSmQyef/J0MKinljGwZq2KSDmtl95tuEn++utaFDUl+el6L
         YJRbGwtxUs0gfJX0ErzvmWyZdnurfATWScqVIMmHCtChAYgzZ1lSCFv0GCAMVIIB3e/7
         Htaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aohNzgrJXBl0ZatvDWqPC2Ou5sYGXyt0QkujjAcpxVQ=;
        b=pi+RAOQWD5mckdpm+UuA8VNfTpYsvFNXTkcQACX9gyd+4HFjECsjmioXi+Jt701zx9
         ZIWn+Y7LhBwlkfNn9n1k+NMnvz44pyEyEzfZztGQkTt8/KAKWef+HuB4mCKXso53MPHG
         eiGpP90fGUjvAp2Xn4J1cH8mjsVu+hvF+rYuDVZBa3aA5f5qhC4zjW5NO+Z3yeK2JF3S
         KqFQLSwq04Qkkvw2FycHj4FVa9MumcfrHgprS991PmqIqJ2UbkGJoKxphdKIifyO8is0
         ou5lycHdY6nBb6qGthZfVhz3QPx5+lyJAix1UM2AWRQSW10MUj8dNmNftgz4BnX1RzjY
         d4eA==
X-Gm-Message-State: APt69E3S/HeiR+1h+LKavnQlYQW/2S8K4sRi+QJXkvWtaZ1aHXqprBTh
        o0OKpi89MGbqyWCBlLPqKbojPfIWBwfXbAyYMGZn0g==
X-Google-Smtp-Source: AAOMgpfVJBpHT3x2a1tyCt8DVA3YdC8P50PSL8+Qzt7uUbYO4n4OKR1oN7jA0B//wZVBRrp73gjMty3tUUEee1yrEaA=
X-Received: by 2002:a6b:5002:: with SMTP id e2-v6mr13070944iob.31.1530285643558;
 Fri, 29 Jun 2018 08:20:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:9082:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 08:20:42
 -0700 (PDT)
In-Reply-To: <CAAeHK+x4jaN9w8O+hYJ0835Ln=rQ8VT1=ZrKLNsBOT92+iOwdQ@mail.gmail.com>
References: <cover.1529507994.git.andreyknvl@google.com> <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com> <CAAeHK+x4jaN9w8O+hYJ0835Ln=rQ8VT1=ZrKLNsBOT92+iOwdQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 29 Jun 2018 17:20:42 +0200
Message-ID: <CAAeHK+yP=oS6EP4g0jqvLSp_=n_Go8WyhJDS-BegJFCWFbAUiw@mail.gmail.com>
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

On Fri, Jun 29, 2018 at 5:19 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> a bunch of compat
> a bunch of ioctl that use ptr to stored ints
>
> ipc/shm.c:1355
> ipc/shm.c:1566
>
> mm/process_vm_access.c:178:20
> mm/process_vm_access.c:180:19
> substraction => harmless
>
> mm/process_vm_access.c:221:4
> ?
>
> mm/memory.c:4679:14
> should be __user pointer
>
> fs/fuse/file.c:1256:9
> ?
>
> kernel/kthread.c:73:9
> ?
>
> mm/migrate.c:1586:10
> mm/migrate.c:1660:24
>
> lib/iov_iter.c
> ???
>
> kernel/futex.c:502
> uses user addr as key
>
> kernel/futex.c:730
> gup, fixed
>
> lib/strncpy_from_user.c:110:13
> fixed?
>
> lib/strnlen_user.c:112
> fixed?
>
> fs/readdir.c:369
> ???

Started looking at the results and accidentally posted my notes.
Ignore this for now, will post when done.
