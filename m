Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9C1C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB74A21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfrh+dsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB74A21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeHTTOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:14:17 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42066 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeHTTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:14:16 -0400
Received: by mail-oi0-f65.google.com with SMTP id b16-v6so26683910oic.9;
        Mon, 20 Aug 2018 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gLM5Hpu6r2atWITweleRFx8OL+5iAWkmqkSSnMLBfds=;
        b=mfrh+dsHIrtAKV+SZOuyJaKrL530dKr8DQmiSA+yOiTzc35XT5e6RDgovdRg3aVLUJ
         4vqXTwNRxuNx2yUJJRguN8ihtsh6UC6RqtolYDBqhNwNvsh0UYbo5MPm7TYmXwSxKBkz
         2lXJu2SFYSX/27gGwRond33khOEk+dLMR0HnEMXBlEXrIJjITplPFpUlnHRm0ve9a1ad
         WUAUqIGEkhjSq3saJKq+yMUuWu+FhUVTNHn8o+65vCUCn/q56LoKLzw5NtK5yKtCTlpL
         pVGMfD/PJ5tjSovHzCENHPGfC9aEa22WgE/JuNa/WhPvY/zyb2IfBylC7mGJKYSPlf9A
         3WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gLM5Hpu6r2atWITweleRFx8OL+5iAWkmqkSSnMLBfds=;
        b=Whm3fMPL/YICb4FlT/edsN+5fqlPVkgZaOwnAc1MURPXPoCQo2tTcWAXtRiGTUB98k
         FJqlu2lPF2o43iP/CFwnx1qQjL6aEKxk+o6LvlnFq8fL/4nb9dEGK+0EmbWxCFm71K4B
         fSIRSBbJd6D3VgEuzZy0JvoJnbQJz6P+2IFOgRU02yJfbN67e71C43bax9vjr6WMDZnm
         mVy9LsWrXatJvbcrImU/RRkJx+jm5a//yW46CAS5WGEBNljnGpT5RwKCUY5Vb0Bg6fdC
         MaEcwmqQMj5J738MTgnD7eSg7cHCKC1HswafJrZVtT+T9QW9y5rZAH0r8TqTr7Dq8R0a
         hDYw==
X-Gm-Message-State: AOUpUlHkVxMHFUrcV7lP/mLtY3ebZCLXKe/YCLfwE07U4eRtS7E1+oBk
        +vkwKFvWbndFQqO+usIY0ti5k5gJLaxyYyRsys6DVQ==
X-Google-Smtp-Source: AA+uWPyyul2WkSkJEANefrr42/0kUY25o+t43YACeOP2ScdPGrpBLHZ44BVrwkaQwqi+uRB0Uk/2u4YXvxokhaW2a+E=
X-Received: by 2002:aca:abc6:: with SMTP id u189-v6mr14617479oie.61.1534780684914;
 Mon, 20 Aug 2018 08:58:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 08:58:04
 -0700 (PDT)
In-Reply-To: <1534540997-20094-1-git-send-email-texier.pj2@gmail.com>
References: <1534540997-20094-1-git-send-email-texier.pj2@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Aug 2018 12:58:04 -0300
Message-ID: <CAOMZO5BGN4182yz3VO9-iddqRWPsy8BA+y81Kgdybq0O36w1ww@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7s-warp: enable i2c3 device support
To:     Pierre-Jean Texier <texier.pj2@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 6:23 PM, Pierre-Jean Texier
<texier.pj2@gmail.com> wrote:
> The WaRP7 has one mikroBUS socket on the back to plug click boards.
> This patch allows to interact with some of these
> i2c modules (EEPROM, RTC and so on).
>
> Signed-off-by: Pierre-Jean Texier <texier.pj2@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
