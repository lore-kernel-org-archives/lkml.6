Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22483C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D781F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D781F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeH1JmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:42:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeH1JmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:42:04 -0400
Received: from localhost (smbcdgpass.hotspot.hub-one.net [213.174.99.145])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F11AB25A;
        Tue, 28 Aug 2018 05:44:48 +0000 (UTC)
Date:   Tue, 28 Aug 2018 07:44:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        weidu.du@huawei.com
Subject: Re: [PATCH] Revert "staging: erofs: disable compiling temporarile"
Message-ID: <20180828054444.GA4453@kroah.com>
References: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 11:39:48AM +0800, Gao Xiang wrote:
> This reverts commit 156c3df8d4db4e693c062978186f44079413d74d.
> 
> Since XArray and the new mount apis aren't merged in 4.19-rc1
> merge window, the BROKEN mark can be reverted directly without
> any problems.
> 
> Fixes: 156c3df8d4db ("staging: erofs: disable compiling temporarile")
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> 
> Hi Greg,
> 
>  Could you please apply this patch to enable EROFS from 4.19-rc2, thanks...
> 
>  p.s. We would like to provide a more stable EROFS when linux-4.19 is out,
>       and there are also two patchsets (the one is already sent out by Chao
>       and me, the other is previewing in linux-erofs mailing list and it will
>       be sent out after gathering enough testdata and feedback from community
>       and carefully reviewed), could you also please consider applying these
>       two patchsets in the later 4.19-rc (both >2, or the first patchset
>       could be in rc2 in advance) if it is convenient to do so, or the next
>       4.20 is also ok...
> 
>  LINK: https://lore.kernel.org/lkml/20180821144937.20555-1-chao@kernel.org/
>        https://lore.kernel.org/lkml/1535076160-99466-1-git-send-email-gaoxiang25@huawei.com/

I applied those patch sets to my -next branch already, right?  So those
would be going into 4.20-rc1, it is time now for "bugfixes only" for
4.19-final.

So perhaps we should just leave it as "BROKEN" for now for 4.19 and add
this to my tree now and let people work on it for the next few months in
linux-next so that 4.20 has a solid base to start with?

thanks,

greg k-h
