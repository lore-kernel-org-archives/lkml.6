Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1829C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F892086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGW1MIkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F892086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeKSPoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 10:44:55 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42198 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeKSPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 10:44:55 -0500
Received: by mail-io1-f66.google.com with SMTP id h19-v6so21318062iog.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 21:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jI1jVFE9UCF+KeJNUzzdhYvd+566/pA0wVI06v6yyDk=;
        b=gGW1MIkNg1NcbA25wA19ubXVLG2xEUkYwb9GiBgBRefjO5IHTFiErBPU0sb/hEEyw+
         NtbMNiNYJT4CjVxidSzu6YeFT32dio3y1w4JsOOBdlSalJw8XZzG8QSbvQlN3YBCJuXk
         U2fVB7PRf5NdPEeHnGxMLbsnfLhWtmchg8Lv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jI1jVFE9UCF+KeJNUzzdhYvd+566/pA0wVI06v6yyDk=;
        b=lQQqNyrQS7dH3C1r99NiQBbb+6GWztyPYLtewhGCKj+fAy6aAqIDd/ooAI0j3MhnPC
         7QBAmY0R9gY+u1X6zJYDa6+1x6Aljs3dLOwqicUcdd2XTPZkStrAdvA/znPOqA2K7DqE
         XkrRvGtBdkmZozQdqxfQtP5lhzXAb8EO6+KtOEP6su9rD6bjqRvxqXr5YJC8LJ6/diMJ
         mZIxKIUsgmgkDqTgpkMdawK4MSNi3Gzp0WEl9t0o/ItaiBSyslS2TFX29YUPKzkxxe+N
         l5kYXKhE2g1meGN6+nLXFI3eK8GksOsqzelsuTqpyAYCHsm1s/hCOfwh/ekxRw5ROxSy
         mLmQ==
X-Gm-Message-State: AA+aEWYxg17n0qVvJHfzYtcSFIp/iznjvyqoP/J65DkwIqb77Nut3/ok
        vnnVSgEw7m5aH0s9vzul1PqGtHU18KROII3wCpyvBQ==
X-Google-Smtp-Source: AFSGD/WvZBXxKgPV3BJRUYSgp3l6RZeOkLrOMf0WRcY71Sginzt5JDW1I2JHiVUqFF+HSI4R0YmJ8r/ASdAvK1dApMA=
X-Received: by 2002:a6b:bc04:: with SMTP id m4-v6mr12863567iof.171.1542604945813;
 Sun, 18 Nov 2018 21:22:25 -0800 (PST)
MIME-Version: 1.0
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org> <20181118.185913.65989390344960294.davem@davemloft.net>
In-Reply-To: <20181118.185913.65989390344960294.davem@davemloft.net>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 19 Nov 2018 10:52:16 +0530
Message-ID: <CALxhOni2YmDX3zYx5a_MWvkfJic+UuMmZBV7sgppkXO5pZB_vw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux <sparclinux@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, 19 Nov 2018 at 08:29, David Miller <davem@davemloft.net> wrote:
>
> From: Firoz Khan <firoz.khan@linaro.org>
> Date: Wed, 14 Nov 2018 10:56:27 +0530
>
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
>  ...
>
> Series applied to sparc-next.

Sounds good. Thanks

Firoz
