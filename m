Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 91171C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C61F208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GBgui4Qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C61F208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936069AbeFMQFT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:05:19 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40135 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935524AbeFMQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:05:18 -0400
Received: by mail-io0-f193.google.com with SMTP id g22-v6so3995506iob.7;
        Wed, 13 Jun 2018 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69gvlWzyTfh9ug7mztAh3Uc5jyMdPAwzoUgFiTiwjSI=;
        b=GBgui4Qk0Erh4fLlVtLrAVGHh1WqFBNW7tbHEa/lcBPigt+wZFttW3u02DZR4KdbME
         USwIvdAwFWuG23Fl7JFcE5arY5NF3yWg9Xtb3LhIjTiQwwM52bZepEZKu+DzjNPufMTl
         M0zeWIqf701zw2FdO7XShsPHycqotIlkEi6yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69gvlWzyTfh9ug7mztAh3Uc5jyMdPAwzoUgFiTiwjSI=;
        b=XQz98d90cvrbN9MMT2YF0ZL4PSfl6dtzDixaMLhEi+f+79mXas2eaorcKtQ22iSIZV
         WY6qNMVbiBVgAaZ28D86Zjz8Hj3b6bMerg4n0YkRl+vT526otYrYrmKU1zDS87dkUJKJ
         T7l9DCaZpP3JAuxvZgKTTpIYrGuTBgCCTLop839ZW66GqNlK6OdLmlo6gqmod0zh1my7
         qOIf1tvvE0zxS2trSs/3miLH4G8OU8erGe2ofLjyWbs48x4nVpmsCvO7XmBbJmy/Qi2p
         TcB9LNP53fRQpV75b1podQavR+VFRm0IFJMZQ80uSmVAr2R5Wg0pxJnnLYsOOHXmxw0T
         iVGg==
X-Gm-Message-State: APt69E2+zPGVwZy45v7ikmSz/XC+bT0e+yCqbI7lWfg0ju3Q9wYGL8Tl
        Mi3YoP/lLR2TSBx++EVbk5fjk5qevs5OIa5HEJc=
X-Google-Smtp-Source: ADUXVKLoChKyMj0TkuzwLxeJMevgYtX7tn9sWDMxiABhEQGBJrZ6KSFvSkk5BwFGxpjBNIK+5+k1saNc4CxKQrs4NqU=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr5499164ion.259.1528905917255;
 Wed, 13 Jun 2018 09:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
 <CA+55aFyxY9f9_eGv3CvA0zwzo8K5WeNbNPDFuyhtCrzRyic85A@mail.gmail.com> <CA+55aFy2KEzTiF=0nG8_RFoPpycaqc=n-hf-mQSbKotMzYJG-w@mail.gmail.com>
In-Reply-To: <CA+55aFy2KEzTiF=0nG8_RFoPpycaqc=n-hf-mQSbKotMzYJG-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 09:05:05 -0700
Message-ID: <CA+55aFwpobon5SH8XO8r+GKPz5=HzzzNKgr0kjU9+VU8kA4Z8A@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for 4.18 (2nd round)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 9:03 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is a pretty dangerous silent change.

I've merged it despite this, but I think we need to revisit the whole
issue. Possibly by just renaming that option, so that people _see_ the
change and get asked about it.

              Linus
