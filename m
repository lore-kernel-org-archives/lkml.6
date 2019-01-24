Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ECFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38258218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548356184;
	bh=xxDA7ZgUr9jlQsh9sg/F1GLFVnZRnBRJQY7+VAKT5iM=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=F8bI1O0pH6kLwJPWMYawZYgxiVB9aq+Nx1BBZw/scmMQf+ExLRApLgOvKNxxqF5w2
	 +VabB0kx2wAIbX/TbxwefpM3BRHYbUvU7+BXah+h2TwyAg9DLsMOzVSFkqdOerAD/C
	 iq/oZ3NkO6XHGfxTbff5L2yrWnvL8Qi795+zp2wY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfAXS4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbfAXS4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:56:22 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68563218A6;
        Thu, 24 Jan 2019 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548356181;
        bh=xxDA7ZgUr9jlQsh9sg/F1GLFVnZRnBRJQY7+VAKT5iM=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=Lp+ApK141IAyh2RMZtOxeVsgTzAY6gVGfOny7L0YzHNS8Obia3ke74HcngQ/dkWkM
         johMP1Y87GXBPcPP7A/Akag4dIyL4SPg2jdqLwYTpUsW89f1+VWJ0ZbzXE1Ye/QZcg
         6rZHsTV8edfo0irJhp7y3xG8PnIv1wXZqq5UCrXk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] Revert "dt-bindings: marvell,mmp2: Add clock id for the SP clock"
References: <20190121062255.551587-1-lkundrak@v3.sk> <20190121062255.551587-4-lkundrak@v3.sk>
User-Agent: alot/0.8
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190121062255.551587-4-lkundrak@v3.sk>
Message-ID: <154835618070.136743.10161536507964722189@swboyd.mtv.corp.google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 24 Jan 2019 10:56:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-01-20 22:22:56)
> It seems that the kernel has no business managing this clock: once the SP
> clock is disabled, it's not sufficient to just enable it in order to bring
> the SP core back up.
>=20
> Pretty sure nothing ever used this and it's safe to remove.
>=20
> This reverts commit e8a2c779141415105825e65a4715f1130bba61b1.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-fixes

