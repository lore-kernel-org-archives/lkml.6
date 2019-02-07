Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F75C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A421872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGxSnork"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfBGRCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:02:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54127 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfBGRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:02:12 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so1446732ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yekiINZOvow/56QtEZFZV4uAzjjuHYvfcb4vk7nERI8=;
        b=KGxSnork5ZdIVpsZ2ZAk3VXpWfz0y58EMcD2qqCIhB2/hauyLjRlpG9lFDVj5OWz4e
         v0LTYvuOAL4BokiAvQqvdUfbaai+UBeaOaZctkVedMO/atnyyEZcTd2MaZM6PVFv8GDP
         UGGurdCGV4Tkm+ceVE7af0QKAF7Tga7wSIgCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yekiINZOvow/56QtEZFZV4uAzjjuHYvfcb4vk7nERI8=;
        b=iwnIQDojUm0Ol1RSmCcmD/xi1/kwy+XgoKf5Jr7MFpltiRMbA5UHZSntpIXhiyNoaN
         G7kjWQGc1t8ehF9tEBnLkaL2B/twynkzJ5ryRsm+VFgHj5Ib/+Hn0cHMXE1jG89sLBGL
         DzhllzVcs420t6wiycFS9D6sxgMlOvROB1WKNKAeoG5vQJOtDCHYfyvZ+ueZ88Pn7Pqu
         YQVCbz+/nMOiVC0JLkrNSIHAIY9aFg5WNgXSY0K+QRkUu3UPNAoDCtPr8SHeHU6WMGWZ
         u6Eizu6N2IcD/QEM11n6n1o/vwX4y2TO8Rdedx/vTfB9DqXEKxBgTTytkz79f8dvR9Ws
         a8eA==
X-Gm-Message-State: AHQUAuYFfXH9Zcd2bWhGsOpFUqYAYZj7syWOeKoKHZzkdGNLjzNRFsmJ
        1klRR8cUEePeuBIV0bR8PlgoayMUj+w=
X-Google-Smtp-Source: AHgI3IY+F2kXTW1wrbVaf5Iqq0KwM8OXmBpxwxLQUh+3sbN2tDrepkg6Gmqju2CrxmvZuS9UEE8qpw==
X-Received: by 2002:a5e:aa18:: with SMTP id s24mr9811164ioe.151.1549558931184;
        Thu, 07 Feb 2019 09:02:11 -0800 (PST)
Received: from mail-it1-f176.google.com (mail-it1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id u126sm5727711ita.1.2019.02.07.09.02.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 09:02:09 -0800 (PST)
Received: by mail-it1-f176.google.com with SMTP id i145so1428673ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:02:09 -0800 (PST)
X-Received: by 2002:a24:55ca:: with SMTP id e193mr5929100itb.119.1549558929044;
 Thu, 07 Feb 2019 09:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-2-thgarnie@chromium.org>
 <20190207114850.GD2414@zn.tnic>
In-Reply-To: <20190207114850.GD2414@zn.tnic>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Thu, 7 Feb 2019 09:01:57 -0800
X-Gmail-Original-Message-ID: <CAJcbSZGzTZmkpCWC3VbLJ7ygkxiRSAfq+GNOkHUungUEjiURTw@mail.gmail.com>
Message-ID: <CAJcbSZGzTZmkpCWC3VbLJ7ygkxiRSAfq+GNOkHUungUEjiURTw@mail.gmail.com>
Subject: Re: [PATCH v6 01/27] x86/crypto: Adapt assembly for PIE support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 3:49 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 31, 2019 at 11:24:08AM -0800, Thomas Garnier wrote:
> > Change the assembly code to use only relative references of symbols for the
> > kernel to be PIE compatible.
> >
> > Position Independent Executable (PIE) support will allow to extend the
> > KASLR randomization range below 0xffffffff80000000.
>
> This sentence is auto-sprinkled in a bunch of commit messages. Sounds to
> me it should be rather somewhere in the 0/n message as a justification
> for the feature but not in every other commit message...?

I go into more details in the compose message but I wanted a small
sentence explaining why PIE changes are being made.

>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
