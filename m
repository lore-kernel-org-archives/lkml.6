Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20CDC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B99C2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546873410;
	bh=IeqPKUGxhHRC5DZRvK8TNQD6sFsEhOVJ26wGiNQwMns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iTVHlvb5RH9mvUAViGXMD1aEnK4QLO/V2lXstrmu1PCLNdaCT3b7hIsO6HE8p94UK
	 ed71ONU165Cn6ZFruM9y0OlfYQ1Z7xKmBwGxsbXgpOK0TtKF1RpeBual0wc5O2iq8j
	 WjqdYFJJFuUtwzQWCeWKerkUwLohHab1gS9Dufio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfAGPD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:03:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfAGPD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:03:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE672089F;
        Mon,  7 Jan 2019 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546873408;
        bh=IeqPKUGxhHRC5DZRvK8TNQD6sFsEhOVJ26wGiNQwMns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcL1m+8w5TIfM79AOXRs+FLoVWwcuiU4N30VZjVZChOYC1GXuGRvhNaowocfMMIGc
         IokKhPvt5guFtFsOPkBy/jH/g1zE7jONkZrKNiv1zCovk6MyJuf5KLdJiUuGNCAdkx
         e9pYk/db+WYRiWOK2EIaZRFE8F1ZaKeVGRvdn/vE=
Date:   Mon, 7 Jan 2019 16:03:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
Message-ID: <20190107150326.GA16052@kroah.com>
References: <20190107105330.280153213@linuxfoundation.org>
 <CAEUSe7-ymDukTDvA6rPTsJrxxs31ChAtHo54+Uti_eG2m1_F9A@mail.gmail.com>
 <20190107145414.GA27990@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107145414.GA27990@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:54:14PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 07, 2019 at 08:40:56AM -0600, Daniel Díaz wrote:
> > Hello!
> > 
> > On Mon, 7 Jan 2019 at 07:06, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > This is the start of the stable review cycle for the 4.9.149 release.
> > > There are 71 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > 
> > With 4.9, we get this build error:
> > | /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/fs/ext4/inode.c:
> > In function 'ext4_write_inode':
> > | /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/fs/ext4/inode.c:5018:6:
> > error: implicit declaration of function 'sb_rdonly'
> > [-Werror=implicit-function-declaration]
> > |       sb_rdonly(inode->i_sb))
> > |       ^~~~~~~~~
> > |   CC      drivers/char/virtio_console.o
> > | In file included from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/linkage.h:4:0,
> > |                  from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/fs.h:4,
> > |                  from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/fs/ext4/inode.c:21:
> > | /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/fs/ext4/inode.c:5021:15:
> > error: implicit declaration of function 'ext4_forced_shutdown'; did
> > you mean 'ext4_force_commit'? [-Werror=implicit-function-declaration]
> > |   if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> > |                ^
> > | /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/compiler.h:168:42:
> > note: in definition of macro 'unlikely'
> > |  # define unlikely(x) __builtin_expect(!!(x), 0)
> > |                                           ^
> 
> Ugh, wow.  Ok, something is really wrong with my build systems to not
> find this either, let me go see what is up...

Ok, builder problem fixed (my fault, hadn't updated the kernel tree
there...)  Let me run it through that testing before I push out a -rc3
to make sure I really fix all of these issues.

thanks for pointing these out, it must be monday...

greg k-h
