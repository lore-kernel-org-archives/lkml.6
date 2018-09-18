Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA994ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586B12133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkB8wAua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586B12133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeISBX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:23:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34975 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISBX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:23:56 -0400
Received: by mail-io1-f68.google.com with SMTP id w11-v6so2609055iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYZ7PM2zieZAM/j9ZjQi/+UsVOJfJog9Gwhj6dl2EdQ=;
        b=GkB8wAuaqkxCIKj2mwXG+KkKRq1NtDfrcb7p11oGTvWyXrlk2hUnhcaQjqFpOqKpyS
         TFo3oACyrvmv3mgRZEtcqORb5GpAIHufxBJlSH8RSEFQbCyECqwjz4wBu+Sym2Uotg9L
         ImHuOHZRCZhmv5pCHLcrU+bsGj3uUZPWr5xmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYZ7PM2zieZAM/j9ZjQi/+UsVOJfJog9Gwhj6dl2EdQ=;
        b=anRo5m1g/kdyeBmaLf6l0/lx1lk2DO25o8L2IdmvLzQUCEg1nTw5HC32yPk0RRNUG9
         fu1sJsVL1+lGk9HF/xrt66dRYumb3h2liPP6kC9xtQMNZFRj/pv5WYGwztwXbI53yuPe
         RwgbcRPMnfm6QeaR9UIU+YT2W6HPNVAteWBfUjhWijCSwPSVQk2G3gpgTGV2p0Lv2wc3
         zJb+sCtJyKvMDfaBBgeGmozrno4wnIX9HyMZkcL5Qowx7lx2GcgoSMjxQocYEzM6zLre
         XKp/lWrQSmgeAyHaiPTxi3/2BxNwm+eIK1lmsRR80sHzH3TbLjvBuzRCUxARqSl8+CMg
         X3+g==
X-Gm-Message-State: APzg51DW3lcQgucgbCh0s0qWczz85D1kytsDgco9yXGzFVDAzMRDCZ85
        mdVB7VnR9l6wQUvMw7BltDmkzIZUVg1PjIjDHb8lFw==
X-Google-Smtp-Source: ANB0VdZZ3oC+JZqydIKUgoDiXUGxc0yED4YuRJaAxV/2ty6Jjz7A3VnHYuTVNpEtvohkR4O7SvRsH7iHH73HHTfxYTE=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr26153271iog.175.1537300189975;
 Tue, 18 Sep 2018 12:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <aa213c9af6f9261f2ba91055785f0058d615bc4d.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <aa213c9af6f9261f2ba91055785f0058d615bc4d.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:49:37 -0700
Message-ID: <CACRpkdaAWZYeQiSBuZQLwhQMoKryGB1aktQ4dpcarN7TNnZh1Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/22] pinctrl: mediatek: add advanced pull related
 support to pinctrl-mtk-common-v2.c
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
> There are some specific pins (i.e. MMC/SD) need specific registers to
> turn on/off the 10K & 50k(75K) resistors when pull up/down.
>
> Therefore, this patch adds the custom prarmeters so that the user could
> control it through device tree.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
