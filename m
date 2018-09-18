Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805C2ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8D72133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/GpMQZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8D72133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeISBQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:16:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33261 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISBQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:16:28 -0400
Received: by mail-io1-f66.google.com with SMTP id r196-v6so2600256iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XY1gIbeI8B4CZIKFLdkkIbfImYYGK7GEGzdtLd7zOA=;
        b=S/GpMQZS/stG0StvP0klEI6cAgG71FYnaTr0wwY/VRU4WOGEYhnQVEExWy3oxGGqOM
         TmXv+Goo3POW+A2aeT+fUZN58u6I+YxGkMXRUAjnLc9ENqx5EENb4Wuqk3b3EIWS8nI9
         52b8KwGoFgGB06hg85eIFETPv4eI8pa9aWtwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XY1gIbeI8B4CZIKFLdkkIbfImYYGK7GEGzdtLd7zOA=;
        b=puQSXJ1Ico3dZnvbyWJ82Lq7G2OqamG7lw5gD75kGwVRr/X1UeAfqlsoNc1JMtpQTh
         eyUccVrF4nzpJEf0hVlOatWlq9D3XKnSeWLtlV5JdsUeT1QD4dY4Who9e2H5NRkjx3Se
         Ql1PgHUZWn7jdPa4WtLXK26UjFq2mc6Sw6yF4CqrhILY/WBuztDlYAwz67ZBHMxbRa3u
         naqkndpsDE2mrZL3UNa90VpT39HkylX0iNDhxqGJ6aoiYTYKYHTTHYaJlAG2/05Fv4V7
         uZNVUxpngc4UYWbumThzWCnoIinw2OqadmPx/F6UNTk+0bJRzFAivECbFWXUwsbw3tsh
         bTiA==
X-Gm-Message-State: APzg51BD5HGfOH+4tNGr+v3l061lRvXMfs38WWqdbrwd8uGQ+n/VI1SI
        bU2qHtdizzJuOKG1yGoFHR3p/CPZZV7j86Ugkc2fdQ==
X-Google-Smtp-Source: ANB0VdZKDnDa54MDwhjzX+90IZbfPjTGwjRwSV9rNhwYGbVm0FnsTu4HK8ZU7uBRcpOZvOk8ZLhMXgKqW4+kbylr5Pk=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr26133105iog.175.1537299742906;
 Tue, 18 Sep 2018 12:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <5001a940525e9da7b0e1ac1afead629e1373fe33.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <5001a940525e9da7b0e1ac1afead629e1373fe33.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:42:09 -0700
Message-ID: <CACRpkdYr+9i+UA477sVp=mQ6oA+b4LqxGUyfTDy0XXN0aW0FMA@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] pinctrl: mediatek: add pinctrl-moore that
 implements the generic pinctrl dt-bindings
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Add a generic driver pinctrl-moore.c for MT762x SoC and any other SoC
> that would like to use generic dt-binding. The patch is furtherly
> refactored from pinctrl-mt7622.c that totally uses the functions back by
> the generic pinctrl core such as GENERIC_PINCONF, GENERIC_PINCTRL_GROUPS,
> and GENERIC_PINMUX_FUNCTIONS and its binding also completely follows up
> pinctrl-bindings.txt in Documentation/devicetree/bindings/pinctrl/ to
> implement.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied with some fuzzing, and removing un unused <linux/gpio.h>
include.

Yours,
Linus Walleij
