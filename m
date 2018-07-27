Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC20C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949262089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="REgKha3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949262089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbeG0LkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbeG0LkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:40:07 -0400
Received: from localhost (unknown [119.197.233.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21CD20891;
        Fri, 27 Jul 2018 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532686732;
        bh=+ZBcC+1HPpcNFwSuUk/k9cs7gTCYKKYp6uObc2wWE1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REgKha3DoyTxNvF1CUf9NX6bYBn633+QEfK8GF/MS7JIgqW/XK3zwE94d6jayv5k7
         MXi1LJHP7ocHs3XBW1FzdbbkLLkgkT4BS/ZUPDIPCYp1x8wvHlMJ5H32e/8QA5oh+I
         oJAYAHhjA8wj1KTVXS9XYkSXcmZfwn2Kurg5d5UE=
Date:   Fri, 27 Jul 2018 19:18:49 +0900
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix 32-bit format string warning
Message-ID: <20180727101849.GG16155@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180724093509.1637386-1-arnd@arndb.de>
 <08f5d7dd-a271-4cef-4cf3-950c4c251c91@kernel.org>
 <CAK8P3a0DTCOtLLKRx6Z41fnweJyB8+J1zjEcpf9oQvMrj82-DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0DTCOtLLKRx6Z41fnweJyB8+J1zjEcpf9oQvMrj82-DA@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25, Arnd Bergmann wrote:
> On Wed, Jul 25, 2018 at 5:21 PM, Chao Yu <chao@kernel.org> wrote:
> > On 2018/7/24 17:34, Arnd Bergmann wrote:
> >> On 32-bit targets, size_t is often 'unsigned int', so printing it as %lu
> >> causes a warning:
> >>
> >> fs/f2fs/inode.c: In function 'sanity_check_inode':
> >> fs/f2fs/inode.c:247:4: error: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'unsigned int' [-Werror=format=]
> >>
> >> The correct format string is %zu.
> >>
> >> Fixes: ba3a252d3367 ("f2fs: fix to do sanity check with i_extra_isize")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I noticed the issue, thank you for fixing it, but original buggy patch has not
> > been upstreamed yet, how about merging this fix into origial patch, if you don't
> > mind?
> 
> Yes, please do that.

Squashed.
Thank you.

> 
>       Arnd
