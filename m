Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3578680-1523894433-2-11862884967927200616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523894431; b=p1dW63p/MNYfm82ePhGjY2NCX4FlZXSv9KRiPa+oD4SZNRv5YI
    0WsBT6ZasyLdRh5mmv8ggJ0cljABng7jSb76MfQBWjfk1fuK1S1LPX/gMSE0P08G
    QPHZRhcEJ4IGvHeQ16/hM+pxjK7Mlzh8ZLL5jhdr0io0h7xDS3IDsif6yqZTEnG8
    ci9DapW0L5EF504QjyKKTh3BgTySwlfhE5rGJ979wdxHJ9pb3bL/Pim2rPLBcKgM
    I62XvVCC3P59nJKUN8mrG77ZzymsOgz5OdZvfG2dhw2Mf+OuMy7sPvJl2u2QYxDM
    F86d1xF37chHBTV0obekijDXOtiSNVfioSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523894431;
    bh=Chhyh17ytKeMbd7s/wRFUf3WfjDqDZQLU5TIf/o3uOM=; b=d6yLkyvOPeJ1
    MnqRCSjhmMQZ8PRnpHVkNXhabrem1HhPUw6uxUE0SgqoEtNRxcho0oOfeNTXhScs
    UxA1fV2IUI6Q3G4Ujxo9Hfuw5XwcRQqd3dHwD9dMPEnNFV8U/CIxV6/euIGLM8y5
    i+EURCdJS7y09RNJfmiG3WvJsm++tQ0WROWemTLWopjUKo3vTog97eGiRm+apWqA
    RCO7yJKXTbVVgofOH+TYPUPS/EzuRuNHBm8qaEfrdyDj8nQKD/5gm3arhbI5jUAO
    9eS0/7tCV2CW5hy5um8cVip5OiozI3xyHsgk5irHJkjcBrbt2AyLdEmZJkNaBP+r
    OIut9gVp8A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MB5wWqv6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iwLVvUs1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MB5wWqv6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iwLVvUs1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD/ioouOxf5vrVlS1zBKWYcWrq8YEB0z04s06r9pUofuQoEEMWWM4qovRGWUugGMaD9LQ3SqOQeDYqW5z1i9/z1Kgc7fVwTzyHIbw7ZB2NmMOyYSLU9n
    acQHC5yCmAznjkpStO7DT+C/WKwUdCTfISFiQNxLiDU2jL/J9ZnwQzkbViI6hWaM26x0rC2AgMfgf844tuOtsADicsxMvfdUfFyl5lbFadNzh+DHpRPaBqhI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=8lk8bxz1YjIA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=4upeBUXoiqqLEDcmZScA:9 a=DwIhnjmI9Ey8-oZJ:21 a=2jwo_FV7C3LanyJ2:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeDPQAL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:00:11 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38023 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeDPQAG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 12:00:06 -0400
X-Google-Smtp-Source: AIpwx49NbRH559bKJOYUqmkd6+qEyBlPL3ZutRA4u3e/OtUdn4zzLS+dgeLrmIR+QhFqhZToVsEdOA==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: tomasz.figa@gmail.com, krzk@kernel.org, s.nawrocki@samsung.com
Cc: linus.walleij@linaro.org, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/2] pinctrl/samsung: Document required order of banks
Date: Mon, 16 Apr 2018 17:52:46 +0200
Message-Id: <1523893966-8884-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch documents requirement coming from the way
exynos_eint_gpio_irq() is working now, which expects
EINTG banks to be at the beginning of the bank arrays.

