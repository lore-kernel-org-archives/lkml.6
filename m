Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31CCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB4B223CB
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qHrZCUfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB4B223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbeKPQ4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:56:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35230 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPQ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:56:31 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so6547785oif.2;
        Thu, 15 Nov 2018 22:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qx8N44BJ3E77BRQNJtLZtWrlzN/8qpNwqjRxReOhEQ=;
        b=qHrZCUfvhNrjX6UHxxirtyAyXbhuRa9yNot6v9wBHFMRi8fOGR+OAUWS6eKa8QubKo
         dSNJcRc7oqu8q1zaxBbAoS9dNQe9nmDEkxUKfVYr7rkHdE1URT7/Wnvs+653qvKWbZ3P
         mDGuJXeTnwACCKjEwOC9xQXwwbVREFp/RFxSa2WD0e3dgu3DcRTwWoo5WszwzVe3ArD/
         5Seqy5QujN8AHbU3s3E8fYynfVUCYJRUJ6FrCU9vdzP4+4dFzx+O3KuwWLsin5yl4kLt
         sTSHC6cNr1T6ixSmM4ZYsqabaoAsr3XnMIj9ckpJiWWQDATa8g7qFo6MshjlsPu94zwX
         YuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qx8N44BJ3E77BRQNJtLZtWrlzN/8qpNwqjRxReOhEQ=;
        b=i7XQCaguPpAhsmM+MxKgDJZaGHVNFu38GFvjBEShoq8/JsZxaBwIRBUTdVEY6NIQRA
         sYbBanng8c4Emh2cT+csGUXQ/ip6DIsXVjCvQtC0gqOXFgShwWAn8XQn0HdR6R2GOXwC
         OMazINJUnGjOtloW2NFk3MYaTvMprgcXpsf9Nry3r2uNnCgqUPttEKtndtAPCLKHluss
         6Q852AIghkpl/wP55bDFZZU2lEU73pJEr5V9M2y+J5eePaBpOHKFnJfcy5gcms35IChl
         PFQVnCI8dOQ3LT5X7Q2T8o87r2WoixESazMKK3L89PgPBQ3Qlixr3jwnpKknWTt41ui/
         z7hQ==
X-Gm-Message-State: AGRZ1gIp/ilHhCsio0PA+jPKYeFYKI9zRomzAD5Q8VgeXlWCIXQbNpyr
        sUTugvWM089e++NIXRaQ0hPwwFelHBl5brPhOWn4UyTw
X-Google-Smtp-Source: AJdET5cZnBvH0xE3dwcUE4zphu+Y/8w0gJ7A3CRxVquUttRaVKp43uFLDVFnlzEaf8+ec9aIggb7bJeQ27MhbT2i0zo=
X-Received: by 2002:aca:4202:: with SMTP id p2-v6mr289604oia.41.1542350725426;
 Thu, 15 Nov 2018 22:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20181109140445.17795-1-jbrunet@baylibre.com> <20181109140445.17795-5-jbrunet@baylibre.com>
In-Reply-To: <20181109140445.17795-5-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 16 Nov 2018 07:45:14 +0100
Message-ID: <CAFBinCCDMUem0AJ56jrW2ZQf06Q=O690aRwWY4Ua79np0J+g+w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: meson: consistently disable pin bias
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     carlo@caione.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 3:05 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Amlogic chipsets, the bias set through pinconf applies to the pad
> itself, not only the GPIO function. This means that even when we change
> the function of the pad from GPIO to anything else, the bias previously
> set still applies.
>
> As we have seen with the eMMC, depending on the bias type and the function,
> it may trigger problems.
>
> The underlying issue is that we inherit whatever was left by previous user
> of the pad (pinconf, u-boot or the ROM code). As a consequence, the actual
> setup we will get is undefined.
>
> There is nothing mentioned in the documentation about pad bias and pinmux
> function, however leaving it undefined is not an option.
>
> This change consistently disable the pad bias for every pinmux functions.
> It seems to work well, we can only assume that the necessary bias (if any)
> is already provided by the pin function itself.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

my Odroid-C1 still boots fine from SD card and Ethernet (ping) also still works

Kevin, can you please move this patch from your v4.21/dt64 branch to
the v4.21/dt (32-bit) branch?
all other patches from this series are for the 64-bit SoCs, so only
this single patch has to be moved


Thank you!
Regards
Martin
