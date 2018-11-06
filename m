Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE41C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DE52086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euAJIe9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DE52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeKGGwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:52:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45949 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeKGGwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:52:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id g10so12851466otl.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 13:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Fuve3pXzZ2+HQbAzrYsq43N10dVgg4dVpwsKvp6UQw=;
        b=euAJIe9MTPuRD+2ksa5bVtfQuxADI2Z26U8PWtLUrLf2U/JHm5kW+XBbn1oCo7aw8I
         ECiyQmNeY+xy3keAQlz0lzh1mAvZl92pshsQ1X5UJszj0uz+hphkpP1Tr63lGguW5cYP
         VdmzIKFg4X58fQI+icUh1eYjnSwZ3K4zGbtkcIQz56NlffDyProJW1X7of0L8nCmn3oY
         hPC0b2bYgHp8DnIHLdpfiTZecvT8Z/MWbCsmjFsG9c20ZxrCZSstlG2+6Jak4Xz1X/aH
         NPwTKPuajXemwQ2Y14Z8ORi46Mxgpoe3/E2voYlbp+hR9XjSRxpiReZLLArc+dBYkjk2
         a6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Fuve3pXzZ2+HQbAzrYsq43N10dVgg4dVpwsKvp6UQw=;
        b=PGJgJ0/zktMaOdtVq1guoiEwshObqGGfoy1XEajG8RIucqMaeDcsgpiRkMDUN8k7GV
         +XSPHpeT/TueVLiTyFDLH/W/7LMruCxeHZPejHM9QXhhBSyWzJseeIZrAf8KVIGzDjCv
         gjNhEfPNLw/yvB54SDdXknVqt0W6qjARjj1wmsJI/u2r5svNF95bK6r9T3TKwz/bta2g
         w5KCDH+/fgjAd3KF45a9AkFNhqnJwSwWqscjccXEM/x60ohxaXT3+qt4LMEIvzmivNbf
         RHEiVjfrjUs3OIj7jioqQ3ZypNqwatn8373tIhU4W3sQWfyNqbgxNb5QgvsRCRe2D4KJ
         RAQA==
X-Gm-Message-State: AGRZ1gLRQ+U3K2pBg2ZB5cEPdEaRj9l7Nl7L5HC6G1WQCOA1oq6B7T2w
        cyZutPbYSJ/B146c5GUCbTDdtd5+HaOT9VK3lo8=
X-Google-Smtp-Source: AJdET5fO81U8WFWLm1XEpwNJ0RkiqNhf+rJDVjIfTFMv13mlhdRVywiILE82AydBZGGXYh3Cwj29So4+EZxDVRgxcZc=
X-Received: by 2002:a9d:dc3:: with SMTP id 61mr8355261ots.345.1541539532360;
 Tue, 06 Nov 2018 13:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20181029104854.17432-1-david.abdurachmanov@gmail.com> <CAHC9VhSaGo0BmX5AsTcnppiVz2Lz8BFkjRA0jg_uuPix3Ziiog@mail.gmail.com>
In-Reply-To: <CAHC9VhSaGo0BmX5AsTcnppiVz2Lz8BFkjRA0jg_uuPix3Ziiog@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Tue, 6 Nov 2018 22:25:20 +0100
Message-ID: <CAEn-LTqQgQkA1XyihEg0MpADLPQADf3Ej2noUp29UtbcEaf0RA@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: add audit support
To:     Paul Moore <paul@paul-moore.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 9:06 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Oct 29, 2018 at 6:49 AM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
> > This patchset adds system call audit support on riscv (riscv32 &
> > riscv64).
> >
> > The pachset was prepared on top of v4.19 tag.
> >
> > audit-userspace changes were submitted. See:
> > https://github.com/linux-audit/audit-userspace/pull/73
> >
> > Tested the following manually:
> > - auditctl (checked several different example rules from internet)
> > - aulast
> > - aulastlog
> > - ausearch
> > - ausyscall
> > - aureport
> > - autrace (compared some syscalls to strace: order and return
> >   value/input arguments seem to be correct)
> > - /proc/self/loginuid (required by DNF [package manager])
> >
> > I looked into audit-testsuite and with some adjustments results are:
> >
> > Failed 4/14 test programs. 19/88 subtests failed.
>
> I realize that the test suite failures are likely not due to your
> code, but rather shortcomings in the test suite itself, but I think it
> is important to resolve these problems before we commit the kernel
> changes.
>
> You mention Fedora 29/RISCV below, is that the distro you are using
> for testing?  Also, are you using a stock kernel config from the
> distro or your own?
>
> > The failing tests were due to missing CONFIG_IP_NF_MANGLE ...
>
> Assuming a general purpose like Fedora, that seems like an odd
> omission.  Any chance you can rebuild your kernel with the mangle
> table?

When we build Fedora, the kernel is not built in a standard way. It's only
build statically and contains minimal setup. We also don't do loadable
kernel modules, because there wasn't support for it months ago. It's
not tested yet by us.

I did rebuild with CONFIG_IP_NF_MANGLE, but I think, there was more
stuff missing. Have to look again.

I am experimenting on building kernel in normal Fedora way, but there
are some issues right now. It also takes 12-24 hours for a single attempt.

>
> > ... 'id -Z' not printing categories (don't know why) ...
>
> Are you seeing the MLS/MCS sensitivity level, s0, or are you not
> seeing any of the MLS/MCS fields?

I boot my VM "selinux=1 enforcing=0".

[root@fedora-riscv ~]# semanage login -l

Login Name           SELinux User         MLS/MCS Range        Service

__default__          unconfined_u         s0-s0:c0.c1023       *
root                 unconfined_u         s0-s0:c0.c1023       *
[root@fedora-riscv ~]# id -Z
unconfined_u:unconfined_r:unconfined_t:s0

>
> > ... not having loadable kernel module support enablled ...
>
> Much like the netfilter config, any chance you can enable this in your kernel?

Experimenting, not sure if it works yet.

>
> > ... and syscall_socketcall not being relevant for new arches.
>
> We will probably need to make that ABI dependent in the test suite.
>
> > audit-testsuite with adjustments:
> > https://github.com/davidlt/audit-testsuite/tree/riscv64
> >
> > Depends on:
> > [PATCH 1/2] Move EM_RISCV into elf-em.h
> > http://lists.infradead.org/pipermail/linux-riscv/2018-October/001885.html
> >
> > This should solve DNF issues in Fedora 29/RISCV.
>
> --
> paul moore
> www.paul-moore.com
