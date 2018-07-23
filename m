Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853D7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD3620854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/xZtikm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD3620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbeGWVvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:51:46 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42122 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388070AbeGWVvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:51:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so3607109oib.9;
        Mon, 23 Jul 2018 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8QbL38i6F1TZ/bOdol/V5ghOdtQ5YahWalmeKqLT6kU=;
        b=k/xZtikmcTNE2lpji7ruueWxnSo4nOwDjmwm2oHg8qcW9L3ssxpLhhN3BskCk17+RD
         vxsGmCyYtPZtVArTIUFC5BknPxdrd11xS62uxoxM8MB2kBu2mYMIG8fAUaUQ0rdB+kXq
         VU9TLL2mrz9ef3acpq8L3BlNhV/HUMDnVneFemXKKZDtUskCDvGTZ9Jb0MLu/OyfDfo1
         JXrhzyibqBExZHKkpaBHIHWaG1BPcX4xjsBpuyCP43eMF/+5MduLNl7gNhqAHEACSTdC
         FOVgUOeRVt9payTPrDZjvVU/Ox8L5/npMOur+f2rtu0rnK6nNqRtmlVu0vGdAQIkL/c7
         MhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8QbL38i6F1TZ/bOdol/V5ghOdtQ5YahWalmeKqLT6kU=;
        b=mKSfLvBZctrxX9gYEpc7hO3rqNr7IzNOa5So+Bkq8p0Uzq888XjHLC/wGGs41s5FTl
         e9R9trO0sosrPyKsybouobhvU94oBgzbitKqD/gJ1dFt7sUcRA0oEy3vMc1BwEeTKAIR
         aIAvrwRqSMAlmGQZmY2XjLTbR9NW/zqP3uzs7sP0ZKaVzo/Z4bzd5f4QjDRGbFdR5WH+
         0k1Gmn/U+me+SXfswoHVntWoHnH0rkTcMPE4QJ7Nc8on1dDhhai5wqTLR7RERwSh9vzW
         v+X7e96wke+Q5/wAT0A5Qgno8oSbP11CIENjv6Jz4K1hTynuwOdL3yxH2jfuXst7khTD
         tSMQ==
X-Gm-Message-State: AOUpUlE281XtR//U5B1iitQ1NZ6/NSi9oMrPX8jwi8PQoLzz0yDkc+h/
        IyR7VBP+H6rg310gEq2Kr04pmfCOzOPo2sFhTPV/H3wu
X-Google-Smtp-Source: AAOMgpdzEmo2uPECJK+3IWbiH55+aCVbkMtgnFo7PeswdK1G+1at5txHJZ+9vJz3W7hagycau7hWVCeI3Ngy5jiZYvw=
X-Received: by 2002:aca:45d6:: with SMTP id s205-v6mr401264oia.147.1532378929219;
 Mon, 23 Jul 2018 13:48:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 13:48:48
 -0700 (PDT)
In-Reply-To: <20180723074747.9328-3-m.felsch@pengutronix.de>
References: <20180723074747.9328-1-m.felsch@pengutronix.de> <20180723074747.9328-3-m.felsch@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 23 Jul 2018 17:48:48 -0300
Message-ID: <CAOMZO5BpFebK1Y3o_3m2WTDTjsv7Y34+kwR_2EEmDHMvPH+O0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] regulator: pfuze100: add support to en-/disable
 switch regulators
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
> Add enable/disable support for switch regulators on pfuze100.
>
> Based on commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for
> switch") which is reverted due to boot regressions by commit 464a5686e6c9
> ("regulator: Revert "regulator: pfuze100: add enable/disable for switch"").
> Disabling the switch regulators will only be done if the user specifies
> "fsl,pfuze-support-disable-sw" in its device tree to keep backward
> compatibility with current dtb's [1].
>
> [1] https://patchwork.kernel.org/patch/10490381/
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
