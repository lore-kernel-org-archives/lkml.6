Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645F2C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F3021A61
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F3021A61
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbeGGLFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:05:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51148 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeGGLFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:05:30 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5DC2C11AB72AE;
        Sat,  7 Jul 2018 04:05:28 -0700 (PDT)
Date:   Sat, 07 Jul 2018 20:05:26 +0900 (KST)
Message-Id: <20180707.200526.1062008433639194322.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     nikolay@cumulusnetworks.com, jiri@mellanox.com,
        yotamg@mellanox.com, roopa@cumulusnetworks.com, petrm@mellanox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: fix br_vlan_get_{pvid,info} return
 values
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180706124420.3129099-1-arnd@arndb.de>
References: <20180706124420.3129099-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Jul 2018 04:05:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri,  6 Jul 2018 14:44:02 +0200

> These two functions return the regular -EINVAL failure in the normal
> code path, but return a nonstandard '-1' error otherwise, which gets
> interpreted as -EPERM.
> 
> Let's change it to -EINVAL for the dummy functions as well.
> 
> Fixes: 4d4fd36126d6 ("net: bridge: Publish bridge accessor functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
