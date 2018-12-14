Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7AAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40B3206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJtXuv6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbeLNRrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:47:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43715 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeLNRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:47:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so3003499pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBuM+iA74sNmdKQ2saKqD/yWLGef6WJ3FVLzLX5jBo8=;
        b=XJtXuv6P45e8uDNMnjoFeRqiFbaKO0tl94qP0H3J7IrDia7TBeBMqsQTMUpUR/s6ne
         PHl3B2Z8ZwnJq6ydlUYjiXEGuFilQ6G/KfrXyWvCGTga+IhMqKtlkCgJBKmNGxw4q3MS
         OdB+5sdDzonuYDN42h7zUP4d/IJGHdTuwVY06XghHxi01hCCnoG9Gmqu1jiwYsZj4W2X
         nXbcg/xtQWmo5X+U2gqyD7kaajwjugTkv4mLaW7toH64ccEe5+8dhfg2viu0eFS/eYBe
         EG/IghQcIoM+7ViZB0sRurG8+v3EF1VC1v0fadliOYPwFbBhukWr9+uQUIhlxlW6J7Md
         ceiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBuM+iA74sNmdKQ2saKqD/yWLGef6WJ3FVLzLX5jBo8=;
        b=bJfBotUfcNUWcFsDZqnC6zfkxS7WVVO5ZJCs+hCTjyfGPRkjLO0hLlyMXLIv6v9wPV
         2TrjWRUw+3YeMEpsK6Hbm9kLiZxSyS41Of0kD/6BMex/lGaK6nfu98f7v6pAO3iPr4qZ
         oxbV3IMe8S2qyXNvkr6Ae704KOpTHQSus3EUu0fNs7A52705GtvMoqIYj+okhy3nA8E5
         cp2jcF1tI49wHcaA+oUsXtDlTXR6yDW0IReuEuVwSgI5Ghp6FGRimztcHeoFRj2wSTp7
         IBm3im1dQS3ezWrJArvdz8f/44Ey0xN91QIUkXdIAvW15DymalJ157I/9h/ydonCzQ7x
         EH9Q==
X-Gm-Message-State: AA+aEWZnP+UO1sDizMiauehvHqWlJV5ZxV4007VJ/zKl6+jqBW2MErhg
        HVXSy1P0Q05dFOS66qRDh/fYRVPndnC+xPQEL+lTNg==
X-Google-Smtp-Source: AFSGD/U4kP7zpPIg1/KPRHD5zuRG5Blrn1RcaWM5sPc1LFh940wFajSkQEyd9QwhSIrrmT+Pg3epXdyqB4byVTH/TqI=
X-Received: by 2002:a62:2c81:: with SMTP id s123mr3666081pfs.174.1544809664268;
 Fri, 14 Dec 2018 09:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20181209032715.3466040-1-liuxiaozhou@bytedance.com>
 <CANiq72nqFuJm5f69G-Pc_9QHz+anwaon-WfVsPrkZWah1OP7Fg@mail.gmail.com>
 <CANiq72=Sim1rmTBqWx6+t4GpRmZoNAhTppvbhEjOo-T2_g0N2A@mail.gmail.com>
 <CAKwvOdnven3n6P6i+WGs_TyWZzH+Cw-RwY8oay0gfnQCfxd=_A@mail.gmail.com> <CANiq72nCa=TQvpgcOcLceGTDc+7KxPmD4NCMamqAqV2o5au89A@mail.gmail.com>
In-Reply-To: <CANiq72nCa=TQvpgcOcLceGTDc+7KxPmD4NCMamqAqV2o5au89A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Dec 2018 09:47:33 -0800
Message-ID: <CAKwvOd=uKhwdnv0gH3E4_C=_uCGUvsWObpd_asMRX0ZQn4Qbyg@mail.gmail.com>
Subject: Re: [PATCH v2] Compiler Attributes: don't pollute userspace with
 macro definitions
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     liuxiaozhou@bytedance.com, Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        paul.burton@mips.com, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 2:02 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Dec 13, 2018 at 11:25 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Moving the __KERNEL__ guard should not affect the kernel, only what
> > userspace sees.  __gnu_inline only affects which
> > implementation/definition you get, so even if userspace doesn't know
> > what the kernel's inline is redefined to, it should not matter as
> > userspace should only ever care about the function signature, which
> > does not change between our definitions of inline.
>
> Hm... I am unsure what you mean by this. Were you replying to me or to
> the original patch?

Justifying my thoughts for ack'ing the original patch.

-- 
Thanks,
~Nick Desaulniers
