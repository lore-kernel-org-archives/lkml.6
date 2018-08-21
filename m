Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169C7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DE1217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DE1217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeHUXC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:02:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36880 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:02:59 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9DF48144D396E;
        Tue, 21 Aug 2018 12:41:30 -0700 (PDT)
Date:   Tue, 21 Aug 2018 12:41:30 -0700 (PDT)
Message-Id: <20180821.124130.2115246742606446637.davem@davemloft.net>
To:     yamada.masahiro@socionext.com
Cc:     sparclinux@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: fix KBUILD_DEFCONFIG for ARCH=sparc32
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1534784908-11692-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534784908-11692-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Aug 2018 12:41:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 21 Aug 2018 02:08:28 +0900

> As commit 5ba800962a80 ("kbuild: update ARCH alias info for sparc")
> addressed, SPARC accepts ARCH=sparc32 as an alias.
> 
> However, arch/sparc/Makefile wrongly sets KBUILD_DEFCONFIG, then
> sparc64_defconfig is chosen as the base configuration for ARCH=sparc32.
> 
>   $ make ARCH=sparc32 defconfig
>   *** Default configuration is based on 'sparc64_defconfig'
>   #
>   # configuration written to .config
>   #
> 
> Fix the logic to choose sparc64_defconfig only when ARCH=sparc64.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thank you.
