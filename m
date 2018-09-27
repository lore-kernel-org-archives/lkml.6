Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7653021582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N++5gZrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7653021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeI0Xe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:34:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37514 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeI0Xe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:34:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id x26-v6so2368831pfn.4;
        Thu, 27 Sep 2018 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IjMA6Cfpm1WUZXSZ/ybhtDKPc5p55N50Lsw4VjOuF7E=;
        b=N++5gZrQbZPk/QNsOYjwkhHs9TgJIaXqHqBZeuFS03GLFp/Jy5zF23lZhXhoMgSYXd
         AxC9cQWtFmGKuiTI59UeouM5fUzHwKSq90BO6Y2ZABsO9PNToDt9P+xgIkBpzt4idkrn
         iQ8KgeZqY10hpGxyD1Hx6pDliftSGD5ysbAvLf7olSaWdPNPDvqYpg4Yd5n7+FMWus4M
         /SIMEaNzpAcESGoEFVXoRBI2Tw510DhCmBcdkI1/eqHpamj3AwvdmG60UpIvmoDqW+fP
         1bSKDf8fmIOcoegnpIQXhG26KIgm1VNK/JHC5T26jUy+swAxlAK16vj5s5LP7Z5BQpOR
         9pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IjMA6Cfpm1WUZXSZ/ybhtDKPc5p55N50Lsw4VjOuF7E=;
        b=RYEkMwZUdlimBtbpTktB/pLSVRqoUctpzI6mgJuOKHITWNaEHBKzsFogDEaP7RjzwY
         S/ojEl+geYLsjPydzktg3LIgD4N6tvAw5RoRA/Jyt8KWz8WVe4xsT0x3opMcwnYXTNIL
         uv9rKNkuYxbdRS263JcYvd0omgt/fSgzqbv9YgTIbaxTg97SmHJSPhtNv8X7pcVvEc3x
         MNSwTOvFwfaYzFFI4Ozm5qt4abn3wO276r5xDuVhSAbIpydDHPOglbz6rKnLyiRqCL+L
         r9DGOPc4yrvfsgG1fx3ErAqzaVwSwBw+qwQz/Z3tIV2iq1U/LJnXqN5HPDKdURV5KRHG
         qY3Q==
X-Gm-Message-State: ABuFfoi8o7Ed2gM9Cir7eM6d4YfyurNVIMZ8lJ1Z6MXQkNPbSsWtYEpE
        FhXOmBWm9wSyCvvlrcCnwXwGgIEz
X-Google-Smtp-Source: ACcGV60WcDmIchVrNJY7HJJtBXHxGulj0pzwG69qGlQ4ABqbKVJ6Z51ImwPUCUUWjZXSZ292G2JOHQ==
X-Received: by 2002:a63:f5a:: with SMTP id 26-v6mr2792530pgp.100.1538068510764;
        Thu, 27 Sep 2018 10:15:10 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id m124-v6sm3445682pfm.164.2018.09.27.10.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:15:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v7 0/6] Add coupled regulators mechanism
To:     Maciej Purski <m.purski@samsung.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <CGME20180423143353eucas1p1d417b5995e380f6a7b168a98a76ecf40@eucas1p1.samsung.com>
 <1524494022-22260-1-git-send-email-m.purski@samsung.com>
Message-ID: <c1e25e2e-e59e-41f8-30e4-822517c73a07@gmail.com>
Date:   Thu, 27 Sep 2018 20:14:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/18 5:33 PM, Maciej Purski wrote:
> Hi all,
> 
> this patchset adds a new mechanism to the framework - regulators' coupling.
> 
> On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
> different devices on the board are supplied by different regulators
> with non-fixed voltages. If one of these devices temporarily requires
> higher voltage, there might occur a situation that the spread between
> devices' voltages is so high, that there is a risk of changing
> 'high' and 'low' states on the interconnection between devices powered
> by those regulators.
> 
> Algorithmicaly the problem was solved by:
> Inderpal Singh <inderpal.s@samsung.com>
> Doug Anderson <dianders@chromium.org>
> 
> The discussion on that subject can be found here:
> https://lkml.org/lkml/2014/4/29/28
> 
> Therefore this patchset is an attempt to apply the idea to regulators core
> as concluded in the discussion by Mark Brown and Doug Anderson.
> 
> This feature is required to enable support for generic CPUfreq
> and devfreq drivers for the mentioned boards.
> 
> The current assumption is that an uncoupled regulator is a special case
> of a coupled one, so they should share a common voltage setting path.


Hello Maciej,

I'm working on the CPUFreq driver for NVIDIA Tegra20/30 and now looking at adding support for DVFS to the driver. The "coupled regulators mechanism" is just what is needed for Tegra.

I'm now using and relying on the "coupled regulators" patches, here are my findings and thoughts on the patchset:

1.

There is a technical problem with resolving of coupled regulators. I'm running into a NULL dereference on a regulator_set_voltage() because one of two coupled regulators doesn't resolve the couple. Solution is to return EPROBE_DEFER on regulator requesting until the coupled pair is fully resolved and re-try the resolving for each of regulators after the regulators registration. Here is the patch:

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 282511508698..baa8ef91bc30 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1747,6 +1747,12 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
                return regulator;
        }
 
+       if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+               regulator = ERR_PTR(-EPROBE_DEFER);
+               put_device(&rdev->dev);
+               return regulator;
+       }
+
        ret = regulator_resolve_supply(rdev);
        if (ret < 0) {
                regulator = ERR_PTR(ret);
@@ -4433,6 +4439,9 @@ static int regulator_register_fill_coupling_array(struct device *dev,
        if (!IS_ENABLED(CONFIG_OF))
                return 0;
 
+       if (rdev == data)
+               return 0;
+
        if (regulator_fill_coupling_array(rdev))
                rdev_dbg(rdev, "unable to resolve coupling\n");
 
@@ -4663,6 +4672,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
        /* try to resolve regulators supply since a new one was registered */
        class_for_each_device(&regulator_class, NULL, NULL,
                              regulator_register_resolve_supply);
+
+       /* try to resolve regulators coupling since a new one was registered */
+       class_for_each_device(&regulator_class, NULL, rdev,
+                             regulator_register_fill_coupling_array);
+
        kfree(config);
        return rdev;

2.

It looks to me that definition of the max-spread property per groups of regulators isn't future-proof and makes it uneasy to extend the coupling properties later. Much better should be to define the max-spread property per regulators pair, like in this example:

regA: regulatorA {
	regulator-coupled-with = <&regB &regC>;
	regulator-coupled-max-spread = <100000 200000;
};

regB: regulatorB {
	regulator-coupled-with = <&regA &regC>;
	regulator-coupled-max-spread = <100000 300000>;
};

regC: regulatorC {
	regulator-coupled-with = <&regA &regB>;
	regulator-coupled-max-spread = <200000 300000>;
};

Right now we can just change the binding, requiring max-spread values to be set per-pair and not allowing spread values to differ in the code, hence only simple cases of coupling will be supported for the starter.

3.

The patches were reverted in upstream because they caused regression on some board, at least on Tegra I haven't noticed any problems with the locking. Are you planing to get back to working on the patches anytime soon?
