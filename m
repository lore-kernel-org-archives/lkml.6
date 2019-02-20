Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D215C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDBF21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgXI3UvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBTJjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:39:49 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34629 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBTJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:39:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id w4so26498717qtc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/FeZwyfXZgABbUk5xrhGDGca9vhxZXVbpExDFFXW6M=;
        b=qgXI3UvUXjfHuV0crOZRbiAHjDUXi6cKG42zNtdcb6yWAm/Vdu3NVq0veolArnT7Y9
         JHcMMSW0zzYr3RsbSgDQRRl1yQto8/gAQ4VRM1IjsTjyGBnuj9pBns1Et0NJMVo5vXEh
         mgTu7diFhuMvJ2Dssy43fPj9qi1VollfRzAxjW9A3poA3QRu283BkJnq1Nhs0w9bbSdJ
         XnTRAUtloVhtD/aq2ABJ3VPtBJZEhsQvywQlViSDfUMF0p433urSPEEqba/vJL6ZuYEc
         VlprmRMaDuqNShTjPNkGWdxUFkWRdbVynHJ7x/1w/HPeav+3WydpD/Pbk0vCEDAwkPv4
         UDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/FeZwyfXZgABbUk5xrhGDGca9vhxZXVbpExDFFXW6M=;
        b=WhynOufwefNty8R3IS+2W4hhMDc8uPOoPRB4xOWmBzG6OOPEWQJP28x3aCEdd0dPq1
         GpxaQ2OU+IBMV4usNRDgJkup4CBzG3LaqCv7KPNYLNvwi9uc1rYZeqGFzJpqu+WfXxj3
         4y8ilzFxJmfQ7irHIDWcBalRqqHY+wrVtbPUQhic0iUJNlMz+0smnXG6Dgq4jmEtArbP
         wbCNMcQeJ0Yqo77C/bpk5h0qa773aX1VZOjFITOru/HjI9yobust8ElqshxhmAjFx7h9
         pxGkgiYTrnE0kgAzZ7sQQPxPIyj1P3yTxH3/OzgUpopSjP7alaN+jKLiXOB3G4b0tnda
         bPLA==
X-Gm-Message-State: AHQUAuY2+Heikkyle8dIAPhHjKVUZOfVPqHcg5pskBTj5Rxh+iWDPYqP
        JBeomuUfhubXSAOyLwc6bXVJXcXebuMDAdcgWnvZrg==
X-Google-Smtp-Source: AHgI3IZZB8qh7vaHCXda8ylDQx7KLRXns6viVZyKkdDWvwkmusLbZ8FGKj6yXwG8OSTiKA4BNrAxDWKcyhHuA283k4g=
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr26528763qtd.144.1550655587339;
 Wed, 20 Feb 2019 01:39:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550493113.git.amit.kucheria@linaro.org> <20190220012641.GH2811@localhost.localdomain>
In-Reply-To: <20190220012641.GH2811@localhost.localdomain>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 20 Feb 2019 15:09:36 +0530
Message-ID: <CAP245DXn3db27wMPSaZazRhprXD89JKQ5qEkc8r0DpSL9A847w@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] qcom: dts: thermal cleanups
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 6:56 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Hey
> On Mon, Feb 18, 2019 at 06:05:14PM +0530, Amit Kucheria wrote:
> > - Expose all temperature sensors on msm8916, msm996, msm8998, sdm845
> > - split up the register address map for msm8998
> > - standardize names of the various thermal-zones across boards to make it
> >   easy for test scripts to parse
> >
>
> I am generally fine with the effort but please fix the following
> (applies for the whole series) wrt to required properties for DT
> thermal:
> a. Trip points for your zones

Thanks for the review.

In some cases, the temperatures are just exposed so something in
userspace might read it and do something with it. We don't expect
kernel trips for them.

Adding trip points also requires me to add cooling-maps (your point b. below).

I guess I'm looking for an example of how to just expose sensor
temperatures w/o any associated trips and cooling maps.

> b. Cooling Mappings for zones that have passive trips.
>

From what I can see currently only CPUs and GPUs (among the major heat
sources) can passively reduce heat by reducing frequencies.

Things like cameras, display, video might have a more ON/OFF approach
to throttling that might be controlled from userspace. And we don't
have a way to tell in DT that these zones are managed in userspace
(https://patchwork.kernel.org/patch/10259487/)
