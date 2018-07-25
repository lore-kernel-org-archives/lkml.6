Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6345C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D9220852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfyrnbmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D9220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeGYRnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbeGYRnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:43:04 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCFB5204EC;
        Wed, 25 Jul 2018 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532536239;
        bh=EaVoYjQdBx9/3lRavseUAcFEV1qkUDTM2ZL7YrB5MV0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=CfyrnbmqvNZxw416YJCLQQIvRXEH3YY1KL7I5F7E+J0+90umO+u6EQ3htyDYBVjp9
         5Mog09W6uy6wimmU1FdVblp/w0x41wbJFMFKYWtg8YRYVjuQRfpf9wOQDwri55QkBa
         DUghWGMtpQEYBPNfgYvWitgUKZhLixyHk4q+sfCU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mikko Perttunen <mperttunen@nvidia.com>, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180711082104.27955-1-mperttunen@nvidia.com>
Cc:     leonard.crestez@nxp.com, cyndis@kapsi.fi,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20180711082104.27955-1-mperttunen@nvidia.com>
Message-ID: <153253623910.48062.11060369743420676475@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: core: Potentially free connection id
Date:   Wed, 25 Jul 2018 09:30:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mikko Perttunen (2018-07-11 01:21:04)
> Patch "clk: core: Copy connection id" made it so that the connector
> id (con_id) is kstrdup_const'ed to cater to drivers that pass non-
> constant connection ids. The patch added the corresponding kfree_const
> to __clk_free_clk, but struct clk's can be freed also via __clk_put.
> Add the kfree_const call to __clk_put and add comments to both
> functions to remind that the logic in them should be kept in sync.
> =

> Fixes: 253160a8ad06 ("clk: core: Copy connection id")
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---

Applied to clk-next

