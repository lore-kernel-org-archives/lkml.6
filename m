Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7167BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C21720866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547621589;
	bh=VmzHOjXjE90OxgcUeoYe1kh49fS9ESRaiLk0XbwWhfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wvXP7aztih3lsqzlj+ltRQfgmkk12e6NVc94gqgb1eYc1mcS72Ef8qKS4tgNLipRv
	 lUZ5qezoMdGA5ADs9owP12VlkwrN/wM21WpcVTDHxxs7RcMCbiaqjgraUiUp3b7ALl
	 A6HcDziuWap59vpTKTKEMJw6CYQT7P7ppbsNjK6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbfAPGxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:53:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:32816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbfAPGxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:53:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FCAB20859;
        Wed, 16 Jan 2019 06:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547621586;
        bh=VmzHOjXjE90OxgcUeoYe1kh49fS9ESRaiLk0XbwWhfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhCFUc8p/9kNjAjxkO59OLIN6Sg6NMRJuo9L4R1AssxKASNCYJYGyBALu+IV8VGDs
         gpuc+V/dZq+0tmTdpGAzxtA/zBkuMKU7t7Nvu6YOz9YDoSSUW6q/ssdpRM0+5nKHh0
         /mNmuF9eXu3C0SVrcm4PlB003LxHdcanPXeJ6mrI=
Date:   Wed, 16 Jan 2019 07:53:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, devel@driverdev.osuosl.org,
        tkjos@android.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com
Subject: Re: [PATCH -next] binderfs: fix error return code in
 binderfs_fill_super()
Message-ID: <20190116065304.GA26290@kroah.com>
References: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
 <20190116062546.ufoeresnwz3wyxiu@brauner.io>
 <20190116062825.thzsb5edkihepgm4@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116062825.thzsb5edkihepgm4@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 07:28:26AM +0100, Christian Brauner wrote:
> On Wed, Jan 16, 2019 at 07:25:46AM +0100, Christian Brauner wrote:
> > On Wed, Jan 16, 2019 at 03:01:04AM +0000, Wei Yongjun wrote:
> > > Fix to return a negative error code -ENOMEM from the new_inode() and
> > > d_make_root() error handling cases instead of 0, as done elsewhere in
> > > this function.
> > > 
> > > Fixes: 3ad20fe393b3 ("binder: implement binderfs")
> 
> This Fixes tag is technically wrong since this codepath was introduced
> by a commit that is still sitting in Greg's char-misc-linus branch. Not
> sure how to handle that though. Might just leave it.

Use the git commit id of the patch in that branch, it is not going to
change as I do not rebase that branch.

thanks,

greg k-h
