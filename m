Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3595654-1523894429-2-9592060274001492913
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
    1523894428; b=uy484B8DGndOSpoh5EkLrZk8n3zf82EfNN+DpnfhCXtYsVb9t1
    v+qaWoe5CzmhAzNk6jf2A3ISSRY2ljwQHZn7/4LutoCMQJMKgCF+Ew/CBMlPhCCn
    uUOYFxPjz5zKOwCZzYRlfyKuG8H+OsMl7ILFjrcbWC0uDmuHg61tink3OO52KpCt
    hBi+m9UxYF4r/zmEHG83JoKxrCd+Au8lNyjif7p2ILwrvYRUwZ1r8d2wV+KzoVv8
    JTFE97w9yUjzBd0pHbkJdRZL5Rxh9Hzjad5IAmgyngkRJMbR6CFiOuAoZkw3TgrQ
    E/KvhMsphPFqjULm5CUtFVB2UZSj+iCGPlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523894428;
    bh=/T9HU9SZVOqOMlY/8NU7XSlN8ZWeBNURpifQCIs75+M=; b=uKazRiRbPIfK
    CSP9xA4g53d1f33qGSOO7RnztxAdUKDDFYHcXm3H2wXHRSc3ea6HKZIEnHt9Qveo
    +9WjNfrEl3w1dW8V/P8GT4OxQrl5QM76NIki2fgxPy4EpGgi93OdXOFlNfmRf+JE
    Vfu+xXYci7vhqJuCRYLa9o2N28AuOHj+dMYBworE1Y84skJNmI1j9ZWE7EpaZv6t
    ussObwhprPFrIxSVcXLKEUTkjevOQgdlXBo+8E3qShpCMrVlWsnzK/41ovCPpcJ4
    5knoG1RznmAIgR1SvtrOx3LBk4TDgiB21ysg+w1wv0Qw7MqZcIgZrcOnGiqe0QDQ
    be33YzOM7w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UHPBLjHZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EojLRt84;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UHPBLjHZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EojLRt84;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI8DeAzooUENjel6SP6MO7Pc1t2gEokCPmflTOYs+5pHtPzvLgD9TOQ2ONBNnJMkAW3YK9OTZ1lIKq4YAebHZdHowgswTp92Zx1aJewbAXlL3oAltts5
    OsibluYmGnP+nhVYNLXeqs2JWdQzDeJS6WmNlkodS5oEO3X8Kbd1gfZ4ATdDfpBHckpeIEjQ6VrJyT4xzcR12yQO+GOuSMzoymj1GwRPVtf1IGgjPT50ffwU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=8lk8bxz1YjIA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=hfpeQFZ0g_gcF6t6SsUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDPQAM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:00:12 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41207 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeDPQAE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 12:00:04 -0400
X-Google-Smtp-Source: AIpwx4/tsKCVco9/KTtKsla0SEvNZ264Yv0kymXzGHYV7USqt6u2YKUZY6qDOjKEmZTt56Zf5x/txA==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: tomasz.figa@gmail.com, krzk@kernel.org, s.nawrocki@samsung.com
Cc: linus.walleij@linaro.org, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] pinctrl/samsung: Correct EINTG banks order
Date: Mon, 16 Apr 2018 17:52:45 +0200
Message-Id: <1523893966-8884-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

All banks with GPIO interrupts should be at beginning
of bank array and without any other types of banks between them.
This order is expected by exynos_eint_gpio_irq, when doing
interrupt group to bank translation.
Otherwise, kernel NULL pointer dereference would happen
when trying to handle interrupt, due to wrong bank being looked up.
Observed on s5pv210, when trying to handle gpj0 interrupt,
where kernel was mapping it to gpi bank.

Cc: stable@vger.kernel.org
Fixes: 023e06dfa6882f500b9c86fd61f0b1913aa07f36 ("pinctrl: exynos: add exynos5410 SoC specific data")
Fixes: 608a26a7bc04a39cfd7041f31ca2b2100113d14e ("pinctrl: Add s5pv210 support to pinctrl-exynos)
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---

Changes from v1:
  - Limit changes to s5pv210 and Exynos5410. Exynos3250 will be handled later.
  - Added cc stable
  - Added fixes tag
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
index 90c2744..4f4ae66 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -105,12 +105,12 @@ static const struct samsung_pin_bank_data s5pv210_pin_bank[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(7, 0x1c0, "gpg1", 0x38),
 	EXYNOS_PIN_BANK_EINTG(7, 0x1e0, "gpg2", 0x3c),
 	EXYNOS_PIN_BANK_EINTG(7, 0x200, "gpg3", 0x40),
-	EXYNOS_PIN_BANK_EINTN(7, 0x220, "gpi"),
 	EXYNOS_PIN_BANK_EINTG(8, 0x240, "gpj0", 0x44),
 	EXYNOS_PIN_BANK_EINTG(6, 0x260, "gpj1", 0x48),
 	EXYNOS_PIN_BANK_EINTG(8, 0x280, "gpj2", 0x4c),
 	EXYNOS_PIN_BANK_EINTG(8, 0x2a0, "gpj3", 0x50),
 	EXYNOS_PIN_BANK_EINTG(5, 0x2c0, "gpj4", 0x54),
+	EXYNOS_PIN_BANK_EINTN(7, 0x220, "gpi"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x2e0, "mp01"),
 	EXYNOS_PIN_BANK_EINTN(4, 0x300, "mp02"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x320, "mp03"),
@@ -630,7 +630,6 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst =
 	EXYNOS_PIN_BANK_EINTG(4, 0x100, "gpc3", 0x20),
 	EXYNOS_PIN_BANK_EINTG(7, 0x120, "gpc1", 0x24),
 	EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpc2", 0x28),
-	EXYNOS_PIN_BANK_EINTN(2, 0x160, "gpm5"),
 	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpd1", 0x2c),
 	EXYNOS_PIN_BANK_EINTG(8, 0x1A0, "gpe0", 0x30),
 	EXYNOS_PIN_BANK_EINTG(2, 0x1C0, "gpe1", 0x34),
@@ -641,6 +640,7 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst =
 	EXYNOS_PIN_BANK_EINTG(2, 0x260, "gpg2", 0x48),
 	EXYNOS_PIN_BANK_EINTG(4, 0x280, "gph0", 0x4c),
 	EXYNOS_PIN_BANK_EINTG(8, 0x2A0, "gph1", 0x50),
+	EXYNOS_PIN_BANK_EINTN(2, 0x160, "gpm5"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x2C0, "gpm7"),
 	EXYNOS_PIN_BANK_EINTN(6, 0x2E0, "gpy0"),
 	EXYNOS_PIN_BANK_EINTN(4, 0x300, "gpy1"),
-- 
2.7.4
