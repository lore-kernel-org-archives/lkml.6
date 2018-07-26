Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03428C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C4F2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cE25OJcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C4F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeGZJM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:12:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34668 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbeGZJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:12:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so1402382ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a5WHBMbUJdRJ3x5qS98+TfZeKXF/7wPResP0zcgSx4w=;
        b=cE25OJcU+NR0+IOnc+ejlq/n4pMJGjGXusWVrMchxazYAem8jRBHjjep7oCFEXSJqW
         yQXTg04ioEXVBSyDa+7AUmaT7JbYCLBSisGYKeXiGveuToIbMMXfWt4udCvJ5pQ4FjYj
         AYh06LDU0sWCkp0o/TldFXcmx+j00gIbrQ7E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a5WHBMbUJdRJ3x5qS98+TfZeKXF/7wPResP0zcgSx4w=;
        b=ruuSzcZ6SB9oEpXKaIEdaMHcZWAce7mD9cImiXh0PrWuJfRGsgD1QVR3+OtKf5dLJS
         QqsdguS5s6RNRF8+xRH73EIsQLcpBBwGtWShloSJOhVUauQlJFve/diXH1JE+wSpyS6o
         Nxjr7xnNz7K95aj7AErj1dVZNlWy16lXKAr1aQSynz7yVNMPT+Qaaan3Y0QBU4iGJ+oq
         aqQ2NttJaTcTXZiF4QsX9Js7L9NOeudw9tay3X8wXL8tyBzxLKZPKxjHaKbvjrxksJKN
         5pUkQc1DABV923L0pSJYk/WhC19OoHruin5EM6iYw25/zZ6C84F9sLGO1Po2OgI2ko1c
         MK9Q==
X-Gm-Message-State: AOUpUlF/xwiooHLz+/rrs8V94sayMsW6/e48fP+Pr892PGGqiLVEp7kw
        BurBJPaePtvZA1gCuLXpqSjHIbskJ+x2Hts2wjotJw==
X-Google-Smtp-Source: AAOMgpfO1Vv1gykZcGWHshcEazoWdi5Ta7BI0f3OH8Nfrv/8DX4AZQ+3lDVkxU8p501QvJSXXjQDBxruk5WielN3lrI=
X-Received: by 2002:aca:cdc2:: with SMTP id d185-v6mr959953oig.350.1532591841932;
 Thu, 26 Jul 2018 00:57:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 00:57:21
 -0700 (PDT)
In-Reply-To: <20180726065208.yalawbgabym3evzy@localhost>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
 <20180726065208.yalawbgabym3evzy@localhost>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 26 Jul 2018 15:57:21 +0800
Message-ID: <CAMz4kuJ7e45xDe=aBc-m9dQczu+hdVH-SHCjnFSRmdjs-5BPZg@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm64: dts: sprd: Add SC27XX breathing light
 controller device
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On 26 July 2018 at 14:52, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Jul 23, 2018 at 02:10:16PM +0800, Baolin Wang wrote:
>> The SC27xx breathing light controller can support 3 outputs:
>> red LED, green LED and blue LED.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Applied 1-5, thanks. If you send a series like this, feel free to send a cover
> letter as well, to let us know what you want done to them. I'm presuming you
> wanted them applied in this case.

Sure, I will add one cover letter next time. Thanks.

-- 
Baolin Wang
Best Regards