Cc: stable@vger.kernel.org
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 26 ++++++++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
index 4f4ae66..d82820f 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -88,6 +88,7 @@ static const struct samsung_retention_data s5pv210_retention_data __initconst =
 
 /* pin banks of s5pv210 pin-controller */
 static const struct samsung_pin_bank_data s5pv210_pin_bank[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
@@ -147,6 +148,7 @@ static atomic_t exynos_shared_retention_refcnt;
 
 /* pin banks of exynos3250 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos3250_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb",  0x08),
@@ -158,6 +160,7 @@ static const struct samsung_pin_bank_data exynos3250_pin_banks0[] __initconst =
 
 /* pin banks of exynos3250 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos3250_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTN(8, 0x120, "gpe0"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x140, "gpe1"),
 	EXYNOS_PIN_BANK_EINTN(3, 0x180, "gpe2"),
@@ -232,6 +235,7 @@ const struct samsung_pinctrl_of_match_data exynos3250_of_data __initconst = {
 
 /* pin banks of exynos4210 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos4210_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
@@ -252,6 +256,7 @@ static const struct samsung_pin_bank_data exynos4210_pin_banks0[] __initconst =
 
 /* pin banks of exynos4210 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos4210_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpj0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(5, 0x020, "gpj1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpk0", 0x08),
@@ -276,6 +281,7 @@ static const struct samsung_pin_bank_data exynos4210_pin_banks1[] __initconst =
 
 /* pin banks of exynos4210 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos4210_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTN(7, 0x000, "gpz"),
 };
 
@@ -346,6 +352,7 @@ const struct samsung_pinctrl_of_match_data exynos4210_of_data __initconst = {
 
 /* pin banks of exynos4x12 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos4x12_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
@@ -363,6 +370,7 @@ static const struct samsung_pin_bank_data exynos4x12_pin_banks0[] __initconst =
 
 /* pin banks of exynos4x12 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos4x12_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpk0", 0x08),
 	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
 	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
@@ -390,11 +398,13 @@ static const struct samsung_pin_bank_data exynos4x12_pin_banks1[] __initconst =
 
 /* pin banks of exynos4x12 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos4x12_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
 };
 
 /* pin banks of exynos4x12 pin-controller 3 */
 static const struct samsung_pin_bank_data exynos4x12_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpv2", 0x08),
@@ -449,6 +459,7 @@ const struct samsung_pinctrl_of_match_data exynos4x12_of_data __initconst = {
 
 /* pin banks of exynos5250 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
@@ -478,6 +489,7 @@ static const struct samsung_pin_bank_data exynos5250_pin_banks0[] __initconst =
 
 /* pin banks of exynos5250 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpe0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(2, 0x020, "gpe1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(4, 0x040, "gpf0", 0x08),
@@ -491,6 +503,7 @@ static const struct samsung_pin_bank_data exynos5250_pin_banks1[] __initconst =
 
 /* pin banks of exynos5250 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv2", 0x08),
@@ -500,6 +513,7 @@ static const struct samsung_pin_bank_data exynos5250_pin_banks2[] __initconst =
 
 /* pin banks of exynos5250 pin-controller 3 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
 };
 
@@ -550,6 +564,7 @@ const struct samsung_pinctrl_of_match_data exynos5250_of_data __initconst = {
 
 /* pin banks of exynos5260 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5260_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
@@ -575,6 +590,7 @@ static const struct samsung_pin_bank_data exynos5260_pin_banks0[] __initconst =
 
 /* pin banks of exynos5260 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos5260_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpc0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpc1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
@@ -584,6 +600,7 @@ static const struct samsung_pin_bank_data exynos5260_pin_banks1[] __initconst =
 
 /* pin banks of exynos5260 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos5260_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
@@ -619,6 +636,7 @@ const struct samsung_pinctrl_of_match_data exynos5260_of_data __initconst = {
 
 /* pin banks of exynos5410 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
@@ -658,6 +676,7 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst =
 
 /* pin banks of exynos5410 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos5410_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpj0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpj1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpj2", 0x08),
@@ -671,6 +690,7 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks1[] __initconst =
 
 /* pin banks of exynos5410 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos5410_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv2", 0x08),
@@ -680,6 +700,7 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks2[] __initconst =
 
 /* pin banks of exynos5410 pin-controller 3 */
 static const struct samsung_pin_bank_data exynos5410_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
 };
 
@@ -727,6 +748,7 @@ const struct samsung_pinctrl_of_match_data exynos5410_of_data __initconst = {
 
 /* pin banks of exynos5420 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpy7", 0x00),
 	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
 	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
@@ -736,6 +758,7 @@ static const struct samsung_pin_bank_data exynos5420_pin_banks0[] __initconst =
 
 /* pin banks of exynos5420 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpc0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpc1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
@@ -753,6 +776,7 @@ static const struct samsung_pin_bank_data exynos5420_pin_banks1[] __initconst =
 
 /* pin banks of exynos5420 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpe0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(2, 0x020, "gpe1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(6, 0x040, "gpf0", 0x08),
@@ -765,6 +789,7 @@ static const struct samsung_pin_bank_data exynos5420_pin_banks2[] __initconst =
 
 /* pin banks of exynos5420 pin-controller 3 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
@@ -778,6 +803,7 @@ static const struct samsung_pin_bank_data exynos5420_pin_banks3[] __initconst =
 
 /* pin banks of exynos5420 pin-controller 4 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks4[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
 };
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 71c9d1d..b6e5642 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -45,6 +45,7 @@ static atomic_t exynos_shared_retention_refcnt;
 
 /* pin banks of exynos5433 pin-controller - ALIVE */
 static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
 	EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
 	EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
@@ -58,27 +59,32 @@ static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst =
 
 /* pin banks of exynos5433 pin-controller - AUD */
 static const struct samsung_pin_bank_data exynos5433_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
 	EXYNOS5433_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
 
 /* pin banks of exynos5433 pin-controller - CPIF */
 static const struct samsung_pin_bank_data exynos5433_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - eSE */
 static const struct samsung_pin_bank_data exynos5433_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FINGER */
 static const struct samsung_pin_bank_data exynos5433_pin_banks4[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FSYS */
 static const struct samsung_pin_bank_data exynos5433_pin_banks5[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
 	EXYNOS5433_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
 	EXYNOS5433_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
@@ -89,16 +95,19 @@ static const struct samsung_pin_bank_data exynos5433_pin_banks5[] __initconst =
 
 /* pin banks of exynos5433 pin-controller - IMEM */
 static const struct samsung_pin_bank_data exynos5433_pin_banks6[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - NFC */
 static const struct samsung_pin_bank_data exynos5433_pin_banks7[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - PERIC */
 static const struct samsung_pin_bank_data exynos5433_pin_banks8[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
 	EXYNOS5433_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
 	EXYNOS5433_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
@@ -120,6 +129,7 @@ static const struct samsung_pin_bank_data exynos5433_pin_banks8[] __initconst =
 
 /* pin banks of exynos5433 pin-controller - TOUCH */
 static const struct samsung_pin_bank_data exynos5433_pin_banks9[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
 };
 
@@ -267,6 +277,7 @@ const struct samsung_pinctrl_of_match_data exynos5433_of_data __initconst = {
 
 /* pin banks of exynos7 pin-controller - ALIVE */
 static const struct samsung_pin_bank_data exynos7_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
@@ -275,6 +286,7 @@ static const struct samsung_pin_bank_data exynos7_pin_banks0[] __initconst = {
 
 /* pin banks of exynos7 pin-controller - BUS0 */
 static const struct samsung_pin_bank_data exynos7_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpb0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpc0", 0x04),
 	EXYNOS_PIN_BANK_EINTG(2, 0x040, "gpc1", 0x08),
@@ -294,31 +306,37 @@ static const struct samsung_pin_bank_data exynos7_pin_banks1[] __initconst = {
 
 /* pin banks of exynos7 pin-controller - NFC */
 static const struct samsung_pin_bank_data exynos7_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - TOUCH */
 static const struct samsung_pin_bank_data exynos7_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - FF */
 static const struct samsung_pin_bank_data exynos7_pin_banks4[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpg4", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - ESE */
 static const struct samsung_pin_bank_data exynos7_pin_banks5[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpv7", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - FSYS0 */
 static const struct samsung_pin_bank_data exynos7_pin_banks6[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpr4", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - FSYS1 */
 static const struct samsung_pin_bank_data exynos7_pin_banks7[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpr0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpr1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(5, 0x040, "gpr2", 0x08),
@@ -327,6 +345,7 @@ static const struct samsung_pin_bank_data exynos7_pin_banks7[] __initconst = {
 
 /* pin banks of exynos7 pin-controller - BUS1 */
 static const struct samsung_pin_bank_data exynos7_pin_banks8[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpf0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpf1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpf2", 0x08),
@@ -340,6 +359,7 @@ static const struct samsung_pin_bank_data exynos7_pin_banks8[] __initconst = {
 };
 
 static const struct samsung_pin_bank_data exynos7_pin_banks9[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
-- 
2.7.4
