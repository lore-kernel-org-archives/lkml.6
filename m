Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E440CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F423214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6NGFoXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F423214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeHVQUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:20:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32818 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbeHVQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:20:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so2967224oip.0;
        Wed, 22 Aug 2018 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I4YZG3Xtkd38QWhrDv7bnephzGbsO4l31Ufiy++9zWE=;
        b=X6NGFoXDKw3gmgf7vJ7X7vDRe+WQyjVLDwVcKVJSPHRjiXg4SvBM/R7BSvwPXnj07w
         uV+CQAPJOLLhDllOxBjTjlPgkZG4qwcl+icKF8FNAmmeSO4PXugUIFpKUdmGANQgaBIF
         2XeYe1QK+WFlAm542K2oEqJiPVStobx1k1WbfrMmaifMZb5DRWpTUfKCc6aD9r8oL84s
         4ygMpJ865por0MR7bElghshFoIK7LoujBVP+7qAsRu+skJK5PZdkwGAN2u59aWiR5MFI
         PsPSE0+PSlYqA9OgVKekxNxJZZyRT0aVbWD44L8QA/VLF1lNlwMIR7IDdV5QZCyZBYBP
         6KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I4YZG3Xtkd38QWhrDv7bnephzGbsO4l31Ufiy++9zWE=;
        b=psqTHas+CgHZAWRIH+ku78NcbuEjBA+o/a/zkhMc0kCCs4V902D1inT/irfE4hXj9F
         ew7tTBz0xXi81gozWoGnYM4Xn2kSYanw0B8mPAMk8p8thImBu4BeIhmqzzA/o8jIVcyK
         eRE6fE/qnZ7gSEfqfdx/2gsmOB5ZWKpzVUn+4L0gmd3YvPiGadIoYXWy8qYIcHQujmNW
         b4hw90ANLMeR8kJfmCMX48l86azpFDMsA1bpmvWwJz83MsZLZPwhu4psVoYLYZAeE4vC
         13skG1ktls8ud8yVst4JaG0Xb9lfZzfSh9Bd6WQ3hGiGtnuBa3H4mB5UENSf18DSYelY
         NhWA==
X-Gm-Message-State: APzg51C+ZEgzE0IBriaJmZv1uk9ulb5G67OvJtDMGVWwtGUqmfEmtapm
        xN4zrIIdTa4hwTWEflYiPmaz1w09N2UxJqNAbx4=
X-Google-Smtp-Source: ANB0VdY1K8JTEEF2QvGkS+pJ0Vx3lHVGk86eeoNclRzDyaQfyKd+k9TGEkW9FbJpswMBzcgaJPnGLsTl7PFQsTDwt0s=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr4048271oig.295.1534942517906;
 Wed, 22 Aug 2018 05:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 05:55:17
 -0700 (PDT)
In-Reply-To: <20180822063005.535lytz7hl32rsha@katana>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-6-wsa+renesas@sang-engineering.com> <CAOMZO5AkVNiYMGdED9erL=YMaKcmtS5BzZxw2gO1KLXEaPnD7A@mail.gmail.com>
 <20180822063005.535lytz7hl32rsha@katana>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 22 Aug 2018 09:55:17 -0300
Message-ID: <CAOMZO5BiAyDMSR=2Y-4-1ftNuVtRS59sSJd_cdFmzX=0kgF0Bw@mail.gmail.com>
Subject: Re: [PATCH 05/11] can: rcar: use SPDX identifier for Renesas drivers
To:     Wolfram Sang <wsa@the-dreams.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 3:30 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>>
>> According to Documentation/process/license-rules.rst the format should
>> be like this instead:
>>
>> // SPDX-License-Identifier: GPL-2.0+
>
> According to https://spdx.org/licenses/ it should be what I did above.

Previous advice I saw was to follow the format described in
Documentation/process/license-rules.rst

Greg/Philippe,

Any inputs on this matter?

Thanks
