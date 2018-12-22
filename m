Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D4BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132662146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObbaId99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404907AbeLVRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:02:50 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40372 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbeLVRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:02:45 -0500
Received: by mail-io1-f65.google.com with SMTP id a11so3658614ioq.7;
        Sat, 22 Dec 2018 09:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmYO1463TLeixuheCGgpPDevsGlONa9PrJNb5gHcVyU=;
        b=ObbaId997euv174p9Vbkk+ty/85lXUDGt25qjwyw/q1RVIYimuk/4q3SYM03gDo5cL
         eQ6nDwM+ce+uYMSTzqQUwOtot+5xcBg9w5VsaGTKrhgYlfuyZ8aLh1oV/cRyt/2QeB/B
         EXgjDrvBE2IKZ+MQjnBVBokM1eWB2U0XdPKkdEJcAYV+GGoeX4jFcfQbf/gTRPzPS5ma
         ZZWMThpL6uFi9AyTK+2bwIxwdHZSs7qDeiZ59ErGwopC7z2wu/ZGRRLMDQ+tcB453C0q
         2VVFdAcdU80SjVz6u9mbGkUwZqpNH2jEPP562RhhHuqKNa4dbh+ytdWVvTMbc1xwd/vj
         RpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmYO1463TLeixuheCGgpPDevsGlONa9PrJNb5gHcVyU=;
        b=HtmIoldL7ZyvbNpDtD44QLRlR44PD2aFRglX9xYeyvD189HsVpRFUzE7L7RcN7IGrs
         xOUJuW6Gj0F+/afEDCN45qyQIOK0jZbE3nAXGOXT0+zXYn0Tj2Ov0xEDvua0dCgJCdnD
         +VidKPHcaKf1XMHPvmLU3sgTwKUymbWaBWXocQesr4CnOW15KWlZXfDQJyvnsgS5bLgI
         SSiVGL6HVJzWsc9cY37WfxxeRZWROkAGwFi1O0nO861PAYjRyenlBvwUHFThiR/ZiuWx
         RMdKZl3XZSyKWPaSnBljPbRm7hkLza5mGOlW1secg3EIbNX+faKEqmY74sLfG9uhmbff
         Gpew==
X-Gm-Message-State: AJcUukdG7ZauEgZqYRD+7aFHL99eQEH3WgvzveosMCU+OExt5tJ4sxho
        2BLUnDY3F1v2CIdSYu01FinC/OslTpU565xgDOw=
X-Google-Smtp-Source: ALg8bN6m+gkkKxzQ+La2apYItzXVRsdSsGt5frMOceUstkL/ifbjiwUbq2hQ6xBvpb0QTfkIJOW4Je0W+11+VIgCGFM=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr5163857ioa.34.1545496506543;
 Sat, 22 Dec 2018 08:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20181221202733.19627-1-deepa.kernel@gmail.com> <CAK8P3a3LivERgLTTmS0A35CoebS3n+cNWNXkoYKGam+fVR-Dxg@mail.gmail.com>
In-Reply-To: <CAK8P3a3LivERgLTTmS0A35CoebS3n+cNWNXkoYKGam+fVR-Dxg@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 22 Dec 2018 08:34:55 -0800
Message-ID: <CABeXuvrdz2UwGBj1+gNhnwcy-uG_dKezM_fPqU99rKuQFsyHJw@mail.gmail.com>
Subject: Re: [PATCH] sock: Make sock->sk_tstamp thread-safe
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Are we actually worried about concurrent writers here? I thought the
> only problem was a race between writer and reader, which would mean
> that we could solve it using only a seqcount_t which is cheaper to
> update than a seqlock_t.

I considered using just the seqcount_t. But, I think we do care about
concurrent writers here.
A couple of scenarios I can think of:

1. When you have 2 concurrent recvmsg() calls on a socket, and they
both try to update sk_tstamp.
2. If a socket has don't have one of the SO_TIMESTAMP/NS options set
and you have a first recvmsg and a concurrent ioctl call on the
socket.

These are corner cases and if we don't care aout these then we can use
just the sequence counters.

I have missed out tstamp update in the sunrcpc code. If everyone is ok
with this approach, I will add it in when I post an update

-Deepa
