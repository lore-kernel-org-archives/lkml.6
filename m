Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C0FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98C721715
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gpYyOnRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98C721715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbeHOCKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:10:11 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39026 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeHOCKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:10:10 -0400
Received: by mail-it0-f68.google.com with SMTP id g141-v6so22623002ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATZwNaWjdnIKxzdnNJ4FOY3NLzJksKjT5I/h1syFoFU=;
        b=gpYyOnRRFRikqhufSOwHSj59E7n6+ji6dMhVa6iKw5fDT+UqmgdWUkiVMOOuF/J5eQ
         hqbHmdO6Ce1YyMJ40OS/D2CTOmDrSGoE3yXG7coOTSG8/0BbgXMYlLMUjiztwjNaKBvN
         B77BzxrEA7tj10XL3h3vWckDI0Ww9G4S2Jq4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATZwNaWjdnIKxzdnNJ4FOY3NLzJksKjT5I/h1syFoFU=;
        b=bt4ENyohETo6PMvqkNo8KpnpHvYDzuRKSCLBrqNSLPPLocZiGgfGKoJwLjUH6CP/Rq
         Wpn3IubpPnqKpcEJhrivHFnaGjC/m4FOae34cCO7knDw9uUeTQtf6LRo4K37fV0a0KIO
         VgbBahiaMPzJj+uVfc3Rw0yuXJ32FNwRJWH3rdhIUB/IEtaddwb7IbJ04449lHhySFli
         Z2BrFH+fj3aj95fZHq1txCz3yJvEFJ1fkuopfv7vBlRa1z1TicQ14Afwcm0AJbTC9JzH
         w30JypyEW0QyJZNuDSf8YlNeqD1COQz/c784nyedzMAdJKXNan42zG1bJtBZFyj8gb/t
         Q4mQ==
X-Gm-Message-State: AOUpUlFsSGW2qKFLTKx7jaaPkSRaCy1e7qGqI+AVeYasIdKmLLeHiuQ5
        a+hLXirAFdSvq7gX7v8qOyPesYxJLkU7KwsI4pE=
X-Google-Smtp-Source: AA+uWPxUyU28IC2JP6r7DuuncnoBzhW6ODrzvpCFX4FESdVS7+S4Ze8aJzxXCXH4ZrPOnY83b39VviHfLU18N/Qm3Xg=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr21347770jaf.70.1534288842970;
 Tue, 14 Aug 2018 16:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180814170904.GA12768@roeck-us.net> <20180814143655.3acd4bb211d44747f77e74f2@linux-foundation.org>
 <20180814221559.GA15888@roeck-us.net> <20180814160208.4f4dd7ca142912f5894ddddd@linux-foundation.org>
In-Reply-To: <20180814160208.4f4dd7ca142912f5894ddddd@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Aug 2018 16:20:32 -0700
Message-ID: <CA+55aFyU6p-da4j0TWQTEkvYDK_ymFDeTfBa9htYXrdH5gahgQ@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 4:02 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> The m68k build still fails because 0cc3cd21657 ("cpu/hotplug: Boot HT
> siblings at least once") was evidently never tested on CONFIG_SMP=n.
> How could that come about - the patch is six weeks old??

Ehh, meet the joys of embargoes.

The code was tested (and people even found subtle arm64 problems due
to that testing), but because it couldn't be made public until today,
it didn't go through all the usual infrastructure we depend on.

But:

> kernel/cpu.c: In function 'boot_cpu_hotplug_init':
> kernel/cpu.c:2275:2: error: 'struct cpuhp_cpu_state' has no member named 'booted_once'

it should be fixed now in -git.

> @@ -490,6 +490,8 @@ struct mm_struct {
>  #endif
>         } __randomize_layout;
>
> +       int wibble;
> +

Can we call this something informative? Like

        int __gcc_4_4_is_garbage_that_shouldnt_be_used;

or something?

That is, if we actually want to really drag out this whole pointless
pain of allowing ancient compilers?

Guys, at some point we need to switch to 4.6. The people who feel the
pain today *will* feel the pain at some point. Just get it over with
already.

                  Linus
