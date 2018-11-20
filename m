Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4876BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F71206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZEJjFAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F71206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeKTUaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:30:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44970 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeKTUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:30:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so1075955lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 02:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+D6yY7Cfdn/qNniqdYwcc09iY07oQJ8kQYvIwB2yU6A=;
        b=TZEJjFAmI8+W9i9LygDdCdU5V3NvxTkX+YIM52DOFNCFh5OoytXLXwG0LIbUQL3CGw
         WHSZonMobR46rU2Iv922HRMNKgzfURe95PLLXluRTuiQGmRrIWPSEotEeB0XiynU/qdF
         XAP/hpckQDoebVlcWcuaFhAzTxfvPpYcl0DFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+D6yY7Cfdn/qNniqdYwcc09iY07oQJ8kQYvIwB2yU6A=;
        b=PIU57UAmQ9nuxjNylm2N4h64fkUeeE3I5bu/gt2iSoD/C6CnxR+FsS5SIri5rRrBcG
         HQFoY6rajtPbTEoC8GNac1GYtXH1WaYiglspUlOznD9MRpiJ2L+MMYMP/SHg79ga62sj
         Cg2sS1NvC/1LDHwRGopEYHpCg2Gb2hbYax9j13Bvg4gQJZ8fHqXKywgfDc4/Qb4qnsKS
         KUcbA6N6M7GTe361E4QfJk60ey2MliQHitz8hn1QKt8oCDLe35Nj/pArCuhIuDWyRtgj
         tnblL/o0U0pLjjFF9uvZ9Ap6TvsG5tKEslap/mh05XveymPn6+b3c6p2h3khph6tOxcl
         pEgQ==
X-Gm-Message-State: AA+aEWYGyOeA27BeZ2goJVkpF9DsgEusSCQ5kIOTeiDAxZZ/Y7zCkGTO
        tSl2T7gaV7OlfqgGi7uxdT6ocyzzT29egAAGxLQ4Vw==
X-Google-Smtp-Source: AFSGD/Xg997BTw997N2nDG1nh21PTWwpmzRZ3GX+6ZDyvUNKHBF+d52Z3DYXlXcEyGfjhzrF/bNsvnXFINbVRsTF388=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr807920ljp.12.1542708136101;
 Tue, 20 Nov 2018 02:02:16 -0800 (PST)
MIME-Version: 1.0
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 11:02:03 +0100
Message-ID: <CACRpkdZj4g9Ht-4sHjFMCmaeZnwmM3AcMaN2rQ65O1Ykgp2eWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] add SAMA5D2 PIOBU GPIO driver
To:     Andrei.Stefanescu@microchip.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Cristian.Birsan@microchip.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On Tue, Nov 20, 2018 at 9:08 AM <Andrei.Stefanescu@microchip.com> wrote:

> On SAMA5D2 SoC the PIOBU pins do not lose their
> voltage during Backup/Self-refresh mode. This can
> be useful, for example, when the voltage must remain
> positive for a peripheral during Backup/Self-refresh
> mode (suspend-to ram is the Linux equivalent state).
>
> v2:

This version looks good to me, I'm just waiting for a DT
binding review.

Yours,
Linus Walleij
