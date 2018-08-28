Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA80C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E215C20869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTyGfrx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E215C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeH1OVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:21:39 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33528 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeH1OVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:21:39 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so1940207oip.0;
        Tue, 28 Aug 2018 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X3zjrahzUeEnh+EkLX5DUTEuWyOz4MKRx3KgBif5Grc=;
        b=WTyGfrx8bZVX6hQgcgp91cjrWn2hq+Xb3xt6R9I229RMX2xjg4ah+rF39ge4ZgBu6q
         75Q8YsfkzWXSuxz8zF1rvbtrjZDpAGtRTEyBVTtKbYhWxFM1srEXxgw2Y1Vv3DELyLPo
         nwImQ02GgS1ScN6tSaG/F9VV+sNSiqnlLtzxOeS++QRU8nUhq9AAsNOcrmsS/zfK86QR
         9cW3kolP5u4hcv/u2kKu7+d3ABDHf7kOODykuHBbaKLvyd1Kmgwo921pH9LtHJ8H1/Pb
         0FT9eBBn8/m+QOedc0iXINDlvjdex2Dk0doqYOZLX77e1Ez4kWx1TdDm5VSVTBrENBT0
         d81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X3zjrahzUeEnh+EkLX5DUTEuWyOz4MKRx3KgBif5Grc=;
        b=Jq6y3SO0lYnNNxiVw4nk2Bc3dHhZfBdOPqlbS8ZtMknJE02ZN1QyOW8AdMY6atejxZ
         l2y54qNZIoZBm/4lIFZPubVUNOtAnoGG9bvAV47zLxNhi3jSQGWvwOQba5lXoh/46pkj
         n7hNEP/GR6pYuQJJA9Y/DvWo7BYTNnXxCebIME2GMesCy5LPx4skVln99ahxiaImo3mR
         El6pEoMo74nm8QUqG3kmzYsgPLuLYFeLu94/YRg6aE0AIYlK1+lKZCKBmgYGj56QfGCo
         HHZKXSlvLbdWEBfSv5HVHyFp5aSZ5zCcFktGilcLJqwKe5gP9klBS4hOlCyvtrVFqRUZ
         QybA==
X-Gm-Message-State: APzg51CF8ifKLldjTwG4zMMZCzecsqkyh6czZyhlBbUGGMoVQPbfK5ZD
        ajg9wNC5mc/0e8kQ7RbvdeEhQaEqaJ8EDk6hRkR5yA==
X-Google-Smtp-Source: ANB0VdZkXMRnzu93K2hYiQTnb3hC7n8sZ2FDPDd29zUgs56x0TVKyjpbW7Wn9PVJiGSTb7h7pmS8KuNne5iJJWnzbho=
X-Received: by 2002:aca:bec2:: with SMTP id o185-v6mr755302oif.22.1535452240137;
 Tue, 28 Aug 2018 03:30:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 03:30:39
 -0700 (PDT)
In-Reply-To: <20180828101213.25750-1-yinbo.zhu@nxp.com>
References: <20180828101213.25750-1-yinbo.zhu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 28 Aug 2018 07:30:39 -0300
Message-ID: <CAOMZO5DJXjWWAOzx_hQKUzjvkb_cCXhGF9nEwnxk8nwTvagh6g@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: ls1043a: Add configure-gfladj property to
 USB3 node
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajesh Bhagat <rajesh.bhagat@freescale.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Sumit Garg <sumit.garg@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, xiaobo.xie@nxp.com,
        Li Yang <leoyang.li@nxp.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 7:12 AM, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
> From: Rajesh Bhagat <rajesh.bhagat@freescale.com>

freescale.com addresses are no longer valid.

The From and the first Signed-off-by lines should match, so use
nxp.com here instead.

> Add "configure-gfladj" boolean property to USB3 node. This property

I don't find any dt-binding doc for this property.

> is used to determine whether frame length adjustent is required or
> not
>
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

You missed to add your Signed-off-by tag.
