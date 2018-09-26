Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB09214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3W4MvQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB09214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeIZOQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:16:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51983 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:16:24 -0400
Received: by mail-it1-f194.google.com with SMTP id 74-v6so41436itw.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0f42Gqns6zf18M9daa2+GGLacy2ap0kbjOBzSSUEIs=;
        b=J3W4MvQU2jaBSARAt9xoijnqO6WXDCTRZjh1I2QTqiwNOgjsi6vcDfd12qVbO/sTYV
         WoF9OT18HCHvWQR79NJTq9atPCQDTHBGCFkKTDMFpfUD+WwM5Hz50qXa2JDHeooxRaYX
         npe4Y8sMB9/uITgadSvlQkwzSV7q+G17OjkvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0f42Gqns6zf18M9daa2+GGLacy2ap0kbjOBzSSUEIs=;
        b=lq6zbFsGYVMdWoL2lMIpDQZvgnle2bHFdBc0E4ZUuU93KnmBaQ4RWowiMk2/lr0tSt
         MBSbWARtVxL64UMCkisWlNDhKbgrWOinuL9mjB4YT67zrImk5IkhuPiPKn2hVpvo1KKG
         ryp4VqTDW13SmI9j7YCjThQ2fGFaaG3Jvx0DCVKsH3DrYFIjr1OFgAZxpqZjwDb6kwat
         2x4tlXJ8lvonQzedxmbjkFwgETYMBo+1/Ichbe8DiQNXWxLSSHPspU21FeBSl1csLZDR
         CjP02br8NvLqdDyS6QoiYY06BdY+fVFq+mZvYE/Hoa/gG2bzg1tVSsFkQ6q1tFq332XD
         t0xA==
X-Gm-Message-State: ABuFfojgK7+1GBw9r5Fxbd5x4RejExE1xNK/OrSj1TQueujd0iL1+TbY
        671JYQ0Fs4f4M/5n93SyxYw0vClsB6iOK9cZ0mTDHA==
X-Google-Smtp-Source: ACcGV62d8Eahg4iGp/SPHs6vvfAdVmDbTtfhAsQ2wZaDhCsYoKXEGZlRlMzI5GH4KdRzm4SXW6q37axotAXPf7zTttc=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr3790803itb.62.1537949083147;
 Wed, 26 Sep 2018 01:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <b4b36b7b54cc227e6e7f14c314b4617863a205f5.1537930252.git.baolin.wang@linaro.org>
In-Reply-To: <b4b36b7b54cc227e6e7f14c314b4617863a205f5.1537930252.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 10:04:31 +0200
Message-ID: <CACRpkdb1SAWk7EaF5-O5QNXrMVZU7GCwp+XqskmGC==VG2zVLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: power: Add Spreadtrum SC27XX fuel
 gauge unit documentation
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 5:00 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
> fuel gauge unit device, which is used to calculate the battery capacity.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Renamed GPIO property.
>  - Use standand battery properties instead of 'sprd,inner-resist' and
>    'sprd,ocv-cap-table'.
>  - Remove battery node's description.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
