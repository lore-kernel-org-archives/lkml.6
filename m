Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77517C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326D825489
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH1y6gxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326D825489
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeFZRO1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:14:27 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39990 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbeFZRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:13:46 -0400
Received: by mail-ua0-f194.google.com with SMTP id j17-v6so4977904uap.7;
        Tue, 26 Jun 2018 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BJ2BGBnGIXcyX31x6KMlsF1I+Al7HxzsfbpJYdJDzCY=;
        b=FH1y6gxHisTx5Kgri9I8NCynGeiN5TN0c6GbPfEeNjkxjneypl8JZ0UEihkzBQZ97z
         YJvKo0hCt5Qco+2pLufDRjihqLcB8CEwyLJXpbuqx41ulkNRHvGUiYbNTKwa616Y3Yqd
         ArPoLU8JsX3kOwzWMFVDixHcOdBygpf6Ox5nJQsaqYXWk3mmmihzlUbJYogPefpDfB7A
         /VWjSPVi24+6d9PvRSRCQ8/vOvvyhkOTWHbT6o+ELJp/YPoTlOUPp+pyiYVgnN/LIHN3
         EViGkaImRCnbsbWaXbpbZPSTJSFIs8lG/wAZ8hveN9UTJCIHPyzqwwzN+xzzn/Eyw1y7
         7ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BJ2BGBnGIXcyX31x6KMlsF1I+Al7HxzsfbpJYdJDzCY=;
        b=CuSS0a1F/h2zRBFC+D91VwF2yalpRRPBj70A90D9bCiTWWSLpNHN09o65Kv7ByMkb1
         2w5mQjP2zXBicVUOUYsN+9NBofGVtrYfFh/mCvunQ/ANrpJci4XvJ0biD6i3BTqnH0ay
         2fmS4G1MzF/X8QDxRNEKzYm03RaEHo0CvD4NWSEK9KpYt7dq1vH3pGgXQarbFmCTinf2
         Q7UXGXPLur5d4F0uEP1vd00CQ+35VRc6qHQDBA2OeAoTlQ9dKqXxqEtLIA05kn6+PsKw
         QBveso6sxGhAS5GdH5mKOWZpg8L3CqL98LVr96fIzbPEPMgf/kLe+0ZcRq7wStxYIt6m
         CDmA==
X-Gm-Message-State: APt69E3VB2yRlklhN0GH8gFn0GcnqDL4u/8JqxNmzWzcqVAhZ+/7zVVV
        Sm3LRX7RW4R3JUi98UhnNeafkvbvdWHdwqbFB6wz1Q==
X-Google-Smtp-Source: AAOMgpdHLRQINLJ2MpNgEcjBCGnQjiMVYSFFzAk3H6Ai17WV053oG2UNE9EjY5oeIPfJnjuWZJ+iTqxdMQhY8vRCXTc=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr904089ual.28.1530033226094;
 Tue, 26 Jun 2018 10:13:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:13:45
 -0700 (PDT)
In-Reply-To: <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
References: <20180626135535.2990-1-hdegoede@redhat.com> <20180626135535.2990-4-hdegoede@redhat.com>
 <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 20:13:45 +0300
Message-ID: <CAHp75VeTvdh8Cd9crQzX_sjM1h2Zb1oQQ3VodJgEDhaF1YT2-w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] console/fbcon: Add support for deferred console takeover
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 8:12 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jun 26, 2018 at 4:55 PM, Hans de Goede <hdegoede@redhat.com> wrote:

>> +       for (i = 0; i < FB_MAX; i++) {
>> +               if (registered_fb[i])
>> +                       fbcon_fb_registered(registered_fb[i]);
>> +       }
>
> Simple git grep shows that we perhaps do
>
> #define for_each_registered_fbcon(i) ...

(Or just ..._fb() since it looks like iteration over framebuffers, not
exactly consoles)

>
> (As an example see for_each_pci_bridge() how it's done there)



-- 
With Best Regards,
Andy Shevchenko
