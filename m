Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EB22098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EB22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeGPKPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:15:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeGPKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:15:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC07DAD2;
        Mon, 16 Jul 2018 09:48:53 +0000 (UTC)
Date:   Mon, 16 Jul 2018 11:48:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Todd Kjos <tkjos@android.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Arve H <arve@android.com>, Martijn Coenen <maco@android.com>,
        Tobias Lindskog <tobias.lindskog@sonymobile.com>,
        kernel-team@android.com
Subject: Re: [PATCH] staging: android: ashmem: Shrink directly through
 shmem_fallocate
Message-ID: <20180716094851.GA31480@kroah.com>
References: <20180706214416.184691-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706214416.184691-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:44:16PM -0700, Joel Fernandes wrote:
> From: Tobias Lindskog <tobias.lindskog@sonymobile.com>
> 
> When ashmem_shrink is called from direct reclaim on a user thread, a
> call to do_fallocate will check for permissions against the security
> policy of that user thread.  It can thus fail by chance if called on a
> thread that isn't permitted to modify the relevant ashmem areas.
> 
> Because we know that we have a shmem file underneath, call the shmem
> implementation of fallocate directly instead of going through the
> user-space interface for fallocate.
> 
> Bug: 21951515

What does this "Bug:" line mean to any of us?  :)

I'll go delete it, and I fixed up the subject to have 'staging: android'
in it as well.  Please do that next time.

thanks,

greg k-h
