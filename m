Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37DBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5D7208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcO4EJt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5D7208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeFUHZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:25:10 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37376 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754142AbeFUHZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:25:08 -0400
Received: by mail-ot0-f193.google.com with SMTP id 101-v6so2459584oth.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HvCqXMXS9xfPROGLPf4r+Hh6qflJ98BnlgsX5ZLv/DY=;
        b=bcO4EJt7703afzm0q4fwt+dEJERgtfoJFo5w69EPS6kJfsP3IrpyQrJtr52UKZPatR
         BBw7rcdtqJ1h2lgJM1sbdTjzeMdIsKdHlaXYdfIJCidLHuF7GJz2zaBXzn5YG9lvttNi
         HyKUDshcKKp4q17/pT8MFQHr44P2BuRTFGRzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HvCqXMXS9xfPROGLPf4r+Hh6qflJ98BnlgsX5ZLv/DY=;
        b=YX7/gIxGBRxBjiV2Dtv63T1CNfomoYDhyuAv6q9XfRkrDxBeEFOMySnPzs1+H/Wmnc
         j4Sa1pcnk4M5E0lRHKKgsmrPvXzaQFauEfay+XXufOoshjlorHJJIrgYoeaiuT4PD1VY
         ELnlM3edWyrWmD0mZpaU6iLeEeVTfKWXSXcINDx/CpeJ7VaoPZ7lO5Czlf8JGLXmC/zy
         7jys9T0uY/u6d63/1Z4UaAjPJuvVmWxvIqYURHmRp/y2Pkoj79a3Gqz2eekum1tmakCU
         k+zw/wE/dHlFJ76so012j479NfcXfIB8+puziRV15iyDFrlGRav1rQN71j0JEwaHzI/d
         dJ/w==
X-Gm-Message-State: APt69E2bYiaz8RJQtQ+Dg3WpinvpWCcLtiAd2SLE0gq31ZecqoyCpYLX
        p2iXVeTW1NzL2CQjlfzhDcB3OH9gd9qLBi+8mHEu/A==
X-Google-Smtp-Source: ADUXVKLHjICoOP6n/L5omfeewyJCyd1ek81zWZc4rhNU8cJwlGPsxjVcTx5IvBKmEv4nmjdgdKy9uRlWuIBKdUMnVMI=
X-Received: by 2002:a9d:40d2:: with SMTP id t18-v6mr15205271oti.249.1529565908266;
 Thu, 21 Jun 2018 00:25:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d44:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 00:25:07
 -0700 (PDT)
In-Reply-To: <7c9d5eec-4e6b-9b26-470c-f8002cca5f27@gmail.com>
References: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
 <9a2a07b8eb313ae3ba64af911337ee7ff7c9ad43.1525757122.git.baolin.wang@linaro.org>
 <20180509142539.GB25131@amd> <bddc1f89-8c2c-ba6e-3c7e-d89710ed5424@gmail.com>
 <20180510113749.GG6977@amd> <6289571e-7224-ca5e-1acf-5b099be57302@gmail.com>
 <20180512083559.GB8944@amd> <7c9d5eec-4e6b-9b26-470c-f8002cca5f27@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 21 Jun 2018 15:25:07 +0800
Message-ID: <CAMz4kuJh+H_5XkeO=FpmHXdusMqPu9=NUfr1YOgumMh2mPsoJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] leds: Add Spreadtrum SC27xx breathing light
 controller driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek and Bjorn,

> OK, I've revised the discussion under Qualcomm LPG patch set and
> it seems that we have almost ready solution in [0], except the
> pattern_repeat file you mention in [1]. So probably Baolin could
> address your remarks from [1] and add pattern_repeat file to the
> patch that begins thread [0].
>
> [0] https://lkml.org/lkml/2017/11/15/27
> [1] https://lkml.org/lkml/2017/12/8/470

I did not see Bjorn's patch introducing the 'pattern' and
'pattern_repeat' interfaces was resend, but we have some requirements
depend on this patch for Spreadtrum LED controller.

Bjorn, will you resend your patchset? and I will help to test it. Or
can I help to resend the patch with keeping your authorization?
Thanks.

-- 
Baolin.wang
Best Regards
