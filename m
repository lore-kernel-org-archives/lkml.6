Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F10C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87AE20869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546026372;
	bh=127sI9LODAG2uJJMO8B/i+boOGLb35BZeBg7srVd7IE=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=FBtWK3FWq0fuKN6jdcIxZ8u0uYma+YBhgJhgNpVQn5H0ddPtF18h7jDdPK8qtMgZQ
	 wxJKf7aKgGnHcFAxfOhqR8TPeYlIRiOGoZU8eRQu/L+vWANey5xadBZlg/05pc3H+Q
	 V1l1i0MMl/EMifAm+1Sb9UOjgvTuKQHhgRswJdSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbeL1TqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:46:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387911AbeL1TqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:46:05 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE7A20866;
        Fri, 28 Dec 2018 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546026364;
        bh=127sI9LODAG2uJJMO8B/i+boOGLb35BZeBg7srVd7IE=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=c8Ca9Rm+upvxBpcf4/w4oUZBowgplKNSTFa02aegeoyi3OsMbmrnIh/e0uQ+JO1ao
         ij6UpWC1ReiGuhz5bOiwBhNQ4frmNozgS4XKgd+6y9ezAb9TUwk0qtRwq6ddD/gFQG
         oIe0x4cW3fOtirFvG62WZyQXxjShygWDUzhJn86c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, gregory.clement@bootlin.com,
        mturquette@baylibre.com
Message-ID: <154602636367.179992.9987310407760575451@swboyd.mtv.corp.google.com>
References: <20181226134226.5338-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: armada-xp: fix refcount leak in axp_clk_init()
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226134226.5338-1-tiny.windzz@gmail.com>
Date:   Fri, 28 Dec 2018 11:46:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:42:26)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

