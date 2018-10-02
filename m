Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE85C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052982089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052982089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJBQSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:18:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34551 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeJBQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:18:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id x23-v6so1204331qtr.1;
        Tue, 02 Oct 2018 02:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpP887vsSKnBfNBNiRd6+zuebqckF+o5kIqy7g5U2K4=;
        b=MmdzNm+J8Q8LZCsydgLjpiuKYlvL7eKZsqOulm1+/DUU3faBmaaUK8SCxGBjwPyBXT
         5anqqVoyRF4PglBJ0IHZe7LmaTlARlsJy3w3NGHQVQACKSOp5TwJ+s27yIkRZLZe03OS
         7YAJyQmG5FK4mkQCTqMemr5YhlP5Ve8EW/agEAgNWata3tgZ/6crTBQ9FxKUX5dusABx
         lZ4MOviHNCOVVX6SQi1IHSTSRwm2dw/JyspsLfnHrDP+XxPzK9ykFyCreV0tLjkT5E8v
         Wm4GPD/zZFY6pTianvIiVM/QM1NVw/Gehwqb3CxfJBHMvD2FHLbNDmxWxJ45Q2Q+2tjl
         fbjQ==
X-Gm-Message-State: ABuFfohFZXhEQ8V5sZTF5GuGMYYyRGFQRtEbT77uK+RLnAhpsOXZdjUA
        LzMzeHTCx/xI4spiGUOSlkkYEn3TnbQF/JRXGVU=
X-Google-Smtp-Source: ACcGV62m5235XZiqgDQo1m5B64jBj5dYNT0JYbVnjKUu3qXIWb5TkYkpE1p/biCQM425Ck/j0Dtlqp7dkbYIi9cpPhY=
X-Received: by 2002:aed:210e:: with SMTP id 14-v6mr5409866qtc.9.1538472987517;
 Tue, 02 Oct 2018 02:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org> <1538332682-12018-5-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1538332682-12018-5-git-send-email-andy.gross@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Oct 2018 11:36:11 +0200
Message-ID: <CAK8P3a3SVftnc83sxe1NCsLbu23Buc+SHOpn9JUQJCZ=MXDuJw@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Device Tree updates for 4.20
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.20
>
> for you to fetch changes up to ca02f96b95ca1a50344e7e2a7bb43fbb825aa3a2:
>
>   ARM: dts: qcom: Update coresight bindings for hardware ports (2018-09-30 13:14:05 -0500)
>
> ----------------------------------------------------------------
> Qualcomm Device Tree Changes for v4.20
>
> * Fix IRQ constants usage on MSM8974
> * Add led, gpio-button, sdcc, and pcie nodes for IPQ8064
> * Move/cleanup common nodes for IPQ8064
> * Add i2c sensor nodes for MSM8974 Hammerhead
> * Fixes for SAW, kpss, opp, pci range, and space/tab on IPQ4019
> * Update coresight bindings

Some of the ipq4019 changes look like important fixes, should
they be applied for linux-4.19 and possibly backported to stable?
If so, please submit them again for the fixes branch.

I also get this one warning (both with and without your patches):

arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning
(graph_endpoint): /soc/mdp@5100000/ports/port@3/endpoint: graph
connection to node '/soc/hdmi-tx@4a00000/ports/port@0/endpoint' is not
bidirectional

Can you have a look and see if it can be fixed in a follow-up?

I pulled this version into next/dt for now, thanks!

      Arnd
