Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00B7C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743342148E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNACq+tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743342148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJQGWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJQGWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:22:40 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03B421470;
        Tue, 16 Oct 2018 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539729008;
        bh=bkRrj3KBwz2z8I8BqlWdPJMDHib8x7wDP3jjC4YVpZ0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=pNACq+tucT+YUERyj3AcVdtlb8D6u7oVKcwy0c5QLEbQ03ldGgo6Bg0DLZdYu3w3y
         OhTZL2i717rP9Vcu4NW5+j6G0Kp5rr6IJu1qdqZcBAN2SC3NM6OcYM7uCigiX94zuE
         bNcHNus661/ptcM5E3GsZXEwmGl7Ru4T/8RckQzM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180814091805.1363-1-marcel@ziswiler.com>
Cc:     Stefan Agner <stefan@agner.ch>, Peter Geis <pgwipeout@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
References: <20180814091805.1363-1-marcel@ziswiler.com>
Message-ID: <153972900814.5275.3822404544995929863@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: tegra: probe deferral error reporting
Date:   Tue, 16 Oct 2018 15:30:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marcel Ziswiler (2018-08-14 02:18:05)
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> =

> Actually report the error code from devm_regulator_get() which may as
> well just be a probe deferral.
> =

> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> =

> ---

Applied to clk-next

