Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE2EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D212147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="hopdn+gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfBGFxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:53:32 -0500
Received: from mx6.ucr.edu ([138.23.62.71]:43392 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfBGFxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1549518811; x=1581054811;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=VcVhiERyGKHily5ypTgS5H29A4FBtKsk1pDYCwypsi4=;
  b=hopdn+gB/BnEGqxCSRTeCqHiXfA69E4RLUSliUNWHNpXZ4FzPDErMjXi
   9p5hpuQDe2Xbl/EuMH7wqpQr5kxpO+7kZze4xoNQTp4BbY40XSscnX1aT
   6O8vGGDfygLUf6qFz9m5B8/QYNOE5YCTQTtaVAiJvH0I76T3Bv08Ww1UJ
   Tnwgi+F8ddM2c+7NAv+RVCUwsmdWovSEDisjeQ20yUW8LwxfKSGEzk5Cx
   W9TouVRcn9+9ycIHEkuwuQy9Y1xXn98njocPxUoFGTtR9dPWejGoqAY1E
   /m5ogqtFLW5vufkcz3WOv5tpkwDRZuhIhp6DJOodB7j1b4cg0sx3UQYes
   Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AH/aaMRFAA55f38CReIncKJ1GYnF86YWxBRYc798d?=
 =?us-ascii?q?s5kLTJ78ociwAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk1Nou?=
 =?us-ascii?q?QttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZr?=
 =?us-ascii?q?KeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1xDHuGFIe+?=
 =?us-ascii?q?NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PGAu+MLrrxjD?=
 =?us-ascii?q?QhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC+85Kl3VhDnlC?=
 =?us-ascii?q?YHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6jAf90VWHBBU95eWCxPAIyy?=
 =?us-ascii?q?b4UBAekcM+hGs4bwvEcOoQekCAWwGO/j1j1Fi3nr1qM6yeQhFgTG0RQiENIPsX?=
 =?us-ascii?q?XUrMj1NKAPWu+2zKnH1zTDZO5R1Db96YnIcgouofCQUb5sf8fc0lQvGB/fjlmK?=
 =?us-ascii?q?t4PqIi6V2/0LvmOG7ORgTfqih3A7pwx1uDSixcchhpPUio8UyF3I7yd0zJgzKN?=
 =?us-ascii?q?alUkB0e8SkH4FVtyyCMot2Rd4tTH9wtSYhz70GpYa7fC8XyJQ73xLfa+KIc4yP?=
 =?us-ascii?q?4h/7UeaeOzZ4hHZ8dLK7iRa+7FGsyuP+W8WqylpKoS1Fkt7DtnAJyRPf8NSISv?=
 =?us-ascii?q?x4/ku52DaP0R7c6v1cLEwqiabWL4Qtz70wm5YJrEjOHy37lF/0gaOIbkkk//Kn?=
 =?us-ascii?q?6+XjYrXovJ+cMIp0hxn+M6UvmsywG+U4PhQSU2WV4um8yaHs/VfjTLpUk/I2j7?=
 =?us-ascii?q?HVsIrGKsQDuq65HwhV354n6xa+CTemzdsZkWAELF1bYhKHiZbmO1XVLfDmAvew?=
 =?us-ascii?q?nU6snC1ox//YJL3hBIvCLnzZnLfmZ7Z95B0U9A1m4dlB5p4cL7AFJP/pEhv9vc?=
 =?us-ascii?q?LVCzc1OhK5xuLgBsk70I4CDzGhGKicZZLTo1+V4aodI+CNLNsEqjb0KqB9vNbz?=
 =?us-ascii?q?hmV/lFMAK/r6laALYWy1S6w1a36SZmDh15JYST8H?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AfAAC4x1tcgEinVdFkHQEBBQEHBQGBU?=
 =?us-ascii?q?gcBCwGDOjMnhAOUCIINkwKFD4F7AQyEbAKDGiI1CA0BAwEBAgEBAgETAQEJDQk?=
 =?us-ascii?q?IJzGCOikBgmYBAQEEIwRSEAsLAwYBAwICHwcCAiISAQUBHAYTCIUeBaB5PIsbf?=
 =?us-ascii?q?DOIWQEHgUsSeYs4ghaEI4gKglcCgSwBAQGKUIU7kU8BBgIBgWWQYBmBbIkCh2E?=
 =?us-ascii?q?tm2MPIYEnA4IJMxolfwZngU6CUo4sITCOegEB?=
X-IPAS-Result: =?us-ascii?q?A2AfAAC4x1tcgEinVdFkHQEBBQEHBQGBUgcBCwGDOjMnhAO?=
 =?us-ascii?q?UCIINkwKFD4F7AQyEbAKDGiI1CA0BAwEBAgEBAgETAQEJDQkIJzGCOikBgmYBA?=
 =?us-ascii?q?QEEIwRSEAsLAwYBAwICHwcCAiISAQUBHAYTCIUeBaB5PIsbfDOIWQEHgUsSeYs?=
 =?us-ascii?q?4ghaEI4gKglcCgSwBAQGKUIU7kU8BBgIBgWWQYBmBbIkCh2Etm2MPIYEnA4IJM?=
 =?us-ascii?q?xolfwZngU6CUo4sITCOegEB?=
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; 
   d="scan'208";a="27151015"
Received: from mail-lf1-f72.google.com ([209.85.167.72])
  by smtpmx6.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 06 Feb 2019 21:53:29 -0800
Received: by mail-lf1-f72.google.com with SMTP id g16so1330546lfb.22
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 21:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuxZLL8UNbVQzWmaxCNdMvTP4WXTa93NPRnjzawF7/s=;
        b=rqo7bqK/PviqtaHTXw10qt3enF0V0FTrM55vEUHd6zhiZrrrMTvEOz7Wxdgm9EP8zy
         Lg0nJ4UGje1NtPlYFf/+Hqn1Xan9Kcgz1ph2x9b6XLM1vEmK1Pl706VvU97MTHoRDKmc
         2tN4FBPm61jYKGmC2nIMenVW/0kzToJ4KfpG57wmCAyApujwX3MIIBHOezpU1Yua8E1L
         WsNnVOjRj2bgV5e6MDbMgfwqjF8X1SzipI5AgGfxXvIclnlaErsVB2PNcRxxAg9n9L7/
         oRSQoqqpQPWlh19SVyFBjLLyN13ZYsMvmWKQPfp8brYF95i+/sAZk6QRbEVvgLOz84Ch
         AUlw==
X-Gm-Message-State: AHQUAuYEWeZ/lZ83iMJdb+vp2lY8w6xpoZGQt8ouHOZdsEE7dKyqAXSJ
        OFETky6csAzHt3u4yfJ8CCbA2MFfYvUidMI4ovrlcUmvvmQN2xY5vlgi7EXJXqYrAOebKCSHmPf
        KJzm91i66lshKppq48c3+ONhbze7Fiwy/yY8b5F8K2Q==
X-Received: by 2002:ac2:5230:: with SMTP id i16mr9363076lfl.54.1549518807246;
        Wed, 06 Feb 2019 21:53:27 -0800 (PST)
X-Google-Smtp-Source: AHgI3IadxvbDND8MVfG27lQv3DRXo1BjCd90b9Zx/Nd0gufYIjmXU1K/Fcm5NdhEj+YyxeekYEbWramdvbOF7CR0gnQ=
X-Received: by 2002:ac2:5230:: with SMTP id i16mr9363057lfl.54.1549518806961;
 Wed, 06 Feb 2019 21:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20190205221559.17545-1-yzhai003@ucr.edu> <20190206.201736.1146228626076916564.davem@davemloft.net>
 <CABvMjLQ6MYtGYeLxwceZsvcyn4oScgMo+BGQMHw7SkZ1uxFmHQ@mail.gmail.com>
In-Reply-To: <CABvMjLQ6MYtGYeLxwceZsvcyn4oScgMo+BGQMHw7SkZ1uxFmHQ@mail.gmail.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 6 Feb 2019 21:53:16 -0800
Message-ID: <CABvMjLTymaszPdX5afOHFfFBS1AueVzRVra5_QUr144GahH5gQ@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
To:     David Miller <davem@davemloft.net>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, but why initialization matters here? Is performance the main concern?


On Wed, Feb 6, 2019 at 9:52 PM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
>
> Thanks, but why initialization matters here? Is performance the main concern?
>
> On Wed, Feb 6, 2019 at 8:17 PM David Miller <davem@davemloft.net> wrote:
>>
>> From: Yizhuo <yzhai003@ucr.edu>
>> Date: Tue,  5 Feb 2019 14:15:59 -0800
>>
>> > @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
>> >       struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
>> >       struct device_node *node = priv->device->of_node;
>> >       int ret;
>> > -     u32 reg, val;
>> > +     u32 reg, val = 0;
>> > +
>> > +     ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
>> > +     if (ret) {
>> > +             dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
>> > +             return ret;
>> > +     }
>>
>> I agree with the other reviewer that since you check 'ret' the initialization of
>> 'val' is no longer needed.
>
>
>
> --
> Kind Regards,
>
> Yizhuo Zhai
>
> Computer Science, Graduate Student
> University of California, Riverside



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
