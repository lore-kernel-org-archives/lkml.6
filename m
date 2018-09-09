Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89940C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDD120854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7ECnImO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDD120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeIIVms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 17:42:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40599 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeIIVms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 17:42:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id c126-v6so12864551qkd.7;
        Sun, 09 Sep 2018 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T8LzPJhmcf5KV53qGoszAMU+i/P3qLvCOxapSpBB+BI=;
        b=K7ECnImOuCYEzfi/4IG7Vs9ucUBFDXOSZavq5L7UL/7iAvfRHugJCjqGcTxAIm7JiN
         joOgKgbRBEg5SycVgKSmJm961xrtbX5EIBtWgdcUAMY3BY58IS54vQfASEpFcIy+j/us
         gMLRrHe2mtVuhrTOmrB1lmwNd3PGtPTgR4v0egQHrZYDECE0DqxM1ft6JfbuvpTr5iYZ
         RI387OAO7s2oPllAX3gyZz7u8NyW0KBzaSg5ZYmVOQmm26hDTeVzwd01p0+FbvzuEIjV
         EtwPd3ir3OdIIViorBTcoojg6XIpPIPCnb/WrxvUmIoF78D7g6W4hR9uHcr1akPtGlFH
         awxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T8LzPJhmcf5KV53qGoszAMU+i/P3qLvCOxapSpBB+BI=;
        b=HAGuYepPW5G3ghtzrfy6E143yrNc8msF+xHKNtDQ5Zg/KAELnvVcXLHrv7LChmmfTh
         jyrX2dP6lsXGFqFNUjcJQek5fmC4SFGi0euLqfXBXyVt4BQXNEjFW3Ndt6F41nJkBS/G
         RSjs6JjzpPsbSByL6qjd6zG76zkJR9l9eONWOsU/Dsku5DnKlbKwmAUuBzpw/ry79aN7
         c6dDcrR7L2yNboB3JECULyt0mUm5oMXpo3k3jF4jNzZlAXjI6dd1DiRBhrxHFq6VgFaq
         62y4X5v5/950LfLPMeIW+PDqHHxkSxD22GwZuN2MhG/KFbN9SPZM+OjLI5z7O3RfNDQh
         tC0Q==
X-Gm-Message-State: APzg51DDRj0XCGj9QNfCrx5icnNeL33++epzS6AHm8PmXC1pw8H8VnOc
        u+u7Ke9cV1E8YmVOoD1AGWrNRAqD89RvfJs6kyw=
X-Google-Smtp-Source: ANB0VdY0yrQ/SaPLgPz/VqH/k07WPOzxFvP1u00oP7RYL9arpcKPE+i2kbRIUuLnGKw0dI0TqHtLuj3RGV6ERZLzoJg=
X-Received: by 2002:a37:6888:: with SMTP id d130-v6mr12406247qkc.192.1536511952913;
 Sun, 09 Sep 2018 09:52:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 09:52:12 -0700 (PDT)
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Sep 2018 18:52:12 +0200
Message-ID: <CANiq72k5GYk8x37mbWQQCLNyP82YcyzYOVunvL_2OO8ycqVTeg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Compiler Attributes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, Sep 8, 2018 at 11:24 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> You can also fetch it from:
>
>   https://github.com/ojeda/linux/tree/compiler-attributes-v4

In case it helps, I have also rebased it onto next-20180907 at:

  https://github.com/ojeda/linux/tree/compiler-attributes-for-next

The only conflict was the removal of __aligned_largest in f3569fd613f6
("crypto: shash - Remove VLA usage in unaligned hashing").

(Luc's Reviewed-by is not included in that version)

Cheers,
Miguel
