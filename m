Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC7CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294D0217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e/nvkB+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfAYXZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:25:42 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:40165 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYXZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:25:42 -0500
Received: by mail-lj1-f182.google.com with SMTP id n18-v6so9730534lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 15:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2SZbTLvXQijwBMiXBUemkl5PUHsVUr/gBxU88AM26Q=;
        b=e/nvkB+cWNeBzoFBiUJypV4cgxoqcuyH6LkwTDhZDx4WpuspUlOzsNTaplv09fIKxP
         0bxrhfoj0uaBgSPEBnp2gHW2a3/+ICOZnbZb1aGhEj/bSTgOV1ec4zgx/OHv7AgcXvQq
         Tje8201Y0HtIa9QbgdqqUVfWsPAxSeMUMPNEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2SZbTLvXQijwBMiXBUemkl5PUHsVUr/gBxU88AM26Q=;
        b=VYVwMAmlYpc8NXNrgK1pCmXSUxo1Xt/x3nb3kslpwDjqbnM5plBdhxXRbPGh8AFzQj
         IXId/rl7E44eseAYRSmj/5K87fvI/iy9sOeyuJmooKdNOnFwbCShw3Td1llNmf8jaBbb
         M9RXSN4rReUD3h595ftVas41IK9QueWjb7ZYDPaEv+vPh852YJShZiO0t+4+SbMMgMV9
         nND+iC3iZopV6c2PZWXLfh6Q/croeg/vdgDkuzFw6gJvjaZLTTaoFJgJhB2SQy77p6F+
         J96BSn3zx+xjQmD0yTVUL3SfeC/Awd4mN2yYFz6hG1XSbg2Ogj3maP79YE6cmxdPERSP
         s5kw==
X-Gm-Message-State: AJcUukdUK/uYEB6nSktLMlTxK7vvDHePhfxbgyC5TKTBeMu2W5GQipCa
        gwO1QhYmxkfgCkFYZTW/meLiHD0y1tjLqA==
X-Google-Smtp-Source: ALg8bN4pwSKNooakVzF+Znz8S7etJigav9Bnyr4VXFHtN+hSkI54WSFDmFxSU42QBhhI3GiTRflMwg==
X-Received: by 2002:a2e:8719:: with SMTP id m25-v6mr11255837lji.121.1548458740183;
        Fri, 25 Jan 2019 15:25:40 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id f8sm1933820lfe.72.2019.01.25.15.25.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:25:39 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id k15-v6so9719205ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 15:25:39 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr11089914ljh.174.1548458738885;
 Fri, 25 Jan 2019 15:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20190125.115827.1407196401514719611.davem@davemloft.net> <CAHk-=whgEt4tUaF=6FstoETUKRzCD5WFzWvE_w9Jb7Kp1rbUFg@mail.gmail.com>
In-Reply-To: <CAHk-=whgEt4tUaF=6FstoETUKRzCD5WFzWvE_w9Jb7Kp1rbUFg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Jan 2019 13:25:22 -1000
X-Gmail-Original-Message-ID: <CAHk-=whFc9FmZe-eO39nRKcXLYqO=Ni-p1ht=tNFtYdtCw07UQ@mail.gmail.com>
Message-ID: <CAHk-=whFc9FmZe-eO39nRKcXLYqO=Ni-p1ht=tNFtYdtCw07UQ@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>,
        Tomer Tayar <tomer.tayar@cavium.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 1:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> You don't even *mention*  the changes to the qlogic driver that are
> completely new and over a thousand lines.

They look like completely new error handling and recovery code. Very
much new development, not fixes.

And this is not some new driver that is getting some fixups from being
merged, the code has been without any of this fundamentally new error
recovery for at least three years.

In other words: no. This is not a "fix". This is fundamental new
development that is larger than all the changes that came in this
merge window.

No way is this appropriate. Get rid of it.

                Linus
