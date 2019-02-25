Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7459C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9241A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnvmNHO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfBYJqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:46:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33676 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfBYJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:46:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id q24so7321257otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 01:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqNcjJhck0p4PRSHnizGkdCIVQaYhz+be76mG1pizg4=;
        b=XnvmNHO/PVRNpOqTRPLPe+tFZGdiWTKpDzdi9l+cYjBoEnxPPvv7cSi70Iwk9qCIdn
         ofC6Im9k85SLu1EhCrNuZ9F65vcb9kNFKpvDVCF6AtRORBGsV70CFD4bIgEdQk5LRYRG
         rRt5sMV0iFnq3EE6teDgefL2SXcpsndiQEhaHh864zEkLAjplfZx+Bs3/INo3dIB2AVv
         GbJmNOHw8ao7slxNQ0Mf5/O+fKks7Js5XVTruwAKwz+Z2mud16C3FCQjRXFpqQaTdyV1
         9oLGBcX9XPDjecND3mn1arLCrfMAAaZPmqhpa7Qsis+snFQjZYvylWWq6umRNV2LNA6Q
         Zi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqNcjJhck0p4PRSHnizGkdCIVQaYhz+be76mG1pizg4=;
        b=NAI7pidmaBb12thtXqY2wteMUTGkVrWytOXLYOukyTewZZknCWxYUYllSrPJXnI79P
         76E28z0/RWJ8nVKGtolAE1WLM1eByBLM1LqeEVzzyKgwwnzOL92CxseTzk9sK+ULLMl0
         6DOIwzvZKaEfJlqe3XAZFiZDjDOnc6ZuRogB7AbgjOjXmtAgG89odqhTajH60gqXC+LE
         c+8ABrcOu0Hdqp5gaAsGzJwp8WbWjcA+d51eCQ16mg7ULzMbKdqykujONeYZHFgWY7q0
         9WJyaxbICiUFQTszN1kU5U2wPcCxXNLTSs1J760DBt0VO4NxsSIgxsobiW8Dv8xx0LaJ
         ukHw==
X-Gm-Message-State: AHQUAubdaKe7rB63NWL1j9M+JsgIrNvQqiXgGsukU1i38FRkyt3qjJTu
        v/OcO7N3jVl9P56zMT50gJuBPc0fPYmJ306h3s8=
X-Google-Smtp-Source: AHgI3IZLUdbKTzp4EP9JXC32bJrSzNGO2unzLilsVSXNIifVsM7XJnbazAC3EfdnjjMtjHcZWRGPjAPOSFYw1ga+xEY=
X-Received: by 2002:a9d:7594:: with SMTP id s20mr11350303otk.112.1551088012557;
 Mon, 25 Feb 2019 01:46:52 -0800 (PST)
MIME-Version: 1.0
References: <1549194583-7684-1-git-send-email-abel.vesa@nxp.com>
 <CAGUNXRTY0yKnLH1hnxiv5ydnWG2VKNzpY_4rZ2yRhj8_Jq9rYQ@mail.gmail.com> <20190225093110.xl2va6jfov3wxbyk@fsr-ub1664-175>
In-Reply-To: <20190225093110.xl2va6jfov3wxbyk@fsr-ub1664-175>
From:   Chris Spencer <spencercw@gmail.com>
Date:   Mon, 25 Feb 2019 09:46:41 +0000
Message-ID: <CAGUNXRS_DOMZ_G=JtEvZgfPMYrR_gbeoTGMEAjodVZ+AthP1FA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Add generic i.MX8 SoC driver
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 at 09:31, Abel Vesa <abel.vesa@nxp.com> wrote:
> I don't get it, in the RFC you said you didn't have the boards to test.
> How did you test it then ?

I have the i.MX8MQ-EVK. I have tested it on that, but I can't test it
on anything else using that driver (i.MX6, Layerscape).

> The SoC driver needs a little bit of rework because of the way the
> revisions are detected. I'll resend this in the next couple of days.

Ok thanks.

Chris
