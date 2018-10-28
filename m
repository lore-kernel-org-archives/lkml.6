Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FBAC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524BA205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524BA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJ1WNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 18:13:48 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44200 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeJ1WNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 18:13:48 -0400
Received: by mail-vs1-f68.google.com with SMTP id w194so3593288vsc.11;
        Sun, 28 Oct 2018 06:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TkUb+kS3yT4e0xmixeNsb64kHqKAAMe3NEYnWIWUDoQ=;
        b=hRFtzjAioj3EtflUI/mvPj2+swxWY14hEQvZzkLuiLvyy12RGca8cqioaSkw7kDFhH
         QiS/D5AEBUmtE7iENIFjz4uFE27Icy2kPCP/ea+Oz4AfMPlaOBWgeQJAjj2T24G3H/BT
         UtKzUsuST+bxk4lhx2QC/H7fafc/Gi1vT+mOdQAcSN6tb7wYn5olDr4Vhaw3i6J8ous1
         pnzVoiJQZKMKNxWUMCD5dV0JpZYa6Xqhi+avTmDxGYkFtxfZA6D9+JcJ6jjDK0dpQ9wj
         3OwxvQ1UuH1yUMk8wl/al6FIce3QYh/O0oUs6j8m0mcbIYOZQpT6T9p2zv/nlExwNMoy
         iu8g==
X-Gm-Message-State: AGRZ1gL4eOfZ5zxw8KkMAZ87Ct6g7Cy0he3ExcZMIf8/XZinKD0jP8Gg
        3Oc9GUgN9n07e955SvfHkO8so2ewNSBczqaIS/k=
X-Google-Smtp-Source: AJdET5eWHIQP+fkrRNO4+QOVC5VuvOCm1AZIQjwd8so5YJmrFPE6Gh6KqrjgbjLwXdqGf4+yteGqCf7dDHDGxSR+sRw=
X-Received: by 2002:a67:c202:: with SMTP id i2mr2688049vsj.11.1540733348725;
 Sun, 28 Oct 2018 06:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200048.2114-1-wsa+renesas@sang-engineering.com> <20181021200048.2114-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181021200048.2114-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 28 Oct 2018 14:28:56 +0100
Message-ID: <CAMuHMdUBf7AZSeEX4SffGapBRainhRCoKKVrEXA1dmyM=7kh6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: spi-rspi: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Sun, Oct 21, 2018 at 10:03 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Build tested only. buildbot is happy.

How disappointing, you do have a Lager ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
