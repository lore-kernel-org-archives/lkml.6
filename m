Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F3BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C69208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VDrXUGKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C69208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbeKOIjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:39:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43863 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeKOIjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:39:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id j202-v6so15066585oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNkHQSVM1FmHKqDWui9ob9lw7nXULjopGvZfUEoQvRM=;
        b=VDrXUGKQVqX9NPzs2AsBoORnBbr3hWIdBwJyLf3K3hTettTLT4qLkqAIALtxpBXAyo
         pDbqOQUWjf1fwfEM4viACFA4Fd0Pq68jczFq7a0P8kWUgBNX9h/gysxnxkYD5XtO8y/o
         qoQwhLY7IK36ZELdObsg6lveUIiXyK6EhNWuUS5XH/hSByy1mne5fOz9X4Q1f0H5ipYw
         hjBDoTncqvZkLhqXoGXXH1aIzaIIoz2Tsos3D187fS0h5lpr2C2erYrd1JK4RUjO4u2e
         tCV3t3CHcj1CX/XfCdYKe6FhZ8T/0BuXOSgfh2nVaS02pn13VKj+egD8xBS0rvN76E/Y
         GCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNkHQSVM1FmHKqDWui9ob9lw7nXULjopGvZfUEoQvRM=;
        b=kzOAPKtRu05SnMgahT9Of/v/nZ8QpWDS3NKFBgGuDt+QS5gl79TQwsFBJDPXCcckk7
         mdaPAtARLVHH0xxfA80f3T2/KJyikC3hEfhqHnTvi6UvF66vhHbuIexWZlyW1hNJIqXL
         f0INRVvlAJoW1vCvXCjoMhj4P6Wf33Id4Pk4pa4HdVS5s32pElVexU/Ytgvfo2FcdxQt
         lN4AXElaI0wUCbeBIuuH7weODtt4TuEAPeNL8eFyfd66429yr3H0dQiTDr+84EO4AQu9
         FwPvhnYBo9fFkczsd/IEkbgojF0ZQM59KKV5hxxYmFu4PuqdY8M4xInSBAktbaLkSESj
         kUjg==
X-Gm-Message-State: AGRZ1gLqg3rhW8hl+Q9qm6o0nuZZo3ILPsZyyWUMSaE7fBxOjNxAe6eZ
        dNAml7DrvsAzw3JnozEyEzn+UN8oDSyOnx5TXM7ioQ==
X-Google-Smtp-Source: AJdET5eAG+aN0YNNTHzisXGnrp/yvKvCwk/TcjK8HtlWWJdz6LOghYeBVH7KmRb8l6bXDWaPVQ5iwiX5+K2s+s8Qnzg=
X-Received: by 2002:aca:bdc1:: with SMTP id n184-v6mr2279697oif.321.1542234843198;
 Wed, 14 Nov 2018 14:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 14 Nov 2018 23:33:52 +0100
Message-ID: <CAFBinCDUYwDn8e4wOKzRCeKMgE0Ey8e_RhmPKim60sbrHBq_Xw@mail.gmail.com>
Subject: Re: [PATCH 0/2] clocksource/meson6_timer: implement ARM delay timer
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Hi Thomas,

On Sun, Oct 28, 2018 at 1:55 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> While trying to add support for the ARM TWD Timer and the ARM Global
> Timer on Meson8, Meson8b and Meson8m2 (ARM Cortex-A5 and Cortex-A9 SoCs)
> I did a review of the existing driver.
> Unfortunately I found it hard to review because the pre-processor
> #defines did not match the names from the public S805 datasheet. Thus
> patch #1 adjusts these. No functional changes here, this is just
> preparation work for patch #2.
>
> Using the ARM Global Timer (drivers/clocksource/arm_global_timer.c)
> would have given us a timer-based delay implementation (so udelay() and
> friends would use the timer instead of using a loop-based delay
> implementation). Unfortunately we can't use the ARM Global Timer yet
> because it's input clock is derived from the CPU clock (which can change
> once we enable CPU frequency scaling on these SoCs, for which I will be
> sending patches in the near future).
> Amlogic's 3.10 kernel uses Timer E as delay timer which (with the
> current configuration) has a resolution of 1us. So patch #2 uses
> register_current_timer_delay() to register Timer E as ARM delay timer
> (which will be especially useful as we have to use udelay() when
> changing the CPU clocks during DVFS).
>
>
> Martin Blumenstingl (2):
>   clocksource: meson6_timer: use register names from the datasheet
>   clocksource: meson6_timer: implement ARM delay timer
(gentle ping) can you please queue these two patches for v4.21?
if not: please let me know what I can improve, then I'll fix that and send a v2


thank you!
Regards
Martin
