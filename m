Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B8C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8EF20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8EF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeG2Vnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:43:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44244 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeG2Vna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:43:30 -0400
Received: from localhost (c-73-37-107-99.hsd1.or.comcast.net [73.37.107.99])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D5C1B13E3B35C;
        Sun, 29 Jul 2018 13:11:50 -0700 (PDT)
Date:   Sun, 29 Jul 2018 13:11:50 -0700 (PDT)
Message-Id: <20180729.131150.2292075046399424568.davem@davemloft.net>
To:     tyhicks@canonical.com
Cc:     gregkh@linuxfoundation.org, hkallweit1@gmail.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] sysfs: Fix regression when adding a file to
 an existing group
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532727207-10912-1-git-send-email-tyhicks@canonical.com>
References: <1532727207-10912-1-git-send-email-tyhicks@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Jul 2018 13:11:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 27 Jul 2018 21:33:27 +0000

> Commit 5f81880d5204 ("sysfs, kobject: allow creating kobject belonging
> to arbitrary users") incorrectly changed the argument passed as the
> parent parameter when calling sysfs_add_file_mode_ns(). This caused some
> sysfs attribute files to not be added correctly to certain groups.
> 
> Fixes: 5f81880d5204 ("sysfs, kobject: allow creating kobject belonging to arbitrary users")
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> 
> Note, this was a regression exclusively in linux-next and never made it to
> Linus' tree. There's no need to queue it up for linux-stable.

Applied, thank you.
