Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBE4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FDB20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FDB20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbeGZWXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:23:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46892 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbeGZWXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:23:08 -0400
Received: from localhost (unknown [172.58.43.154])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 93358108CAEAC;
        Thu, 26 Jul 2018 14:04:32 -0700 (PDT)
Date:   Thu, 26 Jul 2018 14:04:31 -0700 (PDT)
Message-Id: <20180726.140431.1980654012533107924.davem@davemloft.net>
To:     avinash.repaka@oracle.com
Cc:     santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDS: RDMA: Fix the NULL-ptr deref in rds_ib_get_mr
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532489518-27042-1-git-send-email-avinash.repaka@oracle.com>
References: <1532489518-27042-1-git-send-email-avinash.repaka@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 14:04:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avinash Repaka <avinash.repaka@oracle.com>
Date: Tue, 24 Jul 2018 20:31:58 -0700

> Registration of a memory region(MR) through FRMR/fastreg(unlike FMR)
> needs a connection/qp. With a proxy qp, this dependency on connection
> will be removed, but that needs more infrastructure patches, which is a
> work in progress.
> 
> As an intermediate fix, the get_mr returns EOPNOTSUPP when connection
> details are not populated. The MR registration through sendmsg() will
> continue to work even with fast registration, since connection in this
> case is formed upfront.
> 
> This patch fixes the following crash:
 ...
> Reported-by: syzbot+b51c77ef956678a65834@syzkaller.appspotmail.com
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> Signed-off-by: Avinash Repaka <avinash.repaka@oracle.com>

Applied and queued up for -stable, thanks.
