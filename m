Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE40BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853CE2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853CE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeK1WR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:17:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45320 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeK1WR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:17:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so21711263edb.12;
        Wed, 28 Nov 2018 03:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTHy/GTrL8+EFKw7Tj7vAWj8WWnTu1OL6FxHt5d5/v0=;
        b=PP1sPltEbcQxV53+pwg0h5nB9z7Ii6U0dJViCoJIHQokSmIj3l3A4moHj4azVsxLs3
         sLeO566BIOWn1/dhDCnvpQIvWecFG7Zor5OkymzJtDKP/NrdwFfoFprEhxQSWQsijGNM
         JlAdE+PZ8tkf+a1i7ONICqOrDqMzndG02IJtdrPtI5d10SogoKh2JvlTRJII9MCPa/hu
         PhFtokx5QcTXGUh79S0CPtIZmbmGoGgtMow1CPIThHzxfJBwUzVmgyo1v92B7F1FpsmH
         C3q0H+qfHIEFYEt4MCrcRO3d+wtIbZ6numLGrbBpqOKG4EU6ageeTfuY/hG2wPynUMrq
         VtDw==
X-Gm-Message-State: AA+aEWbTOF/uI1m/A+xHz+vwnhWYqxAoceyuCRRL02txOqPjo58th3qm
        pXK7Vlu4lChWBT/GK7dHLCGCnmVbfHA=
X-Google-Smtp-Source: AFSGD/WqaB9rSaBEwXc3NGhsqr9BlJcikCoB9y8/wtMk4g0nbLOdPIAi69631/cVcSv18dEZCj7jiw==
X-Received: by 2002:a50:8d8c:: with SMTP id r12mr29419060edh.105.1543403769718;
        Wed, 28 Nov 2018 03:16:09 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id p36sm1712745edc.78.2018.11.28.03.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 03:16:09 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id y1so2172477wmi.3;
        Wed, 28 Nov 2018 03:16:09 -0800 (PST)
X-Received: by 2002:a1c:2304:: with SMTP id j4mr2320634wmj.14.1543403768741;
 Wed, 28 Nov 2018 03:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20181128093013.24442-1-wens@csie.org> <20181128093013.24442-4-wens@csie.org>
 <20181128102015.jfzqgdlstkjmdfwl@flea>
In-Reply-To: <20181128102015.jfzqgdlstkjmdfwl@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 28 Nov 2018 19:15:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v64wWWHkyt90oZZnHn+1_mPLbL-A_P-igCaOjjOKajxhjw@mail.gmail.com>
Message-ID: <CAGb2v64wWWHkyt90oZZnHn+1_mPLbL-A_P-igCaOjjOKajxhjw@mail.gmail.com>
Subject: Re: [PATCH 03/15] dt-bindings: rtc: sun6i-rtc: Deprecate external
 clock output for A31
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 6:20 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Nov 28, 2018 at 05:30:00PM +0800, Chen-Yu Tsai wrote:
> > The A31 does not have an external clock output directly from the RTC.
> > Instead, it has four muxable clock outputs: three (A, B, C) are
> > controlled from the CCU, and the last (D) is controlled from the PRCM.
> >
> > Deprecate the usage of the external clock output for the A31 compatible.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> I guess we should add a warning in the code as well if one tries to
> use it.

That's on the TODO list. :)
