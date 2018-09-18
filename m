Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6CBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58A42146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlnRQEKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58A42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbeISBWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:22:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52883 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeISBWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:22:07 -0400
Received: by mail-it0-f66.google.com with SMTP id h3-v6so5047222ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwnbn9MBOKrKJuynYg+4PGFCyuZwUxNa7xH/KpJOLNo=;
        b=VlnRQEKSA2Z7vk//TTgUgdlaN/beNQVX1l8nlGO0rLR4B6f/gSJ103FMZnsUpmGjLl
         b9QjVEWSzSNibFEIL+ObYttNMWEt/l9VXrtw3y9/XCaroRKk1PVHUucAYLdsynbh7CTP
         SORugSNkNhqOvatDouYs59YRLGJU2VW2VizPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwnbn9MBOKrKJuynYg+4PGFCyuZwUxNa7xH/KpJOLNo=;
        b=MwfqchE7WSMg5PpZMeFThdIt3WXYh9tjtw1m6ybIxRXNpRqwl/bLAAFCEZzhI5ZjHM
         tuzV6xBvvc9kStfdW/Vlegu9zqPdf4F7TcxYV7kwdPjEbUiEsUDwvDgTuXcbMm1ARgHo
         bVPHPiGrgXJyNhmwMMO1miBqxweKIRBrUgNpfbpINbdhW5Ij982+5xcpgi3P+TRAEmZP
         M0LlkeilQDZyZSL92R/kPB6wfngFEFWVdPA3k14g5I9PMFEN7wn9XnoCE7IRjX/kS1Or
         HlGePvtRxYOKmY7gO3j9NbYvp2b4z5uD4SVPVInUFSCQqE1CNeIqQocAZxwNxw1oS6t4
         ZZKA==
X-Gm-Message-State: APzg51BUqWpaUMxFmtiiZTl2N3i/OIY808t8xNrB1l0uh3rVApzt1WP4
        /6SJw+2ltihM8wH2o9ZDyCoU8l9FjVmErWLJ+D6gc66Q
X-Google-Smtp-Source: ANB0VdYTmGJY80IBzce/zNz+efLTJ1tN0y4TstOdkrfQGvBgUFL6rPvDrEnJkYYpy+7nxFGm/6Ay3TuUUU8+gbgK8pQ=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr6757853itb.62.1537300080690;
 Tue, 18 Sep 2018 12:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <5a7880e3885ba8a1c51ca28a0753228eeeeb9ec7.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <5a7880e3885ba8a1c51ca28a0753228eeeeb9ec7.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:47:47 -0700
Message-ID: <CACRpkdZM-og+p10vdCeOz5dJ=tSMrLmvntqRFz=8v6LTo92ikA@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] pinctrl: mediatek: add drv register support to pinctrl-mtk-common-v2.c
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Certain SoCs have to program DRV register to configure driving
> strength so that we add it in the existing path as an option.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
