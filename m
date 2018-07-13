Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEF2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B9D208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kri8Lvmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B9D208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbeGMHD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:03:57 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55876 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbeGMHD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:03:57 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so10179829itl.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHGT6fNWjqDAefVFo9VLXBTOB1Qqz1ZgFQFw8405HvM=;
        b=Kri8LvmfSWvWMz267RxHq4NOhOBqp7eavdPchLn6vvSMabJRpPNvHcORxPh0qNhD8j
         99l1a3DI1y0SkqITt1H4ZNxkAAdcJe8FaZR8FT7jQ7Bo2/3C5g7njbEfPJI68b8Zryws
         cJENr7TdjryrHLQbD0w1yTCQteU77eGoxy+Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHGT6fNWjqDAefVFo9VLXBTOB1Qqz1ZgFQFw8405HvM=;
        b=RPRCezhgfZ+vWRPkjgB4AuAkXWervhdmcnutsvbZrkfvWBKKGIGu0n0WqWH1DLY6gO
         FEnrjRVve9Q7GYw6FrkLLx1GP0AxieeCyw0ax/sAKMltwzKM59Cpj4IKDZkidFm8vqZX
         1OwNYUAckZp8l4JcET5978C83PvDQG/h4hjaRbaf2ZHdtdTpivoN8n6ppo/ioqTiKr+z
         YefjUdsj+n7uiuSddeblS9DmVOh0EysBV3OEwF3kqmlfjpqS0HDTnnYKhQHN+gy+wUdk
         zpivYg3QKK7aqxsQGYmxMJjpX40A7HoT3IHETa/IUbzAcF+Mm07zTSFGVl/Oll+Ck1/u
         40BQ==
X-Gm-Message-State: AOUpUlFLnyhEsU/L6ejLqhV26yTO/I48EU/bnl1zlLG9tO8wnLCE94W/
        imCcCucCU4tHREGFff9bWrn9cYQ0tcZNpn1WnYTxlA==
X-Google-Smtp-Source: AAOMgpciDj8cS7VOZBGu7SsgA3ayNgnVcSjjz4yKc30oWPQf5ambvXshT8dKwffGYORJevNehGANOicYQ3XGX/FXPoQ=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr3763288itf.70.1531464643915;
 Thu, 12 Jul 2018 23:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180712100323.26684-1-geert+renesas@glider.be>
In-Reply-To: <20180712100323.26684-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 08:50:32 +0200
Message-ID: <CACRpkdbAjfm14umRBj_HEGys67JgAE2TO3y0exciqmdcp4hKBw@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: Warn if missing author Signed-off-by
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     apw@canonical.com, Joe Perches <joe@perches.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:03 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Print a warning if none of the Signed-off-by lines cover the patch
> author.
>
> Non-ASCII quoted printable encoding in From: headers and (lack of)
> double quotes are handled.
> Split From: headers are not fully handled: only the first part is
> compared.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested using a set of ca. 4000 real world commits.
>
> Most common offenders are people using:
>   - different email addresses for author and Sob,
>   - different firstname/lastname order, or other different name
>     spelling,
>   - suse.de vs. suse.com.

Pretty cool patch!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
