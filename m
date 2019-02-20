Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCAF2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550691591;
	bh=gNmgl0sPPT06uTyj0gtld9JGOJ+KPfUjkDUka38IMig=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=aHuwPD1H0jbxG7Al/AWn9L6vq1iVjIuUF0SRy8zMzZkAC9jxVp6W5nK/IlIeH7SFf
	 GKDQh/bC5uSYcZN4/fScwrbVTVyIVzx02VOY4NI6vFGu0HFMOzW0WIUHe0KXSRc5EG
	 Krrld6pNhVJaevQ3k+uVJsZi9YleXOmgItHq2jb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfBTTjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:39:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTTjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:39:49 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5C321841;
        Wed, 20 Feb 2019 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550691589;
        bh=gNmgl0sPPT06uTyj0gtld9JGOJ+KPfUjkDUka38IMig=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=as4Yp+owvdXJZcOZ6PqnsZo9m/Bo/VLMQ/zq2TLNoP6TPGId0cyyrMmFzFWyfOg9C
         R2nyJB6+A1zKONDKnLYi3zoFRE73ts5sdEHyWSri0yrmpvw0k0Gi4+BR9utwGAwqxa
         zJ+u2WusPBGA4W2skEDD6kwS3frtuQjVKaBQb7sM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Message-ID: <155069158817.77512.2569138453972131411@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com> <23696765-c2c7-0df8-1bfd-2dfd96f65e9d@microchip.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <23696765-c2c7-0df8-1bfd-2dfd96f65e9d@microchip.com>
To:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Feb 2019 11:39:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas.Ferre@microchip.com (2019-02-20 03:18:40)
> On 19/02/2019 at 17:51, Alexandre Belloni wrote:
> > nck() looks at the last id in an array and unfortunately,
> > at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculat=
ed
> > number of peripheral clocks is 1 instead of a maximum of 31.
> >=20
> > Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: <stable@vger.kernel.org> # v4.20+
>=20
> It would be nice to queue it as a fix the soonest, as it impacts 5.0 but =

> not 4.20 due to a switch from one DT binding to another (read: a real=20
> regression)... But I know it's a bit late in the cycle...
>=20

Ok. Let's send it off tomorrow.

