Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0E5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7339D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="O6YOuPxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfAQB5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:57:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37120 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfAQB5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:57:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id t33so9663042qtt.4;
        Wed, 16 Jan 2019 17:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hf+ofgSsRS5t45iZYlUrALq0LlHYKreLgUYHny3V58=;
        b=O6YOuPxeg9LSor66Vb6PPawvMjF+bLGkWqJ3eH1LliKIo+5jbgmzK2QN7P8qPI0ykA
         6kCu17SfTW+GGVNd7oTN4WLLpejkNd5bWVBcf4ug947rp4wz+SnMhnBCEcdun09QRJBu
         Loe9vvYMEdeOypnNyLG6ZUkq4x2KJPrNiAm8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hf+ofgSsRS5t45iZYlUrALq0LlHYKreLgUYHny3V58=;
        b=apJ/nR/vKUCp4OhyqiqhRvZY2RiFUCdAXlkwY7FCPXG+SrBULZSWThMTcbGUPcH0ZI
         gElogHQla2hi/qQuHAUMOCSQu7Pn+NrjSSzY6M28hUZQCWhc307u/WhmdzFzSe4gDEvV
         Jg6BnB+tKMgBkdGz7E58mVVfD0qSN4K/R33TKo0tkRqn3/tp903O+ycFiuBaSpaGa1Bi
         Pf3d+9kAErRMNw6hVUPysnmX/LSQRFcMkmKzl8s7K4VffdUdYwvRet1GFfDtReNxt8v6
         /rs/pOV+lm0vKRBiIdEOFhjJ0ULsxYLQl6szuzP+jDuwnDa16xqfK9Ljuk8Bu9e+FJ6S
         Icyg==
X-Gm-Message-State: AJcUukcj7LL8OMRLEyEWJUt29pAZmr4577we/T/BRbgK8hfAlaPQ0KOc
        FEcf7JD1cpNy8pFLVh1Lsu6+DyxmnGvTa16mKaxeKg==
X-Google-Smtp-Source: ALg8bN61lhbNxFwc1ARjGAmnrnKs2Mbk9pynH7KNswSOG0TKqsaJVyiLI67+wVdcAgOc5AHNnQAx9H4f84v7bYQVm4M=
X-Received: by 2002:a0c:e789:: with SMTP id x9mr9533669qvn.245.1547690240331;
 Wed, 16 Jan 2019 17:57:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com> <a7b5fa54198e7fd0def33de3e7db36239a2e3da7.1546918172.git.xiaoting.liu@hxt-semitech.com>
In-Reply-To: <a7b5fa54198e7fd0def33de3e7db36239a2e3da7.1546918172.git.xiaoting.liu@hxt-semitech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 17 Jan 2019 12:57:08 +1100
Message-ID: <CACPK8Xdj1Cas8E+141f=ke99REhm-H-pgWE0GBwxXaZ996tCeQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: dts: dps650ab: add power supply
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        devicetree <devicetree@vger.kernel.org>,
        shunyong.yang@hxt-semitech.com, linux-aspeed@lists.ozlabs.org,
        dongsheng.wang@hxt-semitech.com, Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 13:29, Xiaoting Liu
<xiaoting.liu@hxt-semitech.com> wrote:
>
> Add Delta Electronics power supply DPS-650-AB.
>
> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> ---
> v3:
>   Modify patch subject and commit message.
>   Add delta to compatible property.
> ---
> v2:
>   No change.

I tweaked the commit message to mention the board you were applying
to. Applied to the aspeed tree for 5.1.

Thanks,

Joel
