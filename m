Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24434C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE615217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At+BPDG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfB0TuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:50:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45964 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfB0TuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:50:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id w26so2146829otp.12;
        Wed, 27 Feb 2019 11:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwU+PO/sAoS8OwKdICAhKM+GXnXwxYJ23F0pqlNkrWU=;
        b=At+BPDG53A0iOt2jKXdGW4NPfn1VkFhiBcVHu5xvNu0AATKLHtQm2EfauWdGaTXKk3
         ZjzUxR/KYCDUDXMRbOHbLvmEeqzdf9fYYIFuZF8UFIqo3N4XVJtGYTbOd/ypMVc8a3Es
         bY0ZdGlTI5eMv2TmXnGDtN4QqmJtqtqrgIvDuv/IypuPIAgtgoz+V8+veDTaePdW9fNm
         y5c1zGmcDxAeiIu6vMGZAg4tGXxbVi09hbJPmYmXijEgDRI38+Vkf06MRmiFUnd9he3r
         vPxPsj+78+ew7Bx47HzvrxcdEjcD0AwcGSeKZdhQf8s1eJgqhGC4QHgv5GSSl0eAjLPv
         oyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwU+PO/sAoS8OwKdICAhKM+GXnXwxYJ23F0pqlNkrWU=;
        b=ccc/uziHsTaU4/5k1Hb9VyVnhSngXMdEb1KgCL4esDRMFkgVPQ7F9649BDVIT27BTo
         eK7DsHg8NvCyk2nquaSrcE0r/ZEBvZt01+5hQAgtAeFVea+PfN+6tL5Lp2lk+6MIwpiu
         e9csobv4yzr6bw2UzyWbK773JkjKDjDndNCATMdsV7QsTKnLU62+IiEGJdzM7LfX6AGI
         x7DH+sZZU6k35WP5+xlylSsoTNM4UGaEG+DTajy7Hmwu0WIUNf9u5JhpE5sPYzcvxbiP
         v5RBKW3TvSXJRCmk3CImXgnjKqSHQjI8g5TUTdDAysDR7/OKmdiQTW/dQefVus5DJBzH
         PfUw==
X-Gm-Message-State: AHQUAubt3Ak4wZoI9QzZZUfpDIV8/fPQ0FYEqwDEsRe2sT93L4z7GUTQ
        RvUWcMP0edM8vouPoVQhUpcN2EXUoxZJzKPYsIU=
X-Google-Smtp-Source: APXvYqz9Jgw3g5+1GD5mSQriugqhqBko9lxepiRb2DKF8Ixf9CIZPZUCDM697QOYfLAH84HexkvrL+nTIzHLM1j/nUw=
X-Received: by 2002:a9d:7d02:: with SMTP id v2mr3322079otn.203.1551297011061;
 Wed, 27 Feb 2019 11:50:11 -0800 (PST)
MIME-Version: 1.0
References: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com> <1551261844-23983-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551261844-23983-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 27 Feb 2019 16:50:00 -0300
Message-ID: <CAOMZO5Css2TvbbQ8cy6EA=2goHHDfDRzP1kVSe_vNaT0DtknLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7ulp: add mmdc support
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

On Wed, Feb 27, 2019 at 7:08 AM Anson Huang <anson.huang@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> index fca6e50..fca4a01 100644
> --- a/arch/arm/boot/dts/imx7ulp.dtsi
> +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> @@ -286,6 +286,12 @@
>                         status = "disabled";
>                 };
>
> +               mmdc: mmdc@40ab0000 {

Node names should be generic, so:

memory-controller@40ab0000
