Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2928C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CF620BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rbpQM/Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CF620BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbeGLOly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:41:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40496 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeGLOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:41:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so3959811pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+cY5515XQFFJf75PglpAaqgaiPiDB97yZJu28sfA6Y4=;
        b=rbpQM/Up+ZeG1AdQ5qpnl00HOm4hZH/OAuTq2Y0R8WqBVeueTN+0wHJ06PEHLKlU9L
         YEaNCegM5FZR3bFrpByqcqbKjSrCBqQmT2n3vZP1qMvo4ROAGUPqc99y/QyTmVvg7lQ7
         J/yBFX+PYCO4warjO7BKFa0RCrSpsBqJBqwwFEIXkJl8xsTJcLGlNRIG6j+/ZhLfCi15
         njf2Wi1n+J6aWDFYaOcUHrxbEO89dr8Xi6xrWnyvgA2/Gu4sA0HB8RGD6kOofrKQwnBY
         CqME6i3gm0/M6XmvJJLLBXDZi/8R02Eo3R0TdqHwSGnUf8K2ItrpBnBK1P8W4cTPYufQ
         JqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+cY5515XQFFJf75PglpAaqgaiPiDB97yZJu28sfA6Y4=;
        b=M76o4IOcMkmZLzu61ZVryBJx55jdU4ylQWvVseVU0vJKYqej7h9D5Za49q0w8Bvb3L
         z72SUgwelDxYRwYl60pByQvUfHFksonBr9d579aaUeUyvyst1Xu/RwsV8Q2gUjuj8F9R
         Mm3OFzGLU6xFEv8feZTQhoA1jeiLoSjEeM9t98ADvvCg2hU2HRdB+YFip+Rwm7Kf9Hov
         UMsNffSeig9n1MEO+bSWjVSQIsjNBGEK9mcJYIlmCA/CJmlQG3tog+vJlTo+6EnJtJzl
         zsLroxw6TZRjy5qxcTo9wXHggwGa/0arCn1Hszb32qhekfoF6XQ+j1SmV1IF5LDmBX2U
         WzfA==
X-Gm-Message-State: AOUpUlH/dKJ0hGBh8mHIu+3dj2wtPZU/COM2IihvKAsukE7rDPBMtrn8
        RIluctzXZ+vXYcgwGiMHQJNiTQ==
X-Google-Smtp-Source: AAOMgpdCmyHARUxbjH1+qsGtBqcJYk5qaYcMFibt+NSWjHTQZcEKv/WgxhWcTQOY6CSk70QvPu3qkQ==
X-Received: by 2002:a65:5641:: with SMTP id m1-v6mr2427110pgs.246.1531405924603;
        Thu, 12 Jul 2018 07:32:04 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id m6-v6sm33241303pfh.153.2018.07.12.07.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 07:32:03 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 3560630029E; Thu, 12 Jul 2018 17:31:59 +0300 (+03)
Date:   Thu, 12 Jul 2018 17:31:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+120abb1c3f7bfdc523f7@syzkaller.appspotmail.com>,
        jglisse@redhat.com, kirill.shutemov@linux.intel.com,
        ldufour@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org,
        ross.zwisler@linux.intel.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, ying.huang@intel.com
Subject: Re: general protection fault in _vm_normal_page
Message-ID: <20180712143158.7d5njt37x2bvq2xr@kshutemo-mobl1>
References: <00000000000010c9390570bc0643@google.com>
 <20180711140449.3702358d7e8898017e34dcfd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711140449.3702358d7e8898017e34dcfd@linux-foundation.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 02:04:49PM -0700, Andrew Morton wrote:
> On Wed, 11 Jul 2018 09:49:01 -0700 syzbot <syzbot+120abb1c3f7bfdc523f7@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    98be45067040 Add linux-next specific files for 20180711
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12496ac2400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3f3b3673fec35d01
> > dashboard link: https://syzkaller.appspot.com/bug?extid=120abb1c3f7bfdc523f7
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12a46568400000
> 
> Handy.  /dev/ion from drivers/staging/android/ion/ion.c
> 
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+120abb1c3f7bfdc523f7@syzkaller.appspotmail.com
> > 
> > R10: 0000000004000812 R11: 0000000000000246 R12: 0000000000000005
> > R13: 00000000004c0565 R14: 00000000004cffb0 R15: 0000000000000005
> > ion_mmap: failure mapping buffer to userspace
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] SMP KASAN
> > CPU: 0 PID: 4785 Comm: syz-executor0 Not tainted 4.18.0-rc4-next-20180711+  
> > #4
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> > Google 01/01/2011
> > RIP: 0010:_vm_normal_page+0x1e5/0x330 mm/memory.c:828
> 
> Presumably has a NULL vma->vm_ops.  Probably one of the now-removed
> checks in mm-drop-unneeded-vm_ops-checks.patch would have avoided
> this.
> 
> Something for Kirill to think about ;)
> 

Okay. Looks like we need vm_ops in the error path too :P

Here's the fixup which should help.

I'll post the new version of the patchset once figure out nommu issues.

diff --git a/mm/mmap.c b/mm/mmap.c
index 74d4d2a8fe08..eedac20735c1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1776,6 +1776,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 */
 		vma->vm_file = get_file(file);
 		error = call_mmap(file, vma);
+
+		/* All mappings must have ->vm_ops set */
+		if (!vma->vm_ops)
+			vma->vm_ops = &dummy_vm_ops;
+
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -1788,10 +1793,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 */
 		WARN_ON_ONCE(addr != vma->vm_start);
 
-		/* All mappings must have ->vm_ops set */
-		if (!vma->vm_ops)
-			vma->vm_ops = &dummy_vm_ops;
-
 		addr = vma->vm_start;
 		vm_flags = vma->vm_flags;
 	} else if (vm_flags & VM_SHARED) {
-- 
 Kirill A. Shutemov
