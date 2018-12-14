Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11167C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7AB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uq29A/nO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7AB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbeLNKCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:02:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45127 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:02:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so3795466lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDHKmtVL6/ZvrrxRnynPMSrxAPCPDbchrMAEWLjadG0=;
        b=uq29A/nOLmulzfegiXNgJI4pYeHgekOTmAJs3sKnAzSVkg7wHHLTfQqrK71uCZFh/H
         r3amSllaQFu4hFPfJyXE04UOETytWJat/FGVt4udtqOGpS2ohFgRbvuUy2Hwlsjdxu4m
         roza/dRgHpTeFTD8oVYHz5K8NRkdzmUEfiP/Amfyh+zau2nu53W7UqKzWYTUeKT+97bX
         aXdMRnRGUCGJjpjml7bbZdFVQRfERl91NYVQ31dPmSdqdU+MSGP5Di/F2sV69nPJOUss
         yJNR9ElHK0VaOlvTEpimbwEG1mcaSTdfNJ1f0mxP02J/kYp6INxsKI1VxMCXK4mebjhZ
         3eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDHKmtVL6/ZvrrxRnynPMSrxAPCPDbchrMAEWLjadG0=;
        b=ibhmF8Hw5Vp3z8faVkbi4ziFjY38LLuU0rmL40mgF/hSrQa3oF54237nbCA1qpjAnI
         Uaw7ZUdVrO3Hls3yCmIoveM8tiJmlK/wEX31DSO/eQ7IXpc3ExQPYiT77mGXwMLy+Qkl
         6JIlQSIsmv7dLe9ZE03DVMdCAEQgdlxPbc7IiX3SAl1Yrsx/jx/8BKsXPWt08FFYIR5+
         BJsBVt9ESZPiTpOApvR+/CYBdNFjhs1ZNSnQeqIQYJMFYUVrfrkmst1TcCslUD9bJwyY
         qcl7GfM6Fiwfa3i1eSsn0ttSJfW7uyYjj75fEnvKwp4v7DDp4f9vLbElhOZcxdEWgoN1
         D0Jg==
X-Gm-Message-State: AA+aEWZEc6Wi2llE7ZlRHF+ZH/oPotv86hWtspjRF6i1yBpVIH3q0bMk
        GqZYKYAaDdEOHn8axACgfZ8pVPYJcXZrRjBzELg=
X-Google-Smtp-Source: AFSGD/XmuZMH8PU9yEn9JRRAUuTQA42GWIrBNCLxOOzwUO2Nr8+rRlPvF/mat522O5yc1EJ7QRjXNtAhzudOZxyQbCs=
X-Received: by 2002:a19:5782:: with SMTP id l124mr1318653lfb.91.1544781772004;
 Fri, 14 Dec 2018 02:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20181209032715.3466040-1-liuxiaozhou@bytedance.com>
 <CANiq72nqFuJm5f69G-Pc_9QHz+anwaon-WfVsPrkZWah1OP7Fg@mail.gmail.com>
 <CANiq72=Sim1rmTBqWx6+t4GpRmZoNAhTppvbhEjOo-T2_g0N2A@mail.gmail.com> <CAKwvOdnven3n6P6i+WGs_TyWZzH+Cw-RwY8oay0gfnQCfxd=_A@mail.gmail.com>
In-Reply-To: <CAKwvOdnven3n6P6i+WGs_TyWZzH+Cw-RwY8oay0gfnQCfxd=_A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Dec 2018 11:02:40 +0100
Message-ID: <CANiq72nCa=TQvpgcOcLceGTDc+7KxPmD4NCMamqAqV2o5au89A@mail.gmail.com>
Subject: Re: [PATCH v2] Compiler Attributes: don't pollute userspace with
 macro definitions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     liuxiaozhou@bytedance.com, Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Moving the __KERNEL__ guard should not affect the kernel, only what
> userspace sees.  __gnu_inline only affects which
> implementation/definition you get, so even if userspace doesn't know
> what the kernel's inline is redefined to, it should not matter as
> userspace should only ever care about the function signature, which
> does not change between our definitions of inline.

Hm... I am unsure what you mean by this. Were you replying to me or to
the original patch?

Cheers,
Miguel
