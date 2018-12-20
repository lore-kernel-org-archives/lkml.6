Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146C821905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545340544;
	bh=8Eag9tEeLAOkPfHOvwKQIBsJzR2egdr+WAQlC5teXCg=;
	h=To:References:Cc:From:In-Reply-To:Subject:Date:List-ID:From;
	b=w1qcz2gwT1rfZig/7yKeLVoy5dJFShEt6wt3gTBGEOZ/R9uYquAGTfSQbxvMgFIYa
	 1SNx5Ynjlf+S+lvw3EO/xVO+2RO9BRESE3hR0NoOrVzvW0ZZNPiJuHM9BfBjhbumik
	 fmIJMkM1UuJkVa3ZV7on+/HY6lS78BDTS/2tUn7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbeLTVPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbeLTVPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:15:42 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CB48218F0;
        Thu, 20 Dec 2018 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545340542;
        bh=8Eag9tEeLAOkPfHOvwKQIBsJzR2egdr+WAQlC5teXCg=;
        h=To:References:Cc:From:In-Reply-To:Subject:Date:From;
        b=HG+oagdZ7lQIl8JfYm8JmL4S7dgqWiQCkIpy3pLluT4AbyG6y4d9mfGjqKoCGTrEF
         IXCn2XpXT8GMvORKYpY5qxBPhgab56OMoTWfyBEyFh5vwbW9alDqquCyVXiLUTnc3U
         +O5m0WIOpV0uwajqXZIk0zmUDm1VYbVe1nCNXyM0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: alot/0.8
To:     Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20181024013132.115907-1-dbasehore@chromium.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        mturquette@baylibre.com, heiko@sntech.de, aisheng.dong@nxp.com,
        mchehab+samsung@kernel.org, corbet@lwn.net,
        Derek Basehore <dbasehore@chromium.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181024013132.115907-1-dbasehore@chromium.org>
Message-ID: <154534054131.79149.12015186156265337224@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 0/6] Coordinated Clks
Date:   Thu, 20 Dec 2018 13:15:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Derek Basehore (2018-10-23 18:31:26)
> Here's the first set of patches that I'm working on for the Common
> Clk Framework. Part of this patch series adds a new clk op,
> pre_rate_req. This is designed to replace the clk notifier approach
> that many clk drivers use right now to setup alt parents or temporary
> dividers. This should allow for the removal of the
> CLK_RECALC_NEW_RATES flag and the implementation of a better locking
> scheme for the prepare lock.

Are you going to resend this series? I can do a review but I wonder how
much it will change anyway.

