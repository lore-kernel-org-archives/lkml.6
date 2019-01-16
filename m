Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D28FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589D320840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547678163;
	bh=4OBXSwgqPCQ4syk3N0wXCAqDt+UDaPlt4orBGi6gmCY=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=awr7wIy8uAUipp6JsCJvpMmFfUAglCpKhhRhLQuP4YYFToEg6kJlV8usSikIvDqId
	 2LRwYZ0FzmScvY/E9GyOvLn/slQcEqZyknFKyxxBB+oGGodtGt98dxaRT+4knVFnHF
	 nJtVijKo1BVfAjzLjmoXKaRN+bQjXD44EDIW1E9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbfAPWgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:36:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732911AbfAPWgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:36:01 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B246D20652;
        Wed, 16 Jan 2019 22:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547678160;
        bh=4OBXSwgqPCQ4syk3N0wXCAqDt+UDaPlt4orBGi6gmCY=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=r4Zyf2KarABTVwjGXgitvgyIKxz2F4ADbaPgiXLFhAxZk1SvwIcVtG2Q+Z347XC9b
         X0n/1SOxnmjc1Vtz3ob0owDtKbiwG2aJd4nRzHMeeJJ9JiWvJ0A2osYO9T2IPAoTev
         5GPBuYYpNJ83zzV9HasqJ9X7/q+3kLrq15+etZDs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: Fixes tag needs some work in the clk tree
User-Agent: alot/0.8
In-Reply-To: <20190116083440.11b6839c@canb.auug.org.au>
References: <20190116083440.11b6839c@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <154767815973.169631.1738587342757192096@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 16 Jan 2019 14:35:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2019-01-15 13:34:40)
> [I am experimenting with checking the Fixes tags in commits in linux-next.
> Please let me know if you think I am being too strict.]
>=20
> Hi all,
>=20
> Commit
>=20
>   b488517b28a4 ("clk: socfpga: stratix10: fix naming convention for the f=
ixed-clocks")
>=20
> has a malformed Fixes tag:
>=20
>   Fixes: 07afb8db7340 ("clk: socfpga: stratix10: add clock driver for
>   Stratix10 platform")
>=20
> It should not be split over 2 lines.

Ok sure. Does this matter to scripts? Is it documented in
Documentation/process/submitting-patches.rst? I've seen both types, one
line or many lines, so I'm happy to mandate a policy as long as it's
documented. Maybe also checkpatch can complain about this so that people
don't submit patches "the wrong way".

