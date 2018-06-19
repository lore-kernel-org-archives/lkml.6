Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B681C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF582083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTAYRlF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF582083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937744AbeFSMPB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:15:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35525 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937392AbeFSMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:14:59 -0400
Received: by mail-qt0-f193.google.com with SMTP id s9-v6so18073700qtg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HCQo8UQgwxQb5+Rc67Gmp6LwPx2iN+7wDXtGQs182S0=;
        b=MTAYRlF62GtIBeT3h6WRLsI6vPbryGQPNHI6OQn920+WqZG8efV58KlLsiY83xNqMt
         viORoL4u5FiLX2AHb1YJl3eSfGTwM/jwvHhCa2+08MoTv9WmAKtvxYvDLICxU2kPW6rr
         dSum8akhgd0N2uwdtZj2I53LpTXukybOFCgS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HCQo8UQgwxQb5+Rc67Gmp6LwPx2iN+7wDXtGQs182S0=;
        b=IGQfEXj9L3mOo5TUdFlGHMmuprs/fWWxQZQA2X4qxTFRsTXdhJsKuwuKcPvssDbDxZ
         SKzVA+eLGu177sC9r/hybHf1XwEt/f6QDLyb6Cu3OGMeTShzCySmvJYDk73Ovbw3e/f3
         5OPGaAczMmuLEk6yWF7/8wvRUL3YzaUL5whQUYT+kozYz74YK6leWp3PlvAVnm4s5uR9
         Iu2pOXqqbnZCrQjafcdmB6kwrrfUQGEj4dFJl2NeC4oO8IPwRt7hH2SSbXHtBlZ4uaRb
         fllXx9RJQYJibPOHc6wE3sMh1NTAUBl0MvorR9yV8xKNTFR783oXdpIYQpQhUnoO7oT4
         r8oA==
X-Gm-Message-State: APt69E0eB6wx7gh3CS7HYYkkn7rPcnX04qImaz9+eoxpDHiHmOinTTCq
        7T4n8MNZc4NXN4CxEyX0EHssEQ==
X-Google-Smtp-Source: ADUXVKKJfvjDy22BTKLM/H0rOMmgKeeibo88F9jMv1RKcVDkjun+c75/UwKuklJf+hPUwjNeLvCbrg==
X-Received: by 2002:ac8:26c3:: with SMTP id 3-v6mr14791346qtp.151.1529410499093;
        Tue, 19 Jun 2018 05:14:59 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id a18-v6sm12925533qkj.60.2018.06.19.05.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 05:14:58 -0700 (PDT)
Date:   Tue, 19 Jun 2018 08:14:57 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Joe Perches <joe@perches.com>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] vt: coherence validation code for the unicode
 screen buffer
In-Reply-To: <800831730e3aeaf4da23f7f97cfa80103236c3cb.camel@perches.com>
Message-ID: <nycvar.YSQ.7.76.1806190812550.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org> <20180617190706.14614-5-nicolas.pitre@linaro.org> <CAHp75VfG_4zw+NPuHTUyH-gzdktiCKVcnWcwo0D_fAgfPbdk+A@mail.gmail.com> <nycvar.YSQ.7.76.1806182110450.16670@knanqh.ubzr>
 <800831730e3aeaf4da23f7f97cfa80103236c3cb.camel@perches.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018, Joe Perches wrote:

> On Mon, 2018-06-18 at 21:50 -0400, Nicolas Pitre wrote:
> > On Tue, 19 Jun 2018, Andy Shevchenko wrote:
> []
> > > > +       /*
> > > > +        * Make sure our unicode screen translates into the same glyphs
> > > > +        * as the actual screen. This is brutal indeed.
> > > > +        */
> > > > +       p = (unsigned short *)vc->vc_origin;
> > > > +       mask = vc->vc_hi_font_mask | 0xff;
> > > > +       for (y = 0; y < vc->vc_rows; y++) {
> > > > +               char32_t *line = uniscr->lines[y];
> > > > +               for (x = 0; x < vc->vc_cols; x++) {
> > > > +                       u16 glyph = scr_readw(p++) & mask;
> > > > +                       char32_t uc = line[x];
> > > > +                       int tc = conv_uni_to_pc(vc, uc);
> > > > +                       if (tc == -4)
> > > > +                               tc = conv_uni_to_pc(vc, 0xfffd);
> > > > +                       if (tc == -4)
> > > > +                               tc = conv_uni_to_pc(vc, '?');
> > > > +                       if (tc != glyph)
> > > > +                               pr_notice("%s: mismatch at %d,%d: "
> > > > +                                         "glyph=%#x tc=%#x\n", __func__,
> > > > +                                         x, y, glyph, tc);
> > > 
> > > Don't split format string in printk(). checkpatch will not warn on longer lines.
> > 
> > I didn't do it like that for checkpatch but to keep the code readable.
> > I don't particularly care either ways though.
> 
> If one glyph is off, then perhaps others are off too.
> Perhaps this message should be ratelimited.

Remember that this is costly debugging code that is off by default. 
No production kernel should have it enabled.


Nicolas
