Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B045C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4A920684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXMfRATk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4A920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJCOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:43:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35461 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJCOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:43:23 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so7559897itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tvpBZNyw/JuR1q1O2m8w4fF397cf5hzEAXu/4yC83s=;
        b=bXMfRATk3StiWfZ8U2ORCNs+IMg2q/2GwRjMUcwLul729lxkbJEr5h7xqAxqNiRG7P
         haSYGSmyXjNndzleiHklmSCkcZOIh5ep7PfMEBJuFwwT7EX5YE4NrhA5ljZgvOtF++g+
         kD5JTDAB8LdFirv9wIjY5OdrHPDeWjXSEDPvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tvpBZNyw/JuR1q1O2m8w4fF397cf5hzEAXu/4yC83s=;
        b=uhRU53qQDDhZaevwOOMJ/fviPi0/uprdC+EdzWZfRZXx05f7FYz1ddcockaqcfp02Q
         YMe58VvbToU1V4zM58Suq4AHQdrsk3BEeg4pwXGlv57AB0k9hD5DTGEn5qU0+EXKUctF
         pj0fBM7djYryWSPa2PEThsdvRqKrLN7DK8RJ7DcuXSklaA32+S5SY9/wmgW61lPzvc1m
         44X7RePlzIWoNt3qYIyXFY/lp6cASlLefdS1X2S2gW5n3dSwHw4uvntzPN8Uim6JNNl+
         agenGml4oZX3+W06urbFyuNCylRnWMPdLBs9p+iP9KpCWDuQNPmeZESGjzjBCUCCHKEF
         kqOQ==
X-Gm-Message-State: ABuFfoh2g4UNOFmkA9HnqG5NeZF6Euq1R/WvlhU4rN5fRbAJvDwYQapY
        EVS4TWKOMVQxUwUhzYgxJV3Uz1nzwPycmtaaAtnjlg==
X-Google-Smtp-Source: ACcGV629x2+cXnmh8opt9UbXE7/8e+6q3Zo7H+8/bWuoQPewm4sm1xcQVuqkGgir/YAkghLhSGVt1BYMTYNpX/wDyxI=
X-Received: by 2002:a02:9643:: with SMTP id c61-v6mr194646jai.37.1538553367221;
 Wed, 03 Oct 2018 00:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180926132434.3071168-1-arnd@arndb.de>
In-Reply-To: <20180926132434.3071168-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Oct 2018 09:55:56 +0200
Message-ID: <CACRpkdZG5myxEiOoHP1rnag+yJWWqrMJ=ODRB5ET=oAAn1+T-Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: u300: regulator: add MODULE_LICENSE()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 3:24 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The missing license showed up as a randconfig warning now, no idea
> why we never saw that earlier.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Will you take this into ARM SoC directly (I have no other U300
changes this merge window), or shall I queue it and send
a pull request to ARM SoC?

Yours,
Linus Walleij
