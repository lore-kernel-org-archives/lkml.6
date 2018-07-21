Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E8820856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="0Ja5fPs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E8820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeGUW3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 18:29:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45036 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbeGUW3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 18:29:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so13835130ljq.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 14:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ko9EqyqGqvMjncDtON9O136bCfOfMk21zGU8VR16JIw=;
        b=0Ja5fPs73jqNj+D0KrXPcgUYLOIaKQljhfoWodPyNq9xWOGIWwTl0skns9NNG+pcE9
         uRrWvUA00L/YZFUCDCFGQ+J2FoYyL+IGVhjJNrq6op8rBgcuAC+5VumO8O1CcljB2NbP
         Pytx4I+xsleQQmmqemXmIlzlo+UZGV1U1zcr86wOfNYgY/+9rq8cjqAllnsNjuZjql1h
         gmlvWJZJHWyOX9LcKe2kY1OAuzcnppNMghN6R2xF4o5qGxxAVSUGmr7WunZKiDz+tBKR
         QeqYLNlT/0SDlL+79FfFryJDcCfHzZlhcTYXegfN0T8VNRfoo2D5adch2kqqiOBoP1wb
         VpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ko9EqyqGqvMjncDtON9O136bCfOfMk21zGU8VR16JIw=;
        b=r+2Tn4Zqe1NLs8OI7GQvIaZ9IlwOQMlJXWwIu2n5ocQIm8bnltVkh1niQjA/frD9xX
         PpIYGpD+9wgbk7F85LNu5OI5kprgUMGeIaHXn3519obiPE0NSTubdLC4/XhaBhwK/DMB
         QCmIFuV3Rw9iNbPB9/GUy0tQmX3TdaYeXqUIohQDbTRwrGfu1gjSU4lBAYPpQUIWIrh8
         uGmKw7dpEL5KAtRvQiU8A5Uo+5k9OfW7CVgnmFlsuH8CCeKp+mBn5gLB7An9S2GGSZQ3
         IUQwFYMaGxn8Xl4q7QfAUinWhBbiTbrpULt20XmaN0zcNWfpgumMqnnGzgczi1xYZ7eK
         m6qw==
X-Gm-Message-State: AOUpUlFgf/Ei45kbGR0eU+xfFwjMmMaa6Z1tTgwWyNMW/Fv2LBKE7L9w
        Zc5DBypZ/I4fuJJdvfQ8mUW0wUox5OdCl2bEaDL4HQ==
X-Google-Smtp-Source: AAOMgpdEjWOFoF8GKVt8iiI6ftS5Y82djAG97EGAJ4LZ7iJQT4ZBoPhEGh5qE6ss1+83PtmMosdlOmLtgA+P/k6Hcl4=
X-Received: by 2002:a2e:4357:: with SMTP id q84-v6mr4817761lja.13.1532208902755;
 Sat, 21 Jul 2018 14:35:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 14:35:01
 -0700 (PDT)
X-Originating-IP: [50.250.208.49]
In-Reply-To: <20180628151544.22134-14-antoine.tenart@bootlin.com>
References: <20180628151544.22134-1-antoine.tenart@bootlin.com> <20180628151544.22134-14-antoine.tenart@bootlin.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 21 Jul 2018 14:35:01 -0700
Message-ID: <CAOesGMjx_Qprh+4Y6GM4BqGOeJtKWwAhkFNvBz0PGqQkyuRtrw@mail.gmail.com>
Subject: Re: [PATCH 13/14] arm64: dts: marvell: armada-cp110: update the
 crypto engine compatible
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        Nadav Haklai <nadavh@marvell.com>, oferh@marvell.com,
        igall@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 28, 2018 at 8:15 AM, Antoine Tenart
<antoine.tenart@bootlin.com> wrote:
> New compatibles are now supported by the Inside Secure SafeXcel driver.
> As they are more specific than the old ones, they should be used
> whenever possible. This patch updates the Marvell cp110 device tree
> accordingly.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index 2bf083272a87..bb2914f90048 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -427,7 +427,7 @@
>                 };
>
>                 CP110_LABEL(crypto): crypto@800000 {
> -                       compatible = "inside-secure,safexcel-eip197";
> +                       compatible = "inside-secure,safexcel-eip197b";

So the device is still compatible with the less-specific binding,
right? If so, it should probably have both compatible properties in
there, not just the more specific one.

(Same for another patch in this series).



-Olof
