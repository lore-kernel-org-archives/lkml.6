Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04751C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9E020855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKAiKYCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9E020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeKZHVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:21:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45833 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKZHVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:21:48 -0500
Received: by mail-oi1-f193.google.com with SMTP id b141so13961975oii.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aEImtaNSWL3vILxwl8kUFDp+H9tkCsWSN07QJfPX+qw=;
        b=kKAiKYCDbYUdIfJgFpVHykHqA2op7iNeeDYg4W6T+TCSyV5tnRY3pNspLlAr9s0Bej
         yZvbxKJBjirxfVa4NXBUhG7dWMwAR9rH0KQntI2lq696NjpprHTDvKGSp/LNYjVOOyBE
         J+jD9ouCBNzheYVuV2bDzDH6/2C1mLC3pTN7IggQc7r0P3LSeE1MZg2AJkcaWqkU+bN9
         KU+ZjGqefwce11irrDs2uuKltYloUdkBl5TTBXXjGCwCh6NEFMPGb9uyqk52aMjkzLqf
         Ysas1VMFG7FDm4rHbZIeu1LJJxhsD67qMft9Ahu1D0zePvHadM1t75Z4fTJeJ5TMMdlu
         iFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aEImtaNSWL3vILxwl8kUFDp+H9tkCsWSN07QJfPX+qw=;
        b=f6gk8ZsZbZTEF34PxqkFgnbieuXtnMhc7l3O5yhAAJeMZJXmFTApi0YTpiEi30W2q/
         zHPLMcu6nP35vj8X9bnlVG+F5+kAJHbuwOKYXdxS6iCyTHHsWad6GG7LUEwMlamNGZis
         8eJMXcdjAweXiajP3zLoXHj/7wxgY1Fr85jmF85y2qwOUoQ3zD0ybVDsSTfICmryeCP5
         238g2iuh+yuKUp69tSryG99XDaI55OwbU/7LJpmIAqAUhtx92ouBSBwY7n/UslZl8y3P
         z0ZYLY7kynqJtz/q6kqA2fy6FCezrslEGOk/Y501QtTWxfg2++POFtFo96H0EV1OImEy
         LOhw==
X-Gm-Message-State: AGRZ1gIlQHiFuDlQ46SEt+NDbiIHlVWY6hSK0yiyGTI3XcBHl2tjKrDp
        YdxVKJtTYJsw8EhS+za68IjA1hogEP7pFf4mWrI=
X-Google-Smtp-Source: AJdET5e8cXhtO6OdtEGkQ1hhCmUA0BWa+xsmEQVoGsv1QvWRz8gxsKY8LKXclO+pi/XUjIlWGA7MbCxTPwKFprdQnFo=
X-Received: by 2002:aca:d056:: with SMTP id h83mr14285604oig.67.1543177794888;
 Sun, 25 Nov 2018 12:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20181125201729.19836-1-otavio@ossystems.com.br> <20181125201729.19836-2-otavio@ossystems.com.br>
In-Reply-To: <20181125201729.19836-2-otavio@ossystems.com.br>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 25 Nov 2018 18:29:51 -0200
Message-ID: <CAOMZO5A_=VpGYtFP_2g--gtOt-RHny28+=sBmhMxv3hqPKBVUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: imx_v6_v7_defconfig: Enable BT_BNEP
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 6:18 PM Otavio Salvador <otavio@ossystems.com.br> w=
rote:
>
> From: Andreas M=C3=BCller <schnitzeltony@gmail.com>
>
> This is necessary to support network over bluetooth:
>
> | Sep 11 15:36:33 imx6qdl-variscite-som bluetoothd[281]: kernel lacks bne=
p-protocol support
> | Sep 11 15:36:33 imx6qdl-variscite-som bluetoothd[281]: System does not =
support network plugin
>
> Signed-off-by: Andreas M=C3=BCller <schnitzeltony@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
