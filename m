Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C1AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E10217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zs9c335w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E10217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeHUXCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:02:19 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35284 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:02:19 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so5659286itf.0;
        Tue, 21 Aug 2018 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXyh6+R8cfQ4HL3x6BhgJHeb1XfWk1d4IK5E1mQeWdc=;
        b=Zs9c335wP4g8l/HN4UsGVejy3TxOdYHBLb1bF7Czzj2WiXcUNeNl0nCUO2dX4RI9yj
         t4aP1IyIdsfyPuYEm6aYe++Kvqw/UzI+Zwi2xv1E9OhJfSl6h44TzhlVTHbtVbx5js0z
         pOlJW1hp7A8mNnclwXPGLcf5NH9TyjKqjTvsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXyh6+R8cfQ4HL3x6BhgJHeb1XfWk1d4IK5E1mQeWdc=;
        b=ZGeDgOSZFM4FEvFCc94HjxYPa6GsOrcDvm8isnUmLyEh6rEr3AsIyj9uCSX5v1JA/W
         lG5Tkf/ehT7gWqf+EcWudwSHiQxDBDAEnwtp6wI9Yem7A2uDPwt3BV4WgNIQi/6RkCw3
         ntdTbkGs9WKtMbxYvrJdZWhVvki/fvKKIMylSM4UzWjoAPbRhESTY+HqSTG9BjzpR6w3
         PLXe9yWxBlYhSpgMmDOLtQxL316MKxktswpHxui78+T31iX7g9cGhzVNZxzME3l/3jsL
         PdGlOXazPimNYc27GGZMNPnk98M0aGcp7ymCp7bZcmbW9KRpxvmK2sn6uIuX+aNHZTPx
         lNOw==
X-Gm-Message-State: AOUpUlEoCjGr6cnv9Rkt5W/Pyg/6Pq13kbczCg9Ncbi4y8Bv5L2owsa1
        PWMAPxIfepMcS6dm0NO+agDE6ECNvYr1TtfETHU=
X-Google-Smtp-Source: ANB0Vdb8QtlkWbtE99y3u+mbUeFLkrsMoUXc+hd0k7uAGsNMSeR2uFeNZEMcxlwH/ETX8H5yaKJbdta3bWdiulNsP5Y=
X-Received: by 2002:a02:9d45:: with SMTP id m5-v6mr5118322jal.72.1534880450007;
 Tue, 21 Aug 2018 12:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
 <CAK7LNAStcQoi8oodq98dSGp+Jmgb1F0mowMephUY=OD2o4=2Mg@mail.gmail.com>
In-Reply-To: <CAK7LNAStcQoi8oodq98dSGp+Jmgb1F0mowMephUY=OD2o4=2Mg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Aug 2018 12:40:38 -0700
Message-ID: <CA+55aFxU+cCxLsrTjKdni_xrJ=TvcYbHh0pv7Bk8ns4Gtq8rBA@mail.gmail.com>
Subject: Re: [PATCH] Raise the minimum required gcc version to 4.6
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 11:56 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This broke Clang build.

As mentioned elsewhere, I think the clang build was broken before anyway?

> I sent a patch.
>
> https://lore.kernel.org/patchwork/patch/976025/

Yeah, I'd rather just have the clang case have its own file, instead
of be back in the situation where clang depends on gcc and then has a
different versioning model so we need to have insane clang version
tests in the gcc file.

                Linus
