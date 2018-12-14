Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B71C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74D0208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544823756;
	bh=mJ61LZ819RxsF5MJY95/v++4kh1lVk6JZ1L1UATyzJ0=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=BZ7C/9lMHFB0u/pgFT/13Y7hpecoWGfdhnJMZzW/NBSeyvMCbN0W8vCoYGY2Iwg4s
	 O0G/NGH0gG/WsUsZ/shkJIB6nEN39eGwauseTug47TcyVbRthGuvYdPOL0Mx5G4CF2
	 tplft/rcknFqOyn5u5W+f7iSG5+VdczkDsyd4VZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbeLNVmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730758AbeLNVmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:42:35 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C0A2086D;
        Fri, 14 Dec 2018 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544823755;
        bh=mJ61LZ819RxsF5MJY95/v++4kh1lVk6JZ1L1UATyzJ0=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=qNYLQsMLPUp2ecRw5B5idtxmRhD4QzZ6aMhgh9MGEiKbA6VIoe9RQt3HNAOPKcS7v
         rHwUVKvhtVx95GVObwghuz0aL0bF46rdZgbJmoqTPN87CMhLBm1Y9t2CaHH+Oepr6m
         U3Ol8EaXoFojzZ2dztuVBMBBYDbbDJNvcXjjOuhM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544720949-18404-1-git-send-email-jhugo@codeaurora.org>
Subject: Re: [PATCH v2] clk: qcom: Drop unused 8998 clock
To:     Jeffrey Hugo <jhugo@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com
References: <1544720949-18404-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154482375375.19322.34902486824656539@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, Jeffrey Hugo <jhugo@codeaurora.org>
Date:   Fri, 14 Dec 2018 13:42:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-13 09:09:09)
> gcc_lpass_trig_clk is not used downstream, therefore there is no reason to
> expect it to be needed for clients.  Let's remove it because messing with
> the clock has been observed to cause Linux hangs when the qdss_clk is
> initialized by rpmcc.
>=20
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---

Applied to clk-next

