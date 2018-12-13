Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F49C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09282086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730575;
	bh=fwpEhYnAitTkI58HnEDWfuYQSDqXGjoA5pgdrzVMneE=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=cIIdpJXnrUjUe25HgJ/lUy5JEOot+BiQzIdT2i1IhM0KGBQJ/GjOwJwb4hBWDSrwi
	 iaOjxwMvPOIW2Q9bDrp/Cm0icrp+Iio7ORhIHEdYHwHjpg3lYeOCYT4BVeUpWm85Sv
	 dJgkd0nSrY9B26QXUV4PYvXj56j+LNzd2vghqLVw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09282086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeLMTte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeLMTtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:49:32 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB6D20870;
        Thu, 13 Dec 2018 19:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730572;
        bh=fwpEhYnAitTkI58HnEDWfuYQSDqXGjoA5pgdrzVMneE=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=EepJRaH5NyLnRVTer2m+JN+OSAj1JxO+3DQ4Thmq8znyg+WrODMDl1UXbRNGtw6f/
         H4o+2PULSAACGpAJrHgTueabG6dWegcwnAFstOyspyneLUcDA30yX55j4mmNhzkuyf
         Zma6vgvUPl3wq0tZc28mzwKBCm7p8f9dHEyZvH34=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181206215858.3880-8-sboyd@kernel.org>
Subject: Re: [PATCH 7/8] clk: samsung: s3c2410: Remove usage of CLK_IS_BASIC
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20181206215858.3880-1-sboyd@kernel.org> <20181206215858.3880-8-sboyd@kernel.org>
Message-ID: <154473057112.19322.13875835469680558809@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Date:   Thu, 13 Dec 2018 11:49:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-12-06 13:58:57)
> This flag doesn't look to be used by any code, just set in the clk init
> structure and then never tested again. Remove it from this drivers as it
> doesn't provide any benefit.
>=20
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

