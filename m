Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB204ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF6720BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ajpL8kpJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B7afqpTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF6720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeGQAUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:20:30 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:40930 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbeGQAUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:20:30 -0400
Received: by mail-vk0-f66.google.com with SMTP id s23-v6so22634793vks.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qEAEeBP7MoL5MaLKaMMR427OK4u0PkfHoVlyycKcAxc=;
        b=ajpL8kpJfodSVxKzeyaAjqb/sCi2aqOVR1qIKw7Di6diKRyoyqcGbQKZrqYtw4nRvq
         ozxcNUEC9WDwh3hBv4SHfxHtohwGWOKdNcjN3icgV/EplKz+7cG6wK4hp3eNaYtIoFRF
         y/MHLyGq/FjVxMzrTSclrDyba10PNw0b1fTy/wprOUbi+vBU2XopAVJAP1ma7JoFE+Kw
         l+Y0Y32h1AtcF2RMa4wbI19uWhDpELBu4Bef0/827u6FEY0ej8oeo+XAfK9c3GGGngnY
         C0+W4uKziaDNeNd7GOyyt4I6l8ucpTH6Au8JC/P+O3zqzi4e7vewozjBBrSA51KLhKxB
         jswA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qEAEeBP7MoL5MaLKaMMR427OK4u0PkfHoVlyycKcAxc=;
        b=B7afqpTKbACMBKMOPRlO6bz2lyde/t60/Z0rAmu85fLMbX4PHLBdrXAWAlHa1TmiTP
         gaHCrxnaxiU5rNqrcQaE9QEIQuE1Xx86MJ1hMDyf5U66quHC0CVLtc3W4Ly67EZw5qYe
         GCdGMBwutom5tHVbAMj0hdtxXQB9KT7J8yyoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qEAEeBP7MoL5MaLKaMMR427OK4u0PkfHoVlyycKcAxc=;
        b=fq06oIFMDMrTluO7vpbLeO1dQKfAskt/eWs//FYsF8Fa4B01MtZrigyF/b9eZPVYbv
         s3oQQTYsx0r6RxjLS1XeLQhg2LOmaD9FUZBXky2yipmIiP4a6bny1QuNTfjBgjCCwOK9
         9J/GBt4SuGAP5yeGbeJEPZHsidnc2wTLd7ENs50OchkJ8vz09IC7f+nNBNCYOE5Qc33w
         x1gWLGkKD5lto5WV5smg8revk7hoyjUhXi9xTol0e4B/3C9qDNiCM5zmmyKfPhlR1SxX
         RloH1EIuJCbyH7BOczc5SRYwIN7l0c2IGwzYzaoh1visu4ZRfZV7HLamXtjYGs+MJGdj
         1i5g==
X-Gm-Message-State: AOUpUlE9XPSoMcmS7Z0/qPdgi++BbHn43fki6inI4/qQQfb+JKSVj9q8
        xwozcEO83YOAdQTQfk1dfRvzTps+dL4No4sXtnbq5w==
X-Google-Smtp-Source: AAOMgpe5l/3SWow0eu3sY+OKkEMGCtGCP/Y5+aVJvw36blp9cAP//jZyt58F5CCCHi4Lc7AZ/MGfwWUnsXlAqqSNE9s=
X-Received: by 2002:a1f:d744:: with SMTP id o65-v6mr10633335vkg.101.1531785045941;
 Mon, 16 Jul 2018 16:50:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 16:50:45 -0700 (PDT)
In-Reply-To: <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org> <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Jul 2018 16:50:45 -0700
X-Google-Sender-Auth: m7-xbUuR8bX4G1c8SrCCB89VLKo
Message-ID: <CAD=FV=U-9Xs2pTezM1Ny_5uSGJ7MpSCWZmsSwsW2wq44dtH=Gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
To:     Girish Mahadevan <girishm@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        boris.brezillon@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 5, 2018 at 2:46 PM, Girish Mahadevan <girishm@codeaurora.org> wrote:
> New driver for Qualcomm QuadSPI(QSPI) controller that is used to
> communicate with slaves such flash memory devices. The QSPI controller
> can operate in 2 or 4 wire mode but only supports SPI Mode 0 and SPI
> Mode 3. The controller can also operate in Single or Dual data rate modes.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  drivers/spi/Kconfig         |   7 +
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-qcom-qspi.c | 728 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 736 insertions(+)

I spent a few days poking at this driver and trying to see if I could
get it to do anything other than crash and corrupt memory.  I finally
was able to do so.  I've posted my diffs at:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/6670275e22b5901a1c4c11982cdafd10c2820771%5E%21/#F0

...if it's helpful I'm happy to post a full patch here too (just let
me know), but I'd just expect my patch to get squashed into the next
version and it can be reviewed then.

With my patch applied my testing on sdm845 on a device that can only
support dual SPI seems to work pretty well.  NOTE: as I reply to this,
I realized that I hadn't gone back and tried to address Mark and
Boris's comments.  Some of them are handled because I found the same
problem that they did, but before re-posting you should definitely
handle them.


-Doug
