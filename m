Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F15ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AD52087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfi6VGWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AD52087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeGOUsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:48:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38702 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeGOUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:48:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so13813217edr.5;
        Sun, 15 Jul 2018 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GnF7rpB5BIcd3cXEUi6q07BScRjEc8KTcZ2LAQWwzyA=;
        b=dfi6VGWV92P9hF/YpdKdaXbralXGe3PZzQD+Mo9rEhFHuYJitG1e8pbLYrKJXl4fgA
         nkI00GHZRjOdUiT9INJklZwDJG7KNvzu/GYIEKJOIcgoZkhfcWeq6hLFLrUcv0CowbGa
         Zuv0MuiMyyvXpvPSk+r4ARm9XuVMvCPXPTFeztHhO8JKR+dxXmeFSaJ75kGCHYaaShLW
         jkqUCL1VV4NeNQnNMweDtPdb/t8H6XLppfp97Jv8GMeg3lV8HwS568cstAqh6rkMCA3/
         TWm031dNBuPpFw/ww2NMu0Y7CY55QjVgkGOZILWv9sKelUCayten36QILsr4j6PWSLMp
         zaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GnF7rpB5BIcd3cXEUi6q07BScRjEc8KTcZ2LAQWwzyA=;
        b=qiNAXiZPzACLeWwP4gfPl4mVHUYXBGaQyfbyLUr8PCdXirF6V+uB/2w1twtuH8hzBv
         5fK2FjXCmL6nyg5SX8q0BCfDRBdMboswodd3RFbKJruvqZ18T2ePQA+hZLe71QGAWBQ4
         h7SQUHc0UITVQfg+lvcFv4o8e1dscLf3O9Aoe/8j99vsM2WvREU4TUATUxW6hwQ137dS
         qrM13OnaNxmGYPtFPyjlst3wCzt6prJz/Di0P4T+IX1pL4CcuJ78rzd1h0f3nvI+w2t6
         oeeAgKjJHiWjAKawd0cLJAckHj2K897s+ry/1/EtLZ6ZgcmGqtxf+5AuKUK7Py/JSId/
         1IzA==
X-Gm-Message-State: AOUpUlHL9BOsEvODlYh8nz2MCmpZkDx8CXvuT2nKTuz6ViA+nsm/12gX
        2gew0R3b3/JrPMKKzQ+6W34=
X-Google-Smtp-Source: AAOMgpfjHy+LKjPTQ5PkYutHtlLKI2mzgRWAcWeIzQAUo62GNpR1MJNM5XevwnOls0yI50y9/i65nA==
X-Received: by 2002:a50:b134:: with SMTP id k49-v6mr14204646edd.55.1531686244967;
        Sun, 15 Jul 2018 13:24:04 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40eb:a400:5c5e:e203:2588:6f7b])
        by smtp.gmail.com with ESMTPSA id t7-v6sm3051259edt.33.2018.07.15.13.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:24:04 -0700 (PDT)
Date:   Sun, 15 Jul 2018 22:24:03 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] kernel.h: Avoid that sparse complains about using
 sizeof(void)
Message-ID: <20180715202401.ed2cm3yo6ovg3nei@ltop.local>
References: <20180705161709.17028-1-bart.vanassche@wdc.com>
 <CAGXu5jJJLh+oMcZ94nkrwCvyJzk6MzOATvt66WC-rHfxGTJh0Q@mail.gmail.com>
 <CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 06:57:57PM -0700, Linus Torvalds wrote:
> On Sat, Jul 14, 2018 at 6:49 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > I'm fine with this; it'll only activate for sparse. I'd like to get
> > Linus's eyes on it, though, since this macro caused us SO much pain
> > that I'm nervous to change it without some greater level of review. :)
> 
> Honestly, I'd like to just encourage people to get the sparse update
> from Luc Van Oostenryck instead.
> 
> For a while there it looked like Chris Li would just pull from Luc,
> and we'd have timely releases, but that really doesn't seem to have
> ended up happening after all. So right now it's probably just best to
> get Luc's tree instead from
> 
>     https://github.com/lucvoo/sparse-dev
> 
> which also ends up fixing a lot of other issues.

Thank you.

I'll try to move my trees to kernel.org in the coming days or weeks,
it will be better for everyone, I think (I just need one more
signature on my gpg key).

Meanwhile, I prefer that people use my 'stable' tree:
	https://github.com/lucvoo/sparse
(never rebased, only contains the master branch and one backport)
while my sparse-dev repository is mainly a bunch of topic branches
in diverse state of development (but the master branch is the same
so it doesn't matter much).

-- Luc
