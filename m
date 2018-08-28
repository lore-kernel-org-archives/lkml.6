Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D622C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1514C2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0SYNDPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1514C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeH2CW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH2CW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:22:58 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76482087B;
        Tue, 28 Aug 2018 22:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535495353;
        bh=Cw+ypCjWBo0HBARh/ipnqKkkry/X8f5AZM/Wdxg3ndM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=F0SYNDPv5vY85baqdl+n+cokwEiz3lO03MeFIoPqqfRiZS7uqrpJzrni7JJxoZJNV
         m4G5sAqqo5x7fLHH17iHU6r1PttGeOun0DHJG7Xk4QUYJ4Omkyel9jue35/f2kfRcd
         mmy7LejtHvS9XaAG6pEzB1eTJNQC2thgi97L7GnU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Akshu Agrawal <akshu.agrawal@amd.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1534834341-18345-1-git-send-email-akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1534834341-18345-1-git-send-email-akshu.agrawal@amd.com>
Message-ID: <153549535306.129321.6563896874769936616@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: x86: Set default parent to 48Mhz
Date:   Tue, 28 Aug 2018 15:29:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akshu Agrawal (2018-08-20 23:51:57)
> System clk provided in ST soc can be set to:
> 48Mhz, non-spread
> 25Mhz, spread
> To get accurate rate, we need it to set it at non-spread
> option which is 48Mhz.
> =

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Does this need to go to 4.18 stable trees? I don't see a fixes tag so
I'm trying to understand merge priority of this patch.

