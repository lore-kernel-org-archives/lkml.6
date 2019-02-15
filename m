Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4470C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809A620821
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550216970;
	bh=+s5qNxZ5Bp6kG58TgUUCmvBUuqZCU40Q2bOTrhLjZ58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h2TsTvM/ZazpexIAifpvtGYm80E3Yqy3tsQf43k4aB4PWpKdVcyYJ2wuDc+6vV+Ea
	 cDUrXioaWqx9ZSSJTX05PIMKCjBYiKbu3JA9jLEIfZWqEKSbxhAnFoq/VKEtHMLrU1
	 9ChTfzpaY7466e2rZBvuUohkN4zQ7Ri0AmREdVRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390618AbfBOHtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfBOHtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:49:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35EE420836;
        Fri, 15 Feb 2019 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550216951;
        bh=+s5qNxZ5Bp6kG58TgUUCmvBUuqZCU40Q2bOTrhLjZ58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOgpnsecW3jm7S3g9kpYWf1uX+MGWR8q6fmp307sNfay8pa3baMBsUn3AH1D5v2Xk
         xhLc8Pjt4JmvICynNMSTVRPdnp1ysicdt3IzWhW0q9MpEP9UMlGBlgKuOHbMLFir1z
         +Q4fLZElal10Lby2ZZ3bvmO9YurmLHM3pqXGAwYw=
Date:   Fri, 15 Feb 2019 08:48:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com,
        syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com
Subject: Re: [PATCH] binder: fix handling of misaligned binder object
Message-ID: <20190215074859.GB1808@kroah.com>
References: <20190214232257.76856-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214232257.76856-1-tkjos@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:22:57PM -0800, Todd Kjos wrote:
> Fixes crash found by syzbot:
> kernel BUG at drivers/android/binder_alloc.c:LINE! (2)
> 
> Reported-by: syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com

As the bot asked, this should be:
	Reported-and-tested-by: syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com

I'll go fix that up...

thanks,

greg k-h
