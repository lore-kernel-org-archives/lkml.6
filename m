Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C62EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022E3206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfANTPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:15:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:58043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfANTPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:15:08 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgZ7h-1h4Ad513JN-00nyDX; Mon, 14
 Jan 2019 20:15:06 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 0/2] GPIO: hlwd: Implement IRQ support
Date:   Mon, 14 Jan 2019 20:14:48 +0100
Message-Id: <20190114191450.11597-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PmWhwhnBU2/KC7xgz/NP/8cWxu87Lel0ZXCtEad17T5cbq1KI7b
 YdLqc4PzPas/OmSGOfS0sNpPUKY8QImTOmEF7saAC+HttZm4HXnB6aF3Hd4brR/IzrVDf9k
 CqQqgKjUTSSYBAs1GSTK4mD87Wx4ZiHM7Ym4yskXM/C42x187vRDyq+IkoGsbEYAK2ux5NE
 Oalw54xOvwRJBXrqM8AZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7+d2S/Rs/S8=:JqC8NpkaSBeqlqC2fvAIND
 BJ14QHryOPxg1CBSJY35EtEIWs0QBTx4l0AYNMinG+9S9QcKDPhEjTUAjC19e/mtfRRqhxfup
 GKEFW3kF08huZPqNjxLXRLdoYxUfWkxYbIo2559FGeVrx3fzJYA71lntDRBxAu9YUpzo4G8mC
 xwoeFFIwASp5G+VH64Po5Nl2MYi4AYAMkffgGkH2lvCjIdkXdTYjobSP85Nv4ou3oaJwKAjqv
 fajPnvfBPV7bl1mEJ1U2/Cld1RP/DHH4xzAYInZDZnRKYvVN0xC0nRHws7GgczbNC36AROXuT
 rxhGgrlojgnEwIfgDzQv33ncq6oeI+LT6Pe3SrD89xl6ALIVVofSEi88zA/UsA0d8u6rslUqX
 Uajfy1m7rrhj+sFwhggnohIcyGCA3GcwjclhiwAUTMAujDvEFJHakZ2CCIE14bWJJ4ohb6/qX
 xUdySRdAD2xA8vHE41bT8iFbo1UfzrOf0BbBkKeqgtxV0OFQTNMxlM6fiLzKol+8PkJl5MMYg
 6JoXrPpt0JuD1S3o89JChYGHNHP0iWcJwGqTb0Ymfu032xof/qICW4IhN+zppqq32S/Ri9w3Y
 7/dYe8EJkP7BthbhLJq+7EM9UWJvrGV7sByHlgGm7Jxrj3PlcTsXRM+2VQ0MlvAyAWJ6LMNjF
 3T7En4hcEH88BUg77Gh/NMWQQNSqy+AbAbEik/K7BEz7imflTjN/f3Tz7xWILDaJEdByY+3Kv
 E7RE1aAt4G2qNgOXe3q3Y34W5M/lcDc5GEPlF1I+EzGp9Vj7h/g/+nOEv2uVZROnbqD/4CPb8
 74WVgIAf+Gba9RYBM8lcUbMNZ8an/mhwzSP1MSdnNckyr2Rh++RdsaR1iztwKNBOnxC4GcWgl
 bbBzoQUvnGMiCUC/myfGHJ6ep7QPvt8KY7WMNU3MAuluZa8Z5sdPqkWPFyoE8Ze+QI5FmLa/1
 /Jho2K5LMzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this version, I addressed some comments from Linus Walleij.
v1: https://lore.kernel.org/lkml/20190113135844.13109-1-j.neuschaefer@gmx.net/


This patchset implements IRQ support for the Hollywood GPIO controller
(Hollywood is one of the chips in the Nintendo Wii game console).

Together with two device tree patches[1], I can use the buttons (via the
gpio-keys driver) and the photoelectric sensor in the disc slot (via
gpio-event-mon).

[1]: https://www.spinics.net/lists/kernel/msg3010459.html

Jonathan Neuschäfer (2):
  gpio: hlwd: Add basic IRQ support
  gpio: hlwd: Implement edge trigger emulation

 drivers/gpio/Kconfig     |   1 +
 drivers/gpio/gpio-hlwd.c | 192 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 192 insertions(+), 1 deletion(-)

-- 
2.20.1

