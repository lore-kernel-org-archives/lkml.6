Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B6ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0956920824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMqSILqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0956920824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeJYKcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:32:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40209 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeJYKcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:32:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id n3-v6so5511430lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 19:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G/HmUnhroIQNSIpDXWRVVXv64/CmAg8q+ui1P7Zw0F0=;
        b=DMqSILqCNwtoUoQc8kx75SmBeWAmQmVeyByDccaeTk9PEoT1x3H7owkpGARX2lWxV2
         MiFD9adLSP+LLEoydqWvvWx7SLho9/KZ8IVo4EWdHUDCihWE8JBAi3Iwhr40Ee68oyO2
         rvczx/k4Y+jtiasE4EjnEsYm0lKaOi9aXazRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G/HmUnhroIQNSIpDXWRVVXv64/CmAg8q+ui1P7Zw0F0=;
        b=tTRxGP8rgfOD1pb5se/GqtyOG3CJDtHndkzE1p9m9RlSDfpX8kMaGtnCrsp+wtl+SV
         2B9YBXEGi5Sbjh6NkQuC/b4PCsmpPEa0CxZO4zRiba6yj2ZoTTCzI5TBpTnH3hNFp/L9
         DtSV2cTTvnVZin5H7OWJIUjS3sR1Bxg6RkFk34uI1xpQe1zEqXXzzz62kfUc8yW+dPTL
         qRdhdV8KFq00l1I1cJ0TLU+s0wtQ1gRkh82kaXzla3XXiToX0qI9u0rxWM8cUAGvVDG5
         tnXnTVfoklYfbzMk0zJQIBQnQ8ByeN7IiX2yU4BXHfJBdbGfS7gmLr2yZRofz015RCHB
         Zf0g==
X-Gm-Message-State: AGRZ1gLPwLeJ6X6YYAazd+PViVYrDcMwwIPpM+7iLbUZKiw6FGcaHCuF
        qUVBLCmBystQlDLTG2s1zLikP/M1M+6GwxFqE5o+/Q==
X-Google-Smtp-Source: AJdET5cv2UohVZE4aCdQRljwgePSmgZLTH4rZu05roNoXkJlMNDD0n+Q+0J4W6tLfmmAgt4IVTBjd7ZuWiJ3W+kW/Yg=
X-Received: by 2002:a19:690d:: with SMTP id e13mr94828lfc.84.1540432916298;
 Wed, 24 Oct 2018 19:01:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 19:01:55
 -0700 (PDT)
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 25 Oct 2018 10:01:55 +0800
Message-ID: <CAMz4kuJCS1_E+CUdANepYe+WpYSOwovZ9Rnu85zvTgmV9BE5+g@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] dt-bindings: power: Introduce one property to
 present the battery internal resistance
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 22 October 2018 at 15:43, Baolin Wang <baolin.wang@linaro.org> wrote:
> The internal resistance of a battery is not a constant in its life cycle,
> this varies over the age of the battery or temperature and so on. But we
> just want use one constant battery internal resistance to estimate the
> battery capacity. Thus this patch introduces one property to present
> the battery factory internal resistance for battery information.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v5:
>  - None.
>
> Changes from v4:
>  - None.
>
> Changes from v3:
>  - Split binding into one separate patch.
>  - Add LinusW reviewed tag.
>
> Changes from v2:
>  - Rename the property.
>  - Improve the commit message.
>
> Changes from v1:
>  - New patch in v2.
> ---

I think this v6 patch set have addressed your comments on v5, so could
you apply this patch set if there are no other comments? I hope this
driver can be merged into 4.20 finally. Thanks.

-- 
Baolin Wang
Best Regards
