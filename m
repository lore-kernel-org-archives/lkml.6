Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4834AC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AA820873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AA820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeG3FmT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 01:42:19 -0400
Received: from mx.socionext.com ([202.248.49.38]:56401 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeG3FmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 01:42:19 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Jul 2018 13:09:17 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 0ED6418011F;
        Mon, 30 Jul 2018 13:09:18 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 30 Jul 2018 13:09:18 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 76E1640385;
        Mon, 30 Jul 2018 13:09:17 +0900 (JST)
Received: from DESKTOP0FARE34 (unknown [10.213.134.218])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 4D44D120424;
        Mon, 30 Jul 2018 13:09:17 +0900 (JST)
From:   "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To:     "'Linus Walleij'" <linus.walleij@linaro.org>
Cc:     =?utf-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= 
        <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Hayashi=2C_Kunihiko/=E6=9E=97_=E9=82=A6=E5=BD=A6?= 
        <hayashi.kunihiko@socionext.com>
References: <1531981249-26329-1-git-send-email-hayashibara.keiji@socionext.com> <CACRpkdYD6FT9k50kc4kSx_nzv91wTeBYgJ1jHVrbFDY-XMaB9w@mail.gmail.com>
In-Reply-To: <CACRpkdYD6FT9k50kc4kSx_nzv91wTeBYgJ1jHVrbFDY-XMaB9w@mail.gmail.com>
Subject: RE: [PATCH] pinctrl: uniphier: add spi pin-mux settings
Date:   Mon, 30 Jul 2018 13:09:14 +0900
Message-ID: <002801d427bb$13b8e900$3b2abb00$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUHyi8Jz7/kamrU0SFVRTi9as75KSmJX2AgAD5bPA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

I have sent modified patch for this bag as v2.
Please refer to the following.

[PATCH v2]
https://patchwork.kernel.org/patch/10533929/

[Changes since v1]
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
-index 0f921a6..f912999 100644
+index 0f921a6..f086083 100644
 --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
 +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
 @@ -504,6 +504,8 @@ static const unsigned nand_cs1_pins[] = {22, 23};
@@ -390,7 +393,7 @@
  static const char * const i2c3_groups[] = {"i2c3"};
  static const char * const nand_groups[] = {"nand", "nand_cs1"};
  static const char * const sd_groups[] = {"sd"};
-+static const char * const spi_groups[] = {"spi0"};
++static const char * const spi0_groups[] = {"spi0"};
  static const char * const system_bus_groups[] = {"system_bus",
                                                 "system_bus_cs1",
                                                 "system_bus_cs2",


I mistook "spi0_groups" with " spi_groups",
so there was an undeclared error.

-----------------
Best Regards,
Keiji Hayashibara


> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij@linaro.org]
> Sent: Monday, July 30, 2018 5:47 AM
> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Cc: Yamada, Masahiro/山田 真弘 <yamada.masahiro@socionext.com>; open list:GPIO SUBSYSTEM
> <linux-gpio@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>; linux-kernel@vger.kernel.org; Hayashi,
> Kunihiko/林 邦彦 <hayashi.kunihiko@socionext.com>
> Subject: Re: [PATCH] pinctrl: uniphier: add spi pin-mux settings
> 
> On Thu, Jul 19, 2018 at 8:21 AM Keiji Hayashibara <hayashibara.keiji@socionext.com> wrote:
> 
> > From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >
> > Add pin-mux settings for spi controller.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> 
> There is some problem with the test robot, can you comment/followup?
> 
> Yours,
> Linus Walleij


