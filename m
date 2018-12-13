Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E12C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43B02086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730552;
	bh=j1zJckHYvOibxSVf1pYDhZ57eNO8GvumEkCm8mFlNd0=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=ulYqZUemYc7odyBVglpG3VrnYk1gHEemBxYohaq0N0afcBUwrtOOD1NYLQv5qAQ0N
	 Ak9l4UitHsDnSGDpBbxhlq/rO5KIBLvUme9unO/PuAA7I11QVUhivZM+cP9DsQqOLP
	 phMu24ltupdK9AR5u2iTH7xdEhQBa398O/DbWou8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43B02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeLMTtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:49:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbeLMTtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:49:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D932086D;
        Thu, 13 Dec 2018 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730550;
        bh=j1zJckHYvOibxSVf1pYDhZ57eNO8GvumEkCm8mFlNd0=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=edExN7TlQdnfvZNHsLneo3YL6Mz7d9GHnWcCDNZX+y0CzEgqQpA/vkpxou49gcEqR
         bOCun66emjsTWiSMt1btNhMevY2y00w8ItuMPwo2P9DwmWIFYwQwN8JQ71eUQsjx9S
         m7qyRt/0GTnUC+R+36aE2lCkL9JHZeKa+tfWBF98=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181206215858.3880-4-sboyd@kernel.org>
Subject: Re: [PATCH 3/8] clk: axm5516: Remove usage of CLK_IS_BASIC
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20181206215858.3880-1-sboyd@kernel.org> <20181206215858.3880-4-sboyd@kernel.org>
Message-ID: <154473055009.19322.9701732089486298079@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Anders Berg <anders.berg@lsi.com>
Date:   Thu, 13 Dec 2018 11:49:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-12-06 13:58:53)
> This flag doesn't look to be used by any code, just set in various clk
> init structures and then never tested again. Remove it from these
> drivers as it doesn't provide any benefit.
>=20
> Cc: Anders Berg <anders.berg@lsi.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

