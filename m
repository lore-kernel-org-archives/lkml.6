Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE1920869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546026374;
	bh=6vDKyStz3U+qD2sd6mXDWf/cyQJWestkUIPQZWkH/ME=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=aEFcBnwcrjsQVzj06nZUoFZHDdqrN7qy16LDgATFejioBqkLaarIjZpUVo9nipSII
	 We6I7MuxmQnkz+r+62LWW6kiccc6hGh9HyKwsVx42NVsCz/zZ1IFfq/CarM0C4jZZw
	 OURzv1mV+GD4IJhTHTUPAQNrRZx8kdrDADxwI3ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbeL1TqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbeL1TqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:46:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7596120866;
        Fri, 28 Dec 2018 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546026370;
        bh=6vDKyStz3U+qD2sd6mXDWf/cyQJWestkUIPQZWkH/ME=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=mQOQhKPQHH8nLcpSkJx+T4/ysRok3WZ9HqE5Zn2WMmqg48MFUMB5i7SmsEdGma+Ck
         o8jbLP5JLkmln8H/LyVSx/Yz5pw+KJ1oD/H1AafXa4V3POdxb6PSLthwpyjEpR8nLX
         dWRnBxiB3wqRVYtZe0PMHfkPFF/B80sF3tba/79E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, gregory.clement@bootlin.com,
        mturquette@baylibre.com
Message-ID: <154602636980.179992.17972346536488117543@swboyd.mtv.corp.google.com>
References: <20181226134019.5229-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: kirkwood: fix refcount leak in kirkwood_clk_init()
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226134019.5229-1-tiny.windzz@gmail.com>
Date:   Fri, 28 Dec 2018 11:46:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:40:19)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

