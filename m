Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A90EC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E894420861
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546025630;
	bh=S7hlkszr2TgVRwbGCQ2OkSbWKB7OqVE4ApxXBMUD8kE=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=MR78t/ZMAytdysHN1jnzAtMbsvXUOTCQ4nEijBMq0w6p9AMoPZBeUXi2+jqqCo0W8
	 jx3jWBq0uWoUFg2w78syCEr4TNOUPHY/kc6+d1+ihQG1H8yj1v0Ygwd6iZjHF9dmAV
	 exdm6g4DRCSLy+q3XH+MhSbofc5DBMS3+WzJAR1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbeL1Tdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbeL1Tds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:33:48 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B177E20861;
        Fri, 28 Dec 2018 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546025627;
        bh=S7hlkszr2TgVRwbGCQ2OkSbWKB7OqVE4ApxXBMUD8kE=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=U9u1hWrWl3x3mUzrXx2DwgE45c3L72pqHhl4I0Nizu4VvPTNfaE8pHrF/s1dHzgIp
         NrA8AbTkyOT7ozOy7jWkDbYgqDFcDc1ejcDRlSmkoRO3JDlbmCL3MXrvZAU4cWDJZH
         SVMHB6ZaTDvS1hesa3tdlBUk3LrpPwus/tpfMRa0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, dinguyen@kernel.org,
        mturquette@baylibre.com
Message-ID: <154602562686.179992.14804305363916376345@swboyd.mtv.corp.google.com>
References: <20181226132902.4807-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: socfpga: fix refcount leak
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226132902.4807-1-tiny.windzz@gmail.com>
Date:   Fri, 28 Dec 2018 11:33:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:29:02)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

