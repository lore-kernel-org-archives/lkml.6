Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BA9C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEEA20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0t/mtGoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEEA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJBORw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeJBORw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:17:52 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34BFD20878;
        Tue,  2 Oct 2018 07:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538465760;
        bh=JaBxdk8dlc75n+tiHyHmslRgG4Lljg32mJmDqV4Bh5Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=0t/mtGoUgUUxiMDQVFq6100Fq+0mDM7mFOjff+MycZoBWftAQfXEXFvqjO81CWVY2
         1UcjDYpkBIbWTp0yBbZ13ac0Pbo94kAmyUg0HZJ2DtTNjSTp1eMSsEUFQuOThgr7MJ
         9PObHDjmai1QlPyDxBAWMvyxgmCTWHJP4/lWwifM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        ryang <decatf@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <153843172633.119890.17243129066234373128@swboyd.mtv.corp.google.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryang <decatf@gmail.com>
References: <20180921220037.16862-1-decatf@gmail.com>
 <153843172633.119890.17243129066234373128@swboyd.mtv.corp.google.com>
Message-ID: <153846575952.119890.6094475401652816252@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: tegra: Fix an infinite loop when clock rate is zero
Date:   Tue, 02 Oct 2018 00:35:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-10-01 15:08:46)
> Quoting ryang (2018-09-21 15:00:37)
> > Calling clk_set_rate or clk_round_rate will lock up the kernel when the
> > rate is zero. This avoids the infinite loop and uses a slightly more
> > optimized p divider calculation.
> > =

> > Signed-off-by: ryang <decatf@gmail.com>
> =

> Do you have a more proper name? Or you want the author name to show up as
> "ryang"?
> =


I see a v2 on the list, and it looks similar so I'm going to assume this
is superseded now.
