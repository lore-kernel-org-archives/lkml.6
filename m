Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4246CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544464404;
	bh=GTBCF3HE3OCzMGsHWDdAcrV3d8NpVIYzkUVIVDKlqcU=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=1S0EIzEfJNvdOD2ZwhzBMBwmzXwzKiH4AFvvPk8E/d4YagdmaWTINQ1jf0r8r2gnC
	 Il94DJQU8zFtEtHBHLTToo/Lgvmd7FTyOzpdiQ9spj8fPcutGVJeIUn30T0jCQsYCM
	 J5cbxiB2hl6jxSfvPVhqUTa5JIntPFWqwjiYnOY8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF7F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeLJRxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbeLJRxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:53:22 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1CC12081F;
        Mon, 10 Dec 2018 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544464402;
        bh=GTBCF3HE3OCzMGsHWDdAcrV3d8NpVIYzkUVIVDKlqcU=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=vlW+Bz/GjEAl1YLCmvoNy+ApkYCOaAJ2mirUJdyuta2PoRtYmX+nbbyB6VT0iZck3
         cCavqm7gfLOpH/NJQyNLEku/AM6WqQQlkTAHxwKNIF3nbFcaqXGUmkM3UdaVfTzksH
         giHatPUNSxqSGpw9ZsDUUX9XdFxtMdcy1u5OkUJI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181209150832.9366-1-colin.king@canonical.com>
Message-ID: <154446440114.17204.3027564849049013270@swboyd.mtv.corp.google.com>
To:     Colin King <colin.king@canonical.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH][clk-next] clk: imx: remove redundant initialization of ret to zero
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181209150832.9366-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Dec 2018 09:53:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2018-12-09 07:08:32)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The initialization of ret is redundant as it is being re-assigned to
> the return value from the call to imx8m_clk_composite_compute_dividers.
> Clean this up by removing the initialization.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next

