Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32EDC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7275F25156
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DIAaMZ24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7275F25156
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeGACHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 22:07:46 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36302 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeGACHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 22:07:45 -0400
Received: by mail-io0-f194.google.com with SMTP id k3-v6so11793912iog.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 19:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZob7ibensEYRTV61BkKrNv7QnqAjn20F5AgbJgIybg=;
        b=DIAaMZ24qYkmk137YQ0VjN+fsrxo/E1j2e0cjxuW+C6VItv4H4mMTyoe5ZCrfo8m4A
         gFfF2U6WmbHN7QBgO6tWm/eN6S6WaAjHqUxk+a1xdKQmf1thY8OKwWOlhgdUFV9/eo1U
         J8/JKYq3MuksSiW9MsnlMM95Nwdooii1wT+eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZob7ibensEYRTV61BkKrNv7QnqAjn20F5AgbJgIybg=;
        b=QUBZGX83BiUOho7TauIpeQKPOQciKY1f6sPUJgmueLxUIU4DxGKqXCEdQgr3jH6uuI
         OvF5RSxibU7JT+Ha7tCBw20tBG3TsH00MUkZZyP/68LSviVczrDeeiMxBGeyVgUEyq4c
         H9EtLdV2Bcg1BpwK9+bnA0RZJ3c8RayNYGEctPZEZoQREkMCt9WVAMFzmTRPut74pHkl
         5R2bAYnFn5v6JK4GF3/IIu3frXdqudMSQ9QBVASvrJG8L4tA4T5CGuMmPRLWASdnYrKh
         f1Y6lG0hjadF0GQs8r0W0i34iBT0TgqwhyUcD9KZD/brn4MUZHOR87q7Rt+lDAz6dlhc
         w7lg==
X-Gm-Message-State: APt69E3j3iAI/8AX8xkdri9jCUoWJ+TR7rVzA5WL75KJ5RR7QTzKIUf7
        v+3gcI0U6c1rnawMEa+O4UL+dq1rnCt9LN5Clv9yyQ==
X-Google-Smtp-Source: AAOMgpcbR7hlgguZlvCGgy0gfI3KipAFR0JfJVDIyjnV6zwRBzNMWUU/9ekEY5WjlnFyt5uGSEpbUnuvaxmFlv/+9pA=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr17687057ion.259.1530410864814;
 Sat, 30 Jun 2018 19:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
 <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com> <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
In-Reply-To: <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jun 2018 19:07:33 -0700
Message-ID: <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Ben - feel free to post the missing emails to lkml too ]

On Sat, Jun 30, 2018 at 6:56 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Sat, 2018-06-30 at 12:29 -0700, Linus Torvalds wrote:
> >
> > Because normally, the last kobject_put() really does do a synchronous
> > kobject_del(). So normally, this is all completely pointless, and the
> > normal kobject lifetime rules should be sufficient.
>
> Not entirely sadly....
>
> There's a small race between the kref going down to 0 and the last
> kobject_put(). Something might still "catch" the 0-reference object
> during that window.

That's only true if the underlying subsystem doesn't have any
serialization itself.

Which I don't think is normal.

IOW, if you have (say) a PCI hotplug model, the PCI layer will have
the pci_hp_mutex, for example, which protects the PCI hotplug slot
lists and the kobj things.

Those locks won't protect kobj races in _general_ (ie there is no
locking between two totally unrelated buses), but they *should*
serialize the case of a device being added within one class. No?

If not, maybe we need to add some class-based serialization.

> I think it just opens an existing race more widely. The race always
> exist becaues another CPU can observe the object between the reference
> going to 0 and the last kobject_del done by kobject_release.

No it really damn well can't, exactly because we should not allow it -
and allowing it would be fundamentally racy.

We should never allow a kobject_get() with a zero reference count.
It's always a *fundamental* bug - see my other email on your 1/2
patch.

So there is no race, because the reference count itself protects the
object. Either another CPU gets it in time (before it went down to
zero), or it went down to zero and it is dead (because at that point,
deletion will have been scheduled.

Note that this is entirely independent of the auto-clean actions,
since even with absolutely zero cleanup, you still have the
fundamental issue of "reference count goes to zero causes the object
to be free'd".

              Linus
