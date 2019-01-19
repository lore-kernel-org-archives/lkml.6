Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16C7C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FD92086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb225b79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfASSXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:23:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43542 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfASSXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:23:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so14275757lji.10;
        Sat, 19 Jan 2019 10:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8P9Z5K7dai1JIkcTeJv8ZjOQyR1cmQi2SKstA+YXos0=;
        b=Sb225b79lvsQVt13aI7wFSxrUtUPFMrpW3BNvZb2gIrhpWrR9eC9D5Iyga9rrDI0aJ
         f0lOF/D7gkronqOOrq2zZUTU+Ip/wby8MSxvRidl1NPpmN4g0+2Q2/0IT9PQC7dHpwA/
         TyxiQphPpQR7MXAyCoOqMgKkYrnQJEH+1moUuQpYZOauZAg6YzOfPRhXE6rHxb9ZKVvM
         D9xuSLnQgsbSkGG5qkV+P7iGdYY2JZ6dS+flwEEPomOvwAqXa1tuPIPWUm43V3Q09Xgz
         9PJKVKdMg5I+OC6J8+jVM1tIZH0XqeN/KblY7nCps0cQe2O6P5QSOwWedLCQRZKmrHNR
         DzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8P9Z5K7dai1JIkcTeJv8ZjOQyR1cmQi2SKstA+YXos0=;
        b=ZrdaJKzFTQMEzpwfgHMB/Iro+tKuxiA8MhuQaspUhTL19cnTTWDjCaeT9pTl5MKsXz
         MP2KUqMKUGuwPBbQNl96tHBLdkA3HHAOaLe4kCFRgoVIHcjAwAIWJxkTFx80NC1yo4jW
         XUJ80L5NDAu1nccHU2CUjOLA4hBdEqA9DZhRjct/GclpCmtFXbcBfwbChVBeC7I5MFl6
         u2H2MbkoWAksG5ZbhSSUoqIRiVLz/XY6uxXdjhuLPsOXhf2JVG6Y6UudW8mlaj0njhBQ
         ghVeEqV2yNyLF2o9cehRzXhVBu+Jw5/vHhgwB6hvAjWEf9812BEKVWJCDW3qj2OO+hoQ
         TW/Q==
X-Gm-Message-State: AJcUukchsPwaBhHGBtselvN80wXtnvE3jmfovc4z5PK1RZPfJ8Ucmgsq
        VbW6ocLs/Di96upZLZKYy6JUU7usCd/3POB1WK1ehIflnz8=
X-Google-Smtp-Source: ALg8bN6XQZEniOTZbT6PaX7P8Daw3BB8oxypbdOrH+lAZxW4e/jxmqHYkoGNBjQRlpMmdBK3xlDpRJB/r3nls60560E=
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr16156905ljh.139.1547922181349;
 Sat, 19 Jan 2019 10:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20181128140852.178260-1-liuxiaozhou@bytedance.com>
 <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
 <20181129021635.rzmehzzfgt2jvpgi@bytedancedeMacBook-Air.local>
 <CANiq72=uwbHqPB_1b7q+dD7FaqZ+HOmOvXMPX3d=z7-xqzwFzQ@mail.gmail.com>
 <20181206123926.q5gd5u62vg2u7s5w@bytedancedeMacBook-Air.local> <20181206124957.GA22907@kroah.com>
In-Reply-To: <20181206124957.GA22907@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Jan 2019 19:22:50 +0100
Message-ID: <CANiq72kg+LvComNFkdXVjfE+ZQQt2bqABVH8Q_fSRzXMDJ7Nzw@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: move kernel-only attributes into __KERNEL__
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xiaozhou Liu <lxz1983@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Nick, Xiaozhou,

On Thu, Dec 6, 2018 at 1:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> If something is fixed in Linus's tree for this, I want to take it into
> the 4.19-stable tree as well.

This ended up in Linus' tree before the holidays, i.e. 4.20 has it,
see commit 71391bdd2e9a ("include/linux/compiler_types.h: don't
pollute userspace with macro definitions").

In case you want to still backport this to 4.19: you can't cherry-pick
it without conflicts because some stuff was moved around due to the
Compiler Attributes patch series (which also went in with 4.20 too),
but you can move the macros like this commit does. There are 2
conflicts:

  * The big block of macros for attributes:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/compiler_types.h?h=v4.19.16#n189
  * The __always_inline macro:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/compiler_types.h?h=v4.19.16#n275

All those are nowadays inside __KERNEL__ && !__ASSEMBLY__, so it
should be fine to move those too along the rest that this patch moves.

Cheers,
Miguel
