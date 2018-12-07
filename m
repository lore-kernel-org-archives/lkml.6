Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E8FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F3120868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3Tburc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F3120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLGMlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:41:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46262 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeLGMlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:41:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so2880235lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzt3ti5tXkWTxZxjywBygWxo7yIsI+D4X+mLAkTLH9w=;
        b=B3Tburc6sbZu2F5Uz2zC0Eu3HtJaYabjC4+pFIoYp+STLj40nS5KnnqK2EcdT9wb+i
         3pFeOAfAjz+q6HQ+OjzHh5H6gIhwOtaN3Jb8s/T2i/x62wCAQzm5+73RKQd/v84ulGty
         WgfREwzfz4O39QU03dTTGrvvBSJKqyfk6vtRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzt3ti5tXkWTxZxjywBygWxo7yIsI+D4X+mLAkTLH9w=;
        b=ihuhgvaPRFUhzMmK73Met1Mvp19cbHb3jqsr8jakMvV44rHFXrghSBNz6mhtu12wqv
         5vkLv6wxNlpomoFOrG36GMLW5M/vUI9ipNpma7H+2MBY9vs2SAyJRW+emvRDvtZ7h0mv
         14Misg+iXUzrXEf/s72AtRjaRAPgTKbDTDwOXz4kqdyyUCZ4sDqgqyMILvy1m9BFKf6O
         Hofaj7mfp5qEcFGHpJAFhATBZRxbPgyrmOib0DxPmPug80YLEMz7Wci2hWoWZkrYZ2Mp
         n7QX7y3nRmIAACOsvtGg6m/v/Jzg3jWMnRVNOhQYP1qrMhUScc/IHZkIw5/sLXVu7DPp
         ntow==
X-Gm-Message-State: AA+aEWbP6Hk8TU3YdBprdJqBzl5KpFF2opZ7BXGQ/Sw2CrbsiKtE6p8r
        Go//rlSgEdyuy6l+hw0DFC29fbSM38Dpoz10wcCJDg==
X-Google-Smtp-Source: AFSGD/UFPAvRJHw8htkNvekIkECbNL01nVlEIzOMVz4XqQ7xq4u4kx7I49f6l4zjJCiV91AJPOnTF4PySFwaFj2lY90=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr1312491lfa.32.1544186459897;
 Fri, 07 Dec 2018 04:40:59 -0800 (PST)
MIME-Version: 1.0
References: <1544014449-5104-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544014449-5104-1-git-send-email-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 13:40:47 +0100
Message-ID: <CACRpkdbMKkrW7eaAQZF5AowBsnuj4AO6szdvd=FO+6hFJv=cow@mail.gmail.com>
Subject: Re: [PATCH] gpio: uniphier: convert to SPDX License Identifier
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:54 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> checkpatch.pl suggests to use SPDX license tag. I am happy to
> follow it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
