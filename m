Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B6CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BEB20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="R5bxRIgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BEB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbeGIOWE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:22:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43734 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754515AbeGIOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:22:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so13787615pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9Us+mfwBpFGrRGhWrMwezRBKh0/lhLndaKtZ7J0GGU=;
        b=R5bxRIgZjKcsxiZI1rRY1/DxAkAXQa1ijeM0A0Kj74OWMWoGjizED14NZJDrl21rQF
         6JNfJcn0ds0EmKz1UF6GxiqRqr5Zaen/CXPqkkMNgbbHDiegpsxSPLm9r93TDTWB5oee
         X5azAKpwmfmtEb5Gy1Mv3LOnWpRKDcsaqjvDn+sNYkeLGpEmFtX8cLGjktBe/l5oWRDu
         BpNrmn3hvtFVRv1a8XMFTv3AtrWolCAYMkjr+nkBA9ND+D4nAyk4uUgqDHyOOLlBZiwe
         7/MfDVtMyTagRlf2ZA8UzStR6PopqpzW36b8h9q/1/zLs+oJzKAoyDVNk0CE6oKvYKUH
         LSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9Us+mfwBpFGrRGhWrMwezRBKh0/lhLndaKtZ7J0GGU=;
        b=M3WY5xk9dtYTmFK54NFvdBcGZ21VtTwPJ/ImNk6BLfmgHQFtUM2ePHp551JuDsN6kZ
         yr+OGi5ty90ZuTIQsN/04anWd99JW1Ykq9F6zyPFUDAu89QMYiSfILRv6wB1X/wvvZeO
         iCvQ31MHTTbWyb7IEkCaL6kXiIB2iVrAi7g3dgUHLM1fLEaifRJa0Tryvitd8qJaTMlM
         regZg9TYfNnpXj2YB1NzpnInm8hgMc/PRXeTlXY/uUf/0oHbGQvzSm6XYDsmjVngH2cu
         jVNSa2GHWXAxLFIbYaLx5NeyDt/n7PyikH0zLXNI4HD1kMcux6fsHvVi7pbbseQ8PMry
         GL/g==
X-Gm-Message-State: APt69E0D6NfZWJKWBPtWvV4+vCBx96u26i3bBqwGxTxVcdKJw8P+2ePm
        QCAaPVvHUeRPjJTs3PWHxS0ibA==
X-Google-Smtp-Source: AAOMgpelphFCvnTb7g5Cc52Gx8X/rNjHbG4dFbmOaJMT75TBKB9fiAaiL0TA/OP8E87tTNxfimctOQ==
X-Received: by 2002:a63:3509:: with SMTP id c9-v6mr18885666pga.237.1531146121133;
        Mon, 09 Jul 2018 07:22:01 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id g25-v6sm25945340pge.52.2018.07.09.07.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 07:22:00 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id D571430003F; Mon,  9 Jul 2018 17:21:55 +0300 (+03)
Date:   Mon, 9 Jul 2018 17:21:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+3f84280d52be9b7083cc@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        ldufour@linux.vnet.ibm.com, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>, ying.huang@intel.com
Subject: Re: kernel BUG at mm/memory.c:LINE!
Message-ID: <20180709142155.jlgytrhdmkyvowzh@kshutemo-mobl1>
References: <0000000000004a7da505708a9915@google.com>
 <20180709101558.63vkwppwcgzcv3dg@kshutemo-mobl1>
 <CACT4Y+a=8NOg+h6fBzpmVHiZ-vNUiG7SW4QgQvK3vD=KBqQ3_Q@mail.gmail.com>
 <CACT4Y+baBmOHwH6rUL3DjKhGk-JjBAvKOmnq65_4z6b96ohrBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+baBmOHwH6rUL3DjKhGk-JjBAvKOmnq65_4z6b96ohrBQ@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 12:52:21PM +0200, Dmitry Vyukov wrote:
