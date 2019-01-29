Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6790DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3868A21848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548785126;
	bh=UXXKUNI73cmyYpz+wrJMrhKRCBo97XvqotD/XeWdvL0=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=yalFwasu1YGxplPLeS8PAe+01DRQUH0zi7S2gAfSF5W2aACItuP3TeTk7C/pw7X1B
	 LlpFFbpVmL7pTNDZZ3itSRe9Es3SKi9wsh199frWiAcRWHxpt8q4HBqrht/FAh7eAv
	 3PJCFzy1zyZe8B8e6L/uDXmLxcDbAe6e3ivrAvMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfA2SFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbfA2SFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:05:23 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90DC621848;
        Tue, 29 Jan 2019 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548785122;
        bh=UXXKUNI73cmyYpz+wrJMrhKRCBo97XvqotD/XeWdvL0=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=EuqlRJ96SKeC2oksHrYcCM8ZFfc7UwICC6yXW4sLzxOwzr2yvIY5y2Nu2/yZrf/6V
         G1FQAeKGjsXfoIncT57cWlMKOa2UDS4YFvUtT9k2adrSX07jAnXt20N+owEHQ+vhXg
         pmObpHNNDiNvvRI2maVXX7iUJ+rTnxagGmKirn3A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/14] clk: export some clk_hw function symbols for module drivers
References: <20190128180430.28689-1-jbrunet@baylibre.com> <20190128180430.28689-2-jbrunet@baylibre.com>
User-Agent: alot/0.8
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128180430.28689-2-jbrunet@baylibre.com>
Message-ID: <154878512192.136743.2997052288990015458@swboyd.mtv.corp.google.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Tue, 29 Jan 2019 10:05:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-01-28 10:04:17)
> clk-provider.h provides clk_hw_is_prepared(), clk_hw_is_enabled() and
> clk_hw_is_prepared() but these symbols are not exported for the
> modules which prevents a clock driver using them to be compiled as
> a module. Export them to fix the problem.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

