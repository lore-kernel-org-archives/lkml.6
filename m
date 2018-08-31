Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD3EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CB42083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRDZUedq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CB42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHaVo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:44:28 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:38460 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeHaVo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:44:28 -0400
Received: by mail-qt0-f172.google.com with SMTP id x7-v6so15413914qtk.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mPNDPhl/l1BKCJtvZ7gVrEjCk2pYovw45tTIHQi3c38=;
        b=CRDZUedq+FLaW3CMDAY6KxD6YA+883Nfdd6aozjLye4GOUwoLNTkN5rr9fmXOnoVMQ
         kG9t0zmPjTjpVNkkLvyjyStd5U/FDz3zh6UGZEAPm7hgOrbbz60Xhs60mvqw0DEcJrhh
         z/u5VYn1cQKlwvfbLzPpgcR6gA+YPmEMA6nc2FqChygdPrJKvABNnab9pyzgdbZ2lidZ
         DSksjTSOJMnxMbBNpJAz5K2VYIj8oI5u/5q0k2it3E5yxMg5wdrKPBffurl9QCt9YPon
         +7Kq3TBN218MqVPF+xfEjJkUfm4tpCkP8yv7/6IjxUiXu5U5iJEnLwhOq5nK7OHJw48P
         x63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mPNDPhl/l1BKCJtvZ7gVrEjCk2pYovw45tTIHQi3c38=;
        b=eB59vrMnpSyqXFI63aODFgVes0ySjR/aPhCWpjWkZvzdzu9ZThXC6Iqd3E0qrvI3i3
         AXfRoTGKQbZqdy9Z1eazL8Rrp6v/EYIAOgwdxUKge7oLRJzuDAKNx4flebedSHdafCH6
         HyjsLXAhww3LOj5NjEX5fylBMmBZ5nq86STyHWJhptQf9RD7XZixuk13VPiL5abQLlk9
         WIRtOe8BkHOe/F27JgTkVyJFNvM5ubuT5TmsRqLRtXRZe+9iXyKbOgc9m0B+Xct6nVPr
         QEAPQvTR9SgM/Bi2E3N8vNV+L2NH5MlM/VTaMMvWmPUSQT77uPHhWLXEaLq5bajE3QKH
         46Ew==
X-Gm-Message-State: APzg51CuutNzVeW4HWEQeGHbFPWOgnwQEH+eI+B+K3M6aC2RIaKmlId9
        uP5VLG4AXhqTx3EbVNsvx/syUG8cDqkeUvG8efI=
X-Google-Smtp-Source: ANB0VdY40Fcl+riDgkDR62IoKk/ZDlzPjhoI4qzBeZIxTwbm4Rc/NBTjKjjVAGwpCx1soANTAT7LeskQHMPk0PQGAb0=
X-Received: by 2002:a0c:aed9:: with SMTP id n25-v6mr16420861qvd.10.1535736956313;
 Fri, 31 Aug 2018 10:35:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:33b1:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 10:35:35
 -0700 (PDT)
In-Reply-To: <CANiq72=exw5RUNiZ2svNobeiX4vOhcCB1xs4fQsma2LJDDM5zg@mail.gmail.com>
References: <CANiq72=exw5RUNiZ2svNobeiX4vOhcCB1xs4fQsma2LJDDM5zg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 31 Aug 2018 19:35:35 +0200
Message-ID: <CANiq72=J8cHi40wTUX6ZsF-ni7BmYsyQ6moYsixKGx5UpHWjPg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Compiler Attributes: cover letter
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 7:30 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>   * Removed noinline and noclone inside notrace since we are now post gcc 4.6

s/notrace/naked/
