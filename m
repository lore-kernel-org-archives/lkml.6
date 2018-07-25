Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3231C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24C720852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJd2VZNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24C720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbeGZA5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731420AbeGZA5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:57:31 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC04020843;
        Wed, 25 Jul 2018 23:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532562211;
        bh=Xpz05yOHXuOaXz5yICYb5lLz8DSVKMe03Lva9oeOe5M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=nJd2VZNLobe2r9v75BPM13p8i84y7EdzDV/JWBLTDOHGesWCqXSVPjcWgNyrHKQMn
         0lX+HwtdDHPw6iTQegnVY+xamKH7AWSOnr1nRKU9RD0UDL90uTMFWiPLbYJVn1e/rU
         XT0F8q1rxV7D1WwZ+TTpzr7OkGJbXt29+O5SMNAg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        linux-mips@linux-mips.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180722212010.3979-16-afaerber@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-16-afaerber@suse.de>
Message-ID: <153256221029.48062.5074371246522411479@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 15/15] clk: pistachio: Fix wrong SDHost card speed
Date:   Wed, 25 Jul 2018 16:43:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andreas F=C3=A4rber (2018-07-22 14:20:10)
> From: Govindraj Raja <Govindraj.Raja@imgtec.com>
> =

> The SDHost currently clocks the card 4x slower than it
> should do, because there is a fixed divide by 4 in the
> sdhost wrapper that is not present in the clock tree.
> To model this, add a fixed divide by 4 clock node in
> the SDHost clock path.
> =

> This will ensure the right clock frequency is selected when
> the mmc driver tries to configure frequency on card insert.
> =

> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

