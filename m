Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E291C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BED24DD4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BED24DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeGCEhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:37:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeGCEhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:37:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1BF3EC9F;
        Tue,  3 Jul 2018 04:36:59 +0000 (UTC)
Date:   Tue, 3 Jul 2018 06:36:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Seung-Woo Kim <sw0312.kim@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 3.18.111
Message-ID: <20180703043655.GA9793@kroah.com>
References: <CGME20180530073304epcas3p4967df82d2d086fd08fd354781df61861@epcas3p4.samsung.com>
 <20180530073211.GA22422@kroah.com>
 <20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658~9vfIpgNT51989519895epcas1p2d@epcas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658~9vfIpgNT51989519895epcas1p2d@epcas1p2.samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:24:59PM +0900, Seung-Woo Kim wrote:
> Hello,
> 
> On 2018년 05월 30일 16:32, Greg KH wrote:
> > I'm announcing the release of the 3.18.111 kernel.
> > 
> > All users of the 3.18 kernel series must upgrade.
> > 
> > The updated 3.18.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.18.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------
> 
> <snip.>
> 
> >       do d_instantiate/unlock_new_inode combinations safely
> 
> Recent my test in 3.18.113 kernel with security smack showed following
> crash during mkdir on ext4 fs.
> 
> Unable to handle kernel paging request at virtual address ffffffffffffff98
> pgd = ffffffc012411000
> [ffffffffffffff98] *pgd=0000000000000000, *pud=0000000000000000
> ------------[ cut here ]------------
> Kernel BUG at ffffffc0007d9430 [verbose debug info unavailable]
> Internal error: Oops - BUG: 96000005 [#1] PREEMPT SMP
> CPU: 0 MPIDR: 80000000 PID: 1237 Comm: mkdir Not tainted
> 3.18.113-00083-g1bfc02f-dirty #29-Tizen
> task: ffffffc02cbc2340 ti: ffffffc02b7fc000 task.ti: ffffffc02b7fc000
> PC is at down_read+0x24/0x54
> LR is at down_read+0x24/0x54
> [...]
> Call trace:
> [<ffffffc0007d9430>] down_read+0x24/0x54
> [<ffffffc00022ff64>] ext4_xattr_get+0x74/0x1f4
> [<ffffffc000234838>] ext4_xattr_security_get+0x28/0x38
> [<ffffffc0001ab9f0>] generic_getxattr+0x4c/0x60
> [<ffffffc0002786a0>] smk_fetch.isra.6+0x8c/0xe0
> [<ffffffc000278888>] smack_d_instantiate+0x194/0x324
> [<ffffffc000273794>] security_d_instantiate+0x24/0x30
> [<ffffffc00019edf4>] d_instantiate_new+0x34/0x94
> [<ffffffc0002046b4>] ext4_mkdir+0x284/0x354
> [<ffffffc0001959bc>] vfs_mkdir+0xc0/0x150
> [<ffffffc00019a108>] SyS_mkdirat+0x88/0xb8
> [<ffffffc00019a150>] SyS_mkdir+0x18/0x20
> Code: aa0003f3 b00017c0 912e1000 97e38943 (c85f7e60)
> ---[ end trace b1ad797d63dae9c5 ]---
> 
> It is because d_instantiate_new() added from above commit calls
> security_d_instantiate() before calling __d_instantiate() and
> dentry->d_inode is not yet set and null. In 3.18.113 kernel,
> inode->i_op_getxattr() of ext4 is still generic_getxattr() and it only
> has dentry parameter without inode, so it tries to access dentry->d_inode.
> 
> I did not test with selinux, but selinux also calls
> inode->i_op_getxattr() from selinux_d_instantiate(), so maybe there is
> also same issue.

So should I revert something or do you have a proposed fix for this?

thanks,

greg k-h
