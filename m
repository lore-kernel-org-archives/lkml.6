Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B8C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6189520841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6189520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeIAFUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 01:20:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42076 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeIAFUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 01:20:48 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 53AC1142D15F2;
        Fri, 31 Aug 2018 18:04:25 -0700 (PDT)
Date:   Fri, 31 Aug 2018 18:04:24 -0700 (PDT)
Message-Id: <20180831.180424.463682127429889241.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     santosh.shilimkar@oracle.com, sowmini.varadhan@oracle.com,
        willemb@google.com, ka-cheong.poon@oracle.com,
        s.mesoraca16@gmail.com, avinash.repaka@oracle.com,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rds: store socket timestamps as ktime_t
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180829154732.844217-1-arnd@arndb.de>
References: <20180829154732.844217-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 31 Aug 2018 18:04:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 29 Aug 2018 17:47:19 +0200

> rds is the last in-kernel user of the old do_gettimeofday()
> function. Convert it over to ktime_get_real() to make it
> work more like the generic socket timestamps, and to let
> us kill off do_gettimeofday().
> 
> A follow-up patch will have to change the user space interface
> to deal better with 32-bit tasks, which may use an incompatible
> layout for 'struct timespec'.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
