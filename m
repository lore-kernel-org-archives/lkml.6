Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EB3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03724208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03724208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbeHARFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:05:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51632 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389541AbeHARFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:05:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fksuX-0000eR-Ia; Wed, 01 Aug 2018 15:19:37 +0000
Date:   Wed, 1 Aug 2018 16:19:37 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Commit "new primitive: discard_new_inode()" introduces a problem
Message-ID: <20180801151937.GN30522@ZenIV.linux.org.uk>
References: <64a0f022-a32d-d4ee-7464-5c5ce0ebd222@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a0f022-a32d-d4ee-7464-5c5ce0ebd222@virtuozzo.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:43:35PM +0300, Kirill Tkhai wrote:
> Hi, Al,
> 
> commit 22dc9a1682722fda8603991595528b87e90436f6
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Thu Jun 28 15:53:17 2018 -0400
> 
>     new primitive: discard_new_inode()
> 
> from current linux-next introduces the following problem.
> It reproduces 100% in my test VM:
> 
> # cat /etc/mtab 
> /dev/sda1 / ext4 rw 0 0
> proc /proc proc rw 0 0
> sysfs /sys sysfs rw 0 0
> devpts /dev/pts devpts rw,gid=5,mode=620 0 0
> tmpfs /dev/shm tmpfs rw,noexec,nosuid,nodev 0 0
> # echo 3 > /proc/sys/vm/drop_caches 
> # cat /etc/mtab 
> cat: /etc/mtab: Cannot allocate memory

Can't reproduce here...  Could you post your .config (and
toolchain information, for the sake of completeness)?
