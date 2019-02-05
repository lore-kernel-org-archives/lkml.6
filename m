Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A722FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EBA217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkGDSbHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfBEPI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:08:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35655 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfBEPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:08:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so6220052otj.2;
        Tue, 05 Feb 2019 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1Q0QlJvIRfHK6i1DO3S3Cu2PdkkWhb+q/mjicRFa/U=;
        b=WkGDSbHHiaHVj+2gvxInYdV8gstrS2hDiSAGCyNqsYB3JUfvA2mjPZkqUcWlh3ejP9
         x8MAImD4Zqpc09wfYlml7v7GIiczSgcUkXcWNT4IJR1StxAsugieGOnwD1cSo14eiP68
         HWz8RCh0bMmcMng2SouKxqNfRYiU1unpmq00o01XYp2t8zSbTM74lPmeNsnFVqBJgJs/
         EUJP/M0RMGUD60VIqWEErnvXnz6Gn3Tjkem1748IpccC+1kl35U2ojD3X7iM9MVNx5NH
         rmJdwjzmt+aNi8sHvCTN7+4nj496uvjah1jcXGnadBQUaouq/iOpADYfC4Mnssfugt/Q
         /bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1Q0QlJvIRfHK6i1DO3S3Cu2PdkkWhb+q/mjicRFa/U=;
        b=sz464AW06J9Akm4lMvREM+oCup2LiMljUntJeP6wu+Dg5kLGneg6vw+pZfmGqwJ5Km
         itEf82unTFa6zMG7jLncWh5ptu2y9Hu/ep23zF2Ttc2/dxiEY5aA4aQgo+xD+Nk1R0j4
         85xitzBiMN/ma47UnMh6xLOJnSSQNKGqQSMIpDh9YPncWnpcZuICvIxRnAQeIOJWeQas
         8N8dLjql4YrebOtJrfnAzWjD/ayV1bmHv97sfuKOy9AfbsrQVyeT2EJv52F/vpzWyW84
         DwODox1+Ive57zB+YOUBniC0GxCruvdMzwObKVp3gNaYk3KXkWeSdJp3d5XjufumYJ5x
         HeaQ==
X-Gm-Message-State: AHQUAuby3O+nSfQ/KJqilqkfjTpTcVl7RfY1RTe2UCH9OFebgpORWSXz
        OR+78eXI1c/9S73K8Cd4Md9aYPhujSuD81/qGoouXw==
X-Google-Smtp-Source: AHgI3IZlWOHqiiwLay1ZXepPp3GHv3HmnVS0Mau7jb1d4+uKmG3BMMqtMJ8/MS/ZwPQJYGrSufjSOfQ+ttlSvs9iMeY=
X-Received: by 2002:aca:c591:: with SMTP id v139mr2835945oif.76.1549379305480;
 Tue, 05 Feb 2019 07:08:25 -0800 (PST)
MIME-Version: 1.0
References: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 5 Feb 2019 13:08:22 -0200
Message-ID: <CAOMZO5CX1CNNRrKkifTB3JDCHzpznd42Yy2Ea42qxAVkbouHUg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add RTC support
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 1:03 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add RTC support for i.MX8MQ.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
