Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB66EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9260217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548225465;
	bh=LHe8tLEvC9L9N0vYY06t+3CDW5O/JAq/oAlw0Lyp6Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fUPCcvribPhmmfyqyfWWxEeEcxVqdS5cP55GJBzsEQXlaPQo48lYwCF2k5HXY7x19
	 JTTd++yCmpYxnfJgPpm55tu/YVL0JRiWgvssWhvIEleyuoSHpCjwtvMc3hCfS96HJI
	 WGpqjprZaIKVLssuo0KTYtsnURVkrS04HRPyjNnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAWGho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfAWGhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:37:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BACC321019;
        Wed, 23 Jan 2019 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548225463;
        bh=LHe8tLEvC9L9N0vYY06t+3CDW5O/JAq/oAlw0Lyp6Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acA+eNTJNwiYPWtBMdQSLvzlbFpP7hCnICD6QmDiQFm1UknM5Rax5riE7FiSbOnlq
         TbQz9LpiFL+cqhxY9AX0CSo7qcbokTVqt8iJBpjanI5Ze25tWcvcKPV/kHfvL+VJpT
         rWyZUhkTQD4RvGynQUUULmPL+67UHC80MM35i5gM=
Date:   Wed, 23 Jan 2019 07:37:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/6]  misc/pvpanic: preparing for pvpanic driver
 framework
Message-ID: <20190123063740.GA26046@kroah.com>
References: <1548243477-60654-1-git-send-email-peng.hao2@zte.com.cn>
 <1548243477-60654-2-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548243477-60654-2-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 07:37:52PM +0800, Peng Hao wrote:
> Preparing for pvpanic driver framework. Create a pvpanic driver
> directory and move current driver file to new directory.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/Kconfig                 | 9 +--------
>  drivers/misc/Makefile                | 2 +-
>  drivers/misc/pvpanic/Kconfig         | 7 +++++++
>  drivers/misc/pvpanic/Makefile        | 5 +++++
>  drivers/misc/{ => pvpanic}/pvpanic.c | 0
>  5 files changed, 14 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/misc/pvpanic/Kconfig
>  create mode 100644 drivers/misc/pvpanic/Makefile
>  rename drivers/misc/{ => pvpanic}/pvpanic.c (100%)

In none of these patches do you say what changed from v1 :(

Please fix up as the documentation says to, and resend as v3.

thanks,

greg k-h
