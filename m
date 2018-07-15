Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104CECDFAA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14E72089F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iMljT9DZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14E72089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbeGOCTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:19:15 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37162 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731983AbeGOCTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:19:15 -0400
Received: by mail-io0-f194.google.com with SMTP id z19-v6so34614660ioh.4;
        Sat, 14 Jul 2018 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7q/SOjmobS6UgsAv07jHzji/wery81//CVKQO9pE5D4=;
        b=iMljT9DZkxIADHhJt8GcFIwXsIWJHO38CHxdrbtohFbNZ7Wu/EeZ4j2UKFAQy+Nzgl
         k2hqtCTTQvx64b0PSHzcwEt2h75qqNo1yWyGNxLheDdYEJmxxK5ka0hC7NPItXECBa8r
         DyA48scwKiTPWeMi1YT1/KPc/Up5coQaXAmd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7q/SOjmobS6UgsAv07jHzji/wery81//CVKQO9pE5D4=;
        b=NVeIjfVNl6sWczAlHhf3hzAVX7UsHvqj3zz+OXQbuL0RaqUwWOA/5Vg98WoBq+S4pP
         XcwjyO0d95FIFt/0g0PFXeoOOVn4n3VNb3BvuKsyqx19KpJFp1K0hNha0y+6geqoRrO3
         I+ZoVs5TJbJcPDIxOfPzf6rQEYkoVrWt7rDC6eVgCF0+ts66uRrt81SdWWfB6cPnyWYT
         vTab36WgwcDAvRm87Bv7YBhNqGQdECsfKL1cmhvrbgVzRRIVxzie1TVelW+reM3s0jEa
         k8l124aco45hEPrLMTRJaJFr+ZAO5JpAJF+wb0eht/oMgTorrK1e4DosriDD78HdIIoK
         WcaA==
X-Gm-Message-State: APt69E2t+iWg5Xu2DBnp90eHNr+/N/VhF4c2K//lcMkXo13k7mD8N7Do
        RWQNquwyWY/6kLqTWQqGWNtW3SVwOLBnO7AgFPY=
X-Google-Smtp-Source: AAOMgpdMbZra76T8AmpylbrOf3nzmiqHEoYEtoEdooWDgALj/GMAIIVN/jznLKK48Ri7DT3IE7paX0rBhucy/uXYt7M=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr37623241iov.203.1531619888422;
 Sat, 14 Jul 2018 18:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180705161709.17028-1-bart.vanassche@wdc.com> <CAGXu5jJJLh+oMcZ94nkrwCvyJzk6MzOATvt66WC-rHfxGTJh0Q@mail.gmail.com>
In-Reply-To: <CAGXu5jJJLh+oMcZ94nkrwCvyJzk6MzOATvt66WC-rHfxGTJh0Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Jul 2018 18:57:57 -0700
Message-ID: <CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Avoid that sparse complains about using sizeof(void)
To:     Kees Cook <keescook@chromium.org>
Cc:     Bart Van Assche <bart.vanassche@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 6:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> I'm fine with this; it'll only activate for sparse. I'd like to get
> Linus's eyes on it, though, since this macro caused us SO much pain
> that I'm nervous to change it without some greater level of review. :)

Honestly, I'd like to just encourage people to get the sparse update
from Luc Van Oostenryck instead.

For a while there it looked like Chris Li would just pull from Luc,
and we'd have timely releases, but that really doesn't seem to have
ended up happening after all. So right now it's probably just best to
get Luc's tree instead from

    https://github.com/lucvoo/sparse-dev

which also ends up fixing a lot of other issues.

                Linus
