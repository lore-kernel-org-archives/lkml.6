Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFDDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFACF21502
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSO+pfIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFACF21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJJQaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:30:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34103 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeJJQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:30:24 -0400
Received: by mail-io1-f67.google.com with SMTP id w2-v6so3344419ioc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3K0/ukuDqqwrU8L/RqiepVRRcXbxJWWPyxvgN2H0Ik=;
        b=bSO+pfIh0pwmWupK8C/dpo7Tp4VwerpM6NzVAlY453PXOCMaNty7HlrLQxeI5jLDT1
         QMmURSJFeihQNvPsICBsfIHeYPNXNjrdIV/kRQiPI/uMNhNIyUn5Ifd5w7Zw79EEIfVp
         3W3vOW73EhwI78Q/VHEITu86euWaggF99/X1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3K0/ukuDqqwrU8L/RqiepVRRcXbxJWWPyxvgN2H0Ik=;
        b=V0HkRbX4RGl4r268fXMjuftatSBh7XOSEs5VRDLYfmzGe1b9D+Vs1sgjg06uzBSr/K
         Pesy9JJZ/pgF8M1cCfQ6dn2nbJDEQZArCIQWWgnYPJMTbKErXWPcoLzHUj6x9RtwrEFT
         W5EhDlag3j/sW0a30dWjdHHlhBIEuS/5Jo6nlkAdiQOEaM2lK+GryNRHtBf8wFnrL0D/
         Z4zkrn89TdQbmcBR+T0WawYVIkLqEyT2IwlZ9EtXFDXDTph3Xq5S3delzVvZD5nKb4w3
         JXZj7HlgITphVfdAU5YI5REPjz2CTXbHxDQn9FTCYVyVHOMmHyJGKillvcrX+kUYvYM2
         1cug==
X-Gm-Message-State: ABuFfoiuPFDaH3Suga46GDn6+L824G9GDLrZuYgAuosbYRPciD/q+mA2
        XaDzlCMC6I6jASoq3+fNPn2cvqCPu8reyaWdsmO6wA==
X-Google-Smtp-Source: ACcGV61AHezV+oh9MaF3gVP5bxyooEycFwAa7y9iRXJunpgZeke+MK/hviCvif3bYpiZ0x226E3it76KbU5cSp7qKX4=
X-Received: by 2002:a6b:6302:: with SMTP id p2-v6mr15246930iog.175.1539162550312;
 Wed, 10 Oct 2018 02:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <98b17a3b47f75d4f3f17dae81a087b4163fcd857.1538652946.git.sean.wang@mediatek.com>
In-Reply-To: <98b17a3b47f75d4f3f17dae81a087b4163fcd857.1538652946.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 11:08:58 +0200
Message-ID: <CACRpkda8fK5p2OsG170pbU23TsAJ3bbyUmwCxrs86v5=-Zzoyw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update entry for Mediatek pin controller
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sean.wang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 1:40 PM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Add all source files under drivers/pinctrl/mediatek for the entry and
> change the address to a permanent one since I have a personal leave
> over the next few months and the address would be suspended for a while.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@kernel.org>

Patch applied.

Yoiurs,
Linus Walleij
