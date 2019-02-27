Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6731C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A5A217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldC+wThu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfB0TsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:48:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36107 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0TsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:48:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id t206so14488201oib.3;
        Wed, 27 Feb 2019 11:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fldtQHOifDanDhFlYrzElnvY/w/FO+3Si64v4s151xI=;
        b=ldC+wThusiems77n2S/eNCFK8H5GVsKpTGNDt7XyAeVAlIlxGTxPZJynmbm++33TtM
         q+JemssC1yZ0ojiKPp3TkkH1Gxme5R4gyw8NqeEVoruyd6Y7RtdOG/dFDbZ9RRjIvDUL
         UGKIzFTFLaMD4U9qnFttQM9zjtOq4+KCPLUWbnM2jv01H3il9tdeb5Sh5cnW2G8oALxO
         78y057ZZBZ7xwtqrn4DF1a6+ntIFYJP1Y7hrhteTRplWkO9ICR8XtQ6ImvGlAz+8xE4A
         LWE5o+lJnqt3bSxYk4Oz83y2JtegNgPP8iwk4icYcf6gX68KUtBPPg5B4iNFjsEqp0FT
         ekCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fldtQHOifDanDhFlYrzElnvY/w/FO+3Si64v4s151xI=;
        b=iwOjXTIOpnDwDA2t5tg18E/QvFRALSFzVakY0bel+2+vCo+u3SWtwJkMiFRKErp7oM
         D/O88GakGo5owzqI9SGlGztQoL1BM+/SjAAAySjBJarzkGm129qE2GYncigEgR0YwOfC
         KHRPHkRfYuO7RS1rj9cm3hgnbeAA/PcdJ5afQwe+cT7rGZPMPZL/3iQ1YNNwuTuKyBvH
         cdkbmE3wVkhhKihwNEx/bkRpFE0pOlsEhNkJfZDUbMldnbqC+KX102WkNnYJqlnr9IdR
         TrN+X5/hV6GjL6BllTSswEaeHOC/lTLa6CrojNNoOAs+6KjDuyFFsRr/ek5pCce4iLRf
         U1Hw==
X-Gm-Message-State: APjAAAX9Ue/w9/M8jQcf9pIC1FmaEfgSgC+FgrK70GnIMSCjuGFDfPHi
        3yEpCf+PFYV1doBYFADu8DwMDgiBXPw9kBCxVpA=
X-Google-Smtp-Source: AHgI3IbIQ3i6Q1ipP8ZXVvoVzdH+2F5CKoAo+HBuHc1SUwBvUoh8y9K/ZvDBhlPm19e1rykUom63V1ggknt+WcjZw1E=
X-Received: by 2002:aca:aac7:: with SMTP id t190mr594721oie.43.1551296883878;
 Wed, 27 Feb 2019 11:48:03 -0800 (PST)
MIME-Version: 1.0
References: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 27 Feb 2019 16:47:52 -0300
Message-ID: <CAOMZO5BtjCDw4Vd2DpJdw7iamK694EpvGxsVZ7Me_guesoqqaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: memory-controllers: freescale: add MMDC
 binding doc
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Feb 27, 2019 at 7:08 AM Anson Huang <anson.huang@nxp.com> wrote:

> +Example :
> +       mmdc0: mmdc@21b0000 { /* MMDC0 */

Node names should be generic, so:

memory-controller@21b0000
