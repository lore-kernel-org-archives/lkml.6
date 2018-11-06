Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C783C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E082085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDQ+W5zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E082085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389690AbeKGDI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389275AbeKGDI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:08:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D2AE2085B;
        Tue,  6 Nov 2018 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541526157;
        bh=XOgGZAOFdqS3k3Tez8lni4MGLio6W2YeQhlOrHj8rLI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=hDQ+W5zRcguuA1XeQQKVjJ1Me5NNVPXXkRaI+kmY6JthnbJEI0bGCxEUlTMWmo3k8
         B0+CdpEfkW6MLNXJA3tJA+epUT3hjYzr/VxjyimSgTE7FjVIMQgXgkIxXBKT9BOyIu
         RN4acC4BDG+DBPCF/fO2+33JyzzLfu7qcAueGE2s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1540619262-22681-4-git-send-email-Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540619262-22681-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <154152615653.88331.17161218433869955843@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/8] clk: palmas: constify clk_ops structure
Date:   Tue, 06 Nov 2018 09:42:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julia Lawall (2018-10-26 22:47:37)
> The clk_ops structure is only stored in the ops field of clk_init_data
> structures.  This field is const, so the clk_ops structure can be
> const as well.
> =

> Identified and transformed using Coccinelle.
> =

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> =

> ---

Applied to clk-next

