Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D31ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7422820853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7422820853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeIOCZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:25:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41098 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeIOCZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:25:21 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 92AEF142A2067;
        Fri, 14 Sep 2018 14:09:09 -0700 (PDT)
Date:   Fri, 14 Sep 2018 14:09:06 -0700 (PDT)
Message-Id: <20180914.140906.724918309737328254.davem@davemloft.net>
To:     qing.huang@oracle.com
Cc:     leon@kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        tariqt@mellanox.com
Subject: Re: [PATCH] net/mlx4_core: print firmware version during driver
 loading
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c580ad9d-b63d-743b-2278-1c4cf3553186@oracle.com>
References: <20180914002514.27571-1-qing.huang@oracle.com>
        <20180914044314.GC5257@mtr-leonro.mtl.com>
        <c580ad9d-b63d-743b-2278-1c4cf3553186@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Sep 2018 14:09:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qing Huang <qing.huang@oracle.com>
Date: Fri, 14 Sep 2018 10:15:48 -0700

> IMHO, this information is very useful and only takes up very little
> log file space. :-)

If it's critical then the log is the wrong place for it as the log
is lossy.

The proper place to obtain this information is via the fw_version
field of the ethtool_drvinfo struct.  This can be obtained at any time
and is reliable.  And if it isn't reliable or correct, we must fix
that.
