Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE4C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7C320878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547251029;
	bh=ZCmm1wOKskabQ07CJBIP/K03GW5e9UTCwOj61KfmdTo=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=b2omjKzUW+4FCWxwKgoo37A+vQXx3jQHUHK5Nykv2jA9PDTG4L19j8hSwwUkX137y
	 Xk0axIy/3/53goF9CJOQFzdUQeK9MnDS470fJPF8XqFRnhQ09JucUGUTnSwZLNYdqG
	 wIjsgTPALFjc9K68lJCqMmdxrS016lP8kpzwMW70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfAKX5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfAKX5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:57:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8E520835;
        Fri, 11 Jan 2019 23:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547251027;
        bh=ZCmm1wOKskabQ07CJBIP/K03GW5e9UTCwOj61KfmdTo=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=Obym/N+xNsvpN9Mxn8SD0the1pElFu6moBJZxngJPiuCgS3rcHeVjAcT0D8y6xLIA
         RUeSdq3ivBZXlnijmAJZioTNdL/yCZEI0iFT4TX9pqbhdtLy00dq2f6Cx8lXoaxdCv
         hslBGGmpW6ULltfmlHH2qb4ryhViHAdEu5k3R/KU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] clk: actions: Add configurable PLL delay
User-Agent: alot/0.8
In-Reply-To: <20181231185517.18517-2-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org> <20181231185517.18517-2-manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mturquette@baylibre.com, robh+dt@kernel.org
Message-ID: <154725102657.169631.13321616473847605014@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 15:57:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-12-31 10:55:12)
> S500 SoC requires configurable delay for different PLLs. Hence, add
> a separate macro for declaring a PLL with configurable delay and also
> modify the existing OWL_PLL_NO_PARENT macro to use default delay so
> that no need to modify the existing S700/S900 drivers.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

This one looks good to me.

