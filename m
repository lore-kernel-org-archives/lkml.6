Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A780C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C640820865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C640820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeJMLnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 07:43:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45610 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeJMLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 07:43:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBBD5-0001pe-79; Sat, 13 Oct 2018 04:07:27 +0000
Date:   Sat, 13 Oct 2018 05:07:27 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [resend PATCH] MAINTAINERS: Clarify UIO vs UACCESS maintainer
Message-ID: <20181013040727.GM32577@ZenIV.linux.org.uk>
References: <153902452503.3147008.1742604660028168607.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153902452503.3147008.1742604660028168607.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:50:09AM -0700, Dan Williams wrote:
> The UIO file mask in MAINTAINERS was incorrectly directing UACCESS
> (include/linux/uio.h) patches to Greg.
> 
> Tag Al as the UACCESS maintainer as Ingo and others have explicitly
> required his ack before taking architecture patches that touch
> lib/iov_iter.c.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> I got a bounce last time I tried to send this, hopefully the situation
> has improved now.
> 
> Al, let me know if you want this entry. Alternatively we can just do the
> UIO file mask fixup by itself.

Sure, no problem, except that UACCESS refers to different things.
I'd probably call it UIOVEC, if we want a name that does refer to the
same somewhere (*BSD).  If anything, it's generalization of copyin/copyout
for non-userland destinations/sources; uaccess answer to (subset of) the
same problem would be set_fs()/get_fs() and the fewer we have left of that,
the better...
