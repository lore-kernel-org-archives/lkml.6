Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A755C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B622086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jiOfQfOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B622086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeKZRIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:08:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47031 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeKZRIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:08:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so15387641ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfO5IN90BkEEdF1gLVAkKuc+EdNUCLOF5D45MGnBByQ=;
        b=jiOfQfOL/jpc/whNbYK3T5NZcpl9+Tv8hkrDi0YXSUwBeLF5KdLaKJBVOmvv4tDkRZ
         vPjuvd7gn3tGEkeL3higzDPLL1/eJruGRVJtDRwTQKs4aqAQSz1yEM+zaIS/e8Lgq8lv
         3h7pqEjJjF6KcMQZufy2XVdtVH2nSZEr9S2dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfO5IN90BkEEdF1gLVAkKuc+EdNUCLOF5D45MGnBByQ=;
        b=fsTpbRstkLwYJmY9d84/4lFIH16szG/0vtrGFl46c1okp09h0IKwDvSkJ6yr/z1LIS
         BCFO7F9kbn8l87YbTcEc6V4DoWC3r2vSbsU6FphA+90lRDyuw8eDhZRyh2wGqfFmarvK
         5ZrJ6emM1EOSt5lkxEvhKZ176inrM37CqVte6Cck/iq7OkZGtoDLpbCyY/QjVKVGslGP
         y1ai0knH/E2Nvn/pdisUWPbst6Gvuxjj5/Lz9X8Fo87q95eIFetM/xpqWXUgP4ndPmSE
         FOND053v601dTjVVMU5IE0nrULQligh3ls71hn1e3j9DDvVqJ3tab+Ss4tvIJWHwidCv
         r9EQ==
X-Gm-Message-State: AA+aEWbjetoG5ezcKz7nV8IuxgdzmocvyNDqmeZxfhusNtblbhb/rqoH
        rYo+oS42U4Y9od4mctfwFljUKjAgmL/bB2gZAJEUsQ==
X-Google-Smtp-Source: AFSGD/WyUUdGi/LbbXsTiYTuIZRw9fKj6SP+lBr0ua/YoP88bPpia6DxrdBEuZFCg9tPl/UgBoRehubTcLi769xn/UI=
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr17082171ljb.52.1543212940219;
 Sun, 25 Nov 2018 22:15:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542185618.git.baolin.wang@linaro.org> <ee1dd39f126bd03fb88381de9663d32df994d341.1542185618.git.baolin.wang@linaro.org>
 <20181125214501.GA9913@amd>
In-Reply-To: <20181125214501.GA9913@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 26 Nov 2018 14:15:28 +0800
Message-ID: <CAMz4kuLtsDRcYBqPa5ryNuMMQJkJ0OAn7JZgZj5g5nx33puaqw@mail.gmail.com>
Subject: Re: [PATCH 3/5] power: supply: sc27xx: Add fuel gauge low voltage alarm
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
On Mon, 26 Nov 2018 at 05:45, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-11-14 17:07:06, Baolin Wang wrote:
> > From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> >
> > Add low voltage alarm support to make sure the battery capacity
> > more accurate in lower voltage stage.
> >
> > Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Should we also shut down the system when that happens, as battery is
> empty?
>
> Or is there any lower threshold when we should do the shutdown?

We do not shutdown the system when battery is empty in fuel gauge
driver, instead we should do that in charger manager service or other
upper layers. In fuel gauge driver, we should just supply the accurate
battery capacity for upper layer.

-- 
Baolin Wang
Best Regards
