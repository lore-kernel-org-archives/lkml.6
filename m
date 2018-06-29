Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC76C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EF924CD7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvgrxAR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EF924CD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936602AbeF2WZj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 18:25:39 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40717 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934713AbeF2WZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 18:25:37 -0400
Received: by mail-ua0-f193.google.com with SMTP id j17-v6so6714563uap.7;
        Fri, 29 Jun 2018 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6Wg8t/qoD4PK8F4QTkR4CiA3U6ljeRXRe23jgh6pAfo=;
        b=PvgrxAR8JooSNzj+qz/ZrF8oVpthlgc3hqgVqP8Y4i1Z+oqyVjVH9c/qf02UhiskGq
         sMpEWk3yiGl9f87yzCpwkGjphJuZmp0z7qlstCXy+M96NoexGiKt8uhWyo5S7VyBsst8
         f8/awLySOCUgJadflaorbf+7TDgdbDNa/PY+0RxNdRER4kxcuwuFYvLVSm4xehwlPPwu
         UIsEWQXghTFJd5MMcSlfzU2LE3rNAQfWKKyN+eJJ/7tfUmqHjYymThYSdgMKnHe+SFLi
         TxoWufdW7WRaLobB+pzYlfwCpn8coe38jSuWWfH7btMDqkxyLCJur1lGrwckDSds5ipa
         5R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6Wg8t/qoD4PK8F4QTkR4CiA3U6ljeRXRe23jgh6pAfo=;
        b=qb2OvGy9cW6G++1sha/N3JDjA8r9T/4ffS3bl8fhco+/HCafAkoBKKraUc5Bew0Pzt
         dSril1lYnXPYUOTaF2VI++DH7rKgNKjbxkEiIPfbU1VJY9necNaJo7cxrptsU2s9IdFq
         GE0srMseQHiTI1M71hHNxy960E8y2wSBWctbSB5tEB+SaWQs6rPfaAfKgCQWVVcE6oYz
         PxXMdcAbKTLXT2jVHSFe/yR6h5HLKGPlg4YMPo/Q28S7GNrmDDM81Q2JqVlDEVBUcnPs
         T7SmnkVas3y7wx60rVVxZqAfIBHo5WoySxlsD8QY62c8MV1IW6Q6DUU9aBnoAGVfVBlX
         Sq2w==
X-Gm-Message-State: APt69E2eICxUnVtFmZ3+uiBBf63YWDtbT5tiR8wzUT3ylKrpfoXkafIN
        AIF2PCyrQYbuYI0uOcA3f8hyaykMRdS+abB6tmM=
X-Google-Smtp-Source: AAOMgpc78bE/nLF3Jl0fTMSGBDPB0otTZ28jgtmCGppBEE4HvGbl8o26Wk73IX8BuqmPa6m9tPehxhpJ8xPfgfs7lnI=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr10417312uai.47.1530311137011;
 Fri, 29 Jun 2018 15:25:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 15:25:36
 -0700 (PDT)
In-Reply-To: <20180628204344.13973-2-robh@kernel.org>
References: <20180628204344.13973-1-robh@kernel.org> <20180628204344.13973-2-robh@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jun 2018 01:25:36 +0300
Message-ID: <CAHp75Vf+o7aA8M6T+zM5r8i_YCzWkP=rO8sTHY0qtz-YjVRibA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] driver core: allow stopping deferred probe after init
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        boot-architecture@lists.linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:43 PM, Rob Herring <robh@kernel.org> wrote:
> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version. Deferred
> probe issues can be difficult to debug especially if the console has
> dependencies or userspace fails to boot to a shell.
>
> There are also cases like IOMMUs where only built-in drivers are
> supported, so deferring probe after initcalls is not needed. The IOMMU
> subsystem implemented its own mechanism to handle this using OF_DECLARE
> linker sections.
>
> This commit adds makes ending deferred probe conditional on initcalls
> being completed or a debug timeout. Subsystems or drivers may opt-in by
> calling driver_deferred_probe_check_init_done() instead of
> unconditionally returning -EPROBE_DEFER. They may use additional
> information from DT or kernel's config to decide whether to continue to
> defer probe or not.
>
> The timeout mechanism is intended for debug purposes and WARNs loudly.

> The remaining deferred probe pending list will also be dumped after the
> timeout. Not that this timeout won't work for the console which needs
> to be enabled before userspace starts. However, if the console's
> dependencies are resolved, then the kernel log will be printed (as
> opposed to no output).

There is another patch flying around with debugfs node to dump a list
of deferred probe queue.
I dunno if it makes sense to dump it here and there and if yes, some
unification in output, perhaps?

> +       deferred_probe_timeout = simple_strtol(str, NULL, 0);

Hmm... I don't think 16-base or 8-base values are useful to support.
One subtle difference that people usually consider timeout values as
10-base and if at some point someone makes it as 0100 (no matter why),
it would be much less than expected.
08 wouldn't parsed at all.

> +       if (deferred_probe_timeout > 0) {

Would it be harmful / useful if we skip this check and run the work immediately?

> +               schedule_delayed_work(&deferred_probe_timeout_work,
> +                       deferred_probe_timeout * HZ);
> +       }


-- 
With Best Regards,
Andy Shevchenko
