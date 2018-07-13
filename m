Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC313ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F17208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHYulW0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F17208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbeGMSNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:13:49 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33887 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbeGMSNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:13:49 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so63777146ois.1;
        Fri, 13 Jul 2018 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JCbEJvtEAKr6LRHAyY0uFY7d1JRtqQB+Qh1UAIz4HYc=;
        b=YHYulW0K5dFAmntogym8qmFABcHqEe52Jn1zgUHQwLDfdsRKjN11z5QxgoAddahFWM
         ZaazvZguKYzeCiBc2Id+RJpUluTDWyYIIVgPdJNUU0mKV4y7AnSBnUOJdfn8dpGOeEhE
         TdRsgi8a+/KstghxPeCzog/VCfcB9gpEc3pg3/LLoqx79dsfE3aQEFuvSznKt+09W2Vf
         G6eORLZGrm5dMDfMjWz9EMSpo7FynYg1HTfEb1NBuyTqIDURq0b+YrmVC9ymp8o88DDQ
         4Rfk2Ml7WWmopOJI3lm/CtTuK0mKS9pP2D9i9mg+jQ9H6U3yREQ0foluTZIihHbgJ4SW
         /5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JCbEJvtEAKr6LRHAyY0uFY7d1JRtqQB+Qh1UAIz4HYc=;
        b=cnRyN4P9AEFIFv/n4FWjL/pStQIsTFvejEqPW50fomGAvUSF5hOFec5t61eW28hj1N
         bM/aOzZhoFecIzIfQC13f0RQlyygEQb2uzVewvJNOt4vn5X/q8Nw735bBjMv1VQ8cm2S
         jJTNKSWktudu8Z78TN/+zIgsiHeA0ujSsURENMD3ByumCcx7f2FMaXSR12WRM2w6Qzo+
         E9gVorq+0+N4vHTk9MtMCEIJDBWxSvr4mbuanvtOz/wIqSngeV5Ar35xRcmRQCEby1OB
         HaLWjIDi7CrCEIZNWkSUEbyKE0Af00wwP29RJqADUCVvEk0bWZ+zGEbZvj7VK1XOs8Ut
         xA4A==
X-Gm-Message-State: AOUpUlHhVeaiyL50HVOOLn4FJOz/LzJsUUrgBsbKvwPn/yX4HQy/Lz25
        DzMaG6OUFo14uCCb0FrA/DYLTa9HaqQegxdHVf4=
X-Google-Smtp-Source: AAOMgpc2VPLTMnBt6w7B3ZpcgrqIdx78YngC3y1i4bUPju6su/UpI7G8l3+4yM9wv3Xsa3g685Qikg1WghAnjxPCOEc=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr8816329oif.71.1531504689250;
 Fri, 13 Jul 2018 10:58:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:58:08
 -0700 (PDT)
In-Reply-To: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
References: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Jul 2018 14:58:08 -0300
Message-ID: <CAOMZO5AKtsgQmZ-6Y6L3EiULy2krtWy1vpoY1jbBBjANOio6rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6sll-evk: enable PWM1 for backlight driver
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 4:58 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Enable pwm1 module on i.MX6SLL EVK board to make
> backlight driver really work with LCD panel connected.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
