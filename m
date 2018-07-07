Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF1EC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872AE215EB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872AE215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeGGIAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:00:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeGGIAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:00:39 -0400
Received: from localhost (unknown [37.170.5.79])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E9E7BB6;
        Sat,  7 Jul 2018 08:00:38 +0000 (UTC)
Date:   Sat, 7 Jul 2018 10:00:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Max =?iso-8859-1?Q?Asb=F6ck?= <amax@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibmasm: don't write out of bounds in read handler
Message-ID: <20180707080029.GA27259@kroah.com>
References: <20180707021633.185004-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707021633.185004-1-jannh@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 04:16:33AM +0200, Jann Horn wrote:
> This read handler had a lot of custom logic and wrote outside the bounds of
> the provided buffer. This could lead to kernel and userspace memory
> corruption. Just use simple_read_from_buffer() with a stack buffer.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> NOTE: I put a "CC: stable" tag on this commit because it's a simple
> change and I don't know whether bugs in this code matter; I don't
> have any idea what the userland for this looks like.
> If it's not important, feel free to remove the tag.

Looks worthy of a stable tree inclusion, thanks.  I've kept it and
queued the patch up now.

greg k-h
