Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CA3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243A520854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtTqzJt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243A520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbeGWVvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:51:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33174 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388043AbeGWVvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:51:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id l10-v6so3639699oii.0;
        Mon, 23 Jul 2018 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GJjLMhxqZsUEP3erNZfZwcEpcor6+BXpv9ObD1y3UZ0=;
        b=FtTqzJt4vdeXRZqUKGKxXwCkBC3ln0klB05RcvW8hbFhXO3/9ScyRGxRPSV+SMYDyn
         EO1i/qSbbwN+f6cWd37S66E85QIGO97WgDPYfwAtxnGK6jlQ5SWLrK7RuZsJ4k4CG7aA
         +slZBD0qMb6VqfTX+hSkVj0J17Yaql7YUBT9n5f/CK6isxBdY4jtmv/EFCLUDI85goBm
         W6KtLD0E9KFNLFd/TXEv29c0aQVnq8EehYruEOR0IXrXRncH0QlgXsMvDob/oiemUkdq
         OSMAcEmOtbone7W5urahRB+i2ddVVh7pERqIcvNQsnQd0gfyDYyeFopndooh/nnJbefN
         FawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GJjLMhxqZsUEP3erNZfZwcEpcor6+BXpv9ObD1y3UZ0=;
        b=lfo8fy8xiqVNDjDNFAxLODZTVmfV9jFTGZHpjuBwts8h5ic4Ac9l7WMAHG23BxD2CB
         PuSGEZRSVUOJ0NyCjFQcNu+BTdW5NYX6S/+WnKKv0ADctwF8wM2S6W9d2dvVZLott/ac
         MVzGnSOj5DYmvqX1fNHf68sujB33yQwtT4AKtLVTAni34fDaml1BzOOsfEEqaJMQbbtW
         uoV2Xj1VsAllHBeFFpEyaCfDa5vryOkG4xSQi8rLQRi3fF37/Gl+1TbBBvXB3smen7ZS
         8ZPunTsXoYXutBWjiWlGOc9nvzOlNeYeH0yHGawWCbsdgLE2p9v61W8gPbJci+fdj/YK
         11Vw==
X-Gm-Message-State: AOUpUlFQM3QG25XLYNQAisEUH9hH9+UOxk6XxTQB7jWxZlNyXbMZAyGb
        HlRs59t0cTrtlt0wmjkgv/iZx1KHoexoIeIdsoc=
X-Google-Smtp-Source: AAOMgpcnq/IQ2e3tqFupLzRUtOOpv0Mek+CPfaUyXkTFHuxZYExFnPj0TsGHxnEa7Ukdosb0X0ZWlH9mBnimHPuQhzU=
X-Received: by 2002:aca:4886:: with SMTP id v128-v6mr409824oia.69.1532378889558;
 Mon, 23 Jul 2018 13:48:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 13:48:09
 -0700 (PDT)
In-Reply-To: <20180723074747.9328-2-m.felsch@pengutronix.de>
References: <20180723074747.9328-1-m.felsch@pengutronix.de> <20180723074747.9328-2-m.felsch@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 23 Jul 2018 17:48:09 -0300
Message-ID: <CAOMZO5CPqLDJTSYYRmVci_NMqooSLSQrHOYb4FvHLxMzRB-c3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pfuze100: add optional disable
 switch-regulators binding
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 4:47 AM, Marco Felsch <m.felsch@pengutronix.de> wrote:
> This binding is used to keep the backward compatibility with the current
> dtb's [1]. The binding informs the driver that the unused switch regulators
> can be disabled.
> If it is not specified, the driver doesn't disable the switch regulators.
>
> [1] https://patchwork.kernel.org/patch/10490381/
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
