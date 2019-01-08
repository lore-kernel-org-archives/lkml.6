Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC28C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6755D20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbmmFUjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfAHWTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:19:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45456 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfAHWTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:19:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so2580840pfd.12;
        Tue, 08 Jan 2019 14:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/O3sY8celNMvtR9WhIqaTjCanK7+dtn6FuJgraOR7Uw=;
        b=fbmmFUjh8COCYh5vjmZyvsTK03G99sIrzefroQ5j2Uu9CO9ADuBlP173v5pOy8mkv9
         ciWJf5mnLE1UPL7SQi4Yiags1nwwvcqUkSlMhsqptXAjFJMx6tZ01b5pPtOdHzspitut
         Vo597QJWW7ki/mitT1ERlnnvD4obEg0SxPk4+rLodY/MZ5FSEekGfjTcZVXqbE+1kSn+
         Cif7+1EG12rKvpIR+fR3PktyXs/SvTFO4h/5kk/jAXtAlDMGofTanPAFiKqfiZNGkVsY
         Bn5TvhtCbKZx5nVhnJGTdkzyaTR5pJyaBdmz/NAkWosY9WfgkLCGIPoPVvLQn59zi3+9
         vnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/O3sY8celNMvtR9WhIqaTjCanK7+dtn6FuJgraOR7Uw=;
        b=Io+OjksIWlL6FuYqvR1jWgnM08+FAerXWdbp9vtnDoAa0trEQHqFrnR2WFh2aMGVsb
         hDWRqcqb0rvxXUs4cdXudkPGB/EpJr76EsRQAiHhExgukzr4T5wir+xJtEyM147Uu0o4
         v0Ad6JtYyV1so9ItZ7Z/F2VukYqWMDMXV3RrrtF0Tz/fvS0Q79UEkevQBL/w+vfu4j6z
         hWp1pRgn5UIEqcx2urrOSSs2Idl72zd9Y/JhEEoQ4lVV2SL/Rw7WGfsQ1yuF0E8s8erV
         7GUOP7qFTd4kI5p86ZWCJEM9igkHZYj5Xt/d1qIy88Xuw0QsMWYGHS1k+h8kBLWaBAkb
         NCrQ==
X-Gm-Message-State: AJcUukeTo2wcjst3FJU2rvgCuacWU3Zt7f0MbeuKKSUM9Tiat0zQjb23
        22BeOtDznYrWZbWOw6PcEIQ=
X-Google-Smtp-Source: ALg8bN722fGi+WjBj2KsQHVwIaf0ObT5Q3kuvGLXfLoHV5w7jFnlyoDS9iIt/nAZXcGQ99DTQT1vKg==
X-Received: by 2002:a62:2547:: with SMTP id l68mr3428061pfl.131.1546985973598;
        Tue, 08 Jan 2019 14:19:33 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
        by smtp.gmail.com with ESMTPSA id v184sm99160620pfb.182.2019.01.08.14.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 14:19:32 -0800 (PST)
Date:   Wed, 9 Jan 2019 07:19:30 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-riscv@lists.infradead.org, Greentime Hu <green.hu@gmail.com>,
        linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        openrisc@lists.librecores.org, Mark Salter <msalter@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH] arch: unexport asm/shmparam.h for all architectures
Message-ID: <20190108221930.GQ3235@lianli.shorne-pla.net>
References: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
 <20190108111032.GP3235@lianli.shorne-pla.net>
 <CAK7LNAS+grgqHM-ht0CCTmZHp+JRvr=Q+sJOo0URqRgTAYRs0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS+grgqHM-ht0CCTmZHp+JRvr=Q+sJOo0URqRgTAYRs0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:32:28AM +0900, Masahiro Yamada wrote:
> Hi Stafford,
> 
> 
> 
> On Tue, Jan 8, 2019 at 8:12 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > What is this patch based on?  I tried to apply it to 5.0-rc1 and am having an
> > issue with applying the arch/openrisc/include/uapi/asm/Kbuild part.
> 
> 
> Based on Linus' latest tree.
> (commit 3bd6e94be)
> 
> v5.0-rc1 is NOT the latest.

OK, understood, in that case:

Acked-by: Stafford Horne <shorne@gmail.com>

(though I see its already being picked up on the -mm tree)

> > It seems shmparam.h is not there. It was removed with the others in your
> > ("d6e4b3e326d8") arch: remove redundant UAPI generic-y defines, commit a few
> > days ago.
> >
> > Note, I can't compile 5.0-rc1 without the first part of this patch.  So please
> > get it merged asap :)
> 
> 
> I notice the breakage of several arches after v5.0-rc1 release,
> so I asked Linus to pick up 3d6e94be.
> 
> I had already noticed
> having shmparam.h in uapi is werid,
> but I decided to fix the build errors first.

Yes, that makes sense.

-Stafford
