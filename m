Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D9220851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmmD5pxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D9220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeKTULB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:11:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51159 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbeKTULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:11:01 -0500
Received: by mail-it1-f194.google.com with SMTP id a185so2437311itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O5Ja5dS345107RVffBAhnkzkphy8+mvv7zT2CwLw4zQ=;
        b=ZmmD5pxxkmTk358RidHs32KKHp+S7TT12qjp4BRt/2hRikbvZE9vjJA22fSIeGM9Om
         RrXvBx8Sm18C/mv4GdKl4wSfVsYAOAFA7WP11pm/w+6CGpIV1lF+VdEQGCArJdZlpgPt
         Eb2Ijc89WBmiyxhnGj1/hKNkN8YLPkwMrCBts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O5Ja5dS345107RVffBAhnkzkphy8+mvv7zT2CwLw4zQ=;
        b=fwUxKixpP7A5HLE/sp4ZAE9FBrd3bHxj9+kXeKT/lXF2br3zSe798U8nMMGejTWgRS
         YqnLWLfMmdhkoo+xq3dJgyJMEQx9/W3QpKFWrpTJHXLWA87iNjAcrNL7XJvuEF9ujEmx
         qIscM9lnbocQCTseDAdwuG2DinQbxV72G7f49EvFZrz3EmZOKzC8t5iiJSle8NUwrRoz
         JL8/IP6lZpC/Qht8O8dWMbmgVqoawH4t4X510r1O//kSnI/PXhlwXGHEBWgnbt9hKnlL
         dfthU8va/bypzW+wQnAc74qpaTyneOMW/boIxaD1zKJDXM5sFm8LQWj0qZ5InhssIck4
         W0MQ==
X-Gm-Message-State: AGRZ1gKbCQCVObolEGapBOJiy/wB+RC34khz2HLd2v0wkkUZCRAGow/d
        OkW2Sb7uEN1tOPldRBQOVkP1c71RphGR4FcEKJBVH/DNaWo=
X-Google-Smtp-Source: AJdET5dUrQ8bmChp+yE/wGLlyv0dR+TKNLCW6DljSTQqMYa1dzvbDmP1udPEzyYWMvDMQFbdZxyOjXK+d3viyGxqsJY=
X-Received: by 2002:a24:d4:: with SMTP id 203-v6mr1475002ita.26.1542706967991;
 Tue, 20 Nov 2018 01:42:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 01:42:07
 -0800 (PST)
In-Reply-To: <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com> <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Nov 2018 10:42:07 +0100
Message-ID: <CAPDyKFpLTEwrBagJrd98Zyrd_pwJa9Zkgsi+geZainQV+OgpOQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: mmci: send stop command if sbc error issue
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 November 2018 at 10:30, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> Refer to "4.15 set block count command" of sd specification:
> Host needs to issue CMD12 if any error is detected in
> the CMD18 and CMD25 operations.
>
> In sbc case, the data->stop is fill by framework.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 82bab35..13fa640 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1190,11 +1190,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                         /* The error clause is handled above, success! */
>                         data->bytes_xfered = data->blksz * data->blocks;
>
> -               if (!data->stop || host->mrq->sbc) {
> +               if (!data->stop || (host->mrq->sbc && !data->error))
>                         mmci_request_end(host, data->mrq);
> -               } else {
> +               else
>                         mmci_start_command(host, data->stop, 0);

This looks correct to me!

Although, just wanted to double check that you tested this for a case
where we have host->mrq->sbc set and got an error in data->error? I
guess it can be tricky, so I was thinking of manually trying to
instruct the code, to set an error in data->error, at some point to
trigger this code. That would at least give us some confidence that it
works as expected.

Thoughts?

> -               }
>         }
>  }
>
> --
> 2.7.4
>

Kind regards
Uffe
