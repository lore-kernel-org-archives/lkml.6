Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC55C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B466E2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2v5/chp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B466E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030554AbeFSUqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:46:39 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37794 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030424AbeFSUqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:46:38 -0400
Received: by mail-vk0-f68.google.com with SMTP id w8-v6so652364vkh.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/4LgSSK9VE9KWwXADDEcivGafFZhSQLpyMC5+SFqJwA=;
        b=l2v5/chpuETLRgC87dQzACWJvNXljQDk19+GKjZQ/Xia9uqAr0WzmRN75/M/bVJoNs
         4S1F+NjnXBW3bKIabw3iVtOA4z4SEDE+pH3BEOc8/Eexim/fW7ocPgVcpbDyHd1+bzoJ
         j1C6/bNBvvamB6FMWN9mTrJojtmb5KyvpQcj/ns1wNxITyc/wlQo9IWeheWfyFN4HhCm
         8vUzZZcsZGLC4iZGmbHI2x/eNKrMaIW3kIEZeBWhmKVQw0runUZ+qY6H1ryzkIJ3sPQY
         kPkOh9AmzqIxlb3ZDsJabPPqP+37di2uZQuaXKgsDDL5tAq+oy9KdCxtwgqh9yzqAJCY
         69pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/4LgSSK9VE9KWwXADDEcivGafFZhSQLpyMC5+SFqJwA=;
        b=Pt7VmFbMZDLkmFwMmg3BKC07WUabWT8laJu5h5DJHPYOLLkNZewQ6MLEIXsmXe+qxe
         i3ELH+eUVwQdRuf3XO0xBb2niE3bmOnlQp48IcvCFlZewKjNoWjiS+g6XUOkCvkrUapX
         48FF88cWmRsx5ECzB2ypyCTVGIQ1U8laoUc2o/FAb2H25rC87g0E+fHITg1s1JcFdiXz
         XGJ55Gxu602CgbzeDKDQMEvg8cHPzflqwRUfiRageEdQkGBcWMewc5nKvWvxV7HSU2LS
         uk14ViJY21JAzNK8D5iDDSdM/0OYauUgn44DQMrTqcp15e2e+KTSzrmrvhx4oxCyatD0
         3Kzg==
X-Gm-Message-State: APt69E0L8ZE3WEgvLnaNHvDy2dJxCwbAg+/ZlWrJmho0KiLLJY4B93zZ
        OtegvtI6s01h/eJ3plbKtGAdh0NxfU7DrLp3FaA=
X-Google-Smtp-Source: ADUXVKLLprD3mSuKiHkqaXLfwnUpdQmMgvVUXOvCh9M1kohCauk1Sh0TerzWhtFj+GA3dyfeT31/FMEwMM6N9kvrBRg=
X-Received: by 2002:a1f:d1c5:: with SMTP id i188-v6mr10842456vkg.131.1529441197360;
 Tue, 19 Jun 2018 13:46:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 13:46:36
 -0700 (PDT)
In-Reply-To: <20180619151000.21693-1-ckeepax@opensource.cirrus.com>
References: <20180619151000.21693-1-ckeepax@opensource.cirrus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 23:46:36 +0300
Message-ID: <CAHp75VeytT0aYxoNLbtGzbacubn_kw+44bW8zGZuRVA7=oQWPQ@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: arizona-ldo1: Use correct device to get
 enable GPIO
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, hias@horus.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 6:10 PM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> Currently the enable GPIO is being looked up on the regulator
> device itself but that does not have its own DT node, this causes
> the lookup to fail and the regulator not to get its GPIO. The DT
> node is shared across the whole MFD and as such the lookup needs
> to happen on that parent device.

> Moving the lookup to the parent
> device also means devres can no longer be used as the life time
> would attach to the wrong device.

This part I didn't get.
Why we can't use devm_...(parent_dev, ...) instead?

>
> Additionally, the enable GPIO is active high so we should be passing
> GPIOD_OUT_LOW to ensure the regulator starts in its off state allowing
> the driver to enable it when it is ready.

-- 
With Best Regards,
Andy Shevchenko
