Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE5E20864
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PoYciMbh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gxjrFoJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE5E20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeGUAXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:23:17 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34640 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbeGUAXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:23:17 -0400
Received: by mail-vk0-f66.google.com with SMTP id l143-v6so6826600vke.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MNFt+i9DVqWlcpzvEhwEM+GXKRMSwVetAPeNaDtq8xU=;
        b=PoYciMbhusYTn0LV01wNXmBm0qCkg12HAQVZMsVFnER+wLCe2voYvLCTGFeeq0+7VI
         84g/1F1c8Cim6fRTWBr2EyCfUGwB91UugWbHkEG52i20Na10dedtnpmGa+lYqx/b5Q+P
         SDBp9MuLu94jOYpp+eytZbOxpqXcCw2fGLdPrdgJs0bvb2x4FMI4j2/cK9W8SwyOaSup
         NOaMtIjOBojkGdLLA3azY78gaUfemEGWWbxQ4g6wuN+kTljj8rbc9asWFQ6ETZmUmPCk
         ciVAPZ7mltz50VoID28YdcDGs0MsXKEn0HCvjSjl4nc3k5Wi1NeTcY1UFv7JH/el8nra
         V7KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MNFt+i9DVqWlcpzvEhwEM+GXKRMSwVetAPeNaDtq8xU=;
        b=gxjrFoJzr67ill3AcH3XMNCN1Teb4wbkQBHpUh94aMgrQF6VOL3WZDnSqp6SZJT2rE
         ypG7sG8OVExQmZMr5SSWYqBgXRBEZci2Zor39K/oUR6jdqBjONI9hnpW5+RT9mXXUhhs
         QBL36DxtKcELCI/aEzQ/VRFRBSDad79zr+82E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MNFt+i9DVqWlcpzvEhwEM+GXKRMSwVetAPeNaDtq8xU=;
        b=cznnE0RASXodP6Jyig43GuKrhTEXgUkQJZixz4CTUfMK1MI2QOkzwQDtpPRNFNtbHI
         PjODb45xCGVoSuPjMps2IlFOO51eB3EtMKpeo+aSk8CMoDi0sZTy24b4KsqT5fEzvCQD
         Cxvc6eJWcwAjhhFSNLRBhMSGeb4ark/gpfobPcCrD5VyUMLKOnNdYX9l6fhdNtVySWHQ
         LYvde8vLi0iai5dqSkqzPcIPWoco93Gz+smAv2Y3Zfi6pBrwsMpD4s21jsGvtERuL5xN
         kRILkr4dN0aWR/Z0ugx3OYYoofdQrCoTzi5UblX/MEFB4snHQjaU1siirpPkrRhMRzu/
         Mv2A==
X-Gm-Message-State: AOUpUlGh9cvnQ7ga47K754g1HhR7Cy0FPVQ1WnZIv/9AMIr9ie0IFdoU
        iGmo61ecWhjglnAPZjT/bMfDVj2mvdK7w2fPyda6UQ==
X-Google-Smtp-Source: AAOMgpdyyrwu9oh3NJh3TIryJTwUq7jTq1X2W4J4BfSGdi8+WgNPonylIELONas/iOnJE4Yj+6JXGP+14D5BeSDY7Sc=
X-Received: by 2002:a1f:3653:: with SMTP id d80-v6mr2472255vka.79.1532129568470;
 Fri, 20 Jul 2018 16:32:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 16:32:47 -0700 (PDT)
In-Reply-To: <CAD=FV=VEQwudhCU0h7muB6ZM1WPETW0h4-=wo_=jgk0gyqfhBA@mail.gmail.com>
References: <1532087461-3474-1-git-send-email-dkota@codeaurora.org>
 <1532087461-3474-2-git-send-email-dkota@codeaurora.org> <CAD=FV=VEQwudhCU0h7muB6ZM1WPETW0h4-=wo_=jgk0gyqfhBA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Jul 2018 16:32:47 -0700
X-Google-Sender-Auth: 5QrkRP6g-q3nBmf80m0sdXG3Z88
Message-ID: <CAD=FV=WMAyg8Z+uamOyQ4iBs_SgTG3VTuw1t5u++FZtEpRWH8w@mail.gmail.com>
Subject: Re: [PATCH V2] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Timur Tabi <timur@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 20, 2018 at 3:53 PM, Doug Anderson <dianders@chromium.org> wrote:
>> +               mas->oversampling = 1;
>> +               /* Transmit an entire FIFO worth of data per IRQ */
>> +               mas->tx_wm = 1;
>> +               geni_se_get_wrapper_version(se, major, minor, step);
>
> In v1 Stephen said:
>
>> Drop extra parenthesis.
>
> I'll further add that I'd prefer it if you based your series atop
> <https://patchwork.kernel.org/patch/10412417/> which changes the
> prototype here.

Whoops.  Extra parenthesis was actually referring to the line below
this one, AKA:


> +               if ((major == 1) && (minor == 0))
> +                       mas->oversampling = 2;

...that still applies.  ...but then ignore my comment suggesting that
you base your series atop Stephen's.  You already did that.  Certainly
you should mention somewhere in your email that your patch is based on
his.


-Doug
