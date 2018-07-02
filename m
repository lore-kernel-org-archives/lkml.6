Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A5BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D4225562
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wp4iwkAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D4225562
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeGBQb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:31:27 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35359 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbeGBQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:31:22 -0400
Received: by mail-it0-f65.google.com with SMTP id l16-v6so12789891ita.0;
        Mon, 02 Jul 2018 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wu/o0PLM6VfDEHOCjseLHZTHp7YRRNRAyuA2VxwYPDo=;
        b=Wp4iwkAYtuI0csUWwEuyy8elgLdGOR02Y/GoviVI/cEgNc6rxUM6+pCCHZW/gTZA+B
         Zv0ZLBHq5RbfSCUwPbFcncsEjqUQ5BhBCfD4fDAAWUdFHUB1ei416V899XOMM/6ZiXPU
         NbQUnwfE/wui4/KqXOTdN/VIehDX9X2g+YM/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wu/o0PLM6VfDEHOCjseLHZTHp7YRRNRAyuA2VxwYPDo=;
        b=bWg6zmMYiL6q1aSnqCx2JvTyQxAchv0E7ge+fYzZktObGuQxXWHopRjEd2WWcjh77D
         5RbiyEOM1TZcvKrZuEKivX5FSHYitp8vsV6BlssMNg/6FQx8tg3QIi+hxeAHRpwiz/5S
         AVms93nETgFdHvyI+Z0XTaSVI+m0rBwOFvWkpVaBnVpXZ2eV2Pm2FXfXfmm7v0VXkavE
         npJz0S03R0N/VUrWmvFYXbYqYJv2P/xginnq7hnwx9zD14wHpIhLWxBaf+MKUSzjLDtw
         IW5fGOMCcNQVEUWY63mq4b405TiNYBf6u2JHrwYL8REtSI0umlyEnL7ft4yUhwb7oL5a
         Q66Q==
X-Gm-Message-State: APt69E3UUoq9YKYgs9TdyTPrf6A3OvM5RuP3JJQhS+Bjye74yCcAPzyK
        Guwgi3MHkRL+9lpLmNYZ+MqNLjaAGjoWDKR1qbs=
X-Google-Smtp-Source: AAOMgpcSzjXk6gngMBCVGDQgzX8rv5ObIFlf0QakYruvUHbbm0y3aVqS7L9sWmw2Fmb6mTFreLeseBfCn8VaVL1Mcko=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr1770711itm.113.1530549081386;
 Mon, 02 Jul 2018 09:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws> <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
 <20180622001632.GI79890@dtor-ws> <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
 <20180701234419.GA250349@dtor-ws> <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
 <A5DA555C-6131-4F7B-82F2-A06C12E23CAF@gmail.com> <87sh5196pk.fsf@purkki.adurom.net>
In-Reply-To: <87sh5196pk.fsf@purkki.adurom.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 09:31:10 -0700
Message-ID: <CA+55aFxU853g1dgsQ682R+EeZcm7=tTEmPsmuZ0z=apr24eyEA@mail.gmail.com>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, kt.liao@emc.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        ulrik.debie-os@e2big.org, phoenix@emc.com.tw,
        aaron.ma@canonical.com, josh.chen@emc.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:13 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> FWIW I use patchwork.kernel.org and I don't have any issues with UTF-8
> characters in the From header. For example, here's one patch which I
> recently applied:
>
> https://git.kernel.org/linus/88001968245c

Well, that one actually has at least two reasons why it might work well:

 - Rafa=C5=82 sends his patches with an explicit "From:" line in the body
of the email itself (probably because he has had problems with email
headers in the past).  So his body itself has

    From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

 - Also, even ignoring that, he actually uses utf-8 in the headers
too, so his "From" header line looks like

    From:   =3D?UTF-8?q?Rafa=3DC5=3D82=3D20Mi=3DC5=3D82ecki?=3D <zajec5@gma=
il.com>

so it is already in UTF-8, it just is rfc2047-encoded.

I suspect it's that first reason that patchwork.kernel.org gets it
right, but it *migth* be the fact that the problematic email is using
the old 'big5'  encoding:

    From:   =3D?big5?B?ufmxUrph?=3D <kt.liao@emc.com.tw>

anyway, it does look like a newer version of patchwork will fix this.

           Linus
