Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5402820676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5402820676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeIYXqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:46:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49658 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIYXqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:46:47 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E9720FA2;
        Tue, 25 Sep 2018 17:38:12 +0000 (UTC)
Date:   Tue, 25 Sep 2018 19:38:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong@vt.edu>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: leaking path in android binder: set_nice
Message-ID: <20180925173810.GB20508@kroah.com>
References: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 01:27:11PM -0400, Tong Zhang wrote:
> Kernel Version: 4.18.5
> 
> Problem Description:
> 
> When setting nice value, it is checked by LSM function security_task_setnice().
> see kernel/sched/core.c:3972 SYSCALL_DEFINE1(nice, int, increment)
> 
> We discovered a leaking path in android binder which allows using binder’s interface to change 
> a process’s nice value. This path is leaked from being monitored by LSM.
> see drivers/android/binder.c:1107 binder_set_nice.

Can you please submit a patch for this to get the proper credit for
finding and fixing this?

thanks,

greg k-h
