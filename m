Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F233C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15A220672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sV4cwZpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15A220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeLITvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:51:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37915 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeLITvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:51:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so9157963wml.3;
        Sun, 09 Dec 2018 11:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ICGDzLqEpkhiImNRb5ODmYoWmwur6feiS2st0RYKN4=;
        b=sV4cwZpxGfEm9ef0uH4t74pSJ4JgggIPJCfw9hUmWFgbVHar4uVxQ7WTQdS+AQW1on
         1iCZUAYfgCqXsYdmCdR5fw1P33WSEqharj27x8uT/dulBT+CYDFaEm4ZICDMmFTkmgQn
         8SJVA6SsmFq2LSIe5Mv6mnDnQVshJjhz3+P6zXne+OXFbWHueZR45wf9dedPMuG/8qyX
         v2KPvzXqLTLIXVP28Jnaq7QvEBAEKGfYlgX15P/fcGs5EzgvOc+SilOr0IH7gYD8xwbA
         UQM7NERhLk0QI1iB8MZKA1W64BRpU9UqdClCeHCwYp16StVfyZ3Br76GPM6Xdv93vnzD
         yMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ICGDzLqEpkhiImNRb5ODmYoWmwur6feiS2st0RYKN4=;
        b=D8OL/KKYvu8o3n+WwZpBMvbO0FIolT3DnpBGDgH0SICeCgt3TsUDb+anlAFIKPGNdN
         VsvTuxrZl+Qo/DkwqpsL6JR+eOX1R09jXzJHDxt2hHsMGOdDK+fJxF8Egv92s5g8Endu
         GLNB5RZwpWSsyR/nl484sNfdto2sRum1I4S4WZM3mxLmLsz25TQ+patqD5siHtC7lIlw
         RIqrbkreErbAuPAq3pN12Q6IU/tETVK53pP+9VMxHZ1AoXnWxLjNuYlYBAetLz/ao12E
         WjXIzahR7j2h6eATPQiOE3Ln9gblRDYBoq/xYRywhph8yAqTzBbt+bPulxNDSfPMNcwj
         FJ4w==
X-Gm-Message-State: AA+aEWbW2QaXkE0YYSyp3Lfs1GViPxHDJXaE7pSaGNz6m0nNgXJ/Izw/
        aIa092YYo0cWT4DwVQw9WlE=
X-Google-Smtp-Source: AFSGD/U21nsjBbR+piJXAvWxSa0Gibh6TcxhY1nY+lPbTw7cOPODyyi5tqpxQlK8uUBsavF1KfI/ow==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr8247611wmf.59.1544385062507;
        Sun, 09 Dec 2018 11:51:02 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 11:51:01 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com, carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/6] pinctrl: various fixes for Meson8 and Meson8b SoCs
Date:   Sun,  9 Dec 2018 20:50:49 +0100
Message-Id: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging an USB issue on my Odroid-C1 I found a few issues with
the pinctrl driver for the Meson8 and Meson8b SoCs:
- GPIOAO pins cannot be specified as GPIO group in device-tree
- (not a bugfix bug an improvement) make the gpio_periphs group naming
  consistent with drivers for newer SoCs
- add missing GPIO_GROUP definitions for the pins in the BOOT and CARD
  banks

I added the correct "Fixes" tag to all commits where applicable. These
fixes don't affect any existing boards or functionality. Thus I suggest
to apply them for next (v4.21) instead of sending them to mainline.


Martin Blumenstingl (6):
  pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins
  pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins
  pinctrl: meson: meson8: rename the "gpio" function to "gpio_periphs"
  pinctrl: meson: meson8: rename the "gpio" function to "gpio_periphs"
  pinctrl: meson: meson8: add the missing GPIO_GROUPs for BOOT and CARD
  pinctrl: meson: meson8b: add the missing GPIO_GROUPs for BOOT and CARD

 drivers/pinctrl/meson/pinctrl-meson8.c  | 33 ++++++++++++++++--
 drivers/pinctrl/meson/pinctrl-meson8b.c | 45 +++++++++++++++++++++----
 2 files changed, 69 insertions(+), 9 deletions(-)

-- 
2.19.2

