Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95583C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0A920846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox3vliEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0A920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbeGZMxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:53:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33951 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbeGZMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:53:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so1217385eds.1;
        Thu, 26 Jul 2018 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gGgycYqKR2XYb7GOUj13nP1Wnr0niv4KmX5xHqmp+ek=;
        b=Ox3vliEJKPzyTkZzed3M3uv34Ib/U2qp0beZhutI3MNk/yox62YQfbecOvW2x6bRw2
         mqEuCyE6LZpPRjnj7UOQeHCt4SJX3C50CWASDT1t+qDvUjywWrjmBGyZ5y9Hwawm2uuC
         Fpa7pDuV3P0t+KvkJfXEa97yil38B0vK6KOrUsAU10jOh5NRiQhjj8aVj1e7Q9gOzwMA
         FbZVbVTgQaA+trezeZ/r2cID44ZpGkFbNy+H53PrrGWR40RdpZEVobgbdBk/rnIajqOc
         LaFQjrIZazeeVCfjFM0X1knvK5gP1iQ3O7obax+w7t9JUZMi2oLAxKPHIe0zLnfNz8VP
         3t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gGgycYqKR2XYb7GOUj13nP1Wnr0niv4KmX5xHqmp+ek=;
        b=SKGyndC8kj6w0kJ9xP5AIwxSV3YS/ndDyox9+9D3tz9zP5PjWkSRPeHRiddDSy8JnS
         veFT4JAcGTdDQGs/pRPCX21svJX1puYO3mBcSE0fzA13Zt+r1bmp8ch40Jz3Ntiqt126
         DdRk3OkLUw7D1FJIe9jLGSCheeiIqWg82IuMPcDfjWYcZWgD7K0VbtneNFLGylCliqUk
         RB/pRqCYP95wsR0xiMat6gbr+l5cVbWv4WFfmhATvfH5ASK96eVNZ2kiJxDBwLNRw7Fn
         quu9bAfutM+rgBIu6Bg+COEVsLM6qFgq6fkT9wAjl9z8/aSLR4EvScmgL5g1Q5YUzO3A
         zaWQ==
X-Gm-Message-State: AOUpUlEvXp/qYTM/1agBvRUtsP9+ywFoUZ0DnWrgGqZnepvdZWG/KZ1I
        /BsxLiO/puik3gDCI8Q/5nkbVGQXvBGspnOUOmQ=
X-Google-Smtp-Source: AAOMgpdp3tEuaoYRQtOaJtp3k8Nlyd2tJoFuxKKRoWG7RmfJKR8/234SJqWvZcQSuKYtnpY2B0s9xTm+icETMQpeMqw=
X-Received: by 2002:a50:8a9b:: with SMTP id j27-v6mr2425931edj.36.1532605007257;
 Thu, 26 Jul 2018 04:36:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 04:36:46
 -0700 (PDT)
In-Reply-To: <AM0PR04MB421178C5283BDCCF11F5E2AF802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-2-o.rempel@pengutronix.de> <CABb+yY2+WwxHBtQfU3TJTErpfzfkNH8iwwYyXbmWAQy8UsqLRQ@mail.gmail.com>
 <AM0PR04MB421178C5283BDCCF11F5E2AF802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 26 Jul 2018 17:06:46 +0530
Message-ID: <CABb+yY1DQbGnWL=HZc=xPLdJjKgkpdvCHmm6Pr6_MvERR=D56Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be equal
 to 0
To:     "A.s. Dong" <aisheng.dong@nxp.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 4:30 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
>> -----Original Message-----
>> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
>> Sent: Thursday, July 26, 2018 5:42 PM
>> To: Oleksij Rempel <o.rempel@pengutronix.de>
>> Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
>> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
>> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>;
>> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; Sudeep Holla
>> <sudeep.holla@arm.com>; Devicetree List <devicetree@vger.kernel.org>;
>> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; , Sascha Hauer
>> <kernel@pengutronix.de>; , linux-arm-kernel@lists.infradead.org, linux-
>> mediatek@lists.infradead.org, srv_heupstream <linux-arm-
>> kernel@lists.infradead.org>; dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be
>> equal to 0
>>
>> On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel <o.rempel@pengutronix.de>
>> wrote:
>> > From: Dong Aisheng <aisheng.dong@nxp.com>
>> >
>> > Mailbox devices may have only one channel which means the mbox-cells
>> > at least 1 does not make sense for this type devices. Let's remove
>> > that limitation to allow the mbox-cells to be equal to 0.
>> >
>> OK
>>
>> But please realise that you'll have to write more code -- implement your own
>> of_xlate() callback.
>> Most developers would prefer to call the only channel as channel number 0,
>> and use the common of_xlate implementation.
>>
>
> Yes, that's true because the common of_xlate assuming the mbox-cells is 1.
> And there's already such users:
> arch/arm/boot/dts/bcm283x.dtsi
>
You mean that is a good thing, right?
