Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2FDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF9621836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeLPJMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 04:12:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50857 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeLPJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 04:12:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so9495295wmd.0;
        Sun, 16 Dec 2018 01:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=4M2gNDDUepKT1HSc99zAnCDtL+xwmziOWA+NCTYJTyA=;
        b=jjNDDWaLnZpVrDmBPX/qkV44OfvT2IJpMzLa8l8PlUoxOq1cBBBBALVBvcfg+77v+z
         vMipmKwKM4ltad52GiqE0W5U/ZUWfkXmBpiz/Z50c8Y75xi4ltFwUNB0q3cTq/8fJuua
         AYY6aHqr4vMzp15q583mg5sA2oo22GsvkGUCqrhqzD3tPir+8AF2i0CrgcUmuOCDmRNM
         kUGdTl2krc2pdRovWiPAnfs+kZqlDdnbQO9b7JHFzaXojqo7JEgWEOT3Zd0wZn/8zE7s
         1mAcCbqBpmWpYf1q5wRBpXC5IJt3XbggzgGkBkY0NT326lMYgLvJ7LMmbr7v1FFHnSgc
         t8tw==
X-Gm-Message-State: AA+aEWYAcdak9/rLMXkTPVC4WjL01V9uPYvgriKmwOCr1U2kNdkgeC4U
        eC4eZ02FlJzAs4m+fk4TS9lF5Gccsn6QwsEKJDSP5g==
X-Google-Smtp-Source: AFSGD/XilYU/IwXDpGykSspBC4E0fiH80B5fqsAmx/Yj9DSJhGsqeI062grMIRpcW7PZc5+SBqj6sm8hZvyWdjCAsM4=
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr7852074wmf.125.1544951570317;
 Sun, 16 Dec 2018 01:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-6-robh@kernel.org>
In-Reply-To: <20181205195050.4759-6-robh@kernel.org>
Reply-To: myungjoo.ham@gmail.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
Date:   Sun, 16 Dec 2018 18:12:11 +0900
Message-ID: <CAJ0PZbQRNGoKsMZjpwaemzpK677v0T5n6h9OtZMdd5UTvq-drA@mail.gmail.com>
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 4:54 AM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
>  drivers/devfreq/devfreq-event.c     | 2 +-
>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
