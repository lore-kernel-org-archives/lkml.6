Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902F2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C4F2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544494381;
	bh=1OSvtFaQq6P1XEzWAYQcCvidSvCuOqcP/zeyayT5R/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y9AnHZntSl3JEWU7Nt2eXZ89EQS6jt3MhK63qmY9ecqk9XBo77jkxLlty61JWhFcY
	 xxoalH+0oLI/YlcAvb9B3yc5Wwb5hPaMltZNr1vYvlXllpUc0dD5p6JR8NbOyMJseJ
	 prB7wJkJqm4UvnTi5N3MgGOZ77NVcs/O52K0kJu8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C4F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbeLKCNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeLKCNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 21:13:00 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 815F820672;
        Tue, 11 Dec 2018 02:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544494379;
        bh=1OSvtFaQq6P1XEzWAYQcCvidSvCuOqcP/zeyayT5R/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wux8QDHHAwXG7XertLHqx8AaFDNfDFGgirzfr1QUFIxq8I5pkfOw1gBdR0WCw/tD3
         q5nwhqqalXbW3MuBcOOeb5UqRswO9L8r9h3Th20hV3L8TL9OFrOpVzzIQ96xmt9CfD
         eNHzr0+68KHq4hY/Vp0vDhEa23Ku6n2uVT4uhBa4=
Date:   Tue, 11 Dec 2018 10:12:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jun Nie <jun.nie@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT 05/10] i2c: zx2967: use core helper to mark adapter
 suspended
Message-ID: <20181211021205.GS3987@dragon>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210210310.12677-6-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:03:03PM +0100, Wolfram Sang wrote:
> Rejecting transfers should be handled by the core. Also, this will
> ensure proper locking which was forgotten in this open coded version
> and make sure resume mark is set after enabling clocks (not before).
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
