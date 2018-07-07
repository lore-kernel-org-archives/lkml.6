Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8C4C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF87220862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="o+h3epPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF87220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeGGO6S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:58:18 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:54874 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754155AbeGGO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:58:16 -0400
Received: by mail-it0-f54.google.com with SMTP id s7-v6so20062162itb.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QDNKgTzzOtqjDRnfXM5QHXT1uXc+jR3beFszG+7PNY0=;
        b=o+h3epPZiTst6ulsE6ZpBHw1skNXHsSxSTRaclkhOxq3ICw8GtCCVfakrngX1sZqHV
         6IbqVrDlJWoy9kTNwbJ/9/et9838uCjPIGRbdN4RkPfh6z92H5QE4BI1jVhKIRzL6M0k
         OHhbmKHTyooC4ZYqUsivR03pXIzYv+vVannpKoD4USHe5GJkLaum4QWSUYJxIkv6nCfO
         BoO8VPSmPSKp9yh8/UYxotHihMXqn+7Ahux2dVj6XemittTwSeeWsdjXL0MtQUma41Vm
         kXhHkwS+1mrCb3aZIYAa1PWizU5nv21LjX4bblcM+BN7s9v+7PivIrnka4QZrr4POby+
         GbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QDNKgTzzOtqjDRnfXM5QHXT1uXc+jR3beFszG+7PNY0=;
        b=XEQUI8CXRVScGfEtvAJPLgDCbp6LuuktMMEcY0+CKQCQnLBR2ylWyFtesBKZJKbXc5
         qqJ27Tlb9/szKwkbNW/YghsTpSHvmUF5AHTuHmrlXDdZhKijwekHEgJpd2EoPD91cpKv
         5kIDpvzI43fUqwN1I6ULOUGwSBB7Gx2DGG60KiUvFy/EuMqrdCkhof0B8jiR+xK8NnnK
         yTMnR6+BP7GP8WsdO0rq0HnSKYV+RsiY3I/skHF6q0cZuBSvzCQKwthLu4vtL5BQRb51
         I1BGvEKlIzNWr0CRxGXkv3NDi+o/heyoCCg70iayKiWhy3KugRmyncvajgSddnBF4iOZ
         a76A==
X-Gm-Message-State: APt69E3wMAikfegl2iegqBbX5RxnFNjt1GQI/vNOhA1zKpxtcoyvQsI9
        poqB+O+ZPPRvyieYzdm3Ad/0Yt6uW97Ef7wVESF+Bw==
X-Google-Smtp-Source: AAOMgpeyAV2QykrWZJW8KkUSSncbQq1ymQ4bAejE7M/YrYXSic2ROXY5007ZvMG8/e8Nq/g7ys3iFhQ+g4ivYxjVrZg=
X-Received: by 2002:a24:9b82:: with SMTP id o124-v6mr10586532itd.56.1530975495390;
 Sat, 07 Jul 2018 07:58:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:8e47:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 07:58:14 -0700 (PDT)
In-Reply-To: <20180706131949.2684-6-gregory.clement@bootlin.com>
References: <20180706131949.2684-1-gregory.clement@bootlin.com> <20180706131949.2684-6-gregory.clement@bootlin.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Sat, 7 Jul 2018 16:58:14 +0200
Message-ID: <CAPv3WKc-h3pJ+OjpLS24=QjiTHKUEZ4ODC57CZ-fr-eoa1DDdg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: mvneta: Verify hardware checksum only
 when offload checksum feature is set
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Dmitri Epshtein <dima@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Gregory,

2018-07-06 15:19 GMT+02:00 Gregory CLEMENT <gregory.clement@bootlin.com>:
>
> From: Yelena Krivosheev <yelena@marvell.com>
>
> If the checksum offload feature is not set, then there is no point to
> check the status of the hardware.
>
> [gregory: extract from a larger patch]
> Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 12739fb60732..8fc4be238083 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -1716,11 +1716,13 @@ static void mvneta_rx_error(struct mvneta_port *pp,
>  static void mvneta_rx_csum(struct mvneta_port *pp, u32 status,
>                            struct sk_buff *skb)
>  {
> -       if ((status & MVNETA_RXD_L3_IP4) &&
> -           (status & MVNETA_RXD_L4_CSUM_OK)) {
> -               skb->csum = 0;
> -               skb->ip_summed = CHECKSUM_UNNECESSARY;
> -               return;
> +       if (pp->dev->features & NETIF_F_RXCSUM) {
> +               if ((status & MVNETA_RXD_L3_IP4) &&
> +                   (status & MVNETA_RXD_L4_CSUM_OK)) {

Small nit - wouldn't it be nicer to check conditions in a single 'if':

       if ((pp->dev->features & NETIF_F_RXCSUM) &&
           (status & MVNETA_RXD_L3_IP4) &&
           (status & MVNETA_RXD_L4_CSUM_OK)) {
?

Best regards,
Marcin

> +                       skb->csum = 0;
> +                       skb->ip_summed = CHECKSUM_UNNECESSARY;
> +                       return;
> +               }
>         }
>
>         skb->ip_summed = CHECKSUM_NONE;
> --
> 2.17.1
>
