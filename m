Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D3FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AD920867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cokX/umg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AD920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeKYNeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 08:34:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45447 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYNen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 08:34:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so4565532pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 18:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=hMuploDnEdcZzBOSrvREITOrPwp67uGDmyvlX5GyxQ4=;
        b=cokX/umgn0K8VfZiNzf2wcl2uEzh7cB1VECQyjEJQeDrBQoPS8Hsq4EqSVakePIPh4
         3YTsraZMtEDUKRbKEtTMzM7aiHI0PjlgNivdXUq2f2PfDzt0sYWo0HTFobRiFVhoAKTX
         QGwiJ9hILBpDD7XCOzHB7zvcyw4y1QPWKKZ+oJQ1S2Cjeo7YvVSH0TaRfreC5f5VC8gg
         IWIV/th4a0wOSbDUeQNMO9zmU7+AxZ6s8FVaxWrNoC3yKxQ30zPcdQKdJj+YTu50YDdt
         LSd+ymTCAcB/Gt0UyiT1n5foZCjxKQ3AJaKq7FsSXTKEFWbJH+K8PyWCpeZyWHHPqDIY
         sRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hMuploDnEdcZzBOSrvREITOrPwp67uGDmyvlX5GyxQ4=;
        b=tT/mMMLcTpL3dCi0rjum0cMoAUQd0GGDN1wVIsFmpb+3FESd2c50gbv1Ge2yNj1fsV
         Fot6PWELwiggkDzlowsbgfpXTza6PNx4woYo0IhRam2vpONTD7dgsy704zaRjWTZVD73
         wVwb4EnxQzvFvlYjxotQSZGqzfGywRbSyd4YOHuZBseq25YkLKlidfcTy7REsW1zOrc9
         qXbOCqoSVdybUb+q9BuTHTMwEMtRYTsatakbrfcj/gFMyJE30NblRZHY0TB5jJkORZ3D
         nD2zi8vEmr1z28j2vPJ9Rb7+PBg9ktVD7IXW/315V+Sdw/h2Hbroxx+TwWiepBLLD18y
         /r2w==
X-Gm-Message-State: AA+aEWYwV8lqN/fLdoJ2RaBLgSRFe1MTu4nqECzzo/VkJi0wFN7FCTWb
        DXQupmsBhhU08zgB1F2t7NcFCql3tIM=
X-Google-Smtp-Source: AFSGD/X01dgYZKnnTBwKTUX8u6Oh39rznqiEuigS8b/oiJwM2Ga2Ce3wsmdOCqyimbF8LZ5XZA8odA==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr19658891pgn.205.1543113884618;
        Sat, 24 Nov 2018 18:44:44 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id r130sm31790537pfr.48.2018.11.24.18.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 18:44:43 -0800 (PST)
Subject: Re: [RFC PATCH v2 09/14] m68k: hp300: Remove hp300_gettimeoffset()
To:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au>
 <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com>
 <alpine.LNX.2.21.1811202034350.258@nippy.intranet>
 <CAMuHMdVQPSE7+Pe64OybnugCx-pLVfKmNS6_4DEofF3XZPBLsA@mail.gmail.com>
 <alpine.LNX.2.21.1811211917270.275@nippy.intranet>
 <CAMuHMdVexpeYVSBMXFwu5cYt3d=w9U48m_fNTuK5awhBNnsW_A@mail.gmail.com>
 <alpine.LNX.2.21.1811212032550.275@nippy.intranet>
 <CAMuHMdVzamshSdhDAnxdzq=YiQMvDhrE03UmJxHJLHr6g=u44Q@mail.gmail.com>
 <alpine.LNX.2.21.1811212129520.275@nippy.intranet>
 <alpine.LNX.2.21.1811250953120.10@nippy.intranet>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <36b78174-5038-a1ac-4c70-d84a34edd275@gmail.com>
Date:   Sun, 25 Nov 2018 15:44:33 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1811250953120.10@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 25.11.2018 um 14:15 schrieb Finn Thain:
> Maybe the timer interrupt has a sufficiently high priority and latency is
> low? Maybe cia_set_irq() is really expensive?
>
> I don't know the platform well enough so I'm inclined to revert. We can
> benchmark gettimeofday syscalls on elgar but is that hardware
> representative of other relevant models?

I suppose the CIA is on the main board, so running with the slower clock 
speed that you'd see with a vanilla Amiga without 060 accelerator board. 
Ought to be representative enough?

Adrian has a few other Amigas with different hardware base, so we might 
be able to get test coverage on more than one model.

Cheers,

	Michael


> [1]
> https://github.com/mamedev/mame/commit/e2ed0490520f538c346c8bdaa9084bcbc43427cb
>
> [2]
> http://vice-emu.sourceforge.net/vice_9.html
>
> [3]
> https://www.commodore.ca/manuals/funet/cbm/documents/chipdata/cia6526.zip
>
