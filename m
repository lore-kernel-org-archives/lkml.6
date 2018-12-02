Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF08C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AB22082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AB22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeLBK30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 05:29:26 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:47098 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLBK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 05:29:25 -0500
Received: by mail-ua1-f68.google.com with SMTP id v24so3401435uap.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 02:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DjnSfb1/XDkRJMgWKc6mlafrvIuQN+/tsa8UmBztZ0=;
        b=RoN1L6gl9zWqS+Ad+vGYy5lcOH2BI1Vi70eJ/q6RsWSZXP/HY+AgI7RIw1of9f2auG
         VaRbJprVQFZOUWbjJHrz9HEKx8Dw2O4wh0kne53+BtA17/AnBfZulk4Jzy3i0nWO/P9X
         KO5AIKdulriOa4pLs30S+s2fJTA4MIH1TKIdMxMZxfUH/Yu/FOjgkDS+iRhfH2S4X8ID
         EjBmqMbm1nIxGS7JVZyVbfhXG9MFbvv5+AGL2fEILbiFNajgR2m/NhuzCjyJUfi0Y2DB
         oB4Eb+aQHxJWy8KrNWtm5HOaozQkQUXe1/BY5QP9N9Pmx7YyhkBbb7TOvvqMi5RXnFct
         oeyg==
X-Gm-Message-State: AA+aEWZWCYq/51/+W9hgV1PJsnwuaEQP1TLP7BIg4RzSO3fuJPCGFX+q
        D6B8rDP52wSzw/XfG8x4GSXykKBXCLIEsvMsZr8JOO8s
X-Google-Smtp-Source: AFSGD/Uf8wDQbY0Ir2yC1zsvi7b9cWMP3PK643goSiYRmDwWSEG3dBnBOebe/qXVUpimWxN8wJ1m5xKmI/E6cvUr15A=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr5630504uap.0.1543746562761;
 Sun, 02 Dec 2018 02:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20181120001128.GA11300@altlinux.org> <20181120001524.GF11387@altlinux.org>
In-Reply-To: <20181120001524.GF11387@altlinux.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Dec 2018 11:29:10 +0100
Message-ID: <CAMuHMdV+-Lw-mx8OAifrFP--XhbiHr8hAZ56rsG=9Ayu9BeXtw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] m68k: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@kernel.org>, lineprinter@altlinux.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Nov 20, 2018 at 1:15 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> syscall_get_arch() is required to be implemented on all architectures
> in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
> request.
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

What's your plan w.r.t. the upstreaming strategy?
Do you plan to get this series in as a whole, or through individual architecture
maintainers?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
