Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F221FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A7A218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548356172;
	bh=UcJv7/Pf4dJRbx13QDX2ZtRbVwM6Uie4MlpRhDp0caU=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=pXF3WU0Pz/iY0qxZSC+Gif1YmOjnpCqar7VkvtU467Wl+T4BSfTZw6va7d+DSkBMX
	 +lxPounvPZPYsRTKtuBIal6Gu4V69F+bUMQabLAhHom+X2UfKIpdqR+tT4jf/YnPRp
	 /vpKi29E9bvfEiRQCJmEbP4ptvL1VZRVkRtUdmM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfAXS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfAXS4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:56:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22EB8218A6;
        Thu, 24 Jan 2019 18:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548356170;
        bh=UcJv7/Pf4dJRbx13QDX2ZtRbVwM6Uie4MlpRhDp0caU=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=Y0n/vo0jtenGqCnz0AMXzJZN7FedGU/HXNvdgwgE6xHW3U4LvBvJVNCmtLD+pDcd4
         HWZ1uDWf71LS0lA02zMQbAaXD+5I7Z+siy1GUAbfWUVF9wYrmbPCjLrKBwjo4eWGfR
         zL4GIVwggklF+XBc9LF/xSjjX68QMhQaT4FkOU0s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] Revert "clk: mmp2: add SP clock"
References: <20190121062255.551587-1-lkundrak@v3.sk> <20190121062255.551587-3-lkundrak@v3.sk>
User-Agent: alot/0.8
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190121062255.551587-3-lkundrak@v3.sk>
Message-ID: <154835616940.136743.9426109859913925018@swboyd.mtv.corp.google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 24 Jan 2019 10:56:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-01-20 22:22:55)
> It seems that the kernel has no business managing this clock: once the SP
> clock is disabled, it's not sufficient to just enable in order to bring t=
he
> SP core back up. Just let the firmware keep it enabled and don't expose it
> to drivers.
>=20
> This reverts commit fc27c2394d96fd19854b7e2d3f0e60df0d86fc90.
>=20
> Link: https://lore.kernel.org/lkml/154783267051.169631.319783654464662574=
7@swboyd.mtv.corp.google.com/
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-fixes

