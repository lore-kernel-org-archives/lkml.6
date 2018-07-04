Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93198C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4499D240F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCTb2371"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4499D240F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeGDQZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:25:31 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38946 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeGDQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:25:29 -0400
Received: by mail-vk0-f66.google.com with SMTP id e139-v6so1913067vkf.6;
        Wed, 04 Jul 2018 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gWkxPob4hVxMpjgoYPTVe7ypEjFM9mlZM7ERDkEtjuk=;
        b=FCTb2371DhR8olaL8jB2TYJx2+fELqswO4S/pMyVQdi5K/IVSMpztiDtEM9Y5KvdAV
         hfhodWDz+pInK5vsyR0pIThwbjZBIHh9zG6EfELLEP19BASfsdj9KiLAzPLAhLoAfD3b
         wHzVyVhDA3nWpQqD/cqInPuNQfMPcBrwqH4sON+SvJ+RP3yZDkgft6WiQxraRrQ4eJOF
         VFhN47+c8d7pj48lLXu8F4NXH8sdiobEGwH44XzDwYzlHN96EG0RB7099rtJWpeE2TuP
         w9zs8pI8LmcYw5e4vmLeB0liw8di82+ZjxY6ee0e6IjRYY3s/t7i0pRA0+NK+jrzB0AT
         XuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gWkxPob4hVxMpjgoYPTVe7ypEjFM9mlZM7ERDkEtjuk=;
        b=TIK/x7nlvOuElv8jsooixvYhzyraYTZ3eD/igZ6ZJHMKlJGu4R3l80x7TRGVBITJpK
         KdqQ0Y7+0hsAHfOTOhMIYGmlYHJraKtsZ1eOl+pBHQwE0e35ir2OKERF3ZWsybMdUx1f
         mdW3J0rOOcX2XLZKhKFxOmMs0LhH7LQc+LxhUJ15ScSAf0yMKf/Pyv0gEEFqBJmBykhP
         X2WRTLFvo5l3ZSAhcKVUCth+OnGQdwTe+GC+tApVaEmmnpLE+CymTFIr/23BHnsWD/jr
         vFmRftWujX34cr1lMGq9lFrwvsweibVIM5+0SbZh4vTLe6VYlBDg4teQPpLWyBTZhBaR
         Dp1Q==
X-Gm-Message-State: APt69E0dL+QO9HtaS4/+XyDzFmxCFAuXIq9CU3x5MOeHrbg3k4Jh48fW
        iMRhiJdojjyGxt1/7r2oKG/CiAomsdOdAYqY4Qg=
X-Google-Smtp-Source: AAOMgpeFxbVu+3mWB3UY/XQ2omVm+I9QMKLEDcAkkwndBNXkxo84MDo/2l4ft4YYuRbD/E1QlmxcYvx4E86JsuZM7Dg=
X-Received: by 2002:a1f:7d09:: with SMTP id y9-v6mr1471688vkc.15.1530721528792;
 Wed, 04 Jul 2018 09:25:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:25:28 -0700 (PDT)
In-Reply-To: <20180704024112.GB9015@1wt.eu>
References: <20180703155328.GA18299@arbeit> <CAHp75VcQmUPCqzteHs=EaA5h-ABAQ=GWuLVRGWL3meMKZBJ-iQ@mail.gmail.com>
 <20180704024112.GB9015@1wt.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 19:25:28 +0300
Message-ID: <CAHp75VcPAdTQKreEChrnS=izjb+vKGLMT5mYYEXCoxGs+eRzeQ@mail.gmail.com>
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, ben.whitten@gmail.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 5:41 AM, Willy Tarreau <w@1wt.eu> wrote:
> On Tue, Jul 03, 2018 at 09:43:06PM +0300, Andy Shevchenko wrote:

> Well, in this case it's even possible to go further and avoid storing
> 36 strings. Indeed, no representation is longer than 5 symbols, so you
> can use 5 bits for the encoding (0=".", 1="-") and 3 bits for the
> length, it gives you a single byte per character instead of a pointer
> to a string plus 6 chars. Then in order to make it readable, 5 macros
> can be provided to emit the code :
>

Even further something like

#define MORSE_PACK(len, code)   ((code << 3) | len)

> #define MORSE1(a,b)       (1 | ((a)<<3))
> #define MORSE2(a,b)       (2 | ((a)<<3)|((b)<<4))
> #define MORSE3(a,b,c)     (3 | ((a)<<3)|((b)<<4)|((c)<<5))
> #define MORSE4(a,b,c,d)   (4 | ((a)<<3)|((b)<<4)|((c)<<5)|((d)<<6))
> #define MORSE5(a,b,c,d,e) (5 | ((a)<<3)|((b)<<4)|((c)<<5)|((d)<<6)|((e)<<7))
>
> Then all chars may be defined like this :
>
>     ['a'] = MORSE2(0,1),
>     ['b'] = MORSE4(1,0,0,0),
>     ['c'] = MORSE4(1,0,1,0),
>     ['d'] = MORSE3(1,0,0),
>     ['e'] = MORSE1(0),
>     ...
>
> and when processing these :
>
>     code = morse_table[tolower(c)];
>     code_len = code & 7;
>     code >>= 3;
>
>     while (code_len) {
>        if (code & 1)
>            emit_long();
>        else
>            emit_short();
>        code >>= 1;
>        code_len--;
>     }

Nice!

> In this case it could even cover the whole ASCII table at once since it's
> not certain that the saved bytes compensate for the extra code and alignment
> used to save them :-)
>
> Note that I'm not suggesting that it is required to proceed like this, but
> I think it makes the whole code more compact, which aligns with the purpose
> of focusing on embedded devices.

-- 
With Best Regards,
Andy Shevchenko
