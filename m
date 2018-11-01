Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8881820820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XMSEN8ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8881820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeKAQhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:37:10 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33091 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeKAQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:37:10 -0400
Received: by mail-it1-f193.google.com with SMTP id p11-v6so1555954itf.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlBphSNXM+25aNa0t3XL1G1zVEdZhJeAo7gibeIipLA=;
        b=XMSEN8neQeTcY7ViYCFhHMis8MXEEwy2cgVVSMkMEUwjzHacU1hciO2D1pF8/buHXX
         yMAumKNUl4hlkdqf5Xc4snzM9Os+Ek/0l7/XKCIalkEUTrNe8bgktHqK9ucHoMcRTmi9
         +FNMcIqjkxFaMWZctVwLns3sH0QpcUODawEdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlBphSNXM+25aNa0t3XL1G1zVEdZhJeAo7gibeIipLA=;
        b=pnmrE8TZcu0or2adZ1NpU/jab8R2snFcu1hEU33OzP9jnNALxiU2MqRTOXNN3nTVW2
         HH5XSDe7Av6hO6Bda5tNZYpLWFlSvREsSgrZdZx7FwWVEl97jPOjB/LQxdM86sXVNvf4
         z0w6X6kfKcG2OeJxpaYHSSwT2eframejtyYcBw+ELGYONgzmZSQ8A8e1TH6unxMmrgkN
         66oz9yT1fUTGeJlrf6h/ViOM7RLnX2MsjJVHdMoWPwoKaolszPX/E6CBgUlYIRUJNU/T
         PYKOjPTTy3fJopOcqB9ub3tn3ISmbWEwDcsMcBI5vmVY1DSeHLPR6eZ0PSx8yp4TEUu0
         /xVw==
X-Gm-Message-State: AGRZ1gKpb2VmLOfo0Akb+9k38u4dwY1CNTkT5BshxOXPkXfQ1i1RdDjq
        0ti4QMpdcJeuNcsZCpRUe1IyF/UT2Dw/XrSXA0R/Zw==
X-Google-Smtp-Source: AJdET5frMPf25m+VeHBhfCYM94GZq83FFsVEUHtgkKqHKBb/8JbpGa8eAiPCfcnIkzJIsHZZhjDJTlKplZ+2hT888h8=
X-Received: by 2002:a02:e43:: with SMTP id 64-v6mr5261884jae.58.1541057719960;
 Thu, 01 Nov 2018 00:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com> <20181031183634.29640-7-jagan@amarulasolutions.com>
In-Reply-To: <20181031183634.29640-7-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 1 Nov 2018 13:05:08 +0530
Message-ID: <CAMty3ZCeZzXYy4XRwTeQjYfpB6KKjEVRWyhjoca9Os4foLYL4g@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] arm64: allwinner: h6: orangepi-liet2: Enable
 AP6356S WiFi support
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 12:07 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> From: Jagan Teki <jagan@openedev.com>
>
> Enable AP6356S WiFi/BT combo chip on Orangepi Lite2 board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi WL-PMU-EN pin connected to gpio PM3: attach to mmc-pwrseq
> - WiFi WL-WAKE-AP pin connected to gpio PM0
> - 32kHz external oscillator gate clock from RTC
>
> Signed-off-by: Jagan Teki <jagan@openedev.com>
> ---
> Note:
> - chip detected, but failed to connect
> [  129.084504] brcmfmac: brcmf_sdio_hostmail: mailbox indicates firmware halted
> [  135.906409] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

This got fixed. Will send next version.
