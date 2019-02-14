Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB75C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566B8222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQ/Obm2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393787AbfBNCBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:01:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44996 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfBNCBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:01:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id q128so3767373ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIVs/3U1xIoAZ/7FXZLgFeys0AzDq8ylDN1dFU4vUGc=;
        b=QQ/Obm2mx5TulPtrGzsyeVbXY8nGSnHseiko2rrub8MrUUoMyZ5dLH38TQ2ehSyWj3
         uCkuBNVRFQxB5rcDF+WrEzuH7cbIppPUK7JfMnfL4ocYwIU8Z+6u0Xwl9Ospqq4RHCAb
         9h2TERAGJh4oZlmaZ7eGf9TBzuYwP/XL96j9W7BJAsrlYqpJMWr0qYJsyMzktYjqIkev
         BYUgMYnVNA/9+C6IKIkUlK4m/7Bn6ZQrS3Oye4aSp+24kJ9+JKrPVL8TrwHNrCetGJI0
         R539y2WeNE6yh1LItWt/73t9aXQFH8CNiknwNByMmVGrHISedVFcdjBP6teoTI31TJl+
         m2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIVs/3U1xIoAZ/7FXZLgFeys0AzDq8ylDN1dFU4vUGc=;
        b=CckAVknRH3tfF/32uIaTUVcJmYAG5cr2bqrQggjmc3cT7bIjzjdXtUkKwLWuNraoVH
         0h7oTZQ3r5uadpNkV1VXAIs6locqjIyYHiUGQK2N2GTTwQENv58l0N3RUy1GlTihlzXv
         PN0vGI0iCDBUotw4VO7LRbr2024dCnDg+k7SUdMCSBxdf8WmGydt9eNka2ntFrbvzuqX
         alc11z5fxqKF4o5Sffb/fJnB22gvPRVf2jYjIbvALTdfmJI0QO1JW7+AcqjzuZjfYObr
         5fcb1SkAMFoaGDXyQopIRAZ0Id3i/ugTMVY2+M0QaqJviK8OxB4kFZr/pNHmP+UdKVU7
         mRfg==
X-Gm-Message-State: AHQUAuaK/HZuUKBAyWlel/yBIk1HKpUW2eRFXlevkoG8Nk/7wn1fRlqT
        YV4S52FyKp3i2LJ2o7eDR84zEJ2CM1rtc5OUWia4rw==
X-Google-Smtp-Source: AHgI3IZrygtCUmzMGJnDvTfRPewbFN4tHxZnc7/2bJafAXRh08ntJvtX0BA0yuhH17qcJxqPQnZQgZmPV0A15WdWbBk=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr700565ljc.97.1550109667919;
 Wed, 13 Feb 2019 18:01:07 -0800 (PST)
MIME-Version: 1.0
References: <3d1f18412a927f69c733b6ed31659b7770610442.1550062410.git.baolin.wang@linaro.org>
 <CAK8P3a1Ad+u9DHXkAe=p6pzCm0b24wvh8NH+Y3n6RRup7maBuA@mail.gmail.com>
In-Reply-To: <CAK8P3a1Ad+u9DHXkAe=p6pzCm0b24wvh8NH+Y3n6RRup7maBuA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 14 Feb 2019 10:00:56 +0800
Message-ID: <CAMz4kuKBym0A126Yo+=hQdZDb1U4ivO_g6YawxzLU-KjZdfbvg@mail.gmail.com>
Subject: Re: [PATCH] mfd: sc27xx: Use SoC compatible string for PMIC devices
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 22:28, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 13, 2019 at 1:57 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > We should use SoC compatible string in stead of wildcard string for
> > PMIC child devices.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Looks good. I had a look at arch/arm64/boot/dts/sprd/sc2731.dtsi
> as well, which contains lines such as
>
> compatible = "sprd,sc27xx-efuse", "sprd,sc2731-efuse";
>
> which fortunately work with both variants of the driver.
> Just to make sure we have the same understanding though:
>
> - Other drivers will leave out the 27xx part and just do
>   compatible = sprd,sc2732-efuse", "sprd,sc2731-efuse";
>
> - When you specific a generic name (such as the sc2731 part),
>   the more specific one (e.g. sc2732) needs to come /first/.
>   The current DT appears to have those mixed up.

Yes, that's the conclusion we made. And I've send patches to remove
the 27xx part in drivers. Thanks for your help.

-- 
Baolin Wang
Best Regards
