Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F71C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CD520856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG9OWKLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CD520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeGSHQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbeGSHQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:16:15 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2E320857;
        Thu, 19 Jul 2018 06:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531982083;
        bh=z14h+nP1rj1STh2wbePJTlzoWntypm4duoaGeNZq1rI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PG9OWKLczc2QfqWnVnll7ayqhoGibVtmaxb9ntiSMyI9ZGyWWt9Wz3p8JGm1Um1Gd
         jjrvQqZ8OmaRy9Nf0ERe7+Hl2/dvz+3JccS/J2fKu/h0z8t4loULuYqLJfBvIp91Wb
         xMFbDg0I8vrRe1LxVZKwN+H+0AUZojsVOl/32vts=
Received: by mail-wm0-f51.google.com with SMTP id o11-v6so4945846wmh.2;
        Wed, 18 Jul 2018 23:34:43 -0700 (PDT)
X-Gm-Message-State: AOUpUlEREF+fAqaVPSjoXbyyJh7RiGeuGsfEPlWErsaAB3xra4InZCHu
        iNtwfrAHlqaLbFuAYXHoFo1j0qLNXBZrfxBoOGo=
X-Google-Smtp-Source: AAOMgpeEFleNEaEK2mPgs/WIEyGQucrpsqL3j4m+UO7vthlBQnTuHM222icM1oYTrpIwMb+0W43Fat9J3vp/7OCAUJk=
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr3526127wmm.117.1531982081979;
 Wed, 18 Jul 2018 23:34:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 23:34:41
 -0700 (PDT)
In-Reply-To: <c5e83bb8-840a-9e91-648c-4472b956c111@math.uni-bielefeld.de>
References: <20180718195620.5331-1-krzk@kernel.org> <c5e83bb8-840a-9e91-648c-4472b956c111@math.uni-bielefeld.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 19 Jul 2018 08:34:41 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfPNp_fc8dcz066pWAmS9zmTDWTULyvLp-mTpdyppFYQQ@mail.gmail.com>
Message-ID: <CAJKOXPfPNp_fc8dcz066pWAmS9zmTDWTULyvLp-mTpdyppFYQQ@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: Remove unused mout_user_aclk400_mcuisp_p4x12
 variable
To:     Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 22:33, Tobias Jakobi <tjakobi@math.uni-bielefeld.de> wrote:
> Speaking of the ISP clocks driver, I wonder why this one was never merged?
> https://patches.linaro.org/patch/115531/

Thanks for reminding this!

It seems that Sylwester is out of office so we'll have to wait for reply.

Best regards,
Krzysztof
