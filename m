Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFFAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533512083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="XArYFove"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBGRs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:48:58 -0500
Received: from mx5.ucr.edu ([138.23.62.67]:65295 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfBGRs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1549561738; x=1581097738;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=wuiY8Nk6o96T4mTY1kEf70rq4e+8LiMSrTquEoIWaeY=;
  b=XArYFoveZnyKt+tY2KdIt4gjMXVDP7OEcZX1djFWzZk+Ad4trvij/ewt
   SbNv9j8juBxXrf9GAwFN0M49CmOTavMPFScjxwi7lWaN8eWfgF/oIi6na
   2d8ewGHDbVysOMS8QCZaFh4VopDAqf+y6Hit+8w916CviG/eqRW55GKB+
   4yxj3cCUjXVNhNfAAiiuvowlz4rxP5tRv4oXLlbTLWEdGyk3ISwB2DFct
   FlwVJP37DS9Bi1wGOaIBZ7Po380QRq4fINBxPH79dP1tSu+l6QpCIK56a
   JXCPAimdwVaKptjfr3JBrzQmcSunGzHoxrDG+1tim1jbNVaKNGHVk/FsJ
   Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AY+4IvBGSFPV1G5FXSqdnAp1GYnF86YWxBRYc798d?=
 =?us-ascii?q?s5kLTJ7zpsuwAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk1Nou?=
 =?us-ascii?q?QttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZr?=
 =?us-ascii?q?KeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1xDHuGFIe+?=
 =?us-ascii?q?NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PGAu+MLrrxjD?=
 =?us-ascii?q?QhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC+85Kl3VhDnlC?=
 =?us-ascii?q?YHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6jAf90VWHBBU95eWCxPAIyy?=
 =?us-ascii?q?b4UBAekcM+hGs4bwvEcOoQekCAWwGO/j1j1Fi3nr1qM6yeQhFgTG0RQiENIPsX?=
 =?us-ascii?q?XUrMj1NKAPWu+2zKnH1zTDZO5R1Db96YnIcgouofCQUb5sf8fc0lQvGB/fjlmK?=
 =?us-ascii?q?t4PqIi6V2/0LvmOG4eRgUuevhHQmqwF3ujWg3cAsio7VhoIRy1DE8z91z5oyJd?=
 =?us-ascii?q?29TkNwfN2qEINIui2EK4d7RtkuTmJotSog1LEKpZ22cDIUxJg72xLSbeGMfZKS?=
 =?us-ascii?q?7RL5TumRJC91hHdieL2imRm/6VOgyujgVsms11ZKszZFnsHMtn8T0xzT7dCKSv?=
 =?us-ascii?q?5n8Ueg3TaDzgTT6uNZLUwtm6rXNYItzqIqmpoctkTDGSD2mEHog6OMakok/e2o?=
 =?us-ascii?q?5/zmYrXguJCcK5d5hh/iPqkqgMCyAuQ1PhIQU2SH+umwzqPv8VHlTLlSi/05iK?=
 =?us-ascii?q?jZsJTUJcQBoa65BhdY04Yi6ha/FTim0cgUkWUJIV9eZRKIk5LpN0vQL//lEPez?=
 =?us-ascii?q?m06snytzx/DaIr3hBY3ALnzCkLfnYLZ85FdQyAktwtBF4ZJbFLUBLentWk/+qt?=
 =?us-ascii?q?PYFAU1Mw+qzOb9DtVyyIceVXiIAq+DP6OB+WOPs8cmM+iJaccvuS70MfRts/vn?=
 =?us-ascii?q?nX48lBkHfLGgx5c/Yne/AvBnJQOSZn+60fkbFmJfjwssTPHtwG+CWD8bM2egX6?=
 =?us-ascii?q?s9vmlgIJ+tF8HOSp370+/J5zuyApADPjMOMVuLC3q9MtzcA/o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AHAABIb1xch8jQVdFkGwEBAQEDAQEBB?=
 =?us-ascii?q?wMBAQGBUQYBAQELAYJqgQMnhAOIGotvgg2TAoUPgXsBDBuEUQKDKCI0CQ0BAwE?=
 =?us-ascii?q?BAgEBAgETAQEBCA0JCBsOIwyCOikBgmYBAQEEIwRSEAsLCQEDAgIfBwICIhIBB?=
 =?us-ascii?q?QEcBhODJAGCAQWhVDyLG3wziFoBB4FGBRJ5iziCFoQjiAqCVwKBLAEBAYpQhTy?=
 =?us-ascii?q?RVAEGAgGBZYVSiw4ZgW2JA4dlLYwej0kPIYElgg4zGiV/BmeBToI2HIM4inQhM?=
 =?us-ascii?q?I56AQE?=
X-IPAS-Result: =?us-ascii?q?A2AHAABIb1xch8jQVdFkGwEBAQEDAQEBBwMBAQGBUQYBAQE?=
 =?us-ascii?q?LAYJqgQMnhAOIGotvgg2TAoUPgXsBDBuEUQKDKCI0CQ0BAwEBAgEBAgETAQEBC?=
 =?us-ascii?q?A0JCBsOIwyCOikBgmYBAQEEIwRSEAsLCQEDAgIfBwICIhIBBQEcBhODJAGCAQW?=
 =?us-ascii?q?hVDyLG3wziFoBB4FGBRJ5iziCFoQjiAqCVwKBLAEBAYpQhTyRVAEGAgGBZYVSi?=
 =?us-ascii?q?w4ZgW2JA4dlLYwej0kPIYElgg4zGiV/BmeBToI2HIM4inQhMI56AQE?=
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="27401172"
Received: from mail-lj1-f200.google.com ([209.85.208.200])
  by smtpmx5.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 07 Feb 2019 09:48:57 -0800
Received: by mail-lj1-f200.google.com with SMTP id v24-v6so170165ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2h+KsTudxCs800rU2F/cFHz14DOKXOivwjGfmboDlkE=;
        b=l6xn3M57ir2eemoDw4KnzYqF2U0NlbsA9/B/PhdGKEGrdBf5v9nbyldA4AWQK52xSo
         E9o1cccHkuhoHrcNS+gQPKbe2sxH/JYR7c2k3oVgxLB3YBNt/T1IdTdQjDRftYAHe4/h
         QMD1eOghhe0XREnK0YskFh5d2Wr3KMzJKVMZWsNPMf2UbjNGTfLZyaj9GuoeIfqw6TLk
         uWEj3bO61dSmJyizSrigSWkUvNBohHrJiZZXx90JdxWkFDJhvpoFyIRBx+eJPgArFYXR
         3KG0dEjfCsfARcBFBgl4Tn9v22mqHtfTdQukkfheWIIhUsHW50RopCGAWtYEAxt6voxc
         jk1A==
X-Gm-Message-State: AHQUAuYyi4O2RK13EmcogtfnpZ2V4o6tCF+EvSoiU6WCK7GFIUtHwbOw
        +Joi7XolFj+iV1Vb9or2BXeCd7LsKvAfghsvzyParRCkm9MfRz1LmJrNqD4pDk1wnde4l5km1MK
        SZnI4z3T8CBaHNUQmrbe98zN2d1tgShEbRUHuTe7RnQ==
X-Received: by 2002:a2e:9001:: with SMTP id h1-v6mr6632004ljg.28.1549561735392;
        Thu, 07 Feb 2019 09:48:55 -0800 (PST)
X-Google-Smtp-Source: AHgI3IamVMZFGgUaFIvn9Hr4bdJczD7GZBgzjH9AtRDyXSsBe1CW9j8HHFL/FcBnOQkrEsCWUobngCvfjPanXUy/lrg=
X-Received: by 2002:a2e:9001:: with SMTP id h1-v6mr6631981ljg.28.1549561735019;
 Thu, 07 Feb 2019 09:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20190205221559.17545-1-yzhai003@ucr.edu> <20190206.201736.1146228626076916564.davem@davemloft.net>
 <CABvMjLQ6MYtGYeLxwceZsvcyn4oScgMo+BGQMHw7SkZ1uxFmHQ@mail.gmail.com>
 <CABvMjLTymaszPdX5afOHFfFBS1AueVzRVra5_QUr144GahH5gQ@mail.gmail.com> <20190207092454.xq5jvnfnuhcp37nm@flea>
In-Reply-To: <20190207092454.xq5jvnfnuhcp37nm@flea>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 7 Feb 2019 09:48:41 -0800
Message-ID: <CABvMjLS2ftUgxeKNxQW2npxKRjM3_=U7qg7oYTw6VrkUWcOocw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Miller <davem@davemloft.net>,
        Chengyu Song <csong@cs.ucr.edu>,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sense, I will send the new patch. Thanks for the opinion.

On Thu, Feb 7, 2019 at 1:25 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Feb 06, 2019 at 09:53:16PM -0800, Yizhuo Zhai wrote:
> >
> >
> > On Wed, Feb 6, 2019 at 9:52 PM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> > >
> > > Thanks, but why initialization matters here? Is performance the main concern?
> > >
> > > On Wed, Feb 6, 2019 at 8:17 PM David Miller <davem@davemloft.net> wrote:
> > >>
> > >> From: Yizhuo <yzhai003@ucr.edu>
> > >> Date: Tue,  5 Feb 2019 14:15:59 -0800
> > >>
> > >> > @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
> > >> >       struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
> > >> >       struct device_node *node = priv->device->of_node;
> > >> >       int ret;
> > >> > -     u32 reg, val;
> > >> > +     u32 reg, val = 0;
> > >> > +
> > >> > +     ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
> > >> > +     if (ret) {
> > >> > +             dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
> > >> > +             return ret;
> > >> > +     }
> > >>
> > >> I agree with the other reviewer that since you check 'ret' the initialization of
> > >> 'val' is no longer needed.
> >
> > Thanks, but why initialization matters here? Is performance the main
> > concern?
>
> Not really, but if we turn this the other way around, why should we do
> something that doesn't bring anything?
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
