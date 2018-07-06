Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B57DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4240722544
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="itQO7e44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4240722544
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934256AbeGFUfx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932884AbeGFUfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:35:52 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB58208C4;
        Fri,  6 Jul 2018 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530909351;
        bh=UQxY2M/c3GJcutj8OQT5qY9B/IyHv2/yZ1KvZUGs0Ao=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=itQO7e44ijQtAAJmFoOLBn4k4dhsVvR5WQFMscBiXSNJ7b82iDJZMz9JccxaiF3R4
         vZ31N8qtgH9tsXst1ELBmMSDob6Xeefn9a6vUrIOYgx0tAMN1zhzenlPVRQ4fannz/
         wq/3e44qAbg0hX9p9wl2G4zSGmRoSeRGtW/FSISI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180627121459.13987-1-paul@crapouillou.net>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
References: <20180627121459.13987-1-paul@crapouillou.net>
Message-ID: <153090935111.143105.11886484624639527247@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: ingenic: Fix incorrect data for the i2s clock
Date:   Fri, 06 Jul 2018 13:35:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2018-06-27 05:14:58)
> The register field for configuring the divider for the i2s clock
> occupies the bits [8-0], which means 9 bits and not 8.
> =

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

