Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127CEECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E5920843
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wxeEo8ZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E5920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbeKDMRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 07:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbeKDMRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 07:17:19 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2AB92082E;
        Sun,  4 Nov 2018 03:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541300641;
        bh=odXCp+PIPGoO0DBD4uZ6kCg+R9u/wNd7aaqvF7gWcy0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=wxeEo8ZF3kRXTV928BjD0o85DMXl27IAtUbizYuwz6hO9gOcVfKk9D57yv0p9Q+5k
         57x2c5Qk1uvptpA0C97lS2w3b9OG+cib6j6GvM2aGWkUJg61fpkOiVMsEMXbnbkLSg
         4bFCkptKSonr2yGgJ1Nz0xdp2NUMkGgGOrGsceIY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>, Yixun Lan <dlan@gentoo.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181024145513.GA6647@ofant>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Qiufang Dai <qiufang.dai@amlogic.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-3-git-send-email-jianxin.pan@amlogic.com>
 <ca95948abd58876a23b2eb3e52b96124e9eed793.camel@baylibre.com>
 <20181024145513.GA6647@ofant>
Message-ID: <154130064120.88331.5081431734592584205@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 2/3] clk: meson: add DT documentation for emmc clock controller
Date:   Sat, 03 Nov 2018 20:04:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yixun Lan (2018-10-25 00:29:15)
> yes, I think the documentation need to be fixed
> =

> for the final solution, we decide to make 'mmc-clkc' an independent node
> instead of being a sub-node of 'mmc', so both of them may exist in parall=
el..
> =

> the DT part may like this:
> =

>                         sd_emmc_c_clkc: clock-controller@7000 {
>                                 compatible =3D "amlogic,axg-mmc-clkc", "s=
yscon";
>                                 reg =3D <0x0 0x7000 0x0 0x4>;
>                                 ...
>                         };
> =

>                         sd_emmc_c: mmc@7000 {
>                                 compatible =3D "amlogic,axg-mmc";
>                                 reg =3D <0x0 0x7000 0x0 0x800>;
>                                 ...
>                         };

That's improper usage of DT. We don't want two devices at the same
register offset.

