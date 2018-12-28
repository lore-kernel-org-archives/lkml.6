Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6DE20869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546025710;
	bh=fNpO/g3JeoJYQka0od3jblA+B3xDy5AR8CYpND42NeU=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=sFAG4YbwB/ObSxp97TO/5S0wVyBAIsEku49X46/04S0K0DdbuvNgVSSXyI/JkmSdK
	 iVDailUnvZ6fkN6HZNwc4QM1uIuo8gkXzjb3jNj5bx8zCCQz74IpqfwxqQPUEte+3u
	 +4z3ZU3DDP2Y3pIL66WS7Zx68WTp11O2Fxe/7qyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbeL1TfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbeL1TfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:35:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 446D220861;
        Fri, 28 Dec 2018 19:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546025709;
        bh=fNpO/g3JeoJYQka0od3jblA+B3xDy5AR8CYpND42NeU=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=xwh8is974BWWa3RkABZ8HzjA3CLTVWRLt3NMO9Xn4ADJizjvqnEsnODudOE8hMW9i
         sFEvV4IJuar0Y60GExe2vnufyIdzPDUNe27edH76aNbvPii3eeAS31LsoMmf+msVWs
         RZhBsCIEnSQW7Cc/D7es7CM+5V96OdicSOFm1LYU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, cw00.choi@samsung.com,
        kgene@kernel.org, krzk@kernel.org, mturquette@baylibre.com,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com
Message-ID: <154602570854.179992.17215224103148425228@swboyd.mtv.corp.google.com>
References: <20181226133215.4939-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: samsung: exynos4: fix refcount leak in exynos4_get_xom()
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226133215.4939-1-tiny.windzz@gmail.com>
Date:   Fri, 28 Dec 2018 11:35:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:32:15)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

