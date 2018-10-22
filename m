Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983ABECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9142087A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzTvFw9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9142087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeJVJ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeJVJ2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:28:40 -0400
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31FC82083E;
        Mon, 22 Oct 2018 01:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540170742;
        bh=Wzx181HzwZNznNZZ5g863Cye5ytWBlK/UdVQJdkeOc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzTvFw9+UhMXS6TL3oEgnBPZG7ljNS1W5xrNto6UlE3W9FlFUVmslcO4unliicxOz
         mnRsULv40vnFhTmexpz0x1uExlh6+tIpe3iWNZ093axPruaDRr/838m+JEeC2S125r
         A+zZ3J2n9O6oCikO7F1swQWf8vMlf33sHkHg7WZ8=
Date:   Mon, 22 Oct 2018 09:12:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jun Nie <jun.nie@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] thermal: zx2967_thermal: simplify getting
 .driver_data
Message-ID: <20181022011203.GA13039@tiger>
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021200053.2194-6-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00:52PM +0200, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
