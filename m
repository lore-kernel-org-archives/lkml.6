Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB49FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9565A20891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jj6kPTEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9565A20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeGZKbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:31:49 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34895 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeGZKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:31:48 -0400
Received: by mail-it0-f67.google.com with SMTP id q20-v6so1744113ith.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xI3oIN+spMs9Km7bR//dys3btu2eFjz6BLj3q2HDA24=;
        b=jj6kPTEOFj3c/bLJMRx3nhB1V0phd3RLBMgnYHmBFu//N0NjSdJq5MXbL6cYTpJjuZ
         pt3eNji+w2+rVhC9lZX4v2ZP8JNuO1EaHBfIKAwzE422CQIgC9c6/a7m58xjP6ZCKKle
         YBDpR7+ODGPfk5GNLRFcqxD1R0GY1qmToew/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xI3oIN+spMs9Km7bR//dys3btu2eFjz6BLj3q2HDA24=;
        b=flWuGS44f8RBp0rxkwhAEwxGQAjcjdsChh1bgkPCj5uBvDXz1toXBiiH5kUPHD7SUx
         KwUVP49MYzXAjLDt3VFhCW1s45P4ZzQ5fQljG4tgTul/4mjwcsw8dBDQltw+OyJrpxGv
         MUHLHA/lRWBD7PMnVdM8JqKRW7o3r529PhqGGbJdRtker3wu7dEYS6ijS1RwCiZ3X5Ts
         5p9EqN7llWxWCu99Iwzqdgau4O9Tj02/DFWnwDPSEr9BIULQ3iL2rogICyOcsgTnI8zJ
         SBN40u+I5Wvo1sXaN7597dGqdI/JEI/PawzFkPN1wUUCSfrIVCDb73jFo9H6Ph5tY1e2
         Uqvw==
X-Gm-Message-State: AOUpUlFerrn4y2R9oOwY2Ihgmdh0CKIwHjEXB2b1UbK9yGeFgh4LYYAu
        jK6utFWFcxbPQTCr9HwsQAeP4gtRmOfK0apeQhudIg==
X-Google-Smtp-Source: AAOMgpeUyMIEoy4z46MoGmtzneDxGEyeYv/ndQ/n3sXkd4v8epbXys9dMoWu0UijD/gA9vCpXWobnbnbTonNL2B8FcY=
X-Received: by 2002:a02:35a:: with SMTP id y87-v6mr1068114jad.2.1532596552943;
 Thu, 26 Jul 2018 02:15:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 02:15:52
 -0700 (PDT)
In-Reply-To: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de>
References: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 26 Jul 2018 11:15:52 +0200
Message-ID: <CAKv+Gu_+t_VwY3xDq3nWbnOTfzBc6OtQeRD2GKsseO2uK-uruw@mail.gmail.com>
Subject: Re: [PATCH RT] rtc: Disable RTC_DRV_EFI on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 July 2018 at 11:04, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Based on measurements the EFI functions get_variable /
> get_next_variable take up to 2us. The functions get_time, set_time take
> around 10ms. Those 10ms are too much. Even one ms would be too much.

You cannot extrapolate from these numbers. If the lack of worst case
guarantees on an EFI system is a problem for -rt, the only meaningful
course of action is to disable EFI runtime services entirely.

I think SetVariable() may be even worse than GetTime(), given that NOR
flash updates may involve erasing blocks.

> The funny part is that EFI is invoked with enabled interrupts.
> According to my tracing I see the interrupt almost 10ms later which
> indicates that EFI is disabling interrupts while doing its thing.
>

Yes, and this is also highly implementation specific. Basing this kind
of policy on a single implementation is not very wise imo.

> This was observed on "EFI v2.60 by SoftIron Overdrive 1000". I don't say
> that every EFI implementation does this but given that it has to access a
> slow bus like I2C/SPI it is expected.
>
> Disable EFI's RTC driver on RT.
>

Other calls to GetTime() would still be permitted in this case, so
this seems like a partial solution (although no other calls seem to
exist atm)

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/rtc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index a2ba5db36145..248d72711650 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1087,7 +1087,7 @@ config RTC_DRV_DA9063
>
>  config RTC_DRV_EFI
>         tristate "EFI RTC"
> -       depends on EFI && !X86
> +       depends on EFI && !X86 && !PREEMPT_RT_BASE
>         help
>           If you say yes here you will get support for the EFI
>           Real Time Clock.
> --
> 2.18.0
>
