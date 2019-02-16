Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2E9C10F02
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C281222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="clw4aHtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfBPCOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 21:14:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46350 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731265AbfBPCOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 21:14:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so5695963pfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 18:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vxGwAtkTVlMgRJNqee8nqYyR1YhNSRjvLOqWLKjDkOY=;
        b=clw4aHtq6t64mwyl6fsPtGxDEys/d2BMJ4Bs3812AbympgqxRKwFc6Ebbr9lOfnwDe
         vRGI+lGsdbht5eLMR9zMk5oV8rcS7WgW6zWNWuLzOTm0PkclTDAD0LAh/LC2X9yDe2nf
         JnNZtW8kRapuGRzz/2CXtwjRkGJQpcBXjy3WTr+9vg5Mm7vN68g/aSFHk8VNJAmQLJat
         9wud5KiUp3uELU8DPYwWDO2bS4IfVrOCiBX/Dy2TCC85PEVT+PcUZokP9TFS5Kqpnuf1
         SjmO156N355dVDlqaEp8gJs0wXFnwOJfm+hNdBY3c4kC83zYfObA7WQtrtixBCb1JIxX
         zVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vxGwAtkTVlMgRJNqee8nqYyR1YhNSRjvLOqWLKjDkOY=;
        b=tWtZ8Lx6R8WJMlsWNqTVuvZArYCDLe4ZuK/2DuJmXwip1+PQAfN+K4RqKh1JvVkjgo
         /aJmDgEe6Cm+2qaJhbRMkAExb1pQNMNmYUXq5ZimrwUdFv/vVLvAveo/anNnjDNgbxdN
         8ogv3uC2duuXrnfb3FyNBSerRt+q2t1uU6BffM4gY2afFIdJhmlasC7JUot2DABVb/YB
         Cx+JyVeAwPAUyipIt7y7n7awbEPLyVpNc0QCiVl+IrvxS+uCyymBjFibx7/xo2tvyJeL
         Dte3Nn6ECEtmUQK3O2azOJK6w2oNB+8ssUO6e5usMKlchllGt1v72ijF8yIFWzoLxh1d
         Vjgg==
X-Gm-Message-State: AHQUAuYyFpE4rC3ueheUoCBdjfwOBDx2U+Vv8iWUi8qXJIF790eoD+wc
        E34eF7+lTVRDJLcJZeOB0lMp5g==
X-Google-Smtp-Source: AHgI3IarUHd2gRnfGNi2H414YJbCUXhIsNWzmTZt7kL/nicC746ogQprPm8UHj5rEoYYM0hhb3RBgA==
X-Received: by 2002:a63:9751:: with SMTP id d17mr8201837pgo.392.1550283263603;
        Fri, 15 Feb 2019 18:14:23 -0800 (PST)
Received: from ?IPv6:2601:642:c400:7877:cc9b:b6f4:78c:813a? ([2601:642:c400:7877:cc9b:b6f4:78c:813a])
        by smtp.gmail.com with ESMTPSA id 184sm11109067pfe.106.2019.02.15.18.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 18:14:22 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access kernel memory that can fault
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190215210801.7f8c94cf@gandalf.local.home>
Date:   Fri, 15 Feb 2019 18:14:21 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B52384E-5C02-4279-9111-34881BA3204E@amacapital.net>
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org> <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com> <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net> <20190215191949.04604191@gandalf.local.home> <D1A39BE5-CAB2-42D1-B87B-2E21906FE5B1@amacapital.net> <20190215210801.7f8c94cf@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 15, 2019, at 6:08 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Fri, 15 Feb 2019 17:32:55 -0800
> Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>>> I added you just because I wanted help getting the change log correct,
>>> as that's what Linus was complaining about. I kept using "kernel
>>> address" when the sample bug used for the patch was really a
>>> non-canonical address (as Linus said, it's just garbage. Neither kernel
>>> or user space). But I pointed out that this can also bug if the
>>> address is canonical and in the kernel address space. The old code
>>> didn't complain about non-canonical or kernel address faulting before
>>> commit 9da3f2b7405, which only talks about kernel address space
>>> faulting (which is why I only mentioned that in my messages).
>>>=20
>>> Would changing all the mention of "kernel address" to "non user space"
>>> be accurate?
>>>=20
>>=20
>> I think =E2=80=9Ckernel address=E2=80=9D is right. It=E2=80=99s illegal t=
o access anything that isn=E2=80=99t known to be a valid kernel address whil=
e in KERNEL_DS.
>=20
> But an non-canonical address is not a "kernel address", and that will
> cause a bug too.

Indeed. A non-canonical address is not known to be a valid kernel address.  I=
 stand by my slightly pedantic statement :)

> This patch came about because it was changed that if
> we do a uaccess on something other than a user space address and take a
> fault (either because it was a non-canonical address, or a kernel
> address), we BUG! Where before that one patch, it would just return a
> fault.
>=20
>>=20
>> The old __copy seems likely to have always been a bit bogus.
>>=20
>> BTW, what is this probe_mem_read() thing?  Some minimal inspection sugges=
ts it=E2=80=99s a buggy reimplementation of probe_kernel_read().  Can you de=
lete it and just use probe_kernel_read() directly?
>=20
> Well, the issue is that we have trace_probe_tmpl.h in that same
> directory, which does the work for kprobes and uprobes. The
> trace_kprobes.c defines all the functions for handling kprobes, and
> trace_uprobes.c does all the handling of uprobes, then they include
> trace_probe_tmpl.h which does the bulk of the work.
>=20
> In the uprobes case, we have:
>=20
> static nokprobe_inline int
> probe_mem_read(void *dest, void *src, size_t size)
> {
>    void __user *vaddr =3D (void __force __user *)src;
>=20
>    return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
> }
>=20
> Because that is adding probes on userspace code.
>=20
>=20

Can the kprobe case call probe_kernel_read?  Maybe it does already?=
