Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE875C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8602088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8602088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJGPcF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 11:32:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42194 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeJGPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 11:32:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id e126so3776352vsc.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 01:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tAH3oU8DzZf2Yt28VRobDQAHezGYoFE58HpVRwFCDVM=;
        b=qEyBXRFXTsTsgioNJ8LfAJrZRoA4GveRIFu8SNdWeEGRVp+yhwO8xuv/e0R3SBEMSB
         5pWt08s5y0BqE03fOV4+y9pPNH0syHBcUCpeAxyNNbDk1WiKGqOZ2ronMyttIKYJ9U2C
         sMGKamIjPDfw7PaZl8ZYQT+B2eWAJ7BD049LzuWlt4dKNGY/efpJzMH6OaHpGNVgAC31
         AR5wwft9IHDjs4S8dUa71kasw5CZad9m8aE8P+02qube+3qXVRZAeshh84u107QIVQB6
         BxxjEOb5sFmtDFW8MDromoJA6sJKtX6ahup3OBiXPKSg1wq/50T4u489ny3tyDv70Y5n
         UjRA==
X-Gm-Message-State: ABuFfoiQx5pu9KSlCQVXLFfPUnzWhr3ZM6sommGZOkyx7HFtMPybMyoI
        HtWKZ3LU3VeSXv/7Va4hpQI4NPAqTIBHDNzJhHIqaQ==
X-Google-Smtp-Source: ACcGV61TZ8rkjD+Jo18bXvwQI0R1TXhp/EE1Dmn1k4u24giPlAgPlb1AmBijxfXh0W4kJeHFiWTTeeyPjm9432xZ1z0=
X-Received: by 2002:a67:d69e:: with SMTP id o30mr4585466vsj.11.1538900734661;
 Sun, 07 Oct 2018 01:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <1538861738.4088.5.camel@HansenPartnership.com> <1538861799.4088.6.camel@HansenPartnership.com>
In-Reply-To: <1538861799.4088.6.camel@HansenPartnership.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 7 Oct 2018 10:25:22 +0200
Message-ID: <CAMuHMdWVVR_-r4K_sx-P+gDWwQ4yS7fAhA=FnL=snqxhd8J7dg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for your patch!

On Sat, Oct 6, 2018 at 11:36 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Sat, 6 Oct 2018 14:21:56 -0700
> Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting email
>  addresses
>
> The current code of conduct has an ambiguity in the it considers publishing

that

> private information such as email addresses unacceptable behaviour.  Since
> the Linux kernel collects and publishes email addresses as part of the patch
> process, add an exception clause for email addresses ordinarily collected by
> the project to correct this ambiguity.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants include:
>  * Trolling, insulting/derogatory comments, and personal or political attacks
>  * Public or private harassment
>  * Publishing others’ private information, such as a physical or electronic
> -  address, without explicit permission
> +  address not ordinarily collected by the project, without explicit permission
>  * Other conduct which could reasonably be considered inappropriate in a
>    professional setting

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
