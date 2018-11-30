Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B38C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCA12146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq+I7LeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCA12146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeK3Rzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:55:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeK3Rzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:55:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166FD20863;
        Fri, 30 Nov 2018 06:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543560444;
        bh=k00Kyz0bOoUiNJk5/ViRHfM2wN0VmnuKK832rMILqMk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Oq+I7LePdXVAdv/PxJ/p0BMaUoc7v4CpCmONDMI629/bJ/rW7zRvbvj1EdCzXr8RI
         9NvNgzZGuteGDXoSHGQnJBUY5Yh3eIpLRwHS8yWejINlJHz+2rWrfryoE0jmvvt0Tr
         IektJnUA8UJapvWM619CXEOX3lO1NE7RZylADdwY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     matthias.bgg@gmail.com, matthias.bgg@kernel.org,
        mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181116180901.17737-1-matthias.bgg@kernel.org>
Cc:     jasu@njomotys.info, sean.wang@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
Message-ID: <154356044342.88331.13729809794593193239@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/3] Mark clocks as critical for MT6797
Date:   Thu, 29 Nov 2018 22:47:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting matthias.bgg@kernel.org (2018-11-16 10:08:58)
> From: Matthias Brugger <mbrugger@suse.com>
> =

> Jasper send this series some month ago. As there was no reaction from
> his side, I'll do a friendly take-over.
> I tested the patches on my Helios X20 boards and they fix the issue.
> I didn't add a Tested-by tag as I added my Signed-off-by.
> =

> Changes since v1:
> - add a fixes tag.
> =

> ---
> =

> Currently, DRAM-related clocks and the axi_sel MUX are not marked with
> CLK_IS_CRITICAL for MT6797. This causes memory corruption when the
> system is booted without clk_ignore_unused.
> =

> This patchset
> =

> 1. Makes it possible to mark outputs of MUXes as critical by introducing
>    a new macro, MUX_FLAGS,
> 2. Makes it possible to mark gates as critical by adding flags to
>    mtk_gate, and
> 3. Marks axi_sel, ddrphycfg_sel, infra_dramc_f26m and infra_dramc_b_f26m
>    as critical.
> =

> The addition of flags to mtk_gate also exists in the patch series "Add
> basic and clock support for Mediatek MT8183 SoC" [1].  The type of
> flags is unsigned int in that series, but the real type is unsigned
> long, so my patch differs from that patch.

Will anyone from Mediatek review this? Why aren't the people who signed
off on drivers/clk/mediatek/clk-mt6797.c included on this patch series?
They no longer work there?

