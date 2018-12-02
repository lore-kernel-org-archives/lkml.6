Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500FAC65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C7A20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmrWPVeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C7A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeLBU0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:26:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36667 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeLBU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:26:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so10057344wrs.3;
        Sun, 02 Dec 2018 12:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s7MLxOLgy54TthfzdvQqHtgHm8zv/9fThKbgwRvdpVM=;
        b=SmrWPVeMp763B6LtYCYlKA9vmxoi6Z7EmHBM8uEocYHgvG9Azt3BSsm6Ceb9zaKc+x
         +IzuKYlX566MkJqoyquGbhpVG1LNKZpGdv2cc5pbtNt013igktfmXnyvZ/8JKFciZDO2
         DSnIAp1NQXkfOZs3zqAOY/MtfwsByhr0FHsha0XxuMSxn74DTp2wY0v8PtLTEIb1sxNo
         jEKO85XdFBHTDin7+LxTzKSdKiC7dtAxIuXJ5e3KaH7Y17FDddTABzuii1c873MOpxi0
         dtTbKp9q5SHxmO5Nze1lHp5fUYlY+c/vOOlZ3B+9FtrzKTl7NjrpGEKBwLXeR+dNwS2d
         82Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s7MLxOLgy54TthfzdvQqHtgHm8zv/9fThKbgwRvdpVM=;
        b=ioc5my91nAws7pRIWwwvfCnUhwufKnhsYNhwmjcP6dunu9gHU5jcOF+H4TH8DnUTHe
         4DKyv5VtL2a2gofqrBx4oDP/bgnK1XfzSTs+JUQezOiBMDvNiCxPcLnpJNhgbbcgoSoy
         Zt40ymis0/S0Cl0VKW2mqgpi3h/oikBZ4TbTr30sBrjTokc7LLMQgFaf/8lj7ArErY1A
         UnocnnH+OnXDzFAkoQD87vW2c0fICDm0P70Qggge6ejtzOsM5VlKbARbpGC8Cv4FF0Xm
         3+mUJu4Io7S7+pr5N3bZOpa0iY10aUhCpp0v9ySu2FuN/C9ZYDPrGQzffZU2YMGcC0C7
         qxbQ==
X-Gm-Message-State: AA+aEWYDff1fQyYjlCW5Ly/VO9dn3/wS8gLgR06Gcy3AesLTlWvGWO55
        n2T9+NJ5Uvz0Nccm09G3ZFg=
X-Google-Smtp-Source: AFSGD/VktoL7NCwY1/VreWsmiy08/RhD6hdDHtIHQHucfG9sidK3HrY6SxVdtrzFRAotD0QhWHHrJQ==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr11613380wrq.225.1543782404558;
        Sun, 02 Dec 2018 12:26:44 -0800 (PST)
Received: from localhost ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6507648wmr.22.2018.12.02.12.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 12:26:44 -0800 (PST)
Date:   Sun, 2 Dec 2018 23:26:42 +0300
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH v5 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
Message-ID: <20181202202642.y5me76jyktzbfzbd@ThinkPad>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
 <cc1357c9272628b4d89af007cead83117d9ba6e9.1543443475.git.mesihkilinc@gmail.com>
 <154345243603.88331.17915868280143383591@swboyd.mtv.corp.google.com>
 <20181129063952.623svjr7pti7apah@ThinkPad>
 <154353465409.88331.8677593357765162802@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154353465409.88331.8677593357765162802@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716-631-34bcda
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/29 03:37, Stephen Boyd wrote:
> Quoting Mesih Kilinc (2018-11-28 22:39:52)
> > On 18/11/28 04:47, Stephen Boyd wrote:
> > > Quoting Mesih Kilinc (2018-11-28 14:33:23)
> > > > diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > > > new file mode 100644
> > > > index 0000000..d4bc1b8
> > > > --- /dev/null
> > > > +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > > > @@ -0,0 +1,541 @@
> > > > +/*
> > > > + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.io>
> > > > + *
> > > > + * SPDX-License-Identifier: GPL-2.0
> > > 
> > > Please fix this location.
> > 
> > I am very sorry, I should have been more carefull. Should I resend whole
> > patchset or just resending this patch is enough? 
> > 
> 
> Just this one? Who do you intend to pick up these patches?
> 

I have send as v6 patchset. Thanks! 

Mesih
