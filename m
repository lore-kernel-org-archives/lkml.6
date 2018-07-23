Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED03ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F30520671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxCHuJ8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F30520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbeGWTlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:41:09 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55782 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387941AbeGWTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:41:09 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so196627itl.5;
        Mon, 23 Jul 2018 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unYw6UEUZWY9EH6Pe677aJdF/DMingwdwFvYemTJ2ok=;
        b=hxCHuJ8Mv9pOLPQDE64QZwR9tnhmndE+tXEOxSTfN/OdS3I+t7g7zoC3i2AzEW3z3H
         AlVwgiUw9foi6HsqN8Nl6kB/OfhJNOjYwoDG3c+GEnkwGl8+fnh7X9+qMSxjPzKZ010a
         Ow3lA98ByBK0uQm8Yl6mV+wdNFHKu68E7O37ZXiU9RBCoikMNCwllpv7pJyUhb77OFOk
         vMyr6+3TFm8qgDTxfE+MYZHwp/KVrq8Spts9y9TIVOfe4sFo6k9Jh7B8kH0b3NolGVAE
         sacm6GJwW687NpSox95VHaluMBxG7b27vip/zirRPh58FaqvAJkdc7m4BTSqGxh5ug30
         UA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unYw6UEUZWY9EH6Pe677aJdF/DMingwdwFvYemTJ2ok=;
        b=NDH0HgvfBqdnTouLzNMTmu12qg78mCN4mt5LN5lt+UnZ9QxIZao5XkEFPX+Mj8zERC
         4mCaiQj0nH9X5fXt8y6fAwE/n2V3KrVvvM6h7Snv308/II8zFVsYc9dcC8UrxCHoFZqY
         lMi8IKdmrC+KGi43b5lNOtmRKa5Xp164xmM2lVh1lDkX53lNr7Qwguk6HOk1sHlwO4f6
         uJLi/Qoz9tRfxbzavsnIMimaTLBuiR6JRae16fI4z2scUX5qYC4M5xfMAzZFI5H3RhBa
         i4p/CpC5oWr1b+kdgIBjbNUbBTMdZ27+oGUsimutDuQmua+gU9w7CYkKUAo3aTqTsVP+
         LpUg==
X-Gm-Message-State: AOUpUlHOiD2QGY2MzDhRcpUVx3r6oQ8C9ZObp6+CG97nvKMnMNelkxyk
        cBFtOxxU0JQbus2jVgpwKJc4QSkBNGERqPlCDPA=
X-Google-Smtp-Source: AAOMgpcSZ3Epq4EmCvVhQXDCEWVvM/jMoziNsJIzgszuBuWhtawaTeKRXbH9Hs+Y1z46852iIfBIPQ8j7OVK6HV+KDg=
X-Received: by 2002:a24:7b97:: with SMTP id q145-v6mr130737itc.79.1532371117319;
 Mon, 23 Jul 2018 11:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1532090446.git.leonard.crestez@nxp.com> <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
 <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com> <42ff53eeea3067b19e3e16bed8392706502c8f23.camel@nxp.com>
In-Reply-To: <42ff53eeea3067b19e3e16bed8392706502c8f23.camel@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 23 Jul 2018 11:38:26 -0700
Message-ID: <CAHQ1cqF7u2gjwYt1-16u-uimXHZ2SWsquabZSDftQn_yRurhSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-imx@nxp.com,
        lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>, Joao.Pinto@synopsys.com,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 5:41 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On Fri, 2018-07-20 at 08:33 -0700, Andrey Smirnov wrote:
> > On Fri, Jul 20, 2018 at 5:48 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > >
> > > This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
> > >
> > > That commit followed the reference manual but unfortunately the imx7d
> > > manual is incorrect.
> >
> > I'd also add similar comment to DT file to prevent people from trying
> > to "fix" this in the future.
>
> I'll try to see if I can follow up internally with docs team to get
> this updated in the next revision of the reference manual.
>

Not sure if we are on the same page here, but what I meant is adding
the same explanation that is in your commit message to Device Tree
file as well so that if anyone looks at DT code and goes "Huh?" in the
future, they wouldn't have to research commit history to see the
reason why things the way they are.

> > Also, this change is going to break QEMU's mapping found here:
>
> I had no idea that existed, I guess somebody needs to fix that as well.
>

I take it it's a no to my "any chance you can fix that as well?" ;-).
I'll see if I can find time to do that this week.

> Do you have an imx7d board using pci or did you just test in emulation?
>

I used real i.MX7D Sabre board with i210 network card, when I was
porting i.MX7 PCIe patches. However, as per note I made in the
original submission:

https://lkml.org/lkml/2017/10/9/913

this IRQ swap patch came up as a result of "connecting" emulated ICH4
in QEMU which was using legacy interrupts.

Thanks,
Andrey Smirnov
