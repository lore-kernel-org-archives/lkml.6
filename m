Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E70C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C717218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548356153;
	bh=srTkUatcA9i4woWF0ZV0ocQuNChneTT+GsJnt9Ex5yY=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=iE9X9wFSTc1TN3pzl5AozwB5VXoVkJwQEhfH78fkbbEc/tlCJE27ao5P7SVdYkR8f
	 rVJOS66lAA6XIRxA/RD9jtSBgqbzqDe5R7/NZ1HQ3S5ee2mpFS93imu1W9QVNBR1SO
	 Zkej5NrMTw8C1633Tl8QAeg2uX3o8gkPgd9j6pYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfAXSzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfAXSzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:55:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD42218A6;
        Thu, 24 Jan 2019 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548356149;
        bh=srTkUatcA9i4woWF0ZV0ocQuNChneTT+GsJnt9Ex5yY=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=m2AROoM0B0UJdl/r1kb5Mep/kxAguCYDQ20S/wWfufX0JfRIhgNF4q1mdw40CTTrh
         i2+5uYGJUWoVONwNqxpR7LkILoS4kGRNOoLbd3qWGmT2iBSLlkOpmw3aqI2miHi5pC
         Nl3lL007NSDBJH3sCtPGkYHoMmCVbBGSbxg7JkcE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] Revert "Input: olpc_apsp - enable the SP clock"
References: <20190121062255.551587-1-lkundrak@v3.sk> <20190121062255.551587-2-lkundrak@v3.sk>
User-Agent: alot/0.8
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190121062255.551587-2-lkundrak@v3.sk>
Message-ID: <154835614871.136743.8711596686877554586@swboyd.mtv.corp.google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 24 Jan 2019 10:55:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-01-20 22:22:54)
> Turns out this is not such a great idea. Once the SP clock is disabled,
> it's not sufficient to just enable in order to bring the SP core back up.
>=20
> It seems that the kernel has no business managing this clock. Just let
> the firmware keep it enabled.
>=20
> This reverts commit ed22cee91a88c47e564478b012fdbcb079653499.
>=20
> Link: https://lore.kernel.org/lkml/154783267051.169631.319783654464662574=
7@swboyd.mtv.corp.google.com/
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-fixes

