Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC7D7C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E0D20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzgdePSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E0D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934071AbeFKRvH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932647AbeFKRvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:51:05 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4BF208AF;
        Mon, 11 Jun 2018 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528739464;
        bh=L+s/DDJYvznoDJ296M5ZEzs/YanQb5ehgAJ5Rn85AGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzgdePSEvF0+QXcGgzP7QEyPlj2OffcmJZ6J0l56H+69IiDsEtXuxDULGI0zuI1Ng
         bhn5uGICveEKRTOqPk+0UCv39jS8KarRKoPRrEyjq8IDLrsu/SCT9F9Ct7ryPQL8gH
         1KYdeJNDc48rOXE5d4lpei2u73O2J6BHh5mvVK1k=
Date:   Mon, 11 Jun 2018 10:51:03 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@google.com>, Chao Yu <yuchao0@huawei.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
Message-ID: <20180611175103.GA9244@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFw13-=qJ44s+_SM7csCPu0EeQf4bSzsf+tfPes=cBVBOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw13-=qJ44s+_SM7csCPu0EeQf4bSzsf+tfPes=cBVBOg@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11, Linus Torvalds wrote:
> On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > Eric Biggers (4):
> >       f2fs: call unlock_new_inode() before d_instantiate()
> 
> Btw, in my merge, this got superseded by commit 1e2e547a93a00ebc2158
> ("do d_instantiate/unlock_new_inode combinations safely"), because the
> ordering of that d_instantiate() and unlock_new_inode() was subtler
> than just doing the unlock first.
> 
> I can't test the end result, so you guys should double-check whatever
> xfstest you ran originall, ok?

https://lkml.org/lkml/2018/5/13/248
Got it. Thanks.

> 
>             Linus
