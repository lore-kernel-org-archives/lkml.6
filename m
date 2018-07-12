Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AF4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828B820870
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="kpBA11Hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828B820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbeGLUhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:37:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32886 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732338AbeGLUhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:37:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so21250917pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KKi9ibaSBSFqvBgFnTSgYRNGh2AvXN5hwmg72Nxd7hU=;
        b=kpBA11Hncq9pTaKePX8ENHda/gKF14dHUy0hY5iytDTsQu3ezf9O73/hAWtxzoKkY7
         9N/W4mY74JEddqTTayiAV5QUNiFqtAs15XDcITJoY5nkJ4oHnbB1iPzPQ/o4cYFMHlZl
         XR/KrwbQqnfhnAQeuh91uZPzNMfvIxhx2noYlKLzxRVJDcijrvU6lRbYqeV7u7x0Yrak
         9o0JYAOSXYr9/fBMPMaQ2XB+zJAe5oczYnu3E7uvP2iFgtS9D6km1YAMc5fIuG3UtHYC
         Ap61+0su+Un41Yj3SLOrdAmPSXqr2nGE4k2i2y/5r06bsaa7+ZIok70+34eaPhbL45bd
         nwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KKi9ibaSBSFqvBgFnTSgYRNGh2AvXN5hwmg72Nxd7hU=;
        b=EnXL/I2gZSkQVKQoatHm996xfhOT39m4YbwV3dj6wgKv2RBUAFa/Hr/whPPBZcsoin
         Uv+9US9kGgJE15yAAz5U+VrFEt4nh9EmQOzj0OFw/1xiVEEe5PF3fzoXyRXswpSOrD8X
         tyD1sgRnnNvI22GcJ7rdxP+tufRy9azfb4sdBExb+TEqKXG2UnJruB1iFQtDFdX++c/N
         Uwgqk/+TNA2IEe5uAnYQasdCMAT9a8V0FwzbD5MrEh2j+U4ddsku+AOF6GJ7eXxLDNof
         WZxzdy23gVeXFPH2nJ2IoDKjPAbc5t0VlF/sATl9hVejXnQ95Wdi0MnFg+yAO/k6Aq2r
         ry2w==
X-Gm-Message-State: AOUpUlH9OJ5zlRyG5g2DTNOS3LmC37DvlO+MGwJIuEW9xBSs496gywsj
        RZPE9YcOdPIZy3y3ITK9pN9FLQ==
X-Google-Smtp-Source: AAOMgpetBDFXFLwSF3dg9mSLGk4UpCou8qAZGShrK8HFdNf61aArSCAgwajZQziUGjuY8e69vIP1Wg==
X-Received: by 2002:a62:4add:: with SMTP id c90-v6mr3932974pfj.23.1531427161177;
        Thu, 12 Jul 2018 13:26:01 -0700 (PDT)
Received: from ?IPv6:2600:1011:b01e:e4d1:54df:ba07:cac1:aeab? ([2600:1011:b01e:e4d1:54df:ba07:cac1:aeab])
        by smtp.gmail.com with ESMTPSA id c9-v6sm31851578pgp.38.2018.07.12.13.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:26:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <16699.1531426991@warthog.procyon.org.uk>
Date:   Thu, 12 Jul 2018 13:25:58 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <874BAC3E-390F-458F-A33F-986E89BB2987@amacapital.net>
References: <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <7002.1531407244@warthog.procyon.org.uk> <16699.1531426991@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2018, at 1:23 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>=20
>> Don't play games with override_creds. It's wrong.
>>=20
>> You have to use file->f_creds - no games, no garbage.
>=20
> You missed the point.
>=20

>=20
> My suggestion was to use override_creds() to impose the appropriate creds a=
t
> the top, be that file->f_creds or fs_context->creds (they would be the sam=
e in
> any case).

I think it should be a new syscall and use current=E2=80=99s creds. No overr=
ide needed.


> Btw, do we protect sysfs, debugfs, tracefs, procfs, etc. writes against
> splice?  Some of the things in debugfs are really icky, allowing you to mu=
ck
> directly with hardware.
>=20

We try. It has been a perennial source of severe bugs.

This is part of why I=E2=80=99d like to see splice() be an opt in. Also, it=E2=
=80=99s a major step toward getting rid of set_fs().=
