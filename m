Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D716C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B542075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B542075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeIGWRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:17:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIGWRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:17:07 -0400
Received: from localhost (unknown [172.58.40.83])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F20DA1449DA1D;
        Fri,  7 Sep 2018 10:35:08 -0700 (PDT)
Date:   Fri, 07 Sep 2018 10:35:08 -0700 (PDT)
Message-Id: <20180907.103508.586853927030824859.davem@davemloft.net>
To:     jakub.kicinski@netronome.com
Cc:     hangdianqj@163.com, dirk.vandermerwe@netronome.com,
        daniel@iogearbox.net, quentin.monnet@netronome.com,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet:netronome:nfp:move spin_lock_bh to spin_lock
 in tasklet
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180907183636.48a681f4@cakuba>
References: <20180907162117.47361-1-hangdianqj@163.com>
        <20180907183636.48a681f4@cakuba>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Sep 2018 10:35:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Fri, 7 Sep 2018 18:36:36 +0200

> On Fri,  7 Sep 2018 09:21:17 -0700, jun qian wrote:
>> As you are already in a tasklet, it is unnecessary to call spin_lock_bh.
>> 
>> Signed-off-by: jun qian <hangdianqj@163.com>
> 
> FWIW you should put spaces after the colons.  It's generally a good
> practice to look at the prefix previous authors used for a given piece
> of code with 
> 
> git log -- $file_path
> 
> This would be a better subject:
> 
> nfp: replace spin_lock_bh with spin_lock in tasklet callback

Yes, please fix your subject styling.
