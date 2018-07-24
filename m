Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C75C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E3F20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ADzBQG4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E3F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbeGXJPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:15:08 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52154 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388487AbeGXJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:15:07 -0400
Received: by mail-it0-f65.google.com with SMTP id g14-v6so2612836iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9gGdEF1zB6Pdw8DPASw4wytgbd93/MBTrKbGDhz42NQ=;
        b=ADzBQG4ajUoQdEOtbKPiT3oFffDUeFLlIrgnuM91pyVCjlHrsghXRLLQQE1tJW1z3I
         eLkayClGTYDgU4MIH6hz2dpmaAXKyODHZZHyTwdTTm8UrldeMxu6kgeN3lKp9K3avxhR
         Zqw41t+pGAiW38lRlDJupH/neGWsef/EJtRVbB4eZoH3fcPGqzg7XShDYC9t3duR8KjL
         uoSul4ns7SvrxJDQm1T2GK5zw5gYSuUPOZrv8PKtR5CNI2wKXxo73g1zc8Lk1Llwtkgk
         zpwI6gyS27hcPd6UuUB9yo4OC0Aqc9EVoZ0qy/jxL4tlYrFUSaNzGihJRtwJJOCtFhqY
         YmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9gGdEF1zB6Pdw8DPASw4wytgbd93/MBTrKbGDhz42NQ=;
        b=Ln39YfBZhvvW+l+Q+oX3mS7UOAyDwFseu3vupIekPhvrU8w1efIbvevI3JnPA8hdBy
         XgaDBoC0yuLGw5EwzUc2qyW5MX9RByjf0pTtgFqZBMOgElKGGjuZhJBMohTfcksDkGAS
         l+4LcidlbppGaigpbVZN+GpRo9h6QSwM61qIPVe8SRIpvmhfhm/nICQh2j+679Bk+oEH
         EEwVS7A6fKm5o0dcRUfcqEyP/PPXt2vGG2oyNOsOsBzDBy+ChCUDwj3PlB2dT6QJHsQr
         j7V7qkWTpiFujA7lkOb7UMKWwX4RBgvlb6aeeJEOetqSPAjHmS4zBW702LLnNCA4eBvB
         KJlg==
X-Gm-Message-State: AOUpUlEae4k5c5XmgQZWP29ovjSscR76omG3dCsRRbxEQ5VhGQzzJZSH
        IG5wIW5loo3z7tEObJ6J0Kqm8LkLEZ++0eiyE2QfdQ==
X-Google-Smtp-Source: AAOMgpfAWUbYnAx/1nBULpTHgacpcsEOo8OBmAq6+r2OiYOX+S7Bj2QOjdbpVyi6+gyPKFvc8YmoUNZZKO36GC95u5o=
X-Received: by 2002:a24:d0cd:: with SMTP id m196-v6mr1971471itg.9.1532419792278;
 Tue, 24 Jul 2018 01:09:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bb58:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 01:09:51
 -0700 (PDT)
In-Reply-To: <CAK8P3a1F2j3PL2ng7xw9TbCQqwn_U+1D5ChH+v8qWVrxOfW3xw@mail.gmail.com>
References: <20180716122125.175792-1-maco@android.com> <CAK8P3a1F2j3PL2ng7xw9TbCQqwn_U+1D5ChH+v8qWVrxOfW3xw@mail.gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 24 Jul 2018 10:09:51 +0200
Message-ID: <CAB0TPYH2G_+faZDcvoEyUmZfwP0j83P0KeZXSJdN9rJ4M1ad3w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Symbol namespaces
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Iliyan Malchev <malchev@google.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jul 23, 2018 at 4:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> This looks nice. I don't want to overload you with additional
> requests, but it might be good to think about how this can
> be taken further, if we want to actually convert large
> parts of the kernel to it.

No worries about overloading, I'm happy with all feedback to make this better.

> I have two ideas:
>
> - It would be nice to have a simple mechanism in Kconfig
>   to put all symbols in a module into a namespace that is
>   derived from KBUILD_MODNAME, to avoid having to
>   annotate every symbol separately. This could be similar
>   to how we ended up dealing with EXPORT_NO_SYMBOLS
>   in the linux-2.4 days, with the goal of eventually having
>   a namespace for each symbol. Similarly, we could pass
>   a number of default namespaces through the Makefile,
>   e.g. if we have a directory that has lots of drivers that all
>   import the symbols from a common subsystem module.

I'm hinging on two thoughts here; I really like it because it
obviously reduces work and makes this easier to use. On the other
hand, you now have to look in multiple places to see if a symbol is
exported to a namespace/imported from a module. Perhaps it depends on
how coarse-grained the namespaces end up being. Either way, I think it
would be pretty easy to cook up patches for this.

>
> - If this is possible to implement, it would be great to have
>   a way to limit the globally visible symbols in a module
>   to the ones that are explicitly exported  even when a that
>   module is built-in rather than loadable. Not sure how this
>   is best done though. A couple of things can be done with
>   objcopy, or possibly by reintroducing partial linking (which
>   was removed not too long ago).

If I understand you correctly, this is orthogonal to symbol
namespaces, right? Though I think there is value in doing the same
thing for symbol namespaces: right now, the only way to find out if
all modules correctly import a symbol exported to a namespace is to
run an 'allmodconfig'; not having to do that would be a win. Being
able to do the same thing for the exported symbols in the global
namespace is very similar. So yeah, I think this is a good idea and
will look into this more.

Do you think these things should be a part of these series, or can it
be a follow-up?

Thanks,
Martijn

>
>         Arnd
