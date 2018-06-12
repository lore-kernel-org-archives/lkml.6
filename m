Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 25D02C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA685208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuF+K0hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA685208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbeFLHqG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933183AbeFLHqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:46:05 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C5820693;
        Tue, 12 Jun 2018 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528789564;
        bh=ugtdwQ8fHPQjlVydptCHE8GBCon3MxaMjcIkLsyuLxY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=AuF+K0hD+UKO0Hz2GyBgiSeJzjRlmHoVPpeJ1slLCLh1faTF58ZqmjIyULsryaut/
         WInTPf/hToNXCGVD8eHGLlEregdaIY86AQqGUiF9pgFbc5SFP8SW3VHC/S1aPqCRkn
         XEBEumBwliC4Ql21OXuW+mvHRHgBcqvi23ls2qfM=
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
Message-ID: <152878956397.16708.14349666570210193783@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1] clk: tegra: emc: Avoid out-of-bounds bug
Date:   Tue, 12 Jun 2018 00:46:03 -0700
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

Fixes: tag?

