Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A1C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD4B2173F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9sopBqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD4B2173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHTQ5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeHTQ5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:57:17 -0400
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com [209.85.220.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73352170E;
        Mon, 20 Aug 2018 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534772494;
        bh=WS0FgZLW3dsWZ49He00hp8YSr9tr6Zco+mCW6x7GWRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M9sopBqWUwtEJ4mXs50gmKjp2JZHh9WEIqQPCaMzwlHK8b6mwhkuOxNhhPBaYp2or
         sWeG/sEml8YsRLluU7yuNGUYyYftggNnuEr9ny4DZTSxZVWirbIUzAg9QJR/crnCad
         caZFzC5Oic5Wx2MWZnA/gjS2RLsSkKm/YRWcdKW0=
Received: by mail-qk0-f180.google.com with SMTP id j7-v6so1101141qkd.13;
        Mon, 20 Aug 2018 06:41:34 -0700 (PDT)
X-Gm-Message-State: AOUpUlHSIsv0RXimPz5nGLaszzlxEVOyBagsZkrHApsEe3sjXtnAPNNu
        HsOmLlz0jgr8NKNvu4cTr6AuL/h+2txA+2kcYA==
X-Google-Smtp-Source: AA+uWPw3YU0MhJu7QqST+BLUjDj/mz7HoCLjsBrdDINlqjQqF26LbkANs6uXwwzCH14V2e0+FC6iiA4Hk0Zpo6h7Ejc=
X-Received: by 2002:a37:1617:: with SMTP id g23-v6mr8804043qkh.213.1534772493945;
 Mon, 20 Aug 2018 06:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180804070355.14857-1-manu@freebsd.org> <20180820111755.rzg7l2lznmbpuf2e@flea>
In-Reply-To: <20180820111755.rzg7l2lznmbpuf2e@flea>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 Aug 2018 07:41:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
Message-ID: <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Emmanuel Vadot <manu@freebsd.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > This patch adds documentation for Device-Tree bindings for the Allwinner
> > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> >
> > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
>
> I'm not going to merge a binding for a device that doesn't have any
> driver implemented at the moment in Linux.

I'll take it then. Linux is not the only DT client.

Rob
