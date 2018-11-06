Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B62AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A3320830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rscT6LB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A3320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeKGFIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:08:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32848 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeKGFIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:08:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id q1so12622153otk.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O+AiFU8J1g1KbhypTcqxELFzGTEO5Pl3HZSpe23ehhM=;
        b=rscT6LB2tFCca1i99jYKMH0T6O2yK1cNyEz1bBJBEdZNozwb2xXFt6ulTpfi7YG/Ae
         E0n/FnVnqlGDOdgB/8bsi7Oz0iJqjLbVwbwEjU+0vFWt0DLbddUhyA9t5s84sCS4pUf+
         D7M8IRxpBS4Rmne984XJCpzYsgXfAv7jBbwH3/G4GgNGWOW3WPsKUdv1eKVhspbd/gP8
         8mT2kCc6KWdGypILK6dyPBMCLhYEfUtfagAQchlkXqZch98SUa/iilfg2IayEeVYv1gI
         VXtqUMIb2fVEzNH4a2ouJ+E2WjGe26sAdi+ayCNHrFXlcwpVOzrRRe6hO0CpKQiXbmZs
         NcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O+AiFU8J1g1KbhypTcqxELFzGTEO5Pl3HZSpe23ehhM=;
        b=O2IipcsCAoFznyhhkjqA4l6IHf26mtYEhR69s5tovWmChC+DC8GF50EXzGQs+rZTd7
         0UVXV9KbXPiKO9rUNtpZQDALVqXbh88zmg3uYawp2frA41V4UnNRpEnFLW4573EsgB2x
         MERgWAMLGjyL875HTXiS56IhuAgUNUE0CNreaOpwPkV4l+70IAcK0d4VSIP6iCycGkMw
         tnob9PV2wiecJuR1QGWTqL+8XK9sgLbHzWy/Pjl+yP4uyszsHtyju1965s5g9a8rqnqP
         fVwmd9gKViq/boeTegpbQ5UOkqc0nC2BsFIpnYIkp/OBd0DAO/BWgJypdNLb4xX7jgcj
         KthA==
X-Gm-Message-State: AGRZ1gL1MR066eEERva/mYbqIhmq2JQkWRZqS9fdxXI4XjWxbYnQ68hu
        qwPaYc2InapwAx2BbG/Jm6xd5Q+y6qYvy+57Tt/iZA==
X-Google-Smtp-Source: AJdET5egiHLD7uXKGjjLIEenp4WhNKMIDeFiddT+CUkTy60rxL/r2f/Yhf+blae8wE6iBgBC0BGpopMa8ZLOCA6GB/U=
X-Received: by 2002:a9d:17e8:: with SMTP id j95mr15641635otj.292.1541533284224;
 Tue, 06 Nov 2018 11:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20181010161430.11633-1-laurent@vivier.eu> <20181010161430.11633-2-laurent@vivier.eu>
 <20181016162245.GA7697@gmail.com> <0fb09ce6-e006-31a2-1f32-f3f6eda44504@vivier.eu>
 <4a1ec0cf-dce7-4193-6946-d46d63398c2d@vivier.eu>
In-Reply-To: <4a1ec0cf-dce7-4193-6946-d46d63398c2d@vivier.eu>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 6 Nov 2018 20:40:57 +0100
Message-ID: <CAG48ez1wz6tt2ZLBWgbkspirHYRUN7bAPmqf21jXgBx09G1K2A@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        containers@lists.linux-foundation.org, dima@arista.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 9:51 AM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 24/10/2018 =C3=A0 19:15, Laurent Vivier a =C3=A9crit :
> > On 16/10/2018 17:22, Andrei Vagin wrote:
> >> On Wed, Oct 10, 2018 at 06:14:30PM +0200, Laurent Vivier wrote:
> >>> This patch allows to have a different binfmt_misc configuration
> >>> for each new user namespace. By default, the binfmt_misc configuratio=
n
> >>> is the one of the previous level, but if the binfmt_misc filesystem i=
s
> >>> mounted in the new namespace a new empty binfmt instance is created a=
nd
> >>> used in this namespace.
> >>>
> >>> For instance, using "unshare" we can start a chroot of another
> >>> architecture and configure the binfmt_misc interpreter without being =
root
> >>> to run the binaries in this chroot.
> >>>
> >>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >>
> >> Acked-by: Andrei Vagin <avagin@gmail.com>
> >>
> >> Thanks,
> >> Andrei
> >>
> >
> > I don't konw who is the maintainer for this part,

I think Andrew Morton is the right maintainer here.

> > but is there any
> > chance to have this merged in 4.20?
> >
>
> I'd really want to have this merged.
>
> I have some real use cases for this:
>
> 1- to allow a non root user to run a container (with "unshare" for
> instance) with its own binfmt_misc configuration. For instance, like we
> provide a disk image and ask an ordinary user to run it with his
> favorite VM hypervisor, we can provide a tar.gz containing our own
> interpreter and just ask him to unshare+chroot to the exploded file tree,
>
> 2- to allow to run automatic tests of an interpreter on a machine
> without having to change the global configuration of the system. I have
> in mind to add some tests in Avocado to automatically test
> qemu-linux-user in containers, so the interpreter path can depend on the
> build path and possibly run them concurrently,
>
> 3- to select an interpreter by container. For instance, on the
> qemu-devel mailing list, we have a waiting patch to add the bFLT
> interpreter binfmt_misc configuration, but the bFLT doesn't provide the
> CPU type in magic/mask. So it would be interesting to be able to select
> also a bFLT interpreter by container, as we know the CPU architecture we
> have in each chroot/container,
>
> 4- another example to select an interpreter by container is qemu-mips
> and qemu-misn32 share the same magic/mask because only the kernel API
> changes, so we can't configure both on the system (but I agree it's a
> QEMU bug: they should be merged and the kernel API be selected at runtime=
).
