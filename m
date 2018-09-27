Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27799C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF39121533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3Va39jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF39121533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeI0KBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:01:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38703 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeI0KBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:01:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id h15-v6so1195414otj.5;
        Wed, 26 Sep 2018 20:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pdKOTtjwQc7c/w8MVBBIEDBfMWOUSfaxgI4aDJgTtI=;
        b=Z3Va39jTEJjxYePT+Mj23I33j1kamQW3Akb3NXPfu0+4XCzOBPa/MjKFeyj273xLil
         kBE6big3iUUWdKQmmUGxhNawIcGOy8Uvh0Tq8TRM8g72WqyC8rSj/r56GQ0TExoyDNzi
         6wg1T8wi2gp7OvHdiKiLaT74Tfeww1J332cROTGzke2/PqhUsyj3LKfCohZLw9KfySg4
         YazH0NKwh4bZxQExKRt9KF5lcltFqi1SIe2CjhhQT30kpyEmiBSwpp4Aw+IEUdZgrnnR
         qvUI+JAwx9DhYN4zQuioVqAqVRZAjjQGr6B5anIfyWrPzvbn3QM2T+Kcgmyi27ozM+kr
         mgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pdKOTtjwQc7c/w8MVBBIEDBfMWOUSfaxgI4aDJgTtI=;
        b=rWxUV9mKcMADS48misynoiaxN+vep8YM+LTl3ZPA8vdMJBu1/SdvYjeeab7zsr92/b
         zk+KJqqpQTb0u3NiT3vdaLI7UtWvTQJRMbKbS2RySmiXjmwI2jVh1tiek4G3y425iObw
         q32QoIc5s04CGeQPf4vAcY5cVZ6EovrBdnP9jNZGvk+HtUhtsLB9GLc1ZEiwrcWp2H0/
         x1UrmJKAWdY090/mr3ZrjNNon0FYgOvEzKE0ovgNFNMzL8NFWevCBq2bmKuVcGSrruZ2
         H+vOUuetidcQ5fPQSsu0qi3Y8m0Kx7fF1egAUYctrMupFMKMYu6b1FXUegl1DPqEcsi7
         7d1g==
X-Gm-Message-State: ABuFfogo5Hkc3EFQuQ8v5b6tlfuHERMb7GA+bfrqX8ZkSeaC+fwLhxyB
        MOEUwYMciBez+i3XqpkfxKRg/W9anYztTquG8L8=
X-Google-Smtp-Source: ACcGV63X/sbIIZP2MDhA+0+23tUqfE4AHK91m6o1WR0k/lP5atvqVOxlmZkvEPRADBq1xZnim+eqmRmdgvpIeaq9pyA=
X-Received: by 2002:a9d:1e8a:: with SMTP id n10-v6mr5720691otn.50.1538019924277;
 Wed, 26 Sep 2018 20:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180922075238.884-1-linux.amoon@gmail.com> <20180922075238.884-6-linux.amoon@gmail.com>
 <20180926190639.GA6461@kozik-lap>
In-Reply-To: <20180926190639.GA6461@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 27 Sep 2018 09:15:11 +0530
Message-ID: <CANAwSgSPkKL3jaHHSkEhgocKT_Sq4zg3Z=+7d5889ttpnNPHDA@mail.gmail.com>
Subject: Re: [PATCHv4 4/6] ARM: dts: exynos: Add CD and WP pins to Odroid
 XU3/XU4 SD card
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
On Thu, 27 Sep 2018 at 00:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Sep 22, 2018 at 07:52:36AM +0000, Anand Moon wrote:
> > Add the card-detect and write-protect GPIO pins for OdroidXU3/XU4
> > SD card by adding pinctrl setting for wp-gpio pin and set it to
> > active low.
> >
> > This also removes debug messages:
> >     dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
> >     dwmmc_exynos 12220000.mmc: No GPIO consumer wp found
> >
> > Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Fix the commit message and squash it with cd-gpios and wp-gpio
> > patches into single patch as suggested by Krzysztof.
>
> As Marek pointed to my Odroid XU patch, there is no point of adding
> cd-gpios and wp-gpios properties.
>
> Adding pin configuration for wp pin is also not needed. Reset values are
> working properly. However there might be meaning of adding it just in
> case - if bootloader decided to touch it...
>
> Best regards,
> Krzysztof
>

Do I need to send the all the patches again or just resend this as per
your patch for Odroid XU.
with dropping the cd-gpios and wp-gpios changes.

Best Regards
-Anand
