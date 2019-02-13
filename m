Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFC3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609DF222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550080271;
	bh=M8OX7DAfgjA4BmIZQHSOoHfhCCqbtDKSJFWpNYBMJDw=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=xEAq8PF9F7+jmK4MmqkYdMc/n6OOG+cKIiM+R7AkzRZ7Xa7NuwXXVWMNCcM8w8G7+
	 MuKYc/bHisClJDyx5c6aW/PZ20I2vyiltErW1lDHnycPwvwbgLAFUKQCzHcNFeScK8
	 AXbTeNcymwJOm3u69YZv6SQH3v+LhjM1gEqqTIXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393421AbfBMRvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfBMRvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:51:09 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E78262086C;
        Wed, 13 Feb 2019 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550080269;
        bh=M8OX7DAfgjA4BmIZQHSOoHfhCCqbtDKSJFWpNYBMJDw=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=IWu8mBNMUwltZra2fwg+9FzQJeei4xmCct+BTmd5tIKuwWn8Zxzsa6hcnIkQTerrw
         Ihnw6SJQ3EH+9D0ytFSGz28IQXPumqap5BNmJMIvdA+hykAUAzJGoSomi0h4kFrQZX
         WsRnDhUMo2vDx/18qlwaOTXPhdSA1N7S9TQMCcZ4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        gabriel.fernandez@st.com
In-Reply-To: <20190212135154.2733-3-gabriel.fernandez@st.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 2/7] clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to Kernel clocks
Message-ID: <155008026820.115909.7140639192549039808@swboyd.mtv.corp.google.com>
References: <20190212135154.2733-1-gabriel.fernandez@st.com> <20190212135154.2733-3-gabriel.fernandez@st.com>
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 13 Feb 2019 09:51:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-12 05:51:49)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> Don't change parent during a set rate for Kernel clocks.

Why?

