Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067BDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B881720C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B881720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeHPW1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:27:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60806 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeHPW1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:27:04 -0400
Received: from localhost (unknown [205.153.50.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 425D3145E666C;
        Thu, 16 Aug 2018 12:26:45 -0700 (PDT)
Date:   Thu, 16 Aug 2018 12:26:44 -0700 (PDT)
Message-Id: <20180816.122644.863787126693940698.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     viro@zeniv.linux.org.uk, isdn@linux-pingi.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] isdn: Disable IIOCDBGVAR
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180815191405.GA29528@beast>
References: <20180815191405.GA29528@beast>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Aug 2018 12:26:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 15 Aug 2018 12:14:05 -0700

> It was possible to directly leak the kernel address where the isdn_dev
> structure pointer was stored. This is a kernel ASLR bypass for anyone
> with access to the ioctl. The code had been present since the beginning
> of git history, though this shouldn't ever be needed for normal operation,
> therefore remove it.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Karsten Keil <isdn@linux-pingi.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> netdev doesn't like explict stable markings, so I'll just ask here that it
> get included in -stable please. :)

Applied and queued up for -stable, thanks :)
