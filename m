Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE9BC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1792184B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxkMTbXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfAZVYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:24:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36018 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfAZVYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:24:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so11162984ljk.3;
        Sat, 26 Jan 2019 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j4ZMiwB25w/pcUjmEEMQAlEwTmduHMKm6ZPVtUL9kqw=;
        b=LxkMTbXr+JbCNueJtSg4vqZSodI0OGteRJuTksM6sn5Ytt6S1E97PiU/EVcnoiYJDO
         QY0owFTf+vuTLnVwaNpCTSJybUkjt2Hm4z4oXB+N4dCQwksrHgvhJHORstfBl5vU0m6f
         iTFpMjSqNhwz0ohnqj3cVKpCFBQQP6EGvImeAvH0GnwrMHYqr8AGSjABKGQkQcEHK5X5
         NZAd6NIP6BNw9LMeMrIGQ7xVfoTHWDM4cN3bALDKrdfjeZ6cRYK6eeW9lkDnrw4sUq1t
         EHMsS4kJEdLMbG3xRLiBhhB1/1KYTTmO7+pFndB6OCt1YZgisFWbWfysqeU5ptBYcdmj
         sfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j4ZMiwB25w/pcUjmEEMQAlEwTmduHMKm6ZPVtUL9kqw=;
        b=MLZiLHVSh4VtFqqZeNmW4qGw4ncyM9d44k0mjIivcwZU/d1GiNWs9hPzBXmP/OPiD4
         wZilwlYp4Xb479Opo+lgbrG3gtqVAzAGgEKRm+EcZJIXHOUaE3HrLiqm9d8JJUFW748W
         nq3afrVUGb4/p93u4PRJC0wCSr0dLCYpsaaB7KjZXYdGGobkBu/S18bx5rfO+22lXWUg
         NuMvDpsWFTpM7UXyMEODeRkzQby5otJr9G5+COIuq9GfaKHqW1pkdssbKpTwrwPApk5Q
         T7Rsc7NCqnK54VK152XlryAZvH3LG5c6J/3aQ7uoU2/FipaOR7cCF2i8+YNm2r31/YHm
         pYRQ==
X-Gm-Message-State: AJcUukdRUolvdKtdMKkHcHyDLgYfPxlu+r5TKwMbQURk9fD4SD9EC4Dp
        8TYmPQqTmE2SOL+ucjTstitoVPRw
X-Google-Smtp-Source: ALg8bN7MavFj5Ehs775tvvWkZ2m/Q0q0YSpHuUUtDUnU9l4Uk5qCxTug9FMtNesoqTUwPsI8XID4bQ==
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr12762213ljb.104.1548537878705;
        Sat, 26 Jan 2019 13:24:38 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id u11sm2214991lfb.85.2019.01.26.13.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 13:24:37 -0800 (PST)
Subject: Re: [PATCH V3 3/3] i2c: tegra: Add DMA Support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5973707c-555f-a27c-2ff3-e867d4b2cde7@gmail.com>
Date:   Sun, 27 Jan 2019 00:24:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548475073-12408-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.01.2019 6:57, Sowjanya Komatineni пишет:
> This patch adds DMA support for Tegra I2C.
> 
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
> 
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction adding overhead on CPU for large transfers.
> 
> DMA mode is helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> 
> ---

Seems there are good news, APB DMA could access IRAM. Quote from TRM: "The source may be DRAM or IRAM, and the destination location could be devices placed on APB Bus; or vice versa". Hence it shall be much more efficient to use IRAM for the DMA buffer, please consider that variant.
