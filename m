Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852BBC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC74208DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcMNSpRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC74208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeGHX4i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 19:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932833AbeGHX4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 19:56:36 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27DD2208D9;
        Sun,  8 Jul 2018 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531094196;
        bh=+tI2gvS29CNO4/z8OI68cp07r5PBfRUtx+MyIewwpDw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=AcMNSpRLZtNOC2KERI08L18dsV9AU7OMJ9FznqxpeUIRfQ4kUChOEfu3h/wxCnqrD
         /MsLVnGdsX2/VYfKF+vEhy6h3EnXpZ6m3guAXTM2LhtowLyMUdvjKzBnEs0lWr5lOo
         +94w+yVPWAkUkxKJbt3ayy8y7z6jgwMqtcYjAzTA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mikko Perttunen <mperttunen@nvidia.com>, jonathanh@nvidia.com,
        mturquette@baylibre.com, pdeschrijver@nvidia.com,
        thierry.reding@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180629143814.17950-1-mperttunen@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, swarren@nvidia.com,
        vbhadram@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>
References: <20180629143814.17950-1-mperttunen@nvidia.com>
Message-ID: <153109419548.143105.6202239165158958607@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: tegra: bpmp: Don't crash when a clock fails to register
Date:   Sun, 08 Jul 2018 16:56:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mikko Perttunen (2018-06-29 07:38:14)
> When registering clocks, we just skip any that fail to register
> (leaving a NULL hole in the clock table). However, our of_xlate
> function still tries to dereference each entry while looking for
> the clock with the requested id, causing a crash if any clocks
> failed to register. Add a check to of_xlate to skip any NULL
> clocks.
> =

> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---

Applied to clk-next

