Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9BAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AB420C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AB420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeIYVjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:39:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46117 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbeIYVjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:39:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id h22-v6so5832339qtr.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfHyhczue5Z0n2A7y6QebgffgZ4ExvKGJok+qkGlNWo=;
        b=fWukDO5rx/bnOnxLpRHwKAXG2EROETmtgPVdXC0AKIbcy+u/ITAWrK/y6chM0wyv9Q
         4CZe+t5CB6iB3qGUtMTKVJ8+S7dVKVdHlTyNkoNR7WK10DVcFz3LP21zO++lBZNYz3Ul
         RQpx+2N1HBMJGJ2X3rrdt4SmwrN5y2eUIEkz3NN4nBsQphJO+1g0LektDUX52Qu8hBqx
         Hs4dvNBLGZh0vGI6iAs4CMdc2keSkXBhCxodpvUiwoLjTLwwhL95uO0gFlROnT+9XmdM
         9vJHFd4GlvY2JdBev6f/ygZR5U4lYlTLcbF1BdOUH6EUGh/oZEwKPLceHqo5M5+WGUIf
         fm1Q==
X-Gm-Message-State: ABuFfoicpnqXDNMH92EsGJIyWJVCuiQHNOSXbTDCcTpBOXdv8fM8CLXX
        QN2CVF1hdqhVSa4f3n3TG4xbF59w1g4Ki8Tme8xz2FoC
X-Google-Smtp-Source: ACcGV60viltH7nDH7nHMW1uM4USQb5C/5zN45yJ3ANHOHkU/D46Gi74XsZMKrHtrLDi4Y4rLaAteB6XYOZNpT5NCWtg=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr1166458qvc.180.1537889479975;
 Tue, 25 Sep 2018 08:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180925142344.GA26980@kroah.com> <20180925145410.GA2747@kroah.com>
In-Reply-To: <20180925145410.GA2747@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 17:31:03 +0200
Message-ID: <CAK8P3a2uRUerniKg7cZ+OuX8QLq+9f+SQKzXO9m6-Li6AYXJMA@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver fixes for 4.19-rc6
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 4:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 25, 2018 at 04:23:44PM +0200, Greg KH wrote:
> > [Yes, the oddity of sending a pull request to myself is not lost on me...]
>
> And, I totally messed this up.  Ugh, what kind of idiot does something
> like this!  It's not like I haven't been doing this for years!  I should
> know better...

Ah, I was wondering about that. I even found the char-misc-4.19-rc6 tag,
but it didn't add up. If you want the signoff chain to make more sense,
you can add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

when you pull in your own tag. The resource handling in
drivers/hwtracing/intel_th/core.c does look a bit odd, which
confused me for a bit, but that was already the case before
the patches.

      Arnd
