Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7D820866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546026383;
	bh=uXJd8IZ1PNumWdx2uYY+UIcfRd3zfh0Ov0ERRVcqgPg=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=F1ymZsCdUqm2z3ETOhVifkp8ftu0rGvRkFVd7k0RZJuquUsmxA5SGqxkS6VrpkiOY
	 vat+F7xw4vDNS4WKCjyARrcDofZvXUg/HD/8zFP2EAAPUvznAnwXwHigSDxRnHqs3f
	 JX06fU6NFsrNYQhMP6V2TlQ4sqx87wEp+H2Kdqgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbeL1TqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387954AbeL1TqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:46:21 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4DE20866;
        Fri, 28 Dec 2018 19:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546026380;
        bh=uXJd8IZ1PNumWdx2uYY+UIcfRd3zfh0Ov0ERRVcqgPg=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=Aj82qTa2QH3dxTqLn312g7AvtSikt+j5NVIH6Q1ugHbIAVGEEpGkaeUGJNwEptaJe
         IRl99CVALViipw2DThC6Lq9kKpcdl6Rl9tIe3xPRbPqhtmYZeTfQhj9TqSlAHWakAU
         VPbXglDLSZgzAipqDiF8u0PRGzxaK9EBPabRGuqI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, gregory.clement@bootlin.com,
        mturquette@baylibre.com
Message-ID: <154602637977.179992.16699867972525520096@swboyd.mtv.corp.google.com>
References: <20181226133658.5095-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: armada-370: fix refcount leak in a370_clk_init()
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226133658.5095-1-tiny.windzz@gmail.com>
Date:   Fri, 28 Dec 2018 11:46:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:36:58)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

