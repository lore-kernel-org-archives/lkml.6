Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D91C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE0320815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uSjDnopK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE0320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKSDvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:51:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41485 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeKSDvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:51:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so25354404otk.8;
        Sun, 18 Nov 2018 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfET9DnwoOc3ckuWWTtnD2WEwn4wp17TJBL6xwt1P9w=;
        b=uSjDnopKDXrTpoq72Y4KhxUbkBE4euniGZzLXiF9dFSMhBNgtzMcGf+dWOjCz+omgt
         8uIc3EzW4RtvvuuTBRN9Ry4HYozmpFlhHEPURTYwrQGLpN80ZRN5rV1DtCAUdlx7Y6aV
         4+cePAq4OAm9rH0CC6FF2OtAnZlLu967mkD/NWhByuRcug3detCRyikiMAJ6xxyvdVFB
         yOyaPEU5Z55oZ0sHNz6EQdcfNcaaV9oeYuFvaGoc88y9rM63h1JjdHhRx2zqnd3cbprO
         0EAFP1p7F03InOsYL3/R1Z2yozVZ0ZmgjkfF8hOfb6ZXFOOhv2diVEzlXUirg8Qug+2v
         QWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfET9DnwoOc3ckuWWTtnD2WEwn4wp17TJBL6xwt1P9w=;
        b=YD0ivLc8ir7w/CYngXHq9dsio+5SZbQdf4T81prUZKetc9znqOwHjkvzBvsUu6CVsT
         lT6oUKfWmXI/e33uTO1nxO8sLkQx7LZcpwTZXWeIS92teP6u7+JRcUdspSG8D3yqhWYt
         FBmu1THdbpOe8Ieca8wGFixYsI04qyvpcyYLun86af1Sd4XhqyA0wslzJCdAM3AqCrbp
         hrfHx9w62IYbDkCe0AeTbQ8ss814hnp1JexdpwoFuAikObc4YjJCjA6wrsdz8BXNX8bz
         cqGAvOKDLWeExDTpQAmprAMeErs9VIGJboLPKyDJQwNc/RVcvrMrfjSxKhBkzCPWXZiL
         y4fQ==
X-Gm-Message-State: AGRZ1gLh5//u9uB9sO3wS87DyohOBXVssMy9J3PpYp+d5wteC/y7nD4q
        16JCD3YDjvrcCRFOwoKKdRZSEHe/UKHesvWWmVk=
X-Google-Smtp-Source: AJdET5fCkjy6pJiMucAD2nDYltromc/RYPlphhugGl0SUwPqua7A4CrpKtcAxrmHXav1Tqb+yRPfxXszCNH7qkdIyL0=
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr10830268otq.348.1542562255590;
 Sun, 18 Nov 2018 09:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
 <20181117182007.14791-8-martin.blumenstingl@googlemail.com> <20181118171340.GG5591@lunn.ch>
In-Reply-To: <20181118171340.GG5591@lunn.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 18 Nov 2018 18:30:44 +0100
Message-ID: <CAFBinCBkH3OrtxROpcbqF-1BtRY=6QqS2zkhZTo=W==1FKqZsw@mail.gmail.com>
Subject: Re: [PATCH 7/7] net: phy: icplus: allow configuring the interrupt
 function on IP101GR
To:     andrew@lunn.ch
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Nov 18, 2018 at 6:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Hi Martin
>
> > +static int ip101a_g_probe(struct phy_device *phydev)
> > +{
> > +     struct device *dev = &phydev->mdio.dev;
> > +     struct ip101a_g_phy_priv *priv;
> > +
> > +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     if (device_property_read_bool(dev, "icplus,select-rx-error"))
> > +             priv->sel_intr32 = IP101GR_SEL_INTR32_RXER;
> > +     else if (device_property_read_bool(dev, "icplus,select-interrupt"))
> > +             priv->sel_intr32 = IP101GR_SEL_INTR32_INTR;
> > +     else
> > +             priv->sel_intr32 = IP101GR_SEL_INTR32_KEEP;
>
> It would be good to return -EINVAL if both properties are found.
that makes sense
I'll wait a few days for more feedback and re-send this series with
that issue fixed

> This looks good otherwise.
great, thanks for looking into it!


Regards
Martin
