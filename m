Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12960C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D865720850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546949619;
	bh=ZgV9YuOc2GBOZgetcGRDnI2inupCZQATy1kvaLxFsDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h59arYRxFaoid4TrOiPTDZQOU0Gep8xMPDPrCMqMqfjSb5Q0U0uaPHjsYb8Cu9BMX
	 c48dm4hipLKbTbb8Kxzh7bWCDFZ0LNqKYbY3dR3zvmLB8bW3x8JJE60SycgPCc7OSd
	 jQSp0psnqaEQ36WLqKYrVrOMKS1VKv98gUL7WGws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfAHMNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHMNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:13:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88600206B7;
        Tue,  8 Jan 2019 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949618;
        bh=ZgV9YuOc2GBOZgetcGRDnI2inupCZQATy1kvaLxFsDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xq7p5RioKDjt8mSA1RQ1HKa8n5tb4D8tWUOmU+ROSan9Y9vmchk0QzbDCfqdL8LUQ
         fYY0E40b//7E844EDgsE1E7Cxk5M8Pv5+64wElp0QR9OpI3iC0owTfhUzGtBZ5rerA
         aojKxCWOpawzee9jYeiuoa9HYsH9wLeU04b9dktA=
Date:   Tue, 8 Jan 2019 13:13:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drivers: platform: goldfish: goldfish_sync: add a
 driver
Message-ID: <20190108121335.GA3349@kroah.com>
References: <20190107185039.190919-1-rkir@google.com>
 <20190107185039.190919-3-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107185039.190919-3-rkir@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:50:39AM -0800, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> The Goldfish sync driver is designed to provide a interface
> between the underlying host's sync device and the kernel's
> fence sync framework.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> Changes in v2:
>  - Added a missing include (mod_devicetable.h).
>  - Put in one batch with goldfish_address_space.c to avoid merge comflicts.

You have a number of WARN_ON() calls in here that are not needed, please
remove.

Also, why is this driver needed at all?  Why can't you use the "normal"
drm sync api interface?  Why write a custom ioctl driver just for this
one kernel interface?

thanks,

greg k-h
