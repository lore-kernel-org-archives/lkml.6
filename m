Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F22C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B043F206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9Zn/pSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B043F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeJESEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:04:30 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51190 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJESEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:04:30 -0400
Received: by mail-it1-f193.google.com with SMTP id j81-v6so2076096ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 04:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dagL3CtOofUaWWYlStCBMZiFyV4fbvlY1kE/GohUX24=;
        b=g9Zn/pSAH7Jo+nPEyiEQMPOnrbCXcEsds4TDtKifiPtZrzRl0pp+5JG3P1jC5ysiI/
         UWpZyG0SO1KQGzxFuRU4uOjhLjNKXS34ooA7ERlQ6+FeQcCJzy/57E4hEZNBBhn1Uw9Q
         oZQQSbvzWi2RIliFe4NIJddl0ZKbmA97XdCoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dagL3CtOofUaWWYlStCBMZiFyV4fbvlY1kE/GohUX24=;
        b=SE60WRJGLFLDgHLJ0LE3RbRzqOeZg5jlFKZ2xOwg7GT2MWM0P65Pf98QuKDhKudWoV
         GDr3rIcoZRyUrc4yBmokdXsj4/RE7P5GQcr7Z1xQOEugPrSslIJvus7fGEQVQUldv+wf
         7kYLAGiytrHqO+gcIwN8Dj1LOWokDq8dnSxVsQTWjtp1/TTUzfK/3KXFHX/XPKCpnABV
         p//v0pcO6B1QA6YR0Gxvxwo2dSBzG30YECCMQvHW8vQ40qxYVy1LrBSGkBksKrZKL+lt
         Vai7e7DD+idPSRqHZ/LJrjsKC10zufV5i44pfFgvmd2g7fBc/mioEsyian7nrgfteOY2
         Zw6g==
X-Gm-Message-State: ABuFfojPEMQRVZTIedBuBvlubh/Ug+Cdrd32sGYiKXnMWmWzroIxnkw/
        j0rhgAREJAjTGrqrhe/bZP2JcZdf/+roGyNDtH2dVA==
X-Google-Smtp-Source: ACcGV60QlsW+jEEADb2KcDeUmrO+OV587kzVcxEZPUJs5o9SVSqyV7YS4NlKv4gfQfX5o4G+X9V0CYPEiRORNh6AMtQ=
X-Received: by 2002:a02:7789:: with SMTP id g131-v6mr8390938jac.66.1538737570769;
 Fri, 05 Oct 2018 04:06:10 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Oct 2018 13:05:59 +0200
Message-ID: <CACRpkdaVEmTDBFgf-fdw9uXJYyQ5DC_uL+agTB1zFVia1hzhuQ@mail.gmail.com>
Subject: [GIT PULL] GPIO fix for v4.19
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

here is a single and hopefully final GPIO fix for the v4.19 series.
Details in the signed tag.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.19-3

for you to fetch changes up to 19a4fbffc94e41abaa2a623a25ce2641d69eccf0:

  gpiolib: Free the last requested descriptor (2018-09-18 16:36:05 -0700)

----------------------------------------------------------------
A single GPIO fix:
Free the last used descriptor, an off by one error.
This is tagged for stable as well.

----------------------------------------------------------------
Ricardo Ribalda Delgado (1):
      gpiolib: Free the last requested descriptor

 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
