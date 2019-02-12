Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EACC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEDD222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfBLUiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:38:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42354 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBLUiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:38:11 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gteoj-0006pu-AW; Tue, 12 Feb 2019 20:38:09 +0000
Date:   Tue, 12 Feb 2019 20:38:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     demiobenour@gmail.com
Cc:     "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Return -EINVAL if userspace passes bogus flags to
 open()
Message-ID: <20190212203809.GK2217@ZenIV.linux.org.uk>
References: <20190212145450.2200-1-demiobenour@gmail.com>
 <20190212145450.2200-4-demiobenour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212145450.2200-4-demiobenour@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:54:47AM -0500, demiobenour@gmail.com wrote:
> From: "Demi M. Obenour" <demiobenour@gmail.com>
> 
> While testing the O_PATHSTATIC patch, I discovered that Linux does not
> return any error if an invalid flag is passed to open(2).  This prevents
> adding new flags without a (minor) risk of breaking userspace.
> Therefore, add a check for invalid flags, and return -EINVAL if any are
> found.

... which would qualtify as userland ABI breakage all by itself.
