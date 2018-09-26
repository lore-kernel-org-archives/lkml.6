Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD957C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646BD214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Ad3erh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646BD214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeIZSOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:14:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42857 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeIZSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:14:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so27846918otl.9;
        Wed, 26 Sep 2018 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ktg5ovKSPSBwpjpSXwCWjbFvp8TZfoNhcKkgdpyREkw=;
        b=f8Ad3erhHz++NboUWAoa4oE6XhpsAd4JyYBrgn9+0OVpFYlM0rP/XKNNOhcsj+G0Mj
         q0x+DWqhqwOXP9zqLiA9uVghiQ9xKa3WdI2VpeIgzgmRuIO8Zg7oMQVAS80fRqQ1v6O9
         djySca93NUseIPBa8Q463Tdi9cw8OXgfovKMDH6BSIBwey/mU9KTeGRWlLLR05UhiuU3
         q5eCb62w0r+BlbwQS5HhupcPClQc0t8USvXgl+K7AcpMViAaiW09bu9cw9+1Xr5UbXh5
         bCSWenAQxOJ3H9MT7GUYGrjv/LVgvoXBCU57noXyZMScitvx1Gh8f+5BBpbgKfsZBZEE
         uDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ktg5ovKSPSBwpjpSXwCWjbFvp8TZfoNhcKkgdpyREkw=;
        b=bB1xsxnEo+T+5Zxr6FhgV0Un2D2gdd1Ga6X+Hpn5QhlEd+HYfK07Dx0DkyF2LQuFNP
         O1VbQlyU9gm+mNLP+hgACpa6eQMhFoXPCXE14nYc+zm0wCLYpvBeXjLZVGRdXb9loSSp
         sYx4u+K2gdwxGouJ2jeWJAOKM/v6nsYk8SI6fkjlxBCkQWEo8sdRwxTZIpAV9IB9slhi
         Hx099EnldMeDSitNYy94efoDimlImzLlDhE9wyCQNWaA0COlaBAwf+2qsJ8C2bQmJglv
         0aN5fEcLwEjqAY5prW6ktae83PLMrgVXWqov5VySSgHY5n5abmXb6PB54fn+T4QaK1u1
         TB/w==
X-Gm-Message-State: ABuFfohtLyFF8EHogLazdBY8KVNa+8iWRVhj9eIaYq9coScXVJgAwFfI
        lZsSLZqg+TyLzHx54netxvHr5ghQRzQN3pknvlM=
X-Google-Smtp-Source: ACcGV60lzNGzfflYZdHCoqj9Dc9r5wDp5Vi/PobUYyOkpk1BZqoOdJTuS8sSl5YAqUgQRV2l5dpI2JyXS01Q232Bwcc=
X-Received: by 2002:a9d:23a3:: with SMTP id t32-v6mr3663621otb.65.1537963327897;
 Wed, 26 Sep 2018 05:02:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d28:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 05:02:07
 -0700 (PDT)
In-Reply-To: <20180926064752.GM4097@pengutronix.de>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-5-git-send-email-abel.vesa@nxp.com> <CAOMZO5D7yLUzriOub4RWsq1K8_fTj6c0LFOnSZwHyjqMPYu=0A@mail.gmail.com>
 <20180926064752.GM4097@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Sep 2018 09:02:07 -0300
Message-ID: <CAOMZO5D-40WbanPC=-O_Nj98znOk6Aa3dAqpCuwHTv+GuFR6_g@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] clk: imx: add imx composite clock
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

On Wed, Sep 26, 2018 at 3:47 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> It's:
>         rate = *prate / prediv_value;
>         rate = rate / div_value;

Yes, this looks correct. Thanks for the feedback.

> To me this looks correct. However, For an unsigned long type we have
> DIV_ROUND_UP() with which we do not need any casting. For 64bit code
> unsigned long is 64bit anyway which makes the cast a no-op and for 32bit
> code there's also no point in exanding the initial 32bit value to 64bit.

That's a good point too.

Thanks
