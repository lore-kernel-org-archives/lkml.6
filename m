Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADBCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D152145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D152145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJPM7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:59:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43544 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbeJPM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:59:40 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 703451454BEB4;
        Mon, 15 Oct 2018 22:11:03 -0700 (PDT)
Date:   Mon, 15 Oct 2018 22:11:02 -0700 (PDT)
Message-Id: <20181015.221102.256116443101349517.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, opendmb@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: Poll internal PHY for GENETv5
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181011220633.24450-1-f.fainelli@gmail.com>
References: <20181011220633.24450-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 22:11:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 11 Oct 2018 15:06:33 -0700

> On GENETv5, there is a hardware issue which prevents the GENET hardware
> from generating a link UP interrupt when the link is operating at
> 10Mbits/sec. Since we do not have any way to configure the link
> detection logic, fallback to polling in that case.
> 
> Fixes: 421380856d9c ("net: bcmgenet: add support for the GENETv5 hardware")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied and queued up for -stable.
