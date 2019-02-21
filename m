Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED5C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD92218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550740216;
	bh=s8S79TiwSNQPycQI9tlCN5pynyKc8OhiDbHfbeClHHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TCPJLz1BbKWheNt8B0oToTs4/Kmtss9YQkBGFv3tEMumFCVqu6wrrO5C3c+Yl1TO9
	 ZzPQfKhqtCxk6l58S+GhyGhfhE89zSBqOPoUe50rYfBrosPbnDlP73XTa08iCBhICb
	 ZhV1NKNcDSzUtpeiDq6OTqpNmL9gJr5f02X0EPlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfBUJKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfBUJKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:10:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7302086C;
        Thu, 21 Feb 2019 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550740213;
        bh=s8S79TiwSNQPycQI9tlCN5pynyKc8OhiDbHfbeClHHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KetB6Q6N+4/P79febiDQ77mYAT4JEczdD/6MzfbbnvpaFL41pSGerqEuD+AoBpEPO
         nXEKjzwTqqANnIWMhK5oToDJzomCHyQ1NqdyeUKQxG8UPpN3WAyHB6iL44rCVLUqpF
         8I8Sno2SUe1yW2MiJdTcB+K24hwUdG/mSGb2XmH8=
Date:   Thu, 21 Feb 2019 10:10:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        rientjes@google.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] mm/cma_debug: Check for null tmp in cma_debugfs_add_one()
Message-ID: <20190221091010.GA11118@kroah.com>
References: <20190221040130.8940-1-zbestahu@gmail.com>
 <20190221040130.8940-2-zbestahu@gmail.com>
 <20190221082309.GG4525@dhcp22.suse.cz>
 <20190221165642.00005d86.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221165642.00005d86.zbestahu@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:56:42PM +0800, Yue Hu wrote:
> On Thu, 21 Feb 2019 09:23:09 +0100
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Thu 21-02-19 12:01:30, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > If debugfs_create_dir() failed, the following debugfs_create_file()
> > > will be meanless since it depends on non-NULL tmp dentry and it will
> > > only waste CPU resource.  
> > 
> > The file will be created in the debugfs root. But, more importantly.
> > Greg (CCed now) is working on removing the failure paths because he
> > believes they do not really matter for debugfs and they make code more
> > ugly. More importantly a check for NULL is not correct because you
> > get ERR_PTR after recent changes IIRC.
> 
> Same check logic in cma_debugfs_init(), i'm just finding they do not stay
> the same.

I have patches to fix that up as well :)

thanks,

greg k-h
