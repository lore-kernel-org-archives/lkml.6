Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56290C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0548F208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ3e5D4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0548F208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeGKKry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:47:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39318 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeGKKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:47:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id w14-v6so18867051eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wWXEdSnahduXD2eA2kiAPkv9UCYXOnh0MObnJKZDftY=;
        b=tJ3e5D4NVEDwb28fa/SrOXb9wCpPBkFPy8G2LS0NG5RrKdpj2ZUiEa3NsEroT0/GTO
         2d642m5D0desLTQf0ahTy2PVOj3PoYoaNZJ/1SKYWkGDIydu68lsKJp1r5aorBSl8jj3
         +YJ1yG4Tu5G3A0lFzolf0DGj2sEvU5N6LgHzEKnddXTmU8ZFeu8pd+ZKuRMSbn/o1mjb
         3CneO3nKSMPP9XvhpHSFf5i9iBTkzX/sCp3NtrSMsqv7pUSdUersWJh2ZpHxX/9yiilJ
         FHnpmnQ1qRsGPjAyARsaDVBNqxJSn5ZzbKSo7UWRROAjhh9HdfDlGNDM+UR1ByolCLjF
         Bwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wWXEdSnahduXD2eA2kiAPkv9UCYXOnh0MObnJKZDftY=;
        b=FokOVRtFCL2TBk6qUvXpE0tQBCJq1fkL7fxMfaQoLWhU4OjtSGtGFLaMYzO0Pfic20
         HcTu2aLytd9snqYQ4DaT3UuAL3eEisFH2vxGToH5Vg4bCZTE4mHU+9Ch/aIR/f4reykc
         Q3/qVFZieCc6OhfC09EJ5fEi8wbkPpyo026KJroYbHiw5LUkp7o0Mtblk8ff+biz01QV
         0DbKAXm+Qev6PFno17UAAMhXQwglDYSi1ab3rS4WsGrQSzoEpNsaPi8kArDmeIP2oh1/
         QuSxhnzj8q2kRCv6x0zeaFbQJrQzmCafSBz4gBqgDyJ+D97qwZOl+TKjjho2yjF3gJDm
         +Mow==
X-Gm-Message-State: APt69E3R8r+XXQDB65FD4ou+yuWD3VnrhAK/d2BgC6JE4om2PLZcZkb8
        lCCUqxOBJhG+2D2fpPbDcKcaP1evvd6axBOzbOs=
X-Google-Smtp-Source: AAOMgpeb+jQYeCGS5T+qRdzcJI529jvM5J1+riiFlPD49+Kiit+RUFmuoeqCDaIADqggXTauWTdCf5fgom5oONjEP5Y=
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr30552313ede.213.1531305850928;
 Wed, 11 Jul 2018 03:44:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:9f67:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 03:44:10
 -0700 (PDT)
In-Reply-To: <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com> <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711075456.npwfpm6mtpkx7k76@pengutronix.de> <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 11 Jul 2018 16:14:10 +0530
Message-ID: <CABb+yY1kH8mr3=nazsLXrLaNWT0x6j9MizVaE+bZaHmrsKn-Wg@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
To:     "A.s. Dong" <aisheng.dong@nxp.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:07 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> > Sent: Wednesday, July 11, 2018 3:55 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel@lists.infradead.org; dongas86@gmail.com; Jassi Brar
> > <jassisinghbrar@gmail.com>; linux-kernel@vger.kernel.org; Oleksij Rempel
> > <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> > kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > shawnguo@kernel.org
> > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> >
> > On Wed, Jul 11, 2018 at 07:29:38AM +0000, A.s. Dong wrote:
> > > Hi Sascha,
> > >
> > > > -----Original Message-----
> > > > From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> > > > Sent: Tuesday, July 10, 2018 10:20 PM
> > > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > > Cc: linux-arm-kernel@lists.infradead.org; dongas86@gmail.com; Jassi
> > > > Brar <jassisinghbrar@gmail.com>; linux-kernel@vger.kernel.org;
> > > > Oleksij Rempel <o.rempel@pengutronix.de>; dl-linux-imx
> > > > <linux-imx@nxp.com>; kernel@pengutronix.de; Fabio Estevam
> > > > <fabio.estevam@nxp.com>; shawnguo@kernel.org
> > > > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> > > >
> > > > Hi,
> > > >
> > > > On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
> > > > > This is used for i.MX multi core communication.
> > > > > e.g. A core to SCU firmware(M core) on MX8.
> > > > >
> > > > > Tx is using polling mode while Rx is interrupt driven and schedule
> > > > > a hrtimer to receive remain words if have more than
> > > > > 4 words.
> > > >
> > > > You told us that using interrupts is not possible due to miserable
> > > > performance, we then provided you a way with which you could poll.
> > > > Why are you using interrupts now?
> > > >
> > >
> > > Because mailbox framework does not support sync rx now, I think we do
> > > not need to wait for that feature done first as it's independent and
> > > separate features of framework.
> >
> > You can wait forever for this feature, nobody will add it for you. It's up to you
> > to add support for that feature. Who else should add this feature if not you?
> > And when will you add that feature if not now when you actually need it?
> > It is common practice that you adjust the frameworks to your needs rather
> > than working around them.
> >
>
> I'm willing to add it. Just because you said Jassi already had the idea on how to
> Implement it and does not add much complexity. So I just want to see his patches.
> But if he did not work on it, I can also help on it.
>
I am not much aware of the history of this conversation... but it
seems you need to make use of mbox_chan_ops.peek_data().

If not that, please let me know the requirement.

Cheers!
