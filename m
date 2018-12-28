Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A325820861
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIdthdqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeL1WNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:13:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39599 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeL1WNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:13:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so10524599pgl.6;
        Fri, 28 Dec 2018 14:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jqvj+1DeJWDabLXBLqDqirjD18jg+3P9bttSNCIaMLE=;
        b=eIdthdqswQlY7IsIpkhxQNeManZfaT1/afOS49q8rwjMX34X6wPE3IyXhhaw+HwntJ
         6Dr1nk5b+S9XjTH8YPpwu/wpuhMW0ENrb6Hg5GA+r5ljNBmktzQt35qmAzSMJ0vraOFb
         F3d/25zRovDxQklN8naVyCU82IznWRgqEMWb2UlfAi65xkMcJIMazc4isfEziR6vxMDM
         MwnqSlEA/0QSCBF82SmAzMN7SdZMHFAULF8WtJGFucUOvV8owB0GoeQUU9aXQY5bHYg+
         4ypOcpaAB3hpq00oktvkWwDP2eF8898GQwAVYO4ZCCuNUXE8ITY6mjYSRzmvi9GL/iRN
         hO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Jqvj+1DeJWDabLXBLqDqirjD18jg+3P9bttSNCIaMLE=;
        b=HBD+0wYpStRz1kivgzLG6UnWFmrjb/DRMhASd+P1mkhNYycsEJzrgNOp4RZeBebQ8k
         JVXSqIRW60lKQM3V3JmOimna52Qzv9k6Cd4bG/AuGbPGZwiQaSJyjPtJeBFuMkd/h6fN
         OzMw69ZTJy+7LMzmHRznkjkorAuEj748fGk05mdIusG4QSHw1hmESd149uTWMVFE7Au7
         nUMaJGmle4opvdycXbgXh0tCqH/VavPmqGx04wuWQ90l1SFp56dWk0SyEMNav3YvVcDe
         LDyJ8NdV6z2uD0WRqtPm7SGm3CKmEjKJGMc2xn/8EbpAiVxWTEbruIx7SLd9gvpS+jfK
         deKg==
X-Gm-Message-State: AJcUukfa/Hrj6cGNHiXWRtCcR8YJjoDRCOMDsE0LwMj/lUFOuB45b8at
        t7co6TlnsVE6qUViMykNEaiEE2xNfpwzssiN
X-Google-Smtp-Source: AFSGD/XpQaRjTsj0NDPpPPi4dS69/66uynnTxiU5I/nE4i6l4QaNcxeQrTTaV83fFXKstRMQ++qoEA==
X-Received: by 2002:a62:9419:: with SMTP id m25mr31015836pfe.147.1546035192925;
        Fri, 28 Dec 2018 14:13:12 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id a17sm53170802pgm.26.2018.12.28.14.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 14:13:12 -0800 (PST)
Date:   Fri, 28 Dec 2018 12:13:08 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dledford@redhat.com, KVM list <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wei Wu <ww9210@gmail.com>, Kostya Serebryany <kcc@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Chris Mason <clm@fb.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Olof Johansson <olofj@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Tso <tytso@google.com>, Tim.Bird@sony.com,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix scan ioapic use-before-initialization
Message-ID: <20181228221308.ev2mjvnh273qcrml@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dledford@redhat.com, KVM list <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wei Wu <ww9210@gmail.com>, Kostya Serebryany <kcc@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Olof Johansson <olofj@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Tso <tytso@google.com>, Tim.Bird@sony.com
References: <1542702858-4318-1-git-send-email-wanpengli@tencent.com>
 <442fc8ca-f92c-eded-9ede-c800a03bf39a@redhat.com>
 <CACT4Y+Z_wqpUoLDdTdAoSHSXEYRR8PFpGOzLC0kS4Y52c3QmPw@mail.gmail.com>
 <CAHk-=whZ3_T9b=pac=H1tvdjgX0vjE7FDsC=LfQYDmiY5Aq_kg@mail.gmail.com>
 <CACT4Y+YRs3HLf7-0AhMPMuvHGvKHge_7R5Qo6Q9H1A2w1fQ39A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="klp2wt3olmrd5zts"
Content-Disposition: inline
In-Reply-To: <CACT4Y+YRs3HLf7-0AhMPMuvHGvKHge_7R5Qo6Q9H1A2w1fQ39A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--klp2wt3olmrd5zts
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 28, 2018 at 10:43:11AM +0100, 'Dmitry Vyukov' via syzkaller wro=
te:
> On Thu, Dec 27, 2018 at 6:00 PM Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
> > Nobody reads the kernel mailing list directly - there's just too much t=
raffic.
>=20
> As the result bug reports and patches got lots and this is bad and it
> would be useful to stop it from happening and there are known ways for
> this.

What are the "known ways"? The only effective way I can think of is to
setup personal email filters for specific topics, and while this is
useful and something I do myself, it requires a lot of up front work.

I don't think it's realistic to expect others to be doing this
instead of just subscribing to the topic lists.

--=20
Cheers,
Joey Pabalinas

--klp2wt3olmrd5zts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwmn/MACgkQ2rGdfm9D
tVLkzA/+O25nI9SAivFgYGJ8KMeWXjSfR01gG5E33Lx5x29cW61N285C5YF5fFhH
aDEZtIjrzoofkXQ7T3FkT2NNA+C19wMiZxJi7upKXlC5LqXIzLML+n4qkpx3AKPh
y9ZvaTvv0977O/ilj56O1Qzrf4o+SRw9Vk+EKcgY8ENwa3jeESOjNqOVofa0C/JX
Ul7vyYXfEQgSHyFddBsoBnBLZtUPd5TiNF2akuVEUsU5PZqJcGVcDnlH389HKHSC
yngeiUrlTenGQ601tWMu/VBT66aVVKG8NA9+8xmGNq28LBS3/4tdvnxdfdJxndiT
F4wIuz3Qdi0dJq3BXPVIJxmOFACsmD3/fHWPoZ5bLd656zXzcY4lwsoo7Q+VbF5l
ZTjsbbosrTee7Bhedz5UCipdTiHTO0+2UysF8/6TzQIlP9nyKjDVJGd4yPqxcp5f
QtY1hxK+7tO61xF12H5Zybvkse+kiGl/jqoPRpZgm263RSGf4k44A+VY5ATO2Clf
8OpLNNm+KQ/2nQyoJzr0mlG3NebMgoCHJrbKWvsVwnIDY0h1c6+k2f11I9fZl/Dv
2QhdZvEalS4I0Bj4CirxvY3FJyPBWUiQU9tNT1acScXudJG3Mz9+pGOUwCSqw+im
KVc5+lma65kfRZPYwXYE0m4jwGQdDCj4yq/CjI7En0a4RrKBkRk=
=/Cvv
-----END PGP SIGNATURE-----

--klp2wt3olmrd5zts--
