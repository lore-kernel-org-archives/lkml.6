Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B588CC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78433208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1jb+k+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78433208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeK2RoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:44:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40251 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeK2RoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:44:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so964627wmf.5;
        Wed, 28 Nov 2018 22:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wxQziMvDmCMCdKRAS1AYUQbyHSzwD4zt9Nstih3mWz0=;
        b=k1jb+k+TPG3rHMo2P4g4l7AHD+KwiiP9V4mVnpYZZmuSnjm3EO904YwziNaVJ64oBY
         KR+fBShlGVIg98heBbYYusOltZap2jgtvdpJfpFQVCshKdpWzW8Vr+XtQXL+T90D13Hb
         90Y6AyxZUJN/bDSfm4Uhn/dPpVZlvSj4bi7HH/KiGinh5jnbV2YBBqjj30hMwDW9xhGj
         iz3yD71SGk6C8lNi48RQ23swfxLvKwMumtGb7ps1PuCJ0kSk5c9+hzPVFEnoXbnEaXFm
         Ghs9m6Y/UxganmUpwjFkmj7Kumx/a05uej3CJduYTUw3IQJy8EUQep3OGN9GWIX7692N
         TkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxQziMvDmCMCdKRAS1AYUQbyHSzwD4zt9Nstih3mWz0=;
        b=Hx60V83Y37RD0bgEbvlXgE5gqOhyMRWyT0jERD9hVo9x7Pl4dWmauq/EHYzKyiQv0g
         V7SzkP1pgJg18Zcp+/n48mjiPqKyGT8Avy0kJ4WI5AMcj3jLqtb2i1J65NvhT5XYlwDu
         qwgT0aFcD3F30g51UypbdzdXu85tJcgnQJyE6elkM6j9L3+JO32ivYbL2O1EdgEvrnFr
         s+IHj5EJjRoZljFnGES5WFE2k4aqn+eVsg1gKbdAVZ95I/z0cltDer+v4hEGyJx2thMN
         ArJLHIB9Xo8xpUaKUJg8ZW7Ao5TOEsWrEtvNgYCRC0DcBaC8cxW3t63d6sQq+1DYAHDe
         GN8w==
X-Gm-Message-State: AA+aEWZWz91MavjPRg9IoiJgIWIm2RQb3z5x0WM1bgfqAP70In0MKR6/
        JJXyAi8KZSu5WBhA1LxFHE8=
X-Google-Smtp-Source: AFSGD/VpMEiUiU3zolr/Ke9w8hwKvok+X9tbW0SYEvuUHQcUgqjLYUmXj9OZU86B4XgtyUZ24l7dEw==
X-Received: by 2002:a1c:1903:: with SMTP id 3-v6mr491139wmz.141.1543473596175;
        Wed, 28 Nov 2018 22:39:56 -0800 (PST)
Received: from localhost ([193.140.134.192])
        by smtp.gmail.com with ESMTPSA id z12sm843635wrh.35.2018.11.28.22.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 22:39:55 -0800 (PST)
Date:   Thu, 29 Nov 2018 09:39:52 +0300
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
Message-ID: <20181129063952.623svjr7pti7apah@ThinkPad>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
 <cc1357c9272628b4d89af007cead83117d9ba6e9.1543443475.git.mesihkilinc@gmail.com>
 <154345243603.88331.17915868280143383591@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154345243603.88331.17915868280143383591@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716-631-34bcda
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/28 04:47, Stephen Boyd wrote:
> Quoting Mesih Kilinc (2018-11-28 14:33:23)
> > diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > new file mode 100644
> > index 0000000..d4bc1b8
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > @@ -0,0 +1,541 @@
> > +/*
> > + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.io>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0
> 
> Please fix this location.

I am very sorry, I should have been more carefull. Should I resend whole
patchset or just resending this patch is enough? 

Thanks,
Mesih
