Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96484C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E08120671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joqUPJ/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E08120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeGZK5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:57:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38820 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeGZK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:57:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so981844edr.5;
        Thu, 26 Jul 2018 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tgpp/CnEfrzagoktE+mL6ttGNz8zq7nqCT31lcW1DXw=;
        b=joqUPJ/qM7IXu97uJdimMIIZ24r5b6oOJx2A3jzt/eIOdWwUJsixCoXOOauVpT2sKd
         UeQnZciQxNOIa6XLE+jiFI3+LCbK9Odx42ACgVoW/z580ejK94FeVuUlDiruqyzHYclB
         gMo31dCKUf4Io6YRbrQbVIsnU7NFmGRlYM4EliB3pZjUAxA0mNAIN7+fNVv0i5hU28qp
         1bzY62ZykbvbPsAIi/mv+RI1/8KLG0gBdsM84SZihXPOosbCUzU8cgLnI4PQaHbx2C9p
         D+YrgL0XN6W+LBG23GPhlooes5ITq0qq+VB0yV94dvFjagXLO57FDGEZWseacICfiAXY
         LKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tgpp/CnEfrzagoktE+mL6ttGNz8zq7nqCT31lcW1DXw=;
        b=MvWnoprs013KUK8rQ4uwa38XCG8R9qTLdCrvbjfiDv7HbX2IfK1i6MhMkAiT8F3QxM
         9CRtnNSQ41e6XBL0z7yC+BKtK82mxALitxp+U5/xvxQU/uGUvc9e0JRPALkW+fGOWZJJ
         SNu4svYFDR96XkG/sF3g7cFHinb7IHvzo3kjSb329s2Z45i8CKYNwCPLtjj1nkQJ/ko9
         y9rXn9Z849r0ZmvFSv3E+cwDSl2Y1zqL0wN7vil5PHZPVwd6Mi6x65JkL0Hl4kjumjUb
         NQbrGD8xTJXLkQPOUufYX4Buwvg+zkQJ9YON6wo4b0+khmXgfbRTicJfCSHpcxXXUUw7
         lRgA==
X-Gm-Message-State: AOUpUlEnShipxMqPQ7Rblgu+S2paAJdx0Y2UWtBXt/FEvMEokp0RDR5u
        Bcz6ce/2DadTk7yGk7TB6rROM/CL0UCgS5j0UgM=
X-Google-Smtp-Source: AAOMgpdIGdAzAtBczlOMp//qgNbXLp4C+189LlOx8MId42/1suovX4IoEIM8WczxnFMsBrZM/w9VHI3q7RmClB13ZDo=
X-Received: by 2002:a50:d429:: with SMTP id t41-v6mr1901116edh.75.1532598100387;
 Thu, 26 Jul 2018 02:41:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 02:41:39
 -0700 (PDT)
In-Reply-To: <20180726065331.6186-2-o.rempel@pengutronix.de>
References: <20180726065331.6186-1-o.rempel@pengutronix.de> <20180726065331.6186-2-o.rempel@pengutronix.de>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 26 Jul 2018 15:11:39 +0530
Message-ID: <CABb+yY2+WwxHBtQfU3TJTErpfzfkNH8iwwYyXbmWAQy8UsqLRQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be equal
 to 0
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
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

On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
<o.rempel@pengutronix.de> wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
>
> Mailbox devices may have only one channel which means the mbox-cells
> at least 1 does not make sense for this type devices. Let's remove
> that limitation to allow the mbox-cells to be equal to 0.
>
OK

But please realise that you'll have to write more code -- implement
your own of_xlate() callback.
Most developers would prefer to call the only channel as channel
number 0, and use the common of_xlate implementation.

-jassi
