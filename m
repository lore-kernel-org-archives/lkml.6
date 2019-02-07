Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0990FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD0A2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CeQbYfBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBGIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:25:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40339 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBGIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:25:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25-v6so2012497ljk.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 00:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6/lKpV3+v9G3+Mh9w0wiZ4j0lKH+/UyTxJvhAJZxco=;
        b=CeQbYfBkEdTpeHwvLnu/o/B+0iu39vicAT+3YrDdjbbM0jxDQtfS91yZaYfCR2eeek
         qsWcOLRanfeH0NyUxRnj8WkXP9H89fDDKuolKagQf4q0PoSDpvo6LgoErQAMI3YnB9Lx
         dWtBtzSeDls8PWbF5OtvVm0WpABvGByb334VjRPffJly7xkmi1XXImB85uNJoj6mPCBW
         36ZeljiOf84Nea2Vus7D0vSfKY2+1f/lYv4/5WnIUHEMee213TK3tr83qqWijihO36zn
         1OyDc7v9y7HASRHySD62YPbldK6W3w7469O8QcrloETVUTONzrkB6kUErA8ikNU9Ak8H
         0CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6/lKpV3+v9G3+Mh9w0wiZ4j0lKH+/UyTxJvhAJZxco=;
        b=tp1CUrA8g8uAluz96iGjAEh+z7zquybRpzXx29whaPYce2LHmrDVE3T4nFO2dISeki
         wabsxoJ+UwfPToJaOSh0DcDOiSUIJeIUV+4PumPpUnyyz6Iih6dkh0mISvUyxCodOxiE
         IuW++QnfLXoxVd5/OoKF+vIYkf0NeXy2ep3n+AEHdSzpHXAiCQblCVf34pYPcWNxCD6o
         owCCHt4R/IbDgHXiCWmELvWca/sZxc/Y1Bo+uOoTgYgDA73P26UlOhtCVtyqH8B456Su
         iMcTRmHWggIYoTNlZG9r9RzxhSyvoBVVlfVeFJvpO/sXCBw7oA5YUqQZzCc/TMjD2zv/
         kZtA==
X-Gm-Message-State: AHQUAuZJ9GnOee3KAdoGUVnkIdKC2D5ujmeXV72ZvUMJ/UGfP67grzcR
        EdNkthNydBY+7JzcLKBIgfpOztLqnEUSK/nkCU9zrg==
X-Google-Smtp-Source: AHgI3IYNIugm2w6XQs5O6e+b5Dm0yGoHgbOdBoGr3YuszTCQKBeElQMDWPOP/s+MIvq2R5cZSWeHHQo4cMk1LD1t6d0=
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr9069175lji.57.1549527914653;
 Thu, 07 Feb 2019 00:25:14 -0800 (PST)
MIME-Version: 1.0
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com> <20190206124442.GG21676@ulmo>
In-Reply-To: <20190206124442.GG21676@ulmo>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 7 Feb 2019 13:54:37 +0530
Message-ID: <CAJ2_jOFsyRR8tLpS6C_h1mkWh6WJjN6qFgDoSqKJGjhBieM3NQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 6:14 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
> [...]
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> [...]
> > +static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
> > +                                 unsigned long rate)
> > +{
> > +     /* (1 << (16+scale)) * 10^9/rate = real_period */
> > +     unsigned long scale_pow =
> > +                     (pwm->approx_period * (u64)rate) / NSEC_PER_SEC;
>
> I think you need another div64_ul() for this one to fix the linker error
> that the 0-day builder was pointing out.

Yes, will fix this. Thanks for pointing it out.

>
> Thierry
