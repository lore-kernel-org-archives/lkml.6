Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CBDC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F972403E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F972403E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753603AbeGEX6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:58:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753185AbeGEX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:58:43 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32B59D2E;
        Thu,  5 Jul 2018 23:58:43 +0000 (UTC)
Date:   Thu, 5 Jul 2018 16:58:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] autofs - fix slab out of bounds read in
 getname_kernel()
Message-Id: <20180705165842.856d66594bf695f4f688ccfa@linux-foundation.org>
In-Reply-To: <153060031527.26631.18306637892746301555.stgit@pluto.themaw.net>
References: <153060031527.26631.18306637892746301555.stgit@pluto.themaw.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jul 2018 14:45:15 +0800 Ian Kent <raven@themaw.net> wrote:

> Initial patch contributed by Tomas Bortoli.
> 
> The autofs subsystem does not check that the "path" parameter is
> present for all cases where it is required when it is passed in
> via the "param" struct.
> 
> In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
> ioctl command.
> 
> To solve it, modify validate_dev_ioctl() function to check that a
> path has been provided for ioctl commands that require it.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Signed-off-by: Ian Kent <raven@themaw.net>
> Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com

So who is the primary author of this?  I'm assuming "Tomas" from the
signoff order?

The way of signifying this is to put the other author's From: line right
at the top of changelog.

I assume this is a root-only bug, so we don't need to backport the fix?

