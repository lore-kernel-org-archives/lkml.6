Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A95C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C476D205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLU1nz2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C476D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeIEOKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:10:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51040 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeIEOKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:10:13 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so9035199ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rYq0Ns5WGGJalVHH4oW3meuf2mv7nKvVF0ltZc7tpuE=;
        b=DLU1nz2KNHACnqki/243K3MQtLEnxwD1tCrRyCpZQiUFrSD8STWJvMHYd4r9dw3xUP
         PnTrZvbFogUyRJlE/jLp+Yx4VPhVoN/NX/XisA4euim40F6OfP7CWQSwLgsqARTT+YNX
         U3txHwUHNwrO1+GKqASrMvD1W70R4GGFa0jJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rYq0Ns5WGGJalVHH4oW3meuf2mv7nKvVF0ltZc7tpuE=;
        b=Nqk1sXiQsngn3yR5mfexEQeADMOxb5AkYLVMEtWno1xLWsmjadA02HuMRZRGkeaxTq
         SpfAIAA5ytu86Pc+LnO44V1Azf9SJUkpa9r4f6VNLKWo8Q5VnTvcmbYtkAcVdRoh8CpI
         113n7QpnKEDgWnGv6B2aHa8X1uKRzjEAB/eW3IdizWo5EO72D49nYPipgLZDsHCD6H6c
         hFFm3g6/XRCFhiISqpDqa14V8Fnf5Li1LUxbVXZVTL4XyKUNHtzcy5UeiVhnEKLoejJF
         H+GVfmPvtM7UyA1xRewSVOGBqAPhwWe6j/FJ/86N4IobMedUZBFXFWd7Km9HBFLboAEy
         C9bA==
X-Gm-Message-State: APzg51DdKy+yIfJHzG5UEO7mXBlfPhSARumAOemOZQ0wSNezEN0NfnYc
        EPiHo41K5m4RWfVCdAu8i8Xth0u6R7alk/Bm97r4WQ==
X-Google-Smtp-Source: ANB0VdY4J/wRQqANXuNWPmqaF4t+S3Dz+XcxMz51TaOT1AE6y3nk5aCYjrsQ7jLTuz4PBLNG+uhPMgZgSxyF2OvPVqw=
X-Received: by 2002:a24:99c3:: with SMTP id a186-v6mr11035314ite.128.1536140449789;
 Wed, 05 Sep 2018 02:40:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 02:40:49 -0700 (PDT)
In-Reply-To: <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com> <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com> <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 5 Sep 2018 11:40:49 +0200
Message-ID: <CAKv+Gu8FK9K0G-GJygdpkwqKYzjvpDDj8TyGTC2u0SRxK3ez_w@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 September 2018 at 19:19, Scott Branden <scott.branden@broadcom.com> wrote:
>
> Rather than introduce EFI_ARMSTUB_DTB_LOADER, why not have
> the efistub use CONFIG_OF to determine whether it supports dtb= or not?
>
> That way ACPI-only distros disable devicetree support entirely.
>

Unfortunately, CONFIG_OF cannot be disabled on arm64 even on ACPI-only builds.
