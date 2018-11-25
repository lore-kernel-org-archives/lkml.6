Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93004C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B12D2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="X0vuB7fW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B12D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeKZHpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:45:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41021 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:45:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so14002420oii.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=PFH0k/oZ2rDKPnT86wWbQuPlU0r+CHeexqjSQEffiMA=;
        b=X0vuB7fWKR+PSo3mu7Llyny2G4PYls36YKE1N6OCa+wi4GLw8iP0sFCz5aCE7H3C1s
         5wuG/wYigBt7FWhKc7DbIoB6MPZGP8fXfamFtn4zjez64LpucHvJfgX50dlmYzdU1rTv
         O0moPUKYO8ZW0LR8kSVeBafQ48MI4pLTkvqawMfazjJlBpJHl+5lOnpqxNeI4qweQPme
         3v5ydLFtlZ/oK2WlCUg20T5jdlVxQJTeRO5rxttSGwVkzG6lmXWf8eCPKIp4GpKKWiqW
         Rwauga0TJVs6gfGOv1FsORlmxK6kXWlqZQNSJGllqVXsxTVrD9iJGgUmninJPK18yg9l
         0DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=PFH0k/oZ2rDKPnT86wWbQuPlU0r+CHeexqjSQEffiMA=;
        b=rmZItwiogWiuQgd+z8zkFW/v2ae4MiaNNauCxi1DZfgk3kKU9RWSVAsgh/W7yuCdo4
         qU3YM/Z2vC03wZKG2v5AtTd94gLtkS4QvP7FSn+RUAS2++pn5jl1AVPXxW+3sCmM/EXI
         OR0y68yaigyWW8h7q0tphhms02diH3uZXSARSjWnoseH/FkoyRDrJREiGdp9nvRqm/BN
         rxtJ3Ob8wlZYFjUcYnrcS0aO4h1Uzv61ALkGPXETRrhIOoaTQ9EJw++hh9zMzX2bZWKB
         nSIY2Ou6xOlx3pMjE9zB4fGLye6WwxIgHRHY1fakR/foOA7J4/LFHW8Q/kBjAmYjWTDW
         2Pog==
X-Gm-Message-State: AGRZ1gLKo08W1T91lzVFmVxe3mTp7aSbsiIufQAA+9Rkj5AvbGhZP6Qg
        lz+5cL7OFMk87gNVt850HSf7q/pvQr/QtQ==
X-Google-Smtp-Source: AJdET5cR5vYVb8QJgcIHRUYI+IekERPcLzljf5JUi6BdSLJf+8oWRP4/CQ3ENg+4SDhUQULF7W1dSQ==
X-Received: by 2002:aca:6c4:: with SMTP id 187mr12760464oig.283.1543179199407;
        Sun, 25 Nov 2018 12:53:19 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id o16sm6684299otl.22.2018.11.25.12.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 12:53:18 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-oi1-f175.google.com with SMTP id c206so14052049oib.0;
        Sun, 25 Nov 2018 12:53:18 -0800 (PST)
X-Received: by 2002:aca:ad14:: with SMTP id w20mr12326987oie.3.1543179197737;
 Sun, 25 Nov 2018 12:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20181009213656.27719-1-otavio@ossystems.com.br> <6815120.yyevdQbq0d@phil>
In-Reply-To: <6815120.yyevdQbq0d@phil>
Date:   Sun, 25 Nov 2018 18:53:01 -0200
X-Gmail-Original-Message-ID: <CAP9ODKpnv0FmK1no6mpqR=WGUgwvMUpKjVFNkXsEXReqb9OnXg@mail.gmail.com>
Message-ID: <CAP9ODKpnv0FmK1no6mpqR=WGUgwvMUpKjVFNkXsEXReqb9OnXg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rv1108-evb: enable eMMC support
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,
On Tue, Oct 16, 2018 at 10:09 AM Heiko Stuebner <heiko@sntech.de> wrote:
> Am Dienstag, 9. Oktober 2018, 23:36:56 CEST schrieb Otavio Salvador:
> > Enable eMMC support for rv1108 evaluation board.
> >
> > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> > ---
> >
> >  arch/arm/boot/dts/rv1108-evb.dts |  8 ++++++++
> >  arch/arm/boot/dts/rv1108.dtsi    | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
> > index 70f0106d1252..f3c6f52c49e6 100644
> > --- a/arch/arm/boot/dts/rv1108-evb.dts
> > +++ b/arch/arm/boot/dts/rv1108-evb.dts
> > @@ -226,6 +226,14 @@
> >       status = "okay";
> >  };
> >
> > +&emmc {
> > +     cap-mmc-highspeed;
> > +     supports-emmc;
> > +     non-removable;
> > +     num-slots = <1>;
>
> num-slots should not be present anymore on new additions
>
> Also missing the pinctrl settings you're defining below?
> Aka pinctrl-0 = <&emmc_*>; + pinctrl-names = "default"

Thank you, I am preparing a v2 of this patch together with few more changes.


-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
