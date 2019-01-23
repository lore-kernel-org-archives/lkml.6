Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5182EC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1384420868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLexmQJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfAWA1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:27:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfAWA1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:27:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so348711wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEw7bDn8Ca6oeQT9i2RVs0qPhAeE7dbq+aCULKAqpQw=;
        b=FLexmQJLIG2y8Oh6KwePmY608RIvR/oCQgt+8edS4UduC2K7KiZ2tzlAzJM5cvIBLR
         Z3cn23/Z+jHTTT32t90KrjUK5bydXqVS97l8N+sEjCpFP09XOIYtum4fH720Exj+ONW8
         BKMzVJxPwDKIq2x8bIpB+boBL4GFgVb0BTuBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEw7bDn8Ca6oeQT9i2RVs0qPhAeE7dbq+aCULKAqpQw=;
        b=prejHdaWuwLhoeonCLc5WlrjVc/avxs74aruc4BCsN6V/j91rSJ9bUmrJbigsdTdpA
         vTS+PGU/o6bouCFy8V8Y3yjZXHaePhTs1tAsIPHn7mgzkIX/3l/Nn4m/Ymes4v/zmyCv
         Eq3ROkwRMpPvGbCaP/WrSTy8Vj3EK363h1BHg8Fpe3ss68pqcS999WCblWtu0rQyqNfx
         MF3/Ds3/AnQ/45vaK5lCNuzhJAAqG4Sv9EnDNVpQ6GCTbDU/HHx3MsPjNWAqP9+U6dn+
         A5EV2TkmGv4aQjBLLmDQH4TTQn0CbICEQUSQcAS8+kZFmi0G9yVp5VfX/KXmM2jl9qRz
         YVtw==
X-Gm-Message-State: AJcUukeKaROkuBLcLEUrmPbFWaxUW/xOq9PKxqoY42KJWyDKnHp/wAJE
        IgJototMkirTMaWIff9tF3s/6TDrdTHnkeBrkKqOkQ==
X-Google-Smtp-Source: ALg8bN7luI81+wU73IGRIhN3v4YFFHzklGHOuZn4CPifj5snzWqMilTw7AGxRgHh1i3WYsYiVbFCMY/tbgvAYfK9Hm4=
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr492229wme.64.1548203259067;
 Tue, 22 Jan 2019 16:27:39 -0800 (PST)
MIME-Version: 1.0
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-6-git-send-email-john.stultz@linaro.org> <20190117171430.GK5283@Mani-XPS-13-9360>
In-Reply-To: <20190117171430.GK5283@Mani-XPS-13-9360>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 22 Jan 2019 16:27:27 -0800
Message-ID: <CALAqxLXs1drp37WU9r3tK8aAZptKVwzUCRoqZy18nGrSme4VhA@mail.gmail.com>
Subject: Re: [PATCH 5/8 v4] dma: k3dma: Add support for dma-channel-mask
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Li Yu <liyu65@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Guodong Xu <guodong.xu@linaro.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:14 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> /* Skip the channels which are masked */
> if ((d->dma_channel_mask) & BIT(pch))
>         continue;

Per the discussion w/ Vinod and Rob, I think I'll leave this bit be,
so we use the channels in the bitmask.

> PS: Use BIT() macro where applicable.

But this suggestions I've integrated for v5.

Thanks so much for the review!
-john
