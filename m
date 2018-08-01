Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B4CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1C520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWz/2OjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1C520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbeHAJld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:41:33 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35366 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbeHAJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:41:33 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so7752922oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xYnkeUElkhxdaWZJddBYUPpse1oG6z/9BY3e5KpySqU=;
        b=vWz/2OjDFXxDaFA0h+iSUluc0mQExA+oOmDTZ1FFW6bjW5wDyxfAGvF+wqxa+dwp0C
         F+P1ODkcdnrLEoB0Z9JyO0g7JeILl5TvvXPVbjwiMTzqCbPkCbpkrux2BA+ZcnMvLVkZ
         HZhvF3dPM1UtNp8wnDnTeQTAJ/yaadu7A7nUTRMbWfApCiKS6vufRX/Q4KlHIHsKaHWh
         tg9jDUqE6Wa+bhybShAE2THF+9x8atJQGK8JoAEO1uhqdmB9cIxKrmvbDTGetLOu6a+V
         0qkhEG5Befa9n9QDuUWm83tye9RK5VUutpT6atpNeg1vGwFpCSBkEbywrvByhNG8i87Q
         xitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xYnkeUElkhxdaWZJddBYUPpse1oG6z/9BY3e5KpySqU=;
        b=KGmAsNAhB0/0G2YRJ8V4ux0KMqi+uzW/KGqWFIgZyyb69YmSH5TpKLqHj87Vv0AP7H
         tAakOOKc3D79kdlR3Fk8kXl3CJgt4YCEybq0+nN37FUwaE//JvAdsSZTTlbaIc1aaGMx
         2ifvzb71UrxDtwlyh883Znk2qaSeUCAke1qgGwv+ND4fY2JLsExFORi26CNCqnTtK5Wi
         EzH2/5rh4Pr2YBd23xlJ+J28stjY5gIoGj7yzLZFRnF7XlQ64I+LkrabuXP0PQi4GjDj
         4DpEXeErpTkYv5pTyZWdIRM/P5QTAkR6hyd7fY9+TxeEcq09c48QFroDNn5eRS0T4Qkt
         3zJQ==
X-Gm-Message-State: AOUpUlEUvvFDvMELQv5/Q542h+AVLodv+AliXdnw6A7lH7G6DtDrspSt
        Ot2GEMY1vgdOCudOBDhi+lZwr3Zz5vEnIx4vF03IbA==
X-Google-Smtp-Source: AAOMgpeO/22/EbQVFqrdRsPNAeW03Pw/1ve8t2vLcnDZKpoGWiv6kS37Y2q1mfZ5x9sghgl0x9cc6oiXPRMXrucHFr0=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr2225505oiy.219.1533110227836;
 Wed, 01 Aug 2018 00:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180730075241.24002-1-j@bitron.ch> <CAG48ez1izZ+W_cPdNp3SOUwb_8YzwAYdSA6d=eqvaF=5+GKemA@mail.gmail.com>
 <625ede00c618783eb610b7109c35c514e8faa793.camel@bitron.ch>
In-Reply-To: <625ede00c618783eb610b7109c35c514e8faa793.camel@bitron.ch>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 1 Aug 2018 09:56:41 +0200
Message-ID: <CAG48ez3uu9-QXOnAu0-3-3PcE=kn=uaWqv4A_uc666XqkisJrw@mail.gmail.com>
Subject: Re: [PATCH] prctl: add PR_[GS]ET_KILLABLE
To:     j@bitron.ch
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 9:44 AM J=C3=BCrg Billeter <j@bitron.ch> wrote:
>
> On Tue, 2018-07-31 at 18:26 +0200, Jann Horn wrote:
> > On Mon, Jul 30, 2018 at 10:01 AM J=C3=BCrg Billeter <j@bitron.ch> wrote=
:
> >
> > [...]
> > > diff --git a/kernel/sys.c b/kernel/sys.c
> > > index 38509dc1f77b..264de630d548 100644
> > > --- a/kernel/sys.c
> > > +++ b/kernel/sys.c
> >
> > [...]
> > > +       case PR_SET_KILLABLE:
> > > +               if (arg2 !=3D 1 || arg3 || arg4 || arg5)
> > > +                       return -EINVAL;
> > > +               me->signal->flags &=3D ~SIGNAL_UNKILLABLE;
> > > +               break;
> >
> > I don't have an opinion on this patchset otherwise, but should this
> > prctl maybe block PR_SET_KILLABLE if you're actually the real init
> > process? This seems like it could potentially lead to weird things.
>
> While I don't expect global init to use this, I can't think of a good
> reason to disallow it in the kernel. Do you have specific concerns or
> is the code in kernel/fork.c the only reason?

No, I don't have any other specific concerns.

> I prefer avoiding special cases unless really required.
