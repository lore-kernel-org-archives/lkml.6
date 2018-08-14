Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461F8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0337C21580
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0337C21580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbeHNT7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:59:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52736 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733145AbeHNT7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:59:03 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AA74A13D0F758;
        Tue, 14 Aug 2018 10:11:02 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:11:02 -0700 (PDT)
Message-Id: <20180814.101102.975738099798437246.davem@davemloft.net>
To:     xiliang@redhat.com
Cc:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] xen-netfront: fix warn message as irq
 device name has '/'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180814152128.5477-1-xiliang@redhat.com>
References: <20180814152128.5477-1-xiliang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Aug 2018 10:11:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiao Liang <xiliang@redhat.com>
Date: Tue, 14 Aug 2018 23:21:28 +0800

> There is a call trace generated after commit 2d408c0d4574b01b9ed45e02516888bf925e11a9(
> xen-netfront: fix queue name setting). There is no 'device/vif/xx-q0-tx' file found
> under /proc/irq/xx/.
> 
> This patch only picks up device type and id as its name.
> 
> With the patch, now /proc/interrupts looks like below and the warning message gone:
>  70:         21          0          0          0   xen-dyn    -event     vif0-q0-tx
>  71:         15          0          0          0   xen-dyn    -event     vif0-q0-rx
>  72:         14          0          0          0   xen-dyn    -event     vif0-q1-tx
>  73:         33          0          0          0   xen-dyn    -event     vif0-q1-rx
>  74:         12          0          0          0   xen-dyn    -event     vif0-q2-tx
>  75:         24          0          0          0   xen-dyn    -event     vif0-q2-rx
>  76:         19          0          0          0   xen-dyn    -event     vif0-q3-tx
>  77:         21          0          0          0   xen-dyn    -event     vif0-q3-rx
> 
> Below is call trace information without this patch:
 ...
> Signed-off-by: Xiao Liang <xiliang@redhat.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Applied, thank you.
