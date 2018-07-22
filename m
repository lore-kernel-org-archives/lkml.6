Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA24ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 02:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478B120856
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 02:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478B120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeGVDW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 23:22:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48122 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbeGVDW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 23:22:29 -0400
Received: from localhost (unknown [172.58.46.180])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D3B47125F0ADF;
        Sat, 21 Jul 2018 19:27:34 -0700 (PDT)
Date:   Sat, 21 Jul 2018 19:27:33 -0700 (PDT)
Message-Id: <20180721.192733.1246311779113396139.davem@davemloft.net>
To:     linux@roeck-us.net
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: sfp: Do not use "imply HWMON"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532018499-16490-1-git-send-email-linux@roeck-us.net>
References: <1532018499-16490-1-git-send-email-linux@roeck-us.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 21 Jul 2018 19:27:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jul 2018 09:41:39 -0700

> "imply HWMON" was supposed to ensure that the SFP phy code can be built
> with HWMON enabled or disabled while at the same time ensuring that
> HWMON is not built as module if SFP is built into the kernel.
> Unfortunately, that does not work as intended. With "allmodconfig", it
> results in several unrelated HWMON drivers to be disabled instead of
> being built as module as expected.
> 
> Let's use the old "depends on HWMON || HWMON=n" instead. This is slightly
> different (it enforces SFP to be built as module if HWMON is built as
> module), but it is better than the alternative of using "IS_REACHABLE()"
> in the driver since that would disable sensor support if HWMON is built
> as module and SFP is built into the kernel.
> 
> Fixes: 1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thanks.
