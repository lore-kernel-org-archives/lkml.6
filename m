Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182AC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E66B21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gT2FkW59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E66B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeK3Jm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:42:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39353 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeK3Jm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:42:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id g27so3356195oth.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DukSES9nIA+KfDf1puvdV4R2vgz+jX9tXlxVkF6zqxo=;
        b=gT2FkW59EHxkCZKEKap8F+hiAzyJB+ffyvRdL9yFZP+wO1IDxZJgGR3pLPogbHbzhJ
         L9wtxQY4+2GjwPHv5kHLW25KgtQsgRmhDtxnz571IHBRpj4WHNLwXsCmvfkjzvoV9zvJ
         5oDQBR7hx2iCkMvEnts0h4qGspDE1pW6u/wFoMptcOZptPD2H+cd39hsJ43Z4JNZcsfy
         kmOtAkvDaM8McWdqgaaDFPlnJxe8+nC2dEb31hKCwkignpO8LdVSaXsZTvfxsuUjxao2
         fwPzrWZkVJ3Us3cfzMBshgzwQF7gaatNncX0FV1bC5rv4SVAruIVFW7Gru9qDLkXyGhf
         z6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DukSES9nIA+KfDf1puvdV4R2vgz+jX9tXlxVkF6zqxo=;
        b=t2qt3OIePPeHhWKVOGreymRtHyeouJyOQjzzLG9+633b32Cq5Zi46gsiTNxb3qG/cR
         U6Nm4UDDccCcm1ITOrAtZmDbP7ZkJ1XVxhQsdS7Qot9wzg7FRsbfT6UHZPgGLzPg56J5
         EwebteahdZXvCDfMXZb/iEPMVzfb3qVOeFZR6JHP6bWY2tcwF7rWyqvCiavvXZ3jKDEG
         DI/QTKBYez3gQTvVj9v+7pLPEYxOeUlLHv6+UDpqXj4heVPWLBdR9zhC3X8M1kltDwbn
         YfdLjPqYcwgDWwz5PCytdnLnR7YfYhA802tcqL/ORaPAKuFJTnQ7zMyqNqnRQN7so7sm
         2SiA==
X-Gm-Message-State: AA+aEWYvYyx2sL+u8K/B1bo3AVSCgkfcCey0Rv3GVvWaR2skQ6XGmOcR
        Q3o81b1gCyRY2BFamgnImOq1mG3V8PK3+m+WdHs=
X-Google-Smtp-Source: AFSGD/Xk6GgdOlB724d5Nua9zRed9M7On2rBkIvPgxcmUTXP7vTmD2s8ZGTHYLNvqgtA3S146y97m0LJ0Ol7TZRoXPs=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr2208672otl.342.1543530952687;
 Thu, 29 Nov 2018 14:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com> <7hh8g0d8tg.fsf@baylibre.com>
In-Reply-To: <7hh8g0d8tg.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 29 Nov 2018 23:35:41 +0100
Message-ID: <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to built-in
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Thu, Nov 29, 2018 at 1:30 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
> > voltage supply of the CPU cores (this regulator is typically called
> > "VCCK").
> > Now that we are preparing support for CPU frequency scaling on Meson8,
> > Meson8b and Meson8m2 we should build the pwm-meson driver into the
> > kernel so we can configure the CPU voltage early in the boot process.
>
> Can you explain a little more why the configuration of CPU voltage
> cannot wait a bit so this could be properly probed?
I was under the impression that cpufreq-dt would still initialize even
if the regulator is not ready yet. however (after reading the code
again) this is clearly NOT the case.

there's still a benefit with this change: your Odroid-C1 in your
KernelCI lab would also be able to change the CPU frequency (so in
case something breaks we could spot it there).
will you accept this patch after I updated the description to mention
that it's for KernelCI test coverage?


Regards
Martin
