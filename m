Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECD221473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vfYXoioL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECD221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeJFGh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeJFGh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:37:28 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A29902147C;
        Fri,  5 Oct 2018 23:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538782589;
        bh=aqMFIdyTeV1767+9gTuv9gezKvMfSjBHgc/hdUtMveU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vfYXoioL/IOJZLUbq1BxmTgIg1b8v2qrg1pMaJuGrPZFrWdN9ErOBhX8V243dRb4X
         fk36G6kjjxi4N+5SvwDo6zcvC1XWB6gyYqiqdRi85Mh0ECUY8BprApRVmm5m4WG0Os
         SrVf34rl9o3DxKMI+EUSUCc0j7p6zIQBLAlhwH84=
Received: by mail-qt1-f172.google.com with SMTP id d8-v6so15568663qtk.13;
        Fri, 05 Oct 2018 16:36:29 -0700 (PDT)
X-Gm-Message-State: ABuFfohNwUiZEAhu7bQW5QavFfrI8pAi76zgqGAJUNXfWMc72Wm6Oy5t
        rAkPZeMopDJIiyuO5oPlvJeMxYK8yL4S6PB4Og==
X-Google-Smtp-Source: ACcGV62VFMhbwnUifoyIaDmqfgz2PiDP9zN87wHeG1wmofoje728hI4bK+93kHF9L/pjttxfl1eRO8xZPWE8pxcK2iM=
X-Received: by 2002:a0c:8c86:: with SMTP id p6-v6mr11319328qvb.246.1538782588825;
 Fri, 05 Oct 2018 16:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-34-robh@kernel.org>
 <1538777991.28477.6.camel@toradex.com>
In-Reply-To: <1538777991.28477.6.camel@toradex.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 5 Oct 2018 18:36:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pV6HMs25JxFKwfX7_Cj1z2vT1eGWvqPzx7+Wu3-SPeQ@mail.gmail.com>
Message-ID: <CAL_Jsq+pV6HMs25JxFKwfX7_Cj1z2vT1eGWvqPzx7+Wu3-SPeQ@mail.gmail.com>
Subject: Re: [PATCH 33/36] dt-bindings: arm: Convert Tegra board/soc bindings
 to json-schema
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Jon Hunter <jonathanh@nvidia.com>,
        Grant Likely <glikely@secretlab.ca>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tom Rini <trini@konsulko.com>, Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kumar Gala <kumar.gala@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 5:20 PM Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
>
> Hi Rob
>
> On Fri, 2018-10-05 at 11:58 -0500, Rob Herring wrote:
> > Convert Tegra SoC bindings to DT schema format using json-schema.
> >

[...]

> Are you aware that -next already features a few updating commits
> thereof from around the beginning of September one of which even bears
> your reviewed-by.

I'm not targeting 4.20, but rather early in the 4.21 cycle. So I'll be
rebasing on rc1 and will update with any changes. I've been doing that
a couple of cycles already.

Rob
