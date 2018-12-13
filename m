Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B693C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193882086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QX2QcFJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193882086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeLMWZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:25:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46100 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeLMWZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:25:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so1686804pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=82G2s0eNg1Waw7tQy542Ln9rn5Nef2ejP4Ifav2gnPY=;
        b=QX2QcFJ7EpUmdxlwczPHtencyswmaN9HO6RQ//j/ciI4KtAz74/CVjm5p0EXzvA6wE
         556yjz8lrMXicg0NtamgFPabSpxQxH5XEfxyTdWyp1kxLMmnRbj7KI+U2q0kV48dI2Rx
         NeJWHOtr4RlAlANrYhUPA3ZgVg0ir68XhRQH3Wmh0lUvUdzeVRHPXDzSKJoBTBoKDIM9
         JtUy4w502YzZ/ykB9fm5/mya5+dcX7S2kVaEEKHJcMyGSrhzBaLznvnv4s0w028iFIVD
         16fUCb1g6oA5F9I3eebi9a8sB4OviQQ9RnTYK1SR85xxsm5pr//KnBDCaJAVgtMAtgyU
         Lvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=82G2s0eNg1Waw7tQy542Ln9rn5Nef2ejP4Ifav2gnPY=;
        b=Hmo7D7NOFIVWfkmDd2ZZXJrXwAxL43f9QQQhJ60SZVuLziu7RTjfihMLz5YAY8VJdp
         JTsYCMTaJJ0D0buKjqVz0PAgRjQOkVOdlnQqyomI1QGESTMCdGd8LSNuDHZuXW3DINGE
         PYWiNhOvdxWaf8nr9LmJM8Ae8EzYbFDMIuziYedTvMgIbqICLzEl1wgRsNy+yLcv8O1d
         pTwPt1GVLshkabl8VZQ/ROOr+qz/AAqx2QuXWu22sV+E7m7N0NaT03fc0tgrIxkkNGMX
         2zY3rN8LkznYvYMngrubPx8YrHcWaI5rdbNKvLvXhTsdvA3TCQsLYFR+d34aBlZthH/O
         iVpg==
X-Gm-Message-State: AA+aEWZEr1RJ/6slCxt9o5rQ6TmDdThe9nGOUr8U6PnmNjE2tU+Ckhq4
        XY1/z4L9dhk5iakLQQrTpOq1NQOPfgnlArSeskvZXQ==
X-Google-Smtp-Source: AFSGD/XqkTmeQNL65Ca252Etd85Y3VkSOf4U18w6zhEaqzECmUnW/QV75IF5hGu2gsLm76fpU6yTcAt+WMeXkoV1hho=
X-Received: by 2002:a63:e156:: with SMTP id h22mr505371pgk.255.1544739928397;
 Thu, 13 Dec 2018 14:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20181209032715.3466040-1-liuxiaozhou@bytedance.com>
 <CANiq72nqFuJm5f69G-Pc_9QHz+anwaon-WfVsPrkZWah1OP7Fg@mail.gmail.com> <CANiq72=Sim1rmTBqWx6+t4GpRmZoNAhTppvbhEjOo-T2_g0N2A@mail.gmail.com>
In-Reply-To: <CANiq72=Sim1rmTBqWx6+t4GpRmZoNAhTppvbhEjOo-T2_g0N2A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Dec 2018 14:25:17 -0800
Message-ID: <CAKwvOdnven3n6P6i+WGs_TyWZzH+Cw-RwY8oay0gfnQCfxd=_A@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> compiling error
>> showing "unknown type name =E2=80=98__gnu_inline=E2=80=99" will pop up, =
if userspace
>> somehow includes <linux/compiler.h>.

Oops.

> If not, I can pick it up in compiler-attributes tree linux-next.

That's probably the best, unless we'd like this fix in mainline ASAP?

Moving the __KERNEL__ guard should not affect the kernel, only what
userspace sees.  __gnu_inline only affects which
implementation/definition you get, so even if userspace doesn't know
what the kernel's inline is redefined to, it should not matter as
userspace should only ever care about the function signature, which
does not change between our definitions of inline.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

--=20
Thanks,
~Nick Desaulniers
