Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90667C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E446206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVkgNn5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E446206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeIMNzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:55:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35547 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbeIMNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:55:24 -0400
Received: by mail-io1-f68.google.com with SMTP id w11-v6so2534774iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYMCwpVu2b7s9lEDl6tSfA4gyIE6aENHgzAuLpfC82o=;
        b=jVkgNn5LOl8n2ywu2CANhk37dDCEeEY3kyBZfZHuklIFiooPTMirfT52w8gPm+waV4
         0i41hWpErr/U1cwsZhtFdIvnIGwdMybdnEF7mb4wTun7VgrF+FuWBzepTIRXdJomFA0p
         qKBIiJKclF0fFKG28nV0byNLa/GC9Zhxtefy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYMCwpVu2b7s9lEDl6tSfA4gyIE6aENHgzAuLpfC82o=;
        b=qyUlKhIoCfdiZ3qv0YciPDNTVV3fS1WHPXLjDMHBQDOQkDRvpC1v/L+fjHAt8AvkBD
         0/W20XPBvjqIuJ8hWRE4JIspv2ZI67qGvX8508e/A1HCwgE1CF0fBdogNcxJWgPdtG3s
         LHVoQ9Fz0z3hSj7Z+ZGbbYbvQXRUflsUN+MDmGD6PYD+mk7WOicZRWdAhJa0exi5kRoP
         tIKgXgAO4vBpXfyKzYw/UafPv4jU4coZCIohUsDJi5Do8Aps+j3m4EZ7N8pataeyuVyM
         PHGp1ewM/3VfXuOBKYQHC+4PvAMoEsVryj0sQlIlFJXTO4Hy3H94myvsPoyW9M7OsjEG
         Bn3g==
X-Gm-Message-State: APzg51CEw4R9k7YvFocRWfQ2tLomUgnZq+HaAVx1VN72+Fcf28YpydRA
        jE6LhSYiikS1HDPhkpXCgxWkKV8rcsdp0u8GZWbv0Q==
X-Google-Smtp-Source: ANB0VdZZJ3dHDKhvigtExM00SIK6x473P9QsEXYh7seOPpJhjN49lzoEVhcnh4OBhjUjgvEO/n7RApZ2SdP+XPZFnG0=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr4830269ioa.277.1536828415791;
 Thu, 13 Sep 2018 01:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180911143243.8860-1-geert+renesas@glider.be>
In-Reply-To: <20180911143243.8860-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Sep 2018 10:46:43 +0200
Message-ID: <CACRpkdZ=Cnri+RJPZC4NFGPxMddcHye7E=4BRFy1DTzTY0nu4Q@mail.gmail.com>
Subject: Re: [PATCH trivial] gpio: uapi: Grammar s/array/array of/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jiri Kosina <trivial@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 4:32 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
