Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B23C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED7720BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hrpVGKGw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dU+BAPnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED7720BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbeGLAXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:23:24 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34223 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbeGLAXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:23:24 -0400
Received: by mail-yb0-f193.google.com with SMTP id e9-v6so10758095ybq.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+Hu4uhrieb8C/WIA6FhyXu+PkLTLr9Ze24AHZytFUSo=;
        b=hrpVGKGwRwV1VJhp6GpgXOFeyp29tQEWFqTXdBIEaPO5EEuYzkOy8T77w1HWizzba+
         zLjUUYe2VQgh++yE9nhW5Ct8Nw91NawU4EUCfwv8ds9aaOGn7rzyhJYoV5oGFrKF4IDS
         TGc76aRgAiTxHTmRGenEcydRhm2Ow68iJbhy7nTiaCBCrwhCL4OHYMUDrs0T2zmv1cop
         teMK2kICWTYaLH04a7TJf5QHh6owxhaHVPJhxY8smGFSdL30KszLqbVvk0LgBDOz2Yc3
         fvD9PJc8vitZtQkgBXnc+wmBM4HJ64PWOgYgGtVJJEGtaPvHG5tbbEPnpmkSLo0fgpzl
         eXIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+Hu4uhrieb8C/WIA6FhyXu+PkLTLr9Ze24AHZytFUSo=;
        b=dU+BAPnJP3jloPa2819VFWPDc6+xOc284akctnuxjf4zn0vpMdnmYwtymroRdDoLhX
         lR2gfY8jJf9IdmFe0PMl2uBvdwQPJJ2/7pDb5NWXpXFTeoxFNpdoH3tidqggKhZqeXqm
         0yk3drI4jU5XFdj+HAqFmeBR4YCOhrbS6muwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+Hu4uhrieb8C/WIA6FhyXu+PkLTLr9Ze24AHZytFUSo=;
        b=jyc2AuWZcqk8C4khYalP+smwvu8DMUd2+uTSF05RdOaOKO59t/7J40naHmaYRBukmY
         /qb8+FBPWOZOu+SP30bgoqkwMkmROYM3UkPo2YMmBLgMbg0NTnXb0yXPttILr7wzDeGo
         yPFrC4hVmb7njJ/wG0xG6Amp6nypnqbPFYE9SPYZ67osRCPV9NqHejojqdRpdb9SrZnp
         +bGzJKVJ6k7dpjFOJlq9HDaSQqh9bo6boazZqSqAH583GHLlMAYofQ/W/crYSm49/bPC
         VRSr9eK9cR4OHWwHauHuB9Gyc/wPbNsSWZechQe+41bVK1br7qeDjVmJw+aENKTQw7fv
         VcRQ==
X-Gm-Message-State: AOUpUlEyXo4L8TA7Z4vkYe8BtWKnPbzqCPTtxraFw6HbGFg2NghoG+KD
        5uagpwTisT1nCgqfiOU5t12fLfJ7q18t9wlUjkB9RA==
X-Google-Smtp-Source: AAOMgpfIYUG+yuXEMqwilC64UcceZFlbbb/spXcdfcUUCrFz/UEqWy22GEuoLxqUcjQbW6PH9MInCqV0dDbizvc1kG8=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr3389ybj.343.1531354594785;
 Wed, 11 Jul 2018 17:16:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 17:16:34
 -0700 (PDT)
In-Reply-To: <1530771852-21998-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530771852-21998-1-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 11 Jul 2018 17:16:34 -0700
X-Google-Sender-Auth: Mu-TviqaTWRyHCVeV5QwU_3fFOc
Message-ID: <CAGXu5jK3jgJ5qvT4jPKgvO_Jf+edeLRYKrJ+67r7zrVszB2_xw@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: split out Kconfig entries to scripts/gcc-plugins/Kconfig
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josef Bacik <jbacik@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 11:24 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Collect relevant code into the scripts/gcc-plugins directory.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/Kconfig                | 146 +-------------------------------------------
>  scripts/gcc-plugins/Kconfig | 141 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 143 insertions(+), 144 deletions(-)
>  create mode 100644 scripts/gcc-plugins/Kconfig

I'd been pondering this for a while too. Thanks for sending the patch,
I'll include it in my gcc-plugins tree.

-Kees

-- 
Kees Cook
Pixel Security
