Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137AEC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB6B20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSVrndYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB6B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLLBfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:35:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38015 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLBfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:35:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so4223563wml.3;
        Tue, 11 Dec 2018 17:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5H2li2R33XJbbHxFVIsAyEewkATsOICi72EGgRBsYQ=;
        b=SSVrndYywnMGlAXVieSYSU+A8j8iZ3hz5hHMOj+B/TGgrBg0vKFNfkjvCmu30aZd9m
         qkmcDOmqETvbMkDrz0WcRBOwfQKUkMnNA+V2ZXuKLhUUgkktkM7JmbHHyidadJcQQh4L
         qNjzOTJTmFa6k0AGVnBeAyyynKgISeGhxxi0hg6uJ209Lw7oL45FcQW4vVQSoN6aLYQb
         HULLPfkSG0KEv5fidCxDAW8EqAGsOoDjYvF6wtlz4hB+eUaEdKB3obzdCdd0wMvDnS/6
         eIE7dcrc1Z7kUSEnYS4/WbrKdVxY/4xh0o7SQiHrmx/M/0o4fPXNIHlUPfC/CT4jDoy0
         6E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5H2li2R33XJbbHxFVIsAyEewkATsOICi72EGgRBsYQ=;
        b=UkkLmoPRdrmTEXrZzNdR9FHtLGPD0l9Vs45jRxDGjLLw2aOZqwkliWGvCF1yKH6gXG
         Bu30w9nkOKb4mxS0cEiV8vPIjZkOXXjs4XPAj6k/3oVOfH034oDyACGDPRAsaLLzrcdc
         np+2vwe/jcF5cQZyzEcAWBgL9BJ4uAjcaEYi8n3zvdS/swoxhYCXKfCQdyO8xWFV5Fj8
         Q/Scl0px6ji/hAe6qC+pA7U2Y7HZJsk2zYVnvgQ/VIy64jaAr5GK4VyneE6vTE/264wE
         QK8Kuujbz5xXkedHxd8o69aSp3aP99BF3JBu2zuX7+OmuvT0ftnmDQasnB9z+IwTfh99
         YDlg==
X-Gm-Message-State: AA+aEWYTh53NIsIeId7JBhwbEF/XbgmeDzIFDO/n/30vHCY2DXtsbPdN
        jbf0YNII9P2UhlxBqtCwHLdwBNPNZ8J1rbFGKQ0=
X-Google-Smtp-Source: AFSGD/W74rsJvZY1ubJdvL4SrrI/hfGyehCLgnE/Flyr9XpWUQn93AieMwHbY+HrIth4afV7U64VTLySqYzpGPMOGXA=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr86449wmf.127.1544578527719;
 Tue, 11 Dec 2018 17:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20181128043738.12714-1-andrew.smirnov@gmail.com>
 <20181128043738.12714-3-andrew.smirnov@gmail.com> <20181211224349.GA30397@bogus>
In-Reply-To: <20181211224349.GA30397@bogus>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 11 Dec 2018 17:35:15 -0800
Message-ID: <CAHQ1cqHH5Vef1e7bXBXWQdSzmAOpwj1vdyG-t83PkRyLifVFuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] reset: imx7: Add support for i.MX8MQ IP block variant
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-imx@nxp.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:43 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 27, 2018 at 08:37:37PM -0800, Andrey Smirnov wrote:
> > Add bits and pieces needed to support IP block variant found on
> > i.MX8MQ SoCs.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/reset/Kconfig                    |   2 +-
> >  drivers/reset/reset-imx7.c               | 106 +++++++++++++++++++++++
> >  include/dt-bindings/reset/imx8mq-reset.h |  64 ++++++++++++++
>
> This goes in the binding patch.

OK, I was following the precedent of the original submission:

https://lore.kernel.org/linux-arm-kernel/20170227205408.ajeu3stjpl45dnqf@rob-hp-laptop/

Will split and submit v3.

Thanks,
Andrey Smirnov
