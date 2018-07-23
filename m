Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80726ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3A520846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fODdWX/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3A520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbeGWIlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:41:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33467 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387951AbeGWIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:41:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so16030781ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aY34IsvVYaurREYhq32lRIHZHGs97UNXo+MzghRyGMI=;
        b=fODdWX/GsxYbyDQrfoy3zrLIxePswKHpB6Z7RUa6viKomg8aC4JxfSmRxjbGeqGx+5
         Q3wr1DLY/Wd0KmpkhSPAeLD+gHanttO+ocY84sGeRW55RE2x16pQjAby+GWsQdUNZW0o
         v/RCSR0lyINaaKVNT+rfsalJ23fsXlpX4lVwP155bNmu3E+WomRS95hKIwBa/Nohl7z/
         i96vlcLLI3kofmjQV/kvRNFx4NgA72SsTp73rQgetCJO3iYGAbaaWi+TqwwCWglZurO2
         mYUNEWsT0j7qi10S3Z7MQT5zr7N1eHMovDkFl6v+ByYq1rZbA9kvRAqTPhiA2YBpe9f5
         7PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aY34IsvVYaurREYhq32lRIHZHGs97UNXo+MzghRyGMI=;
        b=aajoQu2aUX6Dx+bFn9T7xqP1X5HQEekuegMfod4A3rZ3gGGNQKfBsXD/W3AUnWEOL1
         ZhGNb3JsUO6v53oBJMxCSzbv5ORUzLydoS4WZ470lKqwdHpDET8L1WtjoUAOyAJL1uFH
         QooOZlihoYboX2CAMU5O4cJXv/oqTid15FI4ae5dXdI+KG0Sl+KFT421Js3W6Uq9NKKw
         ycV2zXeXciZ7mDuIIQfUM8nsHKwOp4Lg2q1G6hjS/H+7KB6YcfM6cdwULfxykDqmXdcz
         fZjdujb0ZbWyaMnfYiScnkhGNzebfzFjJ7mp6o3+dfvKbQ1Q1JXRopLX42MBKoQbEDzX
         kLaw==
X-Gm-Message-State: AOUpUlGOvlJnEbgAomWUvub+lqjHMcv4DMDXr27VV0Rwrm19UcTjJ/R7
        yNaeSUtyXP/y4uOqs7bPc72RxilobixCdXTaHms=
X-Google-Smtp-Source: AAOMgpcehQZmsVCUq9xv8sNmfS6LnZEFJQUXwTbkoaADt9MjXUyr+ttzCqEk8bAnnzLIus6xRVIH4Y5zG+S4+ZMu1MQ=
X-Received: by 2002:a2e:93c9:: with SMTP id p9-v6mr7904093ljh.117.1532331686478;
 Mon, 23 Jul 2018 00:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180723072536.39240-1-yuleopen@gmail.com> <s5h8t621k9m.wl-tiwai@suse.de>
In-Reply-To: <s5h8t621k9m.wl-tiwai@suse.de>
From:   Yue Wang <yuleopen@gmail.com>
Date:   Mon, 23 Jul 2018 00:41:15 -0700
Message-ID: <CA+C1juadkNrQ+jcA6BP=FmoVfjxgQBW=m=Gv8htDMC=RzPihvA@mail.gmail.com>
Subject: Re: [PATCH] alsa/usb-audio: Topping DX7s quirk for DSD interface
To:     tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        kai.heng.feng@canonical.com, albaguirre@gmail.com,
        nob77413@gmail.com, ruslan.bilovol@gmail.com, perex@perex.cz,
        jussi@sonarnerd.net, daniel@zonque.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi

My apologies, it's my first time sending a patch to the kernel, so
there're quite a few things I need to improve.

This patch adds the support for native DSD for Topping DX7s DAC. The
product description is on
http://en.tpdz.net/products_detail/productId=32.html and it's
available on https://www.amazon.com/Balanced-Headphone-Amplifier-Topping-2ES9038Q2M/dp/B07B4VFS21

The DAC uses XMOS chip but uses a special vendor id and product id.
The patch will enable the SNDRV_PCM_FMTBIT_DSD_U32_BE bit for the DAC
hence enable native DSD playback up to DSD512 format.

Thanks again.

Yue
On Mon, Jul 23, 2018 at 12:30 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 23 Jul 2018 09:25:34 +0200,
> <yuleopen@gmail.com> wrote:
> >
> > From: Yue Wang <yuleopen@gmail.com>
> >
> > Signed-off-by: Yue Wang <yuleopen@gmail.com>
>
> Please give more explanation.
> No commit message already indicates that something is very wrong, no
> matter what the change is.
>
>
> thanks,
>
> Takashi
