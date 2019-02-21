Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108CAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05782083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550787344;
	bh=AUFBQOws4oanWvAcnM5BnuOTFGmO/8XE6bxIEqdDx9c=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=twAnSPY8nJ3Z0eLTXACyadcrpQuVnYdZJXX3rFdJ+slJXvuW6jY3XHZPck+Z7727b
	 6KfKzMp6OOP9r3nVcq1mBwNbsrO+pa/uE1or878th/y664hgxCqwFMR27cCRF1pxqT
	 HH58MOPwSZZ1d+5spEvrYBC9I/1VqnYgrlkKK6vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfBUWPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfBUWPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:15:42 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E954120818;
        Thu, 21 Feb 2019 22:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550787342;
        bh=AUFBQOws4oanWvAcnM5BnuOTFGmO/8XE6bxIEqdDx9c=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=ffdOdNO62uZcP5W0EdLXNoyPuaddRSFoyVNPec2cQboBu4D4Ur0bYJCphlh41Q1rx
         hB1Et0lq7i4Lqw0Y6z0KFo4jH3F/75rk1rJ6EUFqNSZVMaYxtMgEoyT+k5/7EfoM9A
         aBPtyHlhxhsT1xYRiD91TvDvEzV0+K7uljQoISeo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to Kernel clocks
Message-ID: <155078734102.77512.15900577675424235040@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104047.1173-1-gabriel.fernandez@st.com> <20190214104047.1173-3-gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104047.1173-3-gabriel.fernandez@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        gabriel.fernandez@st.com
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Date:   Thu, 21 Feb 2019 14:15:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-14 02:40:42)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> STM32MP1 clock IP offers lots of Kernel clocks that are shared
> by multiple IP's at the same time.
> Then boot loader applies a clock tree that allows to use all IP's
> at same time and with the maximum of performance.
> Not change parents on a change rate on kernel clocks ensures
> the integrity of the system.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next

