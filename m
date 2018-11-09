Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C84BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BD62086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6ed4t+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BD62086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeKJAYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:24:07 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45626 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKJAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:24:06 -0500
Received: by mail-ua1-f65.google.com with SMTP id x3so688217ual.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g8Vc3OnZ8sUbHtK45hFGSTzAmURfa4HaGri2Atjh6TE=;
        b=X6ed4t+eayIRD2R3e8pUVVWmb9fxVvoAMxZi/bc9HQd1baYsf3mzeYGnm85FZjgbY5
         j2sGPhDy74ppbBz2tQcYjaqDTxZygjTmu5PiC9RjfTWZCXfGGKgkPpgox04NEZhG0uZH
         2n0P5N70ADAV2Z/7I1R+01NjgUwIuFgVJU7/JINU3IfcsSlXyzh1WLF4O1bdA7e7bRob
         BwOJd+Ltz9g99JUrAEm/V8Cm8JcrFyIjkVU++DhNOWzfSKF3RPJwQeMfS73C3w3nIVDb
         cba9YUwHEhHCxGPvDH9Ewecq/+FMJpEs1Af6ktYX5d57HvwFNOheEjJS9vQDGosP9Wqn
         qlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g8Vc3OnZ8sUbHtK45hFGSTzAmURfa4HaGri2Atjh6TE=;
        b=OlPjp97TY0F/kdBi65abSykOAaTz4NR5uP3DFaS/Oqy/yoreYG4fj/ukUjoPH8dbvw
         xd5F2kIO2mVm6iJDv19tGs3yvyCb101zdEhd7mziKkMxCGa70+lkk/d//GwJpESe4tQT
         eM3xiTmFdMIOTQi/rT2yKFl6nhRCxRguBWr/zwqvsWoLnf2Sto4bpj06iD7KHeQEkP+d
         BICsBP1uVKyO0/irtKFKBmf6D15QT81IghHYi9lXtx8uRoKAqAUIEpvoogZDuaWZLr39
         ERYmvr2usu936IJ3UA29BEaPHw2ZVEdYNFgKUsZX9FYarfna193qwxYkMq2NhrRTm3mv
         w30A==
X-Gm-Message-State: AGRZ1gLoLkBEc/Gv10hv93B60PyaTIkdhEd7emmAINWqzSDJGT4xFRkJ
        znOYJxg1ZVe7Ahvux/xemQTzKVWmAHaQUP/0zHHBmQ==
X-Google-Smtp-Source: AJdET5dioiS1DCRBQoQ17b559gcVgq7tuyzzIZMuFKi0Wl8kklMW1N8+DlMUcSCN9vT4NrClJvFX5XceHBp8gu5LddE=
X-Received: by 2002:ab0:714a:: with SMTP id k10mr4261714uao.45.1541774593303;
 Fri, 09 Nov 2018 06:43:13 -0800 (PST)
MIME-Version: 1.0
References: <CAEbi=3dou8JWKYq9FpRBtPKRRu4ahhsh=+kHKcF8vg5hyO2ZGQ@mail.gmail.com>
 <CAEbi=3dCGmCzM7td_-hdsgfpHOVeB_Bc_tFtvWnn1AJqzMbiUw@mail.gmail.com> <CAHk-=wgsG7vFfjMU8A3cuOq1KgH7C01tkYtUo+2=fN8qFM+9Bw@mail.gmail.com>
In-Reply-To: <CAHk-=wgsG7vFfjMU8A3cuOq1KgH7C01tkYtUo+2=fN8qFM+9Bw@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 9 Nov 2018 22:42:36 +0800
Message-ID: <CAEbi=3d8SPdBxHGushnnOiRrZXBPE+1uDyhmYg-NH=z+fs07dg@mail.gmail.com>
Subject: Re: [GIT PULL] nds32 new features and bug fix for 4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> =E6=96=BC 2018=E5=B9=B411=E6=
=9C=889=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:03=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Fri, Nov 9, 2018 at 4:01 AM Greentime Hu <green.hu@gmail.com> wrote:
> >
> > nds32 patches for 4.20
>
> Much much too late for 4.20.
>
> Send these the next merge window please.

Sorry for late.
I will send these in the next merge window.
