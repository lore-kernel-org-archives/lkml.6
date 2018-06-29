Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779EFC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BCD244A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxkhwNlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BCD244A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965568AbeF2MSq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:18:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37982 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965293AbeF2MSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:18:44 -0400
Received: by mail-io0-f196.google.com with SMTP id l19-v6so8275032ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrVbNFL7Y/nwGZgZFHV6UkPOyhbBiePs4nUUbhJWgxo=;
        b=TxkhwNlgyaEEzn/zrjzMFTYKZTYlqpG+jdRcRacNlXKxvtTgng78SXr55L3mOlrzep
         CtZD/eGKP8boTGeyyNeiwxjXqAV3qUvWoebCRLAk5s4vqcILQpkEdSDksBO2NgQtWzDi
         CjkdZmj4OsuE7IImPUTywz4eESE0NmUnAd1BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrVbNFL7Y/nwGZgZFHV6UkPOyhbBiePs4nUUbhJWgxo=;
        b=GFMWH4aJTOfNF//Pya73jv2I/2c3YWfLc7gA5FbBrPpzVrHN+qwJ91A0HBeBBBc5Kw
         WkISPY4/iYARfck3v9j91mg6XMUVocdMUIKxjhy3xV0CDGnDuYLQEY+yBREJuOtf2d7H
         Jve6hbWDiom0Fs0mXLk7pTq/1+14Fo1m8Ap9phkuLTp3zePfyYkz3MugDv0AOffpANhJ
         4q+R84kTVKmEA/EWpeQEER5hu2IpyvdIv5SHuwSDBGSl8azLq7Ur3k9GU9RJji7skjHV
         3FcMvWbYacwUmjF+N6syOhLZSW1XrLebeRkigwcGuNw4M5u8rBzA2ZPh1M3hhWlF2bn2
         Vihg==
X-Gm-Message-State: APt69E2wXKfM4QF5DA7KdTukbHcCAkuNb+rjQfYdCtgoEX5wBRUy71HE
        MRtTXPRdiV7JumH27UrfGLyhi45CYMFn81knU9P8yzQv
X-Google-Smtp-Source: AAOMgpdbGAsuet17k8b0PEhNK9Ocd1sBkVU68SiSoqDG6NbO1yX9v1z0WP5uAFvJmYKG8ry5Rb60fL61JL0K5b+OTpA=
X-Received: by 2002:a6b:6c0b:: with SMTP id a11-v6mr11826103ioh.175.1530274724163;
 Fri, 29 Jun 2018 05:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <989f31608d4a85594d3805f966006e1f607ccde3.1529639050.git.sean.wang@mediatek.com>
In-Reply-To: <989f31608d4a85594d3805f966006e1f607ccde3.1529639050.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:18:32 +0200
Message-ID: <CACRpkdaa2eBF40T9VcBJUiKm5cBe-iG2T3iKAOo=o7=FviRBvQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] pinctrl: mt7622: fix initialization sequence between
 eint and gpiochip
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Because gpichip applied in the driver must depend on mtk eint to implement
> the input data debouncing and the translation between gpio and irq, it's
> better to keep logic consistent with mtk eint being built prior to gpiochip
> being added.
>
> Cc: stable@vger.kernel.org
> Fixes: e6dabd38d8e7 ("pinctrl: mediatek: add EINT support to MT7622 SoC")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
