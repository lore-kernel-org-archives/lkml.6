Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E21C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE9C24E13
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvtXH6sY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE9C24E13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeGBQry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752550AbeGBQrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:47:53 -0400
Received: from kernel.org (c-71-202-33-127.hsd1.ca.comcast.net [71.202.33.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B0024E13;
        Mon,  2 Jul 2018 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530550072;
        bh=zRwYHXHnpnUiTqFbvIZPZYpGOffNyxpGYh37zIcrci0=;
        h=Date:From:To:Cc:Subject:From;
        b=JvtXH6sY6v/VEaq56VpdQ5CmlbTXrc60ATcnNNT04wrg16XLNv/i79SHI7Rch/Fof
         hlYxOEQHvmdeTD96MsoaB/jQsLsYHGpCL91wd2bVJzoy3cP5Z5d+K60jS6WLUuGiwL
         Acm9ggwqrp0HFXBxbGqDG4v8sSiyVPY6jtJjyJGA=
Date:   Mon, 2 Jul 2018 09:47:50 -0700
From:   Shaohua Li <shli@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [GIT PULL] MD update for 4.18-rc3
Message-ID: <20180702164750.GA24121@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Two small fixes for MD:
- An error handling fix from me
- A recover bug fix for raid10 from BingJing
please pull!

Thanks,
Shaohua


The following changes since commit 9ffc59d57228d74809700be6f7ecb1db10292f05:

  Merge tag '4.18-rc1-more-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2018-06-18 14:28:19 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shli/md.git for-next

for you to fetch changes up to bda3153998f3eb2cafa4a6311971143628eacdbc:

  md/raid10: fix that replacement cannot complete recovery after reassemble (2018-06-28 13:04:49 -0700)

----------------------------------------------------------------
BingJing Chang (1):
      md/raid10: fix that replacement cannot complete recovery after reassemble

Shaohua Li (1):
      MD: cleanup resources in failure

 drivers/md/md.c     | 8 +++++---
 drivers/md/raid10.c | 7 +++++++
 2 files changed, 12 insertions(+), 3 deletions(-)
