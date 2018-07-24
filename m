Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE72ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB2220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WesUxG8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB2220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbeGXKNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:13:52 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45308 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeGXKNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:13:51 -0400
Received: by mail-qt0-f196.google.com with SMTP id y5-v6so3371856qti.12;
        Tue, 24 Jul 2018 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tldQM/OLlJ9qEjeJ+cPEjKb0f/dDCy9sPytvqBK3IdQ=;
        b=WesUxG8qPh2ecmBJWJIBU0rlWVCFRlI4HbjYyMM6tnVNwzlT/i9UZLe7Wcxk0BM0RV
         6Gw9J6r2pFA0oTuWKZmYa5QbrRrMkLtrF/99elcZYY/E1FQk59WPicsntl+KUY4mNbul
         8tOHkxrk35rWHvybUNJufNhlmbDaRV0WHm3s+aZSOSsDDrFQkhyZX2UBKYIW5hFrUHo7
         UlqMJ9BPW2RGnK2fcdUEdgXOTxD0F4kQRUn4POsb/lXKL6W6aS19cF6RJA9aKHZmgSoa
         rjyzaSBhLggCMF5h1HWq3nDkMDy8cAmBYw9MMSEdqRNGv6Z/bH+PWUsTP7asVT/o0hbA
         tCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tldQM/OLlJ9qEjeJ+cPEjKb0f/dDCy9sPytvqBK3IdQ=;
        b=d68JsK4VqLKl6gCWLjJY7AkgNYF1wOkBg+9IiQxCT8ZJqgw3NlekRbqTeq72VULDJz
         iNqBNexI6aqKQRNcWOWFUYvAtcIn/idGfdYZ2yO7ZkQfJ2aoKcTHGTNXhuDY/Ka5gpd1
         CXYliNXwEk7mjjxlU/tC9RcFfobJUEMQWA0yFzzQSU3E8rJesj39sKpiuSt2mlWxoYvt
         xUvmwS1K9alXPj1u3ljsod6ygE9Zh2u8rWhRdOcf0D2agt0PtCweLzRPSxFjUkmvdLwO
         dmXmqWdQ0z4CmEnOacdaJhVBXnledCpPo8Mm9MaZJsuZOzzRoifVBhQoMFNV7IPfLQRX
         S+jQ==
X-Gm-Message-State: AOUpUlGYUdBbLHY97ZGOf0wXctmJVVDAnsShKEeDTa8RyZYSnch7pN8n
        vgkFnv+uK7U2JKhMptv/r2p0Np8S7ri0fOsuAgk=
X-Google-Smtp-Source: AAOMgpfbe0QMwJM/cxCXgpLgQlBVbIhWmhTm9NpF2T14ycFs8F6BClzozQx+p6Yu783mw7jq24OFP9wDut+yKvpw0SQ=
X-Received: by 2002:ac8:30e3:: with SMTP id w32-v6mr15831082qta.280.1532423302211;
 Tue, 24 Jul 2018 02:08:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 02:08:21
 -0700 (PDT)
In-Reply-To: <CAB0TPYH2G_+faZDcvoEyUmZfwP0j83P0KeZXSJdN9rJ4M1ad3w@mail.gmail.com>
References: <20180716122125.175792-1-maco@android.com> <CAK8P3a1F2j3PL2ng7xw9TbCQqwn_U+1D5ChH+v8qWVrxOfW3xw@mail.gmail.com>
 <CAB0TPYH2G_+faZDcvoEyUmZfwP0j83P0KeZXSJdN9rJ4M1ad3w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 11:08:21 +0200
X-Google-Sender-Auth: YpEoGbrW_lwetEiYAIylc-nthTU
Message-ID: <CAK8P3a0SFua3OVzyoWxL+xtozyra5Q5D=GypkOt4hdJ0L3L5Aw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Symbol namespaces
To:     Martijn Coenen <maco@android.com>
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

On Tue, Jul 24, 2018 at 10:09 AM, Martijn Coenen <maco@android.com> wrote:
> Hi Arnd,
>
> On Mon, Jul 23, 2018 at 4:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> This looks nice. I don't want to overload you with additional
>> requests, but it might be good to think about how this can
>> be taken further, if we want to actually convert large
>> parts of the kernel to it.
>
> No worries about overloading, I'm happy with all feedback to make this better.
>
>> I have two ideas:
>>
>> - It would be nice to have a simple mechanism in Kconfig
>>   to put all symbols in a module into a namespace that is
>>   derived from KBUILD_MODNAME, to avoid having to
>>   annotate every symbol separately. This could be similar
>>   to how we ended up dealing with EXPORT_NO_SYMBOLS
>>   in the linux-2.4 days, with the goal of eventually having
>>   a namespace for each symbol. Similarly, we could pass
>>   a number of default namespaces through the Makefile,
>>   e.g. if we have a directory that has lots of drivers that all
>>   import the symbols from a common subsystem module.
>
> I'm hinging on two thoughts here; I really like it because it
> obviously reduces work and makes this easier to use. On the other
> hand, you now have to look in multiple places to see if a symbol is
> exported to a namespace/imported from a module. Perhaps it depends on
> how coarse-grained the namespaces end up being. Either way, I think it
> would be pretty easy to cook up patches for this.

Ok, maybe try it and see where we get with it?

>> - If this is possible to implement, it would be great to have
>>   a way to limit the globally visible symbols in a module
>>   to the ones that are explicitly exported  even when a that
>>   module is built-in rather than loadable. Not sure how this
>>   is best done though. A couple of things can be done with
>>   objcopy, or possibly by reintroducing partial linking (which
>>   was removed not too long ago).
>
> If I understand you correctly, this is orthogonal to symbol
> namespaces, right?

Right, the only connection here is that both try to limit the
scope of which symbols are available where. This can definitely
be done without symbol namespaces. The implementation I
had in mind with objcopy might end up using the same
KBUILD_MODNAME as a prefix for internal symbols (which
are not exported to modules), but that is a different problem.

Another related area is the question what happens to symbols
that we want to share between two built-in parts of the kernel
without exporting them to modules. E.g. if we might want to
put all of vfs into one built-in module and make its symbols
private to that module, while all of the mm subsystem is in a
separate built-in module. The symbols that are needed for
communicating between the two could simply be exported
with EXPORT_SYMBOL_GPL(), but we that would open the
surface to loadable modules that can't access them today.
Using namespaces could solve that problem by limiting the
scope in another way, or we could come up with a different
method to annotate them, such as using the gcc visibility
 attributes.

> Do you think these things should be a part of these series, or can it
> be a follow-up?

If you think you can do the first thing easily, I'd say we should
try to come up with an idea of where we want to take this in
the long run. For limiting the scope of global symbols, that may
well be a much bigger task to do upfront, so unless you have an
idea for how to do that, maybe keep it in mind but let's not make
it a dependency.

      Arnd
