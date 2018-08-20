Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B06C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9FE208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9FE208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeHTWjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:39:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:39:43 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5CD3FCC8;
        Mon, 20 Aug 2018 19:22:51 +0000 (UTC)
Date:   Mon, 20 Aug 2018 21:22:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] kobject: Access kobject name with caution if state is
 not initialized
Message-ID: <20180820192247.GA20101@kroah.com>
References: <1534784987-16107-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534784987-16107-1-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 10:39:47PM +0530, Srikar Dronamraju wrote:
> If kobject state is not initialized, then its not even certain that
> kobject'name is initialized. Hence when accessing the kobject's name
> tread carefully.
> 
> A stupid module test like
> https://github.com/srikard/tests/blob/master/modules/kobject_test.c
> can panic the system.

Lots of stupid modules can do dumb things.  Just don't do that.  The
kernel is not built to keep you from doing stupid things in kernel code
:)

So I fail to see why this patch is needed.  What in-kernel code path is
trying to print a kobject's name before it is initialized?  Why not fix
that obvious bug instead of forcing the kernel core to protect from
stupid code?

thanks,

greg k-h
