Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31943C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8504204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8504204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeJAWjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:39:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39321 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJAWjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:39:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id 5-v6so12659273lju.6;
        Mon, 01 Oct 2018 09:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+DX9LD9Fxj1BpnihQE0ierZZoVUFR7yuTv5z9MGsaA=;
        b=V3svqCeSaIGUoiXpEt5xumjZkgXSv8X2zZ5c18uoFzzGRrd01tokIN+43IfDu88Nf9
         L5vbY4vwjCcLpl1DErClGWTRSJ+woolU1gDN5wqI6um84vX4FUwsI3QxlPPHsSRwbxWd
         Op9VFOJ5B1Xq1GJhO33CdLgcCjVo6b7ooWDfg/3whYlIQPi1Kt+O7PB6VHHH5TLQbOtP
         bBtryIKlsHPz4uBdQJ6jQrWYxIpzHcLerAz+cJgIhltnGGAVWAT897mmXT/iE/vO3Hwg
         fsZFxqpN2npoQ5wFzPijSUyqoy3JOhEqq9QOtihUbFlK4f3d7igFfNVcuBHZtgmFmQDm
         vkuA==
X-Gm-Message-State: ABuFfojucvL8GJm/JJpnVI9YTGwYB09PTEPyGIPO1hRuUC0DsZoQ6oeX
        vFTJ1gtgN9nW19dm/9yoanBZGhZsYyZkyLTbFXk=
X-Google-Smtp-Source: ACcGV601WhWnpkikKetyz+v9MIAQWJ20zkIWwU8BQyexTASRSKq+fP9hAgPmLPEEdJe6DZBiVN/s8bpaov5WL/lKCwQ=
X-Received: by 2002:a2e:6353:: with SMTP id x80-v6mr6598965ljb.11.1538409621948;
 Mon, 01 Oct 2018 09:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Oct 2018 18:00:05 +0200
Message-ID: <CAK8P3a2V9kVOT6LebqEU+t7==rpQJnr_0JB4WDjb8X2wcrXPTQ@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.20
To:     Andy Gross <andy.gross@linaro.org>
Cc:     arm-soc <arm@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 8:38 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.20
>
> for you to fetch changes up to 1bdf91fd2ae8226f34ed3a760199946c7dfe746d:
>
>   arm64: defconfig: Enable Qualcomm QRTR (2018-09-13 14:38:06 -0500)
>
> ----------------------------------------------------------------
> Qualcomm ARM64 Based defconfig Updates for v4.20
>
> * Enable Qualcomm QRTR driver

Pulled into next/defconfig, thanks

       Arnd
