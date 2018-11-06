Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6318CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D052085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="XjCsPlZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D052085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbeKFXxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:53:51 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:41463 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388768AbeKFXxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:53:51 -0500
Received: by mail-oi1-f181.google.com with SMTP id g188-v6so4872353oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kK5/zVUwoCHsYlYMFvMD/JwcX+BXJYzbLab1XIXgz+s=;
        b=XjCsPlZdsJB/o1NlKkLx0BW74Ot3+vZndGh9u0VnR2++NS7dOOsbqbtMRozVAhGH9I
         tSXZJQgEMX3Gk7wLFm3fmkuAfZ3IuWCoBjVEWmgCIQGHfgYM6suggvjejDjvk0KXuFqd
         MATEY09HGdbYwK9OCLaxNXob7Hy+B6AmaRURU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kK5/zVUwoCHsYlYMFvMD/JwcX+BXJYzbLab1XIXgz+s=;
        b=l+lCdaQ/VTcgmVQYuERmFvDqmwF6Q3p7BmyUO3kh7TVdp3vhXeDOCxn0pix3yTBTpt
         Lu6eLVCiPiHYPgcxh7nvnQNKaY8A9PRLSWs8adR33HumSIkf2rEAxYwBg7YuZ9kJormb
         QDgcSjfsBez/p1/wyuu39aRiGGSc9JeuOgyTqFBvmw72VbqVJ8TRXsqdN8tljWx6mPJF
         CCrMiNeaX2VTigFkQPv2WvlnW5J6Iat0rCRgq3XRnWbT3guovW/8vb/1wh68rADOQNtn
         RpM1M1KfGs+UKSd/xx9Ce1UzzrTdC+A2qWoCG84l3CFXjllXSwds6gbIjQes7MZSEAMr
         oIfQ==
X-Gm-Message-State: AGRZ1gIdC/LFIADdueC1BPkX/gqM6TT3uUYMNBl3kslF637/YKloyQeC
        6+LRSUqt7QOUKYWOD9PM0qL24wh4ayCFw+Tu
X-Google-Smtp-Source: AJdET5dYM+Y7wCHJKvInJ+E5Tm/fh7td07QCqyEaQi9ZWqY8SSFy0bV13FkWxTMAC7dNgQNcC3vBcw==
X-Received: by 2002:aca:dfc3:: with SMTP id w186-v6mr16265767oig.331.1541514501527;
        Tue, 06 Nov 2018 06:28:21 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id y31sm14421759oty.78.2018.11.06.06.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 06:28:21 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id j202-v6so10826241oih.10;
        Tue, 06 Nov 2018 06:28:20 -0800 (PST)
X-Received: by 2002:aca:4dd4:: with SMTP id a203-v6mr16013357oib.168.1541514500076;
 Tue, 06 Nov 2018 06:28:20 -0800 (PST)
MIME-Version: 1.0
References: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
 <20181105165544.5215-3-starnight@g.ncu.edu.tw> <20181105.101610.1437737564548154497.davem@davemloft.net>
In-Reply-To: <20181105.101610.1437737564548154497.davem@davemloft.net>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Tue, 6 Nov 2018 22:28:18 +0800
X-Gmail-Original-Message-ID: <CAC=mGzh3KH5H6zAOb_rZvjkYycGcJ=99bJreRzKtgVGS==K8qA@mail.gmail.com>
Message-ID: <CAC=mGzh3KH5H6zAOb_rZvjkYycGcJ=99bJreRzKtgVGS==K8qA@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] net: lorawan: Add LoRaWAN socket module
To:     "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> =E6=96=BC 2018=E5=B9=B411=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> Date: Tue,  6 Nov 2018 00:55:40 +0800
>
> > +static inline struct lrw_mac_cb * mac_cb(struct sk_buff *skb)
>
> "mac_cb()" is pretty generic for a name, and leads to namespace pollution=
,
> please use lrw_mac_cb() or similar.
>
> > +static inline struct dgram_sock *
> > +dgram_sk(const struct sock *sk)
> > +{
> > +     return container_of(sk, struct dgram_sock, sk);
> > +}
> > +
> > +static inline struct net_device *
> > +lrw_get_dev_by_addr(struct net *net, u32 devaddr)
>
> Never use inline for functions in a foo.c file, let the compiler decide.
>
> > +{
> > +     struct net_device *ndev =3D NULL;
> > +     __be32 be_addr =3D cpu_to_be32(devaddr);
>
> Always order local variables from longest to shortest line.
>
> > +static int
> > +dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > +           int noblock, int flags, int *addr_len)
> > +{
> > +     struct sk_buff *skb;
> > +     size_t copied =3D 0;
> > +     DECLARE_SOCKADDR(struct sockaddr_lorawan *, saddr, msg->msg_name)=
;
> > +     int err;
>
> Likewise.
>
> I'm not going to point out every single place where you have made these
> two errors.
>
> Please audit your entire submission and fix the problems wherever they
> occur.

Thanks for the reviewing.  I will check the submission again.

Jian-Hong Pan
