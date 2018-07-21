Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF31CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D4F20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KWhKa8oQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D4F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeGUVLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:11:34 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35342 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbeGUVLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:11:34 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so27071897oik.2;
        Sat, 21 Jul 2018 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRaj/2RLs74uPxhO/TC7tWMoih0nwTmZ15/V8EujcZs=;
        b=KWhKa8oQ4qzH9Y56eUUNSA1SaRNbv4apo3HzgrNpKWOWsMS3PH2UgwaaVsP0QtuNJq
         WbgQY3rq2ijhFoosyy+jGudx2gJEQDrZCW3EsaYC9UGFhPAxoNIVebT3AEwgJmUG1gQQ
         hX7lWFNL0o6Qlz8BzyEdiH6RopMS+ma1xI76I6CjvGTJQsn7JXvap8KmHEXmh0JcZlAo
         jAeq8ldtL6RJRzrCH1LKViPoT2kPNobf0yPogwEMir6x1mk0hfOMBENfoAasRAygI8ib
         KpXzySn9QFcv77ZJIUG7aXkV7H7YykiwtnCxOeTdk4XELxnbtBMDBSAa7KJtg7N0MRia
         8fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRaj/2RLs74uPxhO/TC7tWMoih0nwTmZ15/V8EujcZs=;
        b=JJoR/OogXgoAfUuZ/oVNt7v+nZ8Q8GzDQQdYWnNu4klXosMlHuFljuAPwZ1UPRAz9y
         Ut/1sXvwayJxYHUnGUrgYrT588tamHTWv9E7BY4xfIS/iZNXwrmUrRuRTx342ttyIgmr
         /gGCSOh0DcXCKSBUkacwoP1FU08QPsNn2sPv/Yt299bjOqmeJmaYTH17dRuGrlLuBV31
         BbVfMctvRz5IAQ3OhmEEDtdFElpDPtHoe6twuZbHadGEphkeUDi8E2REq2l+lpcCd/gC
         v91eGaRez5b8hRwQjktN97ZUxgXuY35Cu8iGqmZAAow0/UIzxnPnTkI8xYGOCF9PPfUs
         w8VA==
X-Gm-Message-State: AOUpUlEbW4kqmn3f2veC5rskTL6l7FWSDB5i+Zc3DVecuXSQnV+wQwZm
        B54dHOBRNWk3xYN2UZZtsWTDx1sY7oaBubWUzbnDTQ==
X-Google-Smtp-Source: AAOMgpeImZR0HavdBkjA79Re38jkHH7+iPqUesGQSSPuE2lTzLlwfS/dqzM7AkYXMnpc4OMzYVV0Jf3kBQqt/TWjDwI=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr3270836oib.116.1532204256473;
 Sat, 21 Jul 2018 13:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180717095617.12240-1-jbrunet@baylibre.com>
In-Reply-To: <20180717095617.12240-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 21 Jul 2018 22:17:25 +0200
Message-ID: <CAFBinCC4CO_C_f9LLTnLmzVJ6-C-w8J0JQ0e6F9Jh_h61bGEKQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] clk: meson: clk-pll driver update
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Jul 17, 2018 at 11:56 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> This patchset is yet another round of update to the amlogic pll driver.
>
>  1) Enable bit is added so we don't rely on the bootloader or the init
>     value to enable to pll device.
>  2) OD post dividers are removed from the pll driver. This simplify the
>     driver and let us provide the clocks which exist between those
>     dividera. Some device are actually using these clocks.
>  3) The rates hard coded in parameter tables are remove. Instead, we
>     only rely on the parent rate and the parameters to calculate the
>     output rate, which is a lot better.
>
> This series has been tested on the gxl libretech cc and axg s400.
> I did not test it on meson8b yet.
I had some comments on patch #2
once that is fixed I can help testing on Meson8b (if you give me a few days...)


Regards
Martin
