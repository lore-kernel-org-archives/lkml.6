Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305BE20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDolSMu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305BE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbeGYRwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbeGYRwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:52:12 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E353920882;
        Wed, 25 Jul 2018 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532536785;
        bh=4kSjaYFprfp9AWf3Jvl+O0ClbFs/qzeKfpwTqF1pvqQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=NDolSMu73E21kMu1pnd+FX8S0rwgmtald2wF5BcZsVqXdeKvQJLPhIOgxGmAyyXVe
         tV9dnO27c9yQGuTm4cjxHFC4VY8rp9HOMvZgtPDGY1etL17I+Wpgd0MrWHEwIOd4mY
         jvG1FZejueKEacYRzptDIJ1qF0O0Ty55gE3knx9E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rajan Vaja <rajan.vaja@xilinx.com>, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531833420-27175-1-git-send-email-rajan.vaja@xilinx.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
References: <1531833420-27175-1-git-send-email-rajan.vaja@xilinx.com>
Message-ID: <153253678426.48062.18003542444197103522@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: clk-fixed-factor: Clear OF_POPULATED flag in case of failure
Date:   Wed, 25 Jul 2018 09:39:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2018-07-17 06:17:00)
> Fixed factor clock has two initializations at of_clk_init() time
> and during platform driver probe. Before of_clk_init() call,
> node is marked as populated and so its probe never gets called.
> =

> During of_clk_init() fixed factor clock registration may fail if
> any of its parent clock is not registered. In this case, it doesn't
> get chance to retry registration from probe. Clear OF_POPULATED
> flag if fixed factor clock registration fails so that clock
> registration is attempted again from probe.
> =

> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---

Applied to clk-next