> On Mon, Jul 9, 2018 at 12:48 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Jul 9, 2018 at 12:15 PM, Kirill A. Shutemov
> > <kirill@shutemov.name> wrote:
> >> On Sun, Jul 08, 2018 at 10:51:03PM -0700, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following crash on:
> >>>
> >>> HEAD commit:    b2d44d145d2a Merge tag '4.18-rc3-smb3fixes' of git://git.s..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=11d07748400000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3f84280d52be9b7083cc
> >>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>>
> >>> Unfortunately, I don't have any reproducer for this crash yet.
> >>>
> >>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>> Reported-by: syzbot+3f84280d52be9b7083cc@syzkaller.appspotmail.com
> >>>
> >>> next ffff8801ce5e7040 prev ffff8801d20eca50 mm ffff88019c1e13c0
> >>> prot 27 anon_vma ffff88019680cdd8 vm_ops 0000000000000000
> >>> pgoff 0 file ffff8801b2ec2d00 private_data 0000000000000000
> >>> flags: 0xff(read|write|exec|shared|mayread|maywrite|mayexec|mayshare)
> >>> ------------[ cut here ]------------
> >>> kernel BUG at mm/memory.c:1422!
> >>
> >> Looks like vma_is_anonymous() false-positive.
> >>
> >> Any clues what file is it? I would guess some kind of socket, but it's not
> >> clear from log which exactly.
> >
> >
> > From the log it looks like it was this program (number 3 matches Comm:
> > syz-executor3):
> >
> > 08:39:32 executing program 3:
> > r0 = socket$nl_route(0x10, 0x3, 0x0)
> > bind$netlink(r0, &(0x7f00000002c0)={0x10, 0x0, 0x0, 0x100000}, 0xc)
> > getsockname(r0, &(0x7f0000000000)=@pppol2tpv3in6={0x0, 0x0, {0x0,
> > <r1=>0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, {0x0, 0x0, 0x0,
> > @loopback}}}, &(0x7f00000000c0)=0x3a)
> > mmap(&(0x7f0000e00000/0x200000)=nil, 0x200000, 0x7fdff, 0x11, r1, 0x0)
> > ioctl$FIBMAP(r0, 0x1, &(0x7f0000000100)=0x9)
> > r2 = socket$inet6(0xa, 0x1000000000002, 0x0)
> > ioctl(r2, 0x8912, &(0x7f00000001c0)="796d05ad441e829115ac7fd77200")
> > r3 = syz_open_dev$vcsa(&(0x7f0000000140)='/dev/vcsa#\x00', 0x3, 0x2)
> > ioctl$VHOST_SET_VRING_ENDIAN(r3, 0x4008af13, &(0x7f0000000180)={0x0, 0x8})
> > sendto$inet(0xffffffffffffffff, &(0x7f0000a88f88), 0xffffffffffffff31,
> > 0x0, &(0x7f0000e68000)={0x2, 0x0, @multicast2=0xe0000002},
> > 0xfffffffffffffeb3)
> > ftruncate(r1, 0x6)
> > mmap(&(0x7f0000e00000/0x200000)=nil, 0x200000, 0x0, 0x11, r0, 0x0)
> > setsockopt$SO_TIMESTAMPING(r1, 0x1, 0x25, &(0x7f0000000080)=0x804, 0x4)
> >
> > But take what happens here with a grain of salt, it can pretend that
> > it's doing one thing, but actually do something different.
> > So that r1 passed to ftruncate is something that getsockname returned
> > somewhere in the middle of address. And since the socket is not
> > actually ppp, it can be just some bytes in the middle of netlink
> > address, that than happened to be small and match some existing fd...
> 
> 
> This also happened only once so far:
> https://syzkaller.appspot.com/bug?extid=3f84280d52be9b7083cc
> and I can't reproduce it rerunning this program. So it's either a very
> subtle race, or fd in the middle of netlink address magically matched
> some fd once, or something else...

Okay, I've got it reproduced. See below.

The problem is that kcov doesn't set vm_ops for the VMA and it makes
kernel think that the VMA is anonymous.

It's not necessary the way it was triggered by syzkaller. I just found
that kcov's ->mmap doesn't set vm_ops. There can more such cases.
vma_is_anonymous() is what we need to fix.

( Although, I found logic around mmaping the file second time questinable
  at best. It seems broken to me. )

It is known that vma_is_anonymous() can produce false-positives. It tried
to fix it once[1], but it back-fired[2].

I'll look at this again.

[1] https://lkml.kernel.org/r/1437133993-91885-1-git-send-email-kirill.shutemov@linux.intel.com
[2] https://lkml.kernel.org/r/20150914105346.GB23878@arm.com

#include <stdio.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <fcntl.h>

#define KCOV_INIT_TRACE			_IOR('c', 1, unsigned long)
#define KCOV_ENABLE			_IO('c', 100)
#define KCOV_DISABLE			_IO('c', 101)
#define COVER_SIZE			(1024<<10)

#define KCOV_TRACE_PC  0
#define KCOV_TRACE_CMP 1

int main(int argc, char **argv)
{
    int fd;
    unsigned long *cover, n, i;

    system("mount -t debugfs none /sys/kernel/debug");
    fd = open("/sys/kernel/debug/kcov", O_RDWR);
    ioctl(fd, KCOV_INIT_TRACE, COVER_SIZE);
    cover = mmap(NULL, COVER_SIZE * sizeof(unsigned long),
		    PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    munmap(cover, COVER_SIZE * sizeof(unsigned long));
    cover = mmap(NULL, COVER_SIZE * sizeof(unsigned long),
    			     PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
    memset(cover, 0, COVER_SIZE * sizeof(unsigned long));
    ftruncate(fd, 3UL << 20);
    return 0;
}

-- 
 Kirill A. Shutemov
