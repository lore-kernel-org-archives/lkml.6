Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F3EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BC820673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BC820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeGZJdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:33:25 -0400
Received: from nautica.notk.org ([91.121.71.147]:51589 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbeGZJdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:33:25 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id B5863C009; Thu, 26 Jul 2018 10:17:42 +0200 (CEST)
Date:   Thu, 26 Jul 2018 10:17:27 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH] 9p: fix NULL pointer dereferences
Message-ID: <20180726081727.GA6699@nautica>
References: <20180726081049.10527-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180726081049.10527-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Thu, Jul 26, 2018:
> In p9_fd_create_tcp() and p9_fd_create_unix() it is possible to get
> a NULL value in the addr parameter. Return -EINVAL in such cases.

Let's refuse that at much higher level, like v9fs_mount() in
fs/9p/vfs_super.c

I can't think of any valid reason for dev_name to be NULL, it's the
target IP or virtio handle.

-- 
Dominique
