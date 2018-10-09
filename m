Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BADC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10B5214C2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="xLiPz8A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10B5214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJIK2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 06:28:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45281 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJIK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 06:28:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id j4-v6so90263ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 20:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kucmg1VVyRbjyySw1tRyrOlIC49bPyGNYlCCufAdVnM=;
        b=xLiPz8A1MzzidXAODLMzOCxRuZVdoR9G6qIeSNGTFeHKjLYxapRKzWHkqSTdx2nXrv
         qY7qLct9LHYyqBI4pAxuXCpG7xPWRd3Bb17OPpQO5BPkLRjuRTw16vRQk/9cSVxjC7eM
         nf28fODswPxqZNEdVvUvC/sR/GOiuHlF5wSkJH4I/srMznqjhxhNT+GdWG40heajFgl0
         TkFOxUMhKR4V3q/dPomvdHSvX3nX5mz5gyb0TXe2fTXaPGlkda/EAbGVCRAFki6TxnnE
         oS/YpqdQPEg8rP/oEzI48nubVWaWbJR6smQgHWNK4kBy5oKeAWkOq6aCaiDllUKRWkTV
         kprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kucmg1VVyRbjyySw1tRyrOlIC49bPyGNYlCCufAdVnM=;
        b=aUoFdfHTn9lqL2VfURvISrhvutnmeI98nwdnKeQWKg2WcMkB8b13hkZAAepX1edDaN
         68SzJncroByw4FgpC1cYcpJGK1LcHSO6OHcdcSLuA8attW5mMBaAEubIbJwycqli5D+o
         CBBXEK/axs1JqwcXO5af7pFFzb2F4PSSBusHUEr8FsBLfBRshVs2+PM8MwygTiExUCeb
         1dUv8EZSM0MKlcoi2Bb1mFdM3QnzKg1D69H05DJE4pJB89D4qdlnaUJcQmxzy2k9T73X
         wN1IfGLVJMvbiw23hgCgaGGmXyNH/kYnyPxF3X6+kDX4yGILc6JAR4OJ5078PmzhRrKq
         I1eQ==
X-Gm-Message-State: ABuFfoi7sRJnatqFo06jzmIo0ZYhFnHCDsX+/RLO+tey8u8kyFnNVnH1
        Apnk0fC+HRXnhSKNeT+i1O5Oyh2loV3pulDidxdDxw==
X-Google-Smtp-Source: ACcGV62KhY/WhBL11COhC3GyaPv9E4qmbFZ043lWXpJlVdAds1Wlq6ggtGLzq7tsJYN4FhwFZTKLpVKfgMMPzSnI4jM=
X-Received: by 2002:a2e:8703:: with SMTP id m3-v6mr15761894lji.109.1539054797872;
 Mon, 08 Oct 2018 20:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <CALabi0E=hBjzxarFcvSTtod4x4=efM+HcHKR8J3-i-+K2ntH=w@mail.gmail.com>
 <1537861288-3293-1-git-send-email-svellattu@mvista.com> <CAL_JsqKwr-oVc126vYyTR16d_EQarZRTqvB8KHoUR2QrJbEP3g@mail.gmail.com>
In-Reply-To: <CAL_JsqKwr-oVc126vYyTR16d_EQarZRTqvB8KHoUR2QrJbEP3g@mail.gmail.com>
From:   Silesh C V <svellattu@mvista.com>
Date:   Tue, 9 Oct 2018 08:43:12 +0530
Message-ID: <CALabi0G1M4d-NKoMhz9N2n5Erw8gzCAFJcUwysr0TMcjc-=Z=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] treewide: use bus_find_device_by_fwnode
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thanks for the review.

On Mon, Oct 8, 2018 at 9:15 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> In the future, please use get_maintainers.pl and send to the right
> lists and people. Perhaps the coresight, i2c, network, nvmem and spi
> maintainers would like to see and be aware of this change.
>

Sure. Will send v3 with all the right people copied.

Regards,
Silesh
