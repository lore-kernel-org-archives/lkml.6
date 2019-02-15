Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8994C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52E42192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blybIFt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbfBOHYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:24:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45476 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfBOHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:24:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id d9so7103645edh.12;
        Thu, 14 Feb 2019 23:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RFbQfwT9/wI/RORTUjQ3U5Yg8CJ+8DH8wJ1ahrulbsk=;
        b=blybIFt5OTKxp1WUoiro1xJDcfgPKy9/3NJH9+Y8BpSlL/43pnfgASi+YmKW8qZdyt
         5a6OiGtixLknLzCA8e9U61SLDOVt0kLBbu8dAMpTZVo/H9NUw7hIuEm0fgkrjEWAIMBW
         fk6iUhfEEoy1A5ELuAO0KGYKqSxCdkmKf+mSgbfN5mgJj0hyw20Ni0ZKaNkX4WRPkpuU
         LVuuMsXokLEz8orXgquv+gPY9+jTmYhuwNoQfJBt1uPndj3KKlIagjqty0hmdtEuk5+C
         5cGnpjwYYXm/GeHyHXdZYzTOdLjAzD1Aj4m1suCJmNvLxwAXeuJvF8NC7z5iTndhwWMs
         hybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RFbQfwT9/wI/RORTUjQ3U5Yg8CJ+8DH8wJ1ahrulbsk=;
        b=FPJ9VUEPW5YEg1dkiTmVh4ddxqYWiNSmBfOx08UTcObjjdgE/hn1ssU2dwe19FsgK5
         7J2+91Zx2tvWHEz9pv3SXccPdTfhGqE76fcCyNT//jTzV9vOR6kr+neKBftydCWxSA0i
         McSiDkceDPUWIa1n57gBDlLgb19Lb4dH3F1NJ1RJcVxbi1a6yAy+0X+MW1LuyGhlNfAX
         AoMJigdwIQYdLa28/ZEICdgcaNIzaSQirGtWxHasglf1AcNp0zCq0oWKzvnhVkuBrly5
         vZtb10u6vQU+tOzMst6EQ+ATfovhvNFxjnFo6EJRBAcdAP/ZVzgu0i2wTiK9UFf1V5O7
         kY2A==
X-Gm-Message-State: AHQUAuY0bezEzBpAdeasrkvOvH9pQZzh3CPEwTItVSQKm2fU9BkO6LnP
        dTjTCXScKauVdEcMOF+ZAHT6Ja/5ThE=
X-Google-Smtp-Source: AHgI3IaRcvNDZ6LrhNsdE+1h3x/aLnoScqSN/glGCsbecY0yiEJlkmZwYgYgQazCUTWS4FPBFufJgw==
X-Received: by 2002:a50:a982:: with SMTP id n2mr6293614edc.236.1550215442691;
        Thu, 14 Feb 2019 23:24:02 -0800 (PST)
Received: from linux-gy6r.site ([93.176.151.17])
        by smtp.gmail.com with ESMTPSA id z19sm1039676ejm.47.2019.02.14.23.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 23:24:01 -0800 (PST)
Subject: Re: [PATCH v7 1/6] dt-bindings: mtk-sysirq: Add compatible for
 Mediatek MT8183
To:     Erin Lo <erin.lo@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com, eddie.huang@mediatek.com,
        linux-clk@vger.kernel.org
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-2-git-send-email-erin.lo@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <fe86572e-690b-0e11-cb00-4cfe3a33c5fa@gmail.com>
Date:   Fri, 15 Feb 2019 08:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550210558-30516-2-git-send-email-erin.lo@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/19 7:02 AM, Erin Lo wrote:
> This adds dt-binding documentation of SYSIRQ for Mediatek MT8183 SoC
> Platform.
>=20
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Marc you want me to take it through my tree?

>  .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt      =
   | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/med=
iatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller=
/mediatek,sysirq.txt
> index 33a98eb..91aa9ab 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,s=
ysirq.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,s=
ysirq.txt
> @@ -5,6 +5,7 @@ interrupt.
> =20
>  Required properties:
>  - compatible: should be
> +	"mediatek,mt8183-sysirq", "mediatek,mt6577-sysirq": for MT8183
>  	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
>  	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
>  	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
>=20

