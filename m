Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE966C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B68B218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv8BMoeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeLZQzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:55:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36217 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeLZQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:55:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so14421461otk.3;
        Wed, 26 Dec 2018 08:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAaJlP9aaGld7gK+J2usCpSNkTRGzPvJFj+P3onMp90=;
        b=fv8BMoeH0cql4EYJtwnL34VzbDLpBSCvQNWDMyja8i7xuq///1OY72WzC3xJSvRxYe
         v/etlh5+V+HnHmCWttrYGvHe/AaUFqYr8ydNrp825j/PFxAccIFjofUnCMFxBFASEd3m
         yqjpamPwyRKDysBYkGAy9oxl4HVWxygPX0gEcHLrYp6pSH0A6WxMOmnkiKDHS5kxNwUB
         xYGcMmdSIFf+RhXJ+jjbZMZZxpaF0FsZI2Qa9wpyJqsMCLu/h+5KRMAZiJNWLGLwHwOg
         H1ZqtwWV0Ce1INL/5EgAbavOtMkJmTRlTGFotAWRodMBImrpLNG7Ms2Ci/XPPnP89vU/
         tcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAaJlP9aaGld7gK+J2usCpSNkTRGzPvJFj+P3onMp90=;
        b=AB4WuutalEDjlfw9ctEP6VGbg5ZsTKc9YUOv+BS7/aRPYO4xu+Tn4cPO/pIQjvjl06
         cn6ymT6yo7lLOJDIxtECbQDs4yAvYcfN72O+WUDlyB+/0/tG8UnLoIKtnywwZgHyccss
         uqrVmNKn5hDJXXMemcU3I0aZBvBwTj/QUfSRLMwEG7vA9OUMB0J3JH0TlOApdV+eF8ZN
         q1WqqBvdgX0DfU2esvzaoYY+/cxfymQJHG38CWK1DEGaFPHcWrw8wA/nwACrfKm2n+Ah
         kuX9Fw+VHd1WZ5nO23cPmWiccs7f8JdV2ntpcVayeEm/VlevGfKs0twWTzIAXuwm3dsk
         xPeg==
X-Gm-Message-State: AJcUukfAQqlfbyQ3dPRGDxsq7IQbhtCUVxEIjRzNXzR7kgu4nXXvpJmi
        OrpITvb300nzueQwnuQm6MCXihMYOS2nPF8ZLXo=
X-Google-Smtp-Source: ALg8bN46/yFlnYYvHSo31cQ0OC1KKdCHDMoq0CnWHb/MxFuZPkRqjfZCiddNIq8hC5SheSRlXQU2D4sXtFWLvzmGUAo=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr14732995otq.255.1545843308196;
 Wed, 26 Dec 2018 08:55:08 -0800 (PST)
MIME-Version: 1.0
References: <1545548891-24671-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1545548891-24671-1-git-send-email-abel.vesa@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Dec 2018 14:55:14 -0200
Message-ID: <CAOMZO5Be40EHVw63FKksy0s5DHMLbQLyRVgCxczgz_55tHJYMw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: freescale: Break dependency on SOC_IMX8MQ for i.MX8MQ
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 2:38 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> The CONFIG_SOC_IMX8MQ will go away, so the dependency can be based on
> ARCH_MXC && ARM64.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
