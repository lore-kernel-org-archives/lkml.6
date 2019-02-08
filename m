Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084B3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9FC20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="V5Jx9/4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfBHMyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:54:54 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:44325 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBHMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:54:54 -0500
Received: by mail-wr1-f50.google.com with SMTP id v16so3415310wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vWMJPrTFaawUpyMAT1M03LxVGxmrMKjEk7iqGZ/RXP4=;
        b=V5Jx9/4EN9s1Y0b3BKgqLz7a8/G5FoHUFi7XyQd/c6z1ivOqntxVr7VFUkBjQiBWTH
         8MdP+lDslUVDweVd8DwOjODvuHkKUSTzapkziVKL2uQ5L3SbJSUmJpRhZcl6aYG+orcf
         6NTQRW1Skl4DRNaoPvC9gMis5WIPfZRxZVwixdSazs5K2pMOC9rgO2q9YxYlTKY3fnBt
         wHnDWEP2SciSJxXVMpMmfDtNSxd95FS9j2mgAbN5P/3Syty95Qp5YHbRRCaA3l9nM/Kc
         TvahPu7th0LTtjF0MRD6lTT4/lPAZfOK1nE2QwAcrSOwPUFLQOuBvWr6q0Ie2dFClbQo
         KubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vWMJPrTFaawUpyMAT1M03LxVGxmrMKjEk7iqGZ/RXP4=;
        b=NQRTFlFV2pV9fM6f8Ywt4x5ZOkJ62tH9/7DrKLPSCIAmU5OV/8Gh8wLqSdfXbMPvAi
         24/107RkF2Y2pnF7sqmJJyBAATD5qmlrgSG7KVw4LSRUCjt6a0eMoQJ8r+rNSRynZrRP
         8tIlXK3FuGXGTWBoeqvuNmZm0rVxZyZfy0Bet6jDehl/Y9WRfSzyP7bdixGV34COGRfc
         wBIYldXzIrg4Oq2x3s/FdULsy/bzxLJIeHawexapw5p2KKYE5DCNjheUgwlLCdX9K6+l
         xqF/xIoaii+1eDwOOdnf1zvv8dFpVgZaUlTVPNjJRl7FH2/ahHENGmKatvBqD+FlqFc1
         1upQ==
X-Gm-Message-State: AHQUAuYCM5BqFznUDK4WSWQHq3+FO+0iqL2SVzDc6K9roncYYDB7w94U
        5JxLQfc9FX1A/f3TvLHktRkQ6E1felZrHTIzUVcmUmd+wMI=
X-Google-Smtp-Source: AHgI3Ia7dZLvF1RQhOkI9h1Xpfk0U4ldONETkgDnkA+qwgAh8GJTV3uHL2YYdPU/e+LUBPzT+Ba28oXdKB6UXOnHr6w=
X-Received: by 2002:adf:a14d:: with SMTP id r13mr1213143wrr.169.1549630491993;
 Fri, 08 Feb 2019 04:54:51 -0800 (PST)
MIME-Version: 1.0
From:   Axel Lin <axel.lin@ingics.com>
Date:   Fri, 8 Feb 2019 20:54:40 +0800
Message-ID: <CAFRkauBgVjtjJPM_5GdNTrzUymMEo180xajYwT4Duk=yxwOcbg@mail.gmail.com>
Subject: regulator: rt5033: Question regarding define for RT5033_REGULATOR_BUCK/LOD_VOLTAGE_MAX
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beomho,
The code has below defines in include/linux/mfd/rt5033-private.h
#define RT5033_REGULATOR_BUCK_VOLTAGE_MAX               3000000U
#define RT5033_REGULATOR_LDO_VOLTAGE_MAX                3000000U

However, according to current settings in rt5033 regulator driver:
For LDOs, it can support up to
RT5033_REGULATOR_LDO_VOLTAGE_MIN + RT5033_REGULATOR_LDO_VOLTAGE_STEP *
(RT5033_REGULATOR_LDO_VOLTAGE_STEP_NUM - 1)
= 1200000 + 100000 * 31
= 4300000 (This is different from the define of
RT5033_REGULATOR_LDO_VOLTAGE_MAX)

The same issue for BUCKs.

I don't find the datasheet, can you check which part is incorrect that
causes the inconsistent?

Thanks,
Axel
