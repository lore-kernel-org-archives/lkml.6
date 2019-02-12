Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6D7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3DF20863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgAi8o1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfBLMPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:15:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35401 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfBLMPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:15:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id z19so4040717otm.2;
        Tue, 12 Feb 2019 04:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEOduNJ0RjW+YUJ0IVEj2dzwwQgGoMtGUNW/usiPNGQ=;
        b=pgAi8o1EwGJTeObiGthLjf6Sim83zww/PVb6khau6gXMnVhoaEaPtC4YME1l4/h80C
         Fl1vgAiKgbG28pgvKUUs3l+CGWG12NYevIKWvZqHPJGVgRyYww3cyFn9FtRVgJP/c3L9
         C7bv67a5yT+eojvigsCO2QcB3J2dfevZVnTS/1AZ7whXFi/1pphz1jzrUVyP/oqEh6Fl
         X/hCJU+y18JVmZi6k3w8QBSp3ya8ugEQ327yONrMX9aFm+q0LyOQmoyvU9t7vSXoxbiV
         didagrsKZlHlcpCc1tuvsg+wyiXnNMwHb9i26vrUdnuJgwhLP+pzQaviMxnWmtklqn97
         dBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEOduNJ0RjW+YUJ0IVEj2dzwwQgGoMtGUNW/usiPNGQ=;
        b=KPivBPNbW1uWvd7tHOuDHQye26TKPq3Ljq2LuWHpTEyzsD1qUf7Vpm/1q4IhQWdDA8
         VkG3wCTMHWd5s6lGrOoMtxIElvdz7Yhuwl3UUay/d480XR5K4XuuIZ+3ie2yfKd77T/E
         T7VXpi5RZTjTXkde3M5kqyHEk51AKx9JxeRu+pP+XZR1SmQQB/B+VK4bXt5ObSCkvcSI
         qLnDS9po0VYEZlT254xvrL+XnJA1RUtODUc/+XpCgo7LWwWpSq2EdZU7f1DRKt3RmW27
         hyLVy5DB0A7VLH7LllcS/O1pi9ib6qxCs4XmxCCUfUyYb7a8D5G3k8fcntmzF4Lm39vx
         Mqcg==
X-Gm-Message-State: AHQUAuY5hdyw9XNcGSNCgikwIuOUWpS+wwaXD/zDiSRrNO0hlC0Zfw+e
        CHbKelvUWuAc4E2wvfPzZSRV8NpFqWMUkO3Ohrg=
X-Google-Smtp-Source: AHgI3Ibilhy1y42eFwPUaYlPFd5yTFV4DGoIuhdnF09vbee28qzKRqSvOkz8QxTDmDa7QFOZjy6h/Z5eQB/gtU56dRM=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr3457366otk.203.1549973707260;
 Tue, 12 Feb 2019 04:15:07 -0800 (PST)
MIME-Version: 1.0
References: <1549973439-26706-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1549973439-26706-1-git-send-email-abel.vesa@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Feb 2019 10:14:55 -0200
Message-ID: <CAOMZO5BgWYKv_sJ=pmknEs+CdOasdK47H32xbwtHub6s0yi=rQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add cpu opp table
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Tue, Feb 12, 2019 at 10:13 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Add i.MX8MQ cpu OPP table info for cpu-freq driver.

Has the imx8m cpufreq driver already been submitted?
