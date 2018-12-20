Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83111C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5528A218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osmqip4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbeLTRYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:24:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34577 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeLTRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:24:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so2428100ede.1;
        Thu, 20 Dec 2018 09:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRjAxROorEvxBprVf5PNP6Ke4Ss59kCkaqw/MUZv1ek=;
        b=Osmqip4cgQYe5cqYF9/RJIivquVdeSNuHMaPwDVtKP/04V/ot/SfU44n/+wRRHYPWq
         oKphEqbm8gs/Ao1ISywv+Oog+YB21Ia3Dzyy7z+eUKN6wClqeT1GQFN5C3Kvkxtpy76f
         HSLDbz2LVua1iGbzKCFV0ZRR20ybW7yPB3pSVwCyZO+cn5evn54cVc+Xt/zfhmOJlP1q
         qSyKlFh0SgV7xH/ZLDnSxoFiTAkdBSD5vSYeCuaKvKgnb1yrybHWTQxLtoqQZUJifQPx
         le618jX9MTSYF2hQWeHJebwLuess382G/dApj+1dwSSlmzAqb6E0ew8nKH/I0qcBUUqX
         elsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRjAxROorEvxBprVf5PNP6Ke4Ss59kCkaqw/MUZv1ek=;
        b=FfNcLPAvPp9pazedupF68aL4n8JE1Bw3JeZtXB9rpAtnjiiKCrNG8743eNhGU77rSH
         eiF106jZkJ26FaqQi5ZiIZQ2zM/g/8F6eQtsq5q7tHIqIJ9B3IxDBr9fh0SJAEWFXCi9
         MK5fVhm67aAj6aVgLaiJVS3q7WWQZVnB1rGOpTegQqmplU/FW2p9KIreibXPYXW/q4dx
         Wz6CuOqUFTOpBEosMqrpgs7ZTjnrJXRBSGV+PVnfkizdE4fy4YH5epTwp7U+oaWB1PQb
         ZJUFKRs92mAKrwIT0gUohw/LlnjjZCMoTZqWz60T4RwQzWIv0Ia7h7CKYIBTOPnQjLp5
         pIFw==
X-Gm-Message-State: AA+aEWbmHWc9N2fWrlWyv3inIoxsb99p2F13IVmWh4FSCZwERtsR51vf
        hLQrWu3SIW3k2ExvMcbdVVDdrsfKTSMasYCkOLM=
X-Google-Smtp-Source: AFSGD/V7mMrYsXMYYwxYePg+tJBd/y9FflnSyK9Qb2OEuFEIFgDs+a2VKMMWhrvJehZreougFZCFsehFz53pbKYpe+o=
X-Received: by 2002:a50:ac81:: with SMTP id x1mr24922547edc.71.1545326655844;
 Thu, 20 Dec 2018 09:24:15 -0800 (PST)
MIME-Version: 1.0
References: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com>
 <20181220091207.GA25942@splinter> <0c5a8fa8-efb3-71f2-0da9-6fc0f133cdf9@de.ibm.com>
 <20181220141752.GB861@splinter>
In-Reply-To: <20181220141752.GB861@splinter>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 20 Dec 2018 12:23:39 -0500
Message-ID: <CAF=yD-KBkX3NxtDt6mv-PoujFfdtJJ66XsnGzx-KQop6EU6LRw@mail.gmail.com>
Subject: Re: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764
 __skb_flow_dissect
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Willem de Bruijn <willemb@google.com>,
        Michael S Tsirkin <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:17 AM Ido Schimmel <idosch@idosch.org> wrote:
>
> On Thu, Dec 20, 2018 at 03:09:22PM +0100, Christian Borntraeger wrote:
> > On 20.12.2018 10:12, Ido Schimmel wrote:
> > > +Willem
> > >
> > > On Thu, Dec 20, 2018 at 08:45:40AM +0100, Christian Borntraeger wrote:
> > >> Folks,
> > >>
> > >> I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
> > >> Maybe someone has a quick idea.
> > >>
> > >> [85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318
> > >
> > > I managed to trigger this warning as well the other day, but from a
> > > different call path:
> >
> > FWIW, it also seems to happen on 4.20-rc1. 4.19.0 seems fine. bisect seem to have failed so
> > my reproducer is not reliable.
>
> Yes, it is caused by commit d0e13a1488ad ("flow_dissector: lookup netns
> by skb->sk if skb->dev is NULL")
>
> $ git tag --contains d0e13a1488ad
> v4.20-rc1
> v4.20-rc2
> v4.20-rc3
> v4.20-rc4
> v4.20-rc5
> v4.20-rc6

That tap_get_user_xdp path is also new for 4.20-rc1:

    commit 0efac27791ee068075d80f07c55a229b1335ce12
    tap: accept an array of XDP buffs through sendmsg()

    $ git describe --contains 0efac27791ee
    v4.20-rc1~14^2~382^2~1

In v4.19 and before all packets went through tap_get_user.
