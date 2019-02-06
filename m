Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83743C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4519C217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsxiwBGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfBFApd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:45:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45578 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFApd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:45:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id j3so167636pfi.12;
        Tue, 05 Feb 2019 16:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q/8XiG+wkXa7W3/S2KFGpbojZP5o7LDIgwemY4fgXYI=;
        b=SsxiwBGnwvK77MdpSDJp+O1131ULkmQHOlCPQ+ECoHDY6S+gFExDkDKAyWNZWzal/S
         a5fxIRYFnvLN0AE66XqosnaK0g5IYSa5obRQZM5bZlLaLnZ1f8oji57/i2/JN8b4j85r
         tCKwb38477IYenj7sRv1YjvQIJ5LD8Xn+FjManUiql9rZ5QtJHIC+lPy/b4IEzgnbtCj
         f3dGr0KgkrIql646LAyBB+aTef6HL6XG0pxmMxbTF2pktB3GO/3inANp2cNhPSfW2QzK
         AtDlUeaTM7HHK/Gbm4TGT+0IqbJ8nAsxXDqEWUy8l5ulTrrbbNC39ZAiXSE4f9vYb/WM
         jn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q/8XiG+wkXa7W3/S2KFGpbojZP5o7LDIgwemY4fgXYI=;
        b=gptCZe0PgAPfirXHRFmnYGTysAgD95MPleTp8SNnpS+Y/C7breLDlE6ICptHl1osRY
         n6dUljQ5Oc4hj5x4LskJOpQEk6AZXkfI+zvop48afGegx3Hw0UgWaEiwW5E70lpfVCK3
         QAX2gI3Yyizv+PyWCoW+H7h6BgG19zHBcVLkp63r3oXxbX9MPiS4fQXDqEfoPsXgMRdd
         9/asyXf2jnHFzjIjphFoJHT8R8TRzIsPA6ZjxaiZTzeusRu+ybYAoNJThj1o5NWoN2HD
         J1PuH195AOcIQGypPKyVXpYanbt6Wpt1Wxikh/nIZk/BC4cvNqHC/gQppoYQxNxpIDd6
         mkyQ==
X-Gm-Message-State: AHQUAuZGKsH37afXxmc0aGxR2t/yU/330tNa65E8jf41bZwE32YCYsOS
        rOnsw5nv8aViAdEIWsfzUiQ=
X-Google-Smtp-Source: AHgI3IZhB78Hp0k4kEuVLw83F5KYttRGF6aNnWzHdnTQeRqvzwo5o2DdFCEa4NTg+pO6wLpBK+RVfQ==
X-Received: by 2002:a62:4c:: with SMTP id 73mr7701973pfa.24.1549413931917;
        Tue, 05 Feb 2019 16:45:31 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v14sm9057412pgf.3.2019.02.05.16.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 16:45:31 -0800 (PST)
Date:   Tue, 5 Feb 2019 16:45:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH] Input: gpio-keys - Add shutdown callback
Message-ID: <20190206004529.GC19151@dtor-ws>
References: <20190201192417.15037-1-f.fainelli@gmail.com>
 <65d6350f-2cd8-c183-6d8b-dbb11ae31819@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d6350f-2cd8-c183-6d8b-dbb11ae31819@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 02:02:49PM -0800, Florian Fainelli wrote:
> On 2/1/19 11:24 AM, Florian Fainelli wrote:
> > On some platforms (e.g.: ARCH_BRCMSTB) it is possible to enter
> > "poweroff" while leaving some wake-up sources enabled such as key
> > presses in order to allow for the system to wake-up.
> > 
> > Wire up a .shutdown() callback which calls into the existing
> > gpio_keys_suspend() since the logic is essentially the same.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> Any feedback on this?

OK, I'll take it. Hopefully it won't affect existing systems as the
change is unconditional.

Thanks.

-- 
Dmitry
