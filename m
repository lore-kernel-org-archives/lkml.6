Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9C7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6C0218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+sahEKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfBLIkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:40:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34591 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfBLIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:40:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id u21so1357296lfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kapGc7eEnZJS2jJlq3PavBS0KtBWSH5wGVqr3Ma7PVk=;
        b=C+sahEKzHhNuyY3MtTs3y8VQ7S2IAG+/hRaY3fG2nsqyB5dn7ABC3WFOi8wStHv3yP
         Pqb3+RipqGW0NiCojzGsu/zOL8kzmgBWgF9cMKmMfkmfNWt0nBifx0dH7CMcxf7xlico
         sTy5S+AaQQw0gAmwC9lwp9N29VPzzGGTpNgbkXvVoAewBMpcYbjsTYl3XlwZZoPCDdPg
         L8QhyC0RKUkfyvs/u2CR9HhV5hCMkyAe86BUAj2zW4nYYOQUniI0kkO+nCzLgsMSj7E5
         3LEdyHf1rmtv5U2O9tCjhl3ekcEXHYj0r9etFfxK1baQfOEx7ukvTSmxASzu40aDxXYN
         DMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kapGc7eEnZJS2jJlq3PavBS0KtBWSH5wGVqr3Ma7PVk=;
        b=HxjX4BX8XFwdHSNyNPZGumweDMznZ9dTrUOfJ0tfp4jlTPCVvFLIRMMheZA7y85P68
         aCTuaHmtl2Je9FQhTtMVfELsg6X6WIfciQFOlhhIkM8iX0emVTYXxaQHqMVk7zkDrEOb
         FmgkbLY85cF9WdZUc+C7wVyLbNmXqyNzbgbUQ/i9KqiwrRsoi78lu21zdrErsQjVB2Do
         Ab49TfrjbB1jNBI1niE87In/EFO8W4l0SMjx35feNxcDKaR4k0w9ZZUPeWmc3DgTE1dY
         ZRz6iu4wd1CwA5XiSYjTH9RyEAqASQAwMOrA1TQl718L6w+S5S4iD2/M/U16SaK4eTev
         HIVA==
X-Gm-Message-State: AHQUAubS+ursbUiHhkjya2yHiIvaynezQuIo7tjuVye25Vq6Ex+GvDor
        EayO/kjmspa0MULpYk9xTxOlHkiFwS+JCZn+ikTKFw==
X-Google-Smtp-Source: AHgI3IZ8z4QC8e7jHotvOMuIrTXc2Rlv1WBYvpBmt3BX2+0iUCQ0UEorBo18AIH3L+tnGeYhYmjSxBCLqxlYBJLmmac=
X-Received: by 2002:ac2:42c5:: with SMTP id n5mr1603960lfl.115.1549960821979;
 Tue, 12 Feb 2019 00:40:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org> <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
 <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com> <20190201130519.GH20797@sirena.org.uk>
In-Reply-To: <20190201130519.GH20797@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 12 Feb 2019 16:40:10 +0800
Message-ID: <CAMz4kuJdPts31Ak-H=VAivvoqqPtxO5M1RdqrNPwTLT5d1h_7w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Sorry for late reply.

On Fri, 1 Feb 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Feb 01, 2019 at 08:05:30PM +0800, Baolin Wang wrote:
>
> > On Spreadtrum platform, we use one mfd driver [1] to populate the
> > SC27XX series PMICs including SC2731, SC2721, SC2720 and SC2730. So we
> > use sc27xx to be compatible with different PMICs' devices, otherwise
> > it will be difficult to define the mfd cell arrays in mfd driver. Do
> > you have any good suggestion? Thanks.
>
> You can just list all the individual device names in the of_match_table
> for the MFD and then it can bind to any of them.  You can always map
> them onto the same behaviour in the MFD driver if they are identical
> from a software point of view.

If I understood correctly, as you suggested, we should add new
mfd_cell groups to list all different PMICs' device names. Something
like:

static const struct mfd_cell sprd_pmic_sc2731_devs[] = {
{
.name = "sc27xx-wdt",
.of_compatible = "sprd,sc2731-wdt",
}, {
.name = "sc27xx-rtc",
.of_compatible = "sprd,sc2731-rtc",
}, {
.name = "sc27xx-charger",
.of_compatible = "sprd,sc2731-charger",
},  {
.name = "sc27xx-fast-chg",
.of_compatible = "sprd,sc2731-fast-chg",
}, {
.name = "sc27xx-typec",
.of_compatible = "sprd,sc2731-typec",
}, {
.name = "sc27xx-eic",
.of_compatible = "sprd,sc2731-eic",
},

.......

};

static const struct mfd_cell sprd_pmic_sc2730_devs[] = {
{
.name = "sc27xx-wdt",
.of_compatible = "sprd,sc2730-wdt",
}, {
.name = "sc27xx-rtc",
.of_compatible = "sprd,sc2730-rtc",
}, {
.name = "sc27xx-charger",
.of_compatible = "sprd,sc2730-charger",
},  {
.name = "sc27xx-fast-chg",
.of_compatible = "sprd,sc2730-fast-chg",
}, {
.name = "sc27xx-typec",
.of_compatible = "sprd,sc2730-typec",
}, {
.name = "sc27xx-eic",
.of_compatible = "sprd,sc2730-eic",
},

.......

};

......

But from my point, they are just some meaningless duplication, and
will waste lots of code there.

-- 
Baolin Wang
Best Regards
