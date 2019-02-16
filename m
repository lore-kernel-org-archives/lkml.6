Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764BBC10F06
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B4F222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wLAgU+7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbfBPBdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 20:33:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34437 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbfBPBc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 20:32:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so5823788plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jfToRhCVM6PkCsG8ZiGa3BK6CoGhkDKPZVlbAuwN9eQ=;
        b=wLAgU+7w2CJsE2jXukWH8xNd8hxWjaVTyP6YZ9XgVU0cMOHS2sWnIjVCBe4lw/hpYH
         /zBccqIp3nbHC8w3jvB9SYTzUVjAYGuvVgmdZNN+eq1/Zb66LASeKD95KNIdqAuipFT6
         NlKMXddC3y5usCmNFEe6WtsCrO6u9DxHI7UwARSMvLNEm3mGOUNwtFl5AKjbjSJ97Dwv
         2GcnU/zqHuvTmFHtK9BkUMbTHGGyHr7Tfr+8s5xOLf95l8A+FF87EAhLqpNsYww8/DFe
         dij8pGadKZ/QKhHeUJ9Fv6R+QUWekjK6khf6fDi5rfInBllhtW7wrd1n3wExyrVFmqyD
         vPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jfToRhCVM6PkCsG8ZiGa3BK6CoGhkDKPZVlbAuwN9eQ=;
        b=L4uF9zIk1mzeHBHom/LsJ3Pi8/Vhy0krqckqzG1lv3ZlKiUJDgyeY7ZtmfcEqCtDbA
         M8WnERYOa5iVFJwxI7lFERVs7jCk/Sq9c1v3OwaFE25dVfrHVvdobo0Wjts4IcJpvpQW
         mgFJPZf7ge2L4AZ0C1W9njFKtBCDMyaRJ3cTOetK4Hn0I/NloysBD+tm9ZgQaDmSt4VW
         Seko2uZfjfr6rXRNDu3EgKdQMC18egKkdo/oPOI4Mvfb/KSr74Tm/pNkpbtbZSlDc1FW
         hWkNE8+iEbU1p5P2SnGQsSHjaFgIaDRwPyYw4XCrTsWNbYSyoFpY4k1cKsQQFXG7JxEX
         q4wg==
X-Gm-Message-State: AHQUAuY7vlMYnzBeRTiGV2Rnfyb/JW8ngxBcyB6K4dnoYetg3WpB71/g
        6rD4kRZ3GP9zr9TNTaGf5iu9lQ==
X-Google-Smtp-Source: AHgI3IYmEgLrDDUBkl9l+GA66gHcn0I/9Uyy19jW5TzKekCZ1x2+uxIojUSrb+0rk4i8bs4WDgC6LA==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr13311774plo.112.1550280779010;
        Fri, 15 Feb 2019 17:32:59 -0800 (PST)
Received: from ?IPv6:2600:1010:b061:1c16:6868:625e:8d68:5c84? ([2600:1010:b061:1c16:6868:625e:8d68:5c84])
        by smtp.gmail.com with ESMTPSA id z4sm7182172pgu.10.2019.02.15.17.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 17:32:57 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access kernel memory that can fault
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190215191949.04604191@gandalf.local.home>
Date:   Fri, 15 Feb 2019 17:32:55 -0800
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
Message-Id: <D1A39BE5-CAB2-42D1-B87B-2E21906FE5B1@amacapital.net>
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org> <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com> <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net> <20190215191949.04604191@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Feb 15, 2019, at 4:19 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Fri, 15 Feb 2019 15:49:35 -0800
> Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>> I=E2=80=99m missing most of the context here, but even probe_kernel_...()=
 is
>> unwise for a totally untrustworthy address. It could be MMIO, for
>> example.
>=20
> True, but kprobes are used like modules, and only allowed by root. They
> are used to poke literally anywhere one wants. That's the entire
> purpose of kprobes.
>=20
>>=20
>> If needed, we could come up with a safe-ish helper for tracing.  For
>> direct-map addresses, probe_kernel_...() is probably okay.  Same for
>> the current stack. Otherwise we could walk the page tables and check
>> that the address is cacheable, I suppose, although this is slightly
>> dubious if we don=E2=80=99t also check MTRRs. We could also check that th=
e PA
>> is in main memory, I suppose, although this may have unfortunate
>> interactions with the MCE code.
>=20
> I added you just because I wanted help getting the change log correct,
> as that's what Linus was complaining about. I kept using "kernel
> address" when the sample bug used for the patch was really a
> non-canonical address (as Linus said, it's just garbage. Neither kernel
> or user space). But I pointed out that this can also bug if the
> address is canonical and in the kernel address space. The old code
> didn't complain about non-canonical or kernel address faulting before
> commit 9da3f2b7405, which only talks about kernel address space
> faulting (which is why I only mentioned that in my messages).
>=20
> Would changing all the mention of "kernel address" to "non user space"
> be accurate?
>=20

I think =E2=80=9Ckernel address=E2=80=9D is right. It=E2=80=99s illegal to a=
ccess anything that isn=E2=80=99t known to be a valid kernel address while i=
n KERNEL_DS.

The old __copy seems likely to have always been a bit bogus.

BTW, what is this probe_mem_read() thing?  Some minimal inspection suggests i=
t=E2=80=99s a buggy reimplementation of probe_kernel_read().  Can you delete=
 it and just use probe_kernel_read() directly?

> For reference:
>=20
>  http://lkml.kernel.org/r/20190215174945.557218316@goodmis.org
>  http://lkml.kernel.org/r/20190215142015.860423791@goodmis.org
>=20
> -- Steve
