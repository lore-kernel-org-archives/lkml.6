Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C140C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E22B21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546596079;
	bh=Ja2t7NUSQwvtW9iH4Sxc3jVrV/XrUV/jSE+EvQL2LU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=McGbsY+v7E6dn3voBekRVJQ5lGv1NVk4VFqQXqcUMk4YRld1vJyUc3D+Pu9QMGXA/
	 SkTcUuPpFv5yTpxqd3NcvYMexFit4IchX7LsCErVaxTUNsRLg+pD/gzRssbSiu7Di8
	 htQJqxOPhdW5WpjfeV3bD+dJd0Q6Inb4Lyvpd2Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfADKBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfADKBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:01:17 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F8C21874;
        Fri,  4 Jan 2019 10:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546596077;
        bh=Ja2t7NUSQwvtW9iH4Sxc3jVrV/XrUV/jSE+EvQL2LU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S7q7E4vb03uxY79r2W0GUOKQVzUvVcme+KXiIWlBbuMk1WIQt49gp68siPpuUX/ul
         JjsKzPaFnzrX0bfqVQeDvpMkPwRLQHGfDP4W+ZnZchtYPusI1fZumBNIyDNBnc5KKz
         mA4Ul44mqseQu2ajnLCnFyYmb8WEpqnRVNE848l0=
Received: by mail-lf1-f51.google.com with SMTP id a8so22401lfk.5;
        Fri, 04 Jan 2019 02:01:16 -0800 (PST)
X-Gm-Message-State: AA+aEWbrzL3UVkY1R1rUZG97iUtChRzXv1iGwQ8eGJLMZDVTGj4SNKvq
        4VAqTMjZsYmAIowSSLL4Spt2gumGnGTXPoD0vps=
X-Google-Smtp-Source: AFSGD/UbsuzL7FDbcBMtgO52ETHPCzGz8Ca32VrpalqkhkX9q7oyZKq2Xup8GAtnQchGcNUZnE/wl5frIEtB4CpcpkM=
X-Received: by 2002:a19:10a4:: with SMTP id 36mr24687993lfq.60.1546596075026;
 Fri, 04 Jan 2019 02:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20190101140717.13564-1-krzk@kernel.org> <20190101140717.13564-3-krzk@kernel.org>
 <913204f7-93e7-95f1-c477-85359ea1d73c@gmail.com>
In-Reply-To: <913204f7-93e7-95f1-c477-85359ea1d73c@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 4 Jan 2019 11:01:03 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe4EXD+oKt_pYToszaPz_W=K7Td8F1+32-ouyrKeYQLCQ@mail.gmail.com>
Message-ID: <CAJKOXPe4EXD+oKt_pYToszaPz_W=K7Td8F1+32-ouyrKeYQLCQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] leds: Add helper for getting default pattern from
 Device Tree
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2019 at 20:16, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> Hi Krzysztof,
>
> You mentioned change of helper name in the cover
> letter, but it still has "classdev" part.

Yes, you're right. I mixed up my branches. Sorry for that.

I'll send v6.

Best regards,
Krzysztof
