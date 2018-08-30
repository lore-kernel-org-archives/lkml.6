Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E893C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A336520835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b="Vf0+c0LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A336520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=python.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeHaBzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:55:10 -0400
Received: from mail.python.org ([188.166.95.178]:54722 "EHLO mail.python.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbeHaBzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:55:10 -0400
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com [66.111.4.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.python.org (Postfix) with ESMTPSA id 421bld3FFvzFqry;
        Thu, 30 Aug 2018 17:50:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
        t=1535665854; bh=vP/3k/d5Q2ilr+OTdlYqCYzUUq+ug4BweZ8RHwzM6SU=;
        h=From:To:Cc:Date:Subject:In-Reply-To:References:From;
        b=Vf0+c0LBypRa0+LVXgVntyuktYkadBTRFM2MOWMZF5OyN2lWGO5oXEZVmDey48atT
         i038lRNLFn5vfnc3tme/MTml9i6KrFwr8B8BJyGtgfLiAWq+Cr88NYy8KDTRooonx1
         GMDJ+kaj2qmCcPVAc6jzby83zKicH/XEpGncHnmg=
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id EEB6E21E95;
        Thu, 30 Aug 2018 17:50:51 -0400 (EDT)
Received: from web2 ([10.202.2.212])
  by compute4.internal (MEProxy); Thu, 30 Aug 2018 17:50:51 -0400
X-ME-Proxy: <xmx:u2aIW3o1e4-MUzOoSPFYo7AfePknbANSRekuhmNyWu5ElK6L3vI7-w>
    <xmx:u2aIW9-493721BiE_QQPlYYP8jQ_3kFJm3XA9w9qi7PpRlH5oiw4lA>
    <xmx:u2aIWwuftquT-xNEbINJdn1ozGirFMEbhS2aYkZ0_f5dMpwMDJCBzw>
    <xmx:u2aIW1ZIMihcGwYfvn23H4TSYcRCWuiz_rFjiw7UIp6VZBOt658zQA>
    <xmx:u2aIW6BGAPFHZ6UKz0Q-CoUbwJWcMlb8lGD-84kKABnP2FcJBp6U4Q>
    <xmx:u2aIW7S2VisVn5jeNs-so9HUpE1Lq0hJqreiZl7f2QII0ermewE8Aw>
X-ME-Sender: <xms:u2aIWwsQJoTLVij7kHlx6lz5tpukVBqLmX8bcz8roX1y7Sy65Z5Qpg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 124C2621D0; Thu, 30 Aug 2018 17:50:51 -0400 (EDT)
Message-Id: <1535665851.2058334.1491869472.4E860103@webmail.messagingengine.com>
From:   Benjamin Peterson <benjamin@python.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-7b72137a
Date:   Thu, 30 Aug 2018 14:50:51 -0700
Subject: Re: [PATCH] perf trace beautify: Beautify flags of mount(2) and
 umount(2).
In-Reply-To: <20180830182848.GE6097@kernel.org>
References: <20180828035344.31500-1-benjamin@python.org>
 <20180830182848.GE6097@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On Thu, Aug 30, 2018, at 11:28, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 27, 2018 at 08:53:44PM -0700, Benjamin Peterson escreveu:
> > Example output of perf trace -e mount,umount2:
> > 
> >   6243.930 ( 0.052 ms): mount/30976 mount(dev_name: 0x55dc541bb920, dir_name: 0x55dc541bc960, type: 0x55dc541b9c40, flags: BIND) = 0
> >   7851.821 (26.015 ms): umount/30983 umount2(name: 0x558daa82cf50, flags: MNT_FORCE                        ) = 0
> > 
> > Signed-off-by: Benjamin Peterson <benjamin@python.org>
> 
> So, I tried:
> 
> Before your patch:
> 
>   # perf trace -e *mount* mount /dev/mapper/fedora-home /s
>      0.000 ( 4.335 ms): mount/3126 mount(dev_name: 0x55deecc4d480, 
> dir_name: 0x55deecc4d4a0, type: 0x55deecc53880, flags: 3236757504) = 0
>   #
>   # perf trace -e *mount* umount /dev/mapper/fedora-home /s
>          ? (         ): umount/3138  ... [continued]: umount2()) = 0
>     11.576 (umount:  0.004 ms): /s: not mounted.umount/
> 3138 umount2(arg0: 94501956754656, arg1: 0, arg2: 1, arg3: 
> 140051050083104, arg4: 4, arg5: 94501956755136) = -1 EINVAL Invalid 
> argument
>   #
> 
> After:
> 
> [root@jouet ~]# perf trace -e *mount* mount /dev/mapper/fedora-home /s
>      0.000 ( 1.213 ms): mount/5244 mount(dev_name: 0x5558c1169480, 
> dir_name: 0x5558c11694a0, type: 0x5558c116f880, flags: ) = 0
> [root@jouet ~]# perf trace -e *mount* umount /s
>      0.000 ( 9.241 ms): umount/5251 umount2(name: 
> 0x55f74a986480                                          ) = 0
> 
> The flags for mount got empty? Can you pleaes check that? I.e. using the
> default mount options, not specifying a 'bind' mount like you did.

That comes from these lines in syscall_arg__scnprintf_mount_flags:

if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
	flags &= ~MS_MGC_MSK;

The reason for this is explained in the comment for do_mount in fs/namespace.c:

/*
 * Pre-0.97 versions of mount() didn't have a flags word.
 * When the flags word was introduced its top half was required
 * to have the magic value 0xC0ED, and this remained so until 2.4.0-test9.
 * Therefore, if this magic number is present, it carries no information
 * and must be discarded.
*/

(I used a bind mount for my commit message example because a "default" mount() doesn't use any flags.)

> 
> I'm splitting this patch so that the aliasing of 'umount2' to 'umount'
> gets merged now,
> 
> Check my perf/core branch at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

LGTM. Thanks

