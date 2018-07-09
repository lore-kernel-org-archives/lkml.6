Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961BFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4412B208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlqlTMhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4412B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933317AbeGIANU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933079AbeGIANS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:13:18 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87941208DB;
        Mon,  9 Jul 2018 00:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531095197;
        bh=hfwxmQgDtb/r0mzl5gg2f0WngbyBkMIitAnRd2ZxiF8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=JlqlTMhAuqI7FSoSnIhDud5sTd0wtMjiJvE/4duFQQjb8VIUStKyc8GqR1Egi9B66
         NYSS9GTQ79lsRGILO2Cmtsl6fO9t2vXhH+1OTjup37EhgpzK7ytPcaVdeLPlBUfEb+
         W2HZ84L/K5wTHiHK0JTxat083/Qcq4FWeCChs3nU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dmitry Osipenko <digetx@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180605121232.7121-1-digetx@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180605121232.7121-1-digetx@gmail.com>
Message-ID: <153109519683.143105.5234021316802477195@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1] clk: tegra: emc: Avoid out-of-bounds bug
Date:   Sun, 08 Jul 2018 17:13:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2018-06-05 05:12:32)
> Apparently there was an attempt to avoid out-of-bounds accesses when there
> is only one memory timing available, but there is a typo in the code that
> neglects that attempt.
> =

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied to clk-next

