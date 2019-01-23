Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1316AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABF221726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548235369;
	bh=QbQ+0FtMp55OgNZXPcfZ1al4xezVqyH8ot8uon9/Zmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F6V1n9xKBGk5J9k7UYrPZ9bycZzINPOFk+jexJVx1EKFYJ5vVJmjr6a7/AbCBqM13
	 9vZT3uAZH5THRpINDIAPtHLSBYRbPAf+cC6r6khEKROlfvotdh8WHn2qOuQI45nYiP
	 /Eg/nJClOneXJo83BiH39tGPYvkFEMLxw3N58A2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfAWJWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:22:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfAWJWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:22:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E7BA20870;
        Wed, 23 Jan 2019 09:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548235367;
        bh=QbQ+0FtMp55OgNZXPcfZ1al4xezVqyH8ot8uon9/Zmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoWaAR8/YtZlo7uZgVcOJaO26VkGa4dq9/oGxbTyvw9JVr6Y49Ka7gPzRECQwCaKz
         FwX3bEviUIjUOcRz5dJs+8hsFYVSA9fP/+c7YsaWU6YlRIlYCfsVnrOoCc5so4crd6
         Td+Trlo7HE66UaKUYL2y0F0uE0d8LLJtju5K3sWI=
Date:   Wed, 23 Jan 2019 10:22:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] qspinlock: no need to check return value of
 debugfs_create functions
Message-ID: <20190123092245.GB14010@kroah.com>
References: <20190122152151.16139-44-gregkh@linuxfoundation.org>
 <20190123091016.GA15019@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123091016.GA15019@brain-police>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:10:18AM +0000, Will Deacon wrote:
> On Tue, Jan 22, 2019 at 04:21:43PM +0100, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/locking/qspinlock_stat.h | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> Curious, but are you planning to make these functions return void after
> you've modified all of the callers?

I wish, but I can't, as those values are needed for some other debugfs
calls.

thanks,

greg k-h
