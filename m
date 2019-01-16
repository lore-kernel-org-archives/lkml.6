Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207A6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84A120675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547657750;
	bh=jtcnC/mcLZU+TbEdK135MAXmenXTe5HLkT9c7675w4I=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=wFt1ceSKzYjZmNnhMEnvm6o3jXPpK3ZECQbarLY+TtX9YD0WLdapppjF6dK/E/MF1
	 Z3uuzafqVJhwKFsckFmC4XFQlWhF3UYr/mo9KSQSoXPHWhTuUaP6gRmtVX7sBQi71z
	 Jt/HluLElYgChGIpuHiTt1hijWd9Zn7olc66j2s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394345AbfAPQzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:55:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388438AbfAPQzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:55:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA4E0205C9;
        Wed, 16 Jan 2019 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547657746;
        bh=jtcnC/mcLZU+TbEdK135MAXmenXTe5HLkT9c7675w4I=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=iegWhycqgGNRplk9dL5JBEZ0B7w5SWuGPNuSAdUrcjdGDnTaKhWl9NIjIQCYtbXiR
         btOKshbAy1+pCY4rrUkajJUsTUwEVg3fluXI/8gf4mlo5thpDkQKsuiqlSzuLceRkg
         8Rg84o6vtEQXrAI+C20toZ21ZQS/BdL7vRKvkxpA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] arm64: dts: sdm845: Add lpasscc node
User-Agent: alot/0.8
In-Reply-To: <20190116060910.GA6841@builder>
References: <1543996836-16717-1-git-send-email-tdas@codeaurora.org> <20190116060910.GA6841@builder>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, david.brown@linaro.org,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Message-ID: <154765774593.169631.13437519610171417596@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 16 Jan 2019 08:55:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-15 22:09:10)
> On Wed 05 Dec 00:00 PST 2018, Taniya Das wrote:
>=20
> > This adds the low pass audio clock controller node to sdm845 based on
> > the example in the bindings.
> >=20
>=20
> Applying this causes my MTP to reboot as clk_disable_unused() tries to
> disable "lpass_qdsp6ss_core_clk". Am I missing something?
>=20

Probably you need this patch[1] so that this "essential" clk isn't
turned off during clk late init.

[1] https://lkml.kernel.org/r/1545306385-31240-1-git-send-email-tdas@codeau=
rora.org
