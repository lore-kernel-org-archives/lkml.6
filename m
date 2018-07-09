Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8070C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A065820877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="hdlWkGT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A065820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeGIK0Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:26:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38014 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbeGIK0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:26:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id x13-v6so3434578pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pgauaGfXbwUaP0MxzKX0JYweqOQRxWsXGdFeUrh8jCU=;
        b=hdlWkGT3l/laiN9yhv6w7rqcLLaybSYskQTpde+MQpDEvEVA6DR/4FH/fBDrz6X2O3
         iTzZ8rI3C+yGYxSngTlcFO5GI9/fYH/gyC2V9R6ZOfXU/rvHozS87cFAegAHXR/5qQ6J
         1Svc5U+8C9xOqGrRxQdJNc0+uc0xh2Ms3lnoPIo7qvagB3W568uD0ra7/f7gn+aD91DA
         VT0nhzqPAooCDntfveJH6pcU2W6cfHaGjQyk5JGQK+2KqCuvvPDrJJAhzB6NXEiSHTQm
         KSc+QmOeqByT6lYCEhA5y97uXvrjnXbxx/ktlYKm1wfu5qVoxl5vJV/dExUMRMzxLi9Y
         V/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pgauaGfXbwUaP0MxzKX0JYweqOQRxWsXGdFeUrh8jCU=;
        b=gNkJn94MS8SSEFxmfV6GJJv97i/fvwxfdSgbTH67jhRIVLmbJMDGC6INuJLV4yHTeJ
         W2uMxOWXWUoMLfqMyISVnQkDkam+zH65VMlaOoqptMagg7rkfdREgpjuKJsF+yMHOtDp
         GO2ZNsAuh48b15LgohRqsGLp83mIkpYBan+43wktJc04KlB5y8hwJodWa3TN/dETZ1be
         pQJG6mBrnPjSMz4wHCFY1higXUXNqoK8j+goIY59G73+8GWryL8sls7bce3/C879FIbr
         WPv8DBktwMCouI9TTSW7EvAtTifbLHVm+R/1aRePgiCKlhNxNFlgpoE6vEkgq2l4Z44Z
         ugPw==
X-Gm-Message-State: APt69E14BvoP2Ep8uMTeaNdEhIsK2RRWYUVVLuS7FJ50YOuxWErzQOYa
        vdxpXlSXQvBj99EN+EtN2JbwXQ==
X-Google-Smtp-Source: AAOMgpdgowmdbPEjYcP2asq7R19mgNfry+0tehVQxPpdCdeQ2/HhDvNEY8RUmOog29Te27fi+oTenA==
X-Received: by 2002:a65:5141:: with SMTP id g1-v6mr18184002pgq.418.1531131983442;
        Mon, 09 Jul 2018 03:26:23 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id b1-v6sm14808046pfa.181.2018.07.09.03.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 03:26:22 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 484B630003D; Mon,  9 Jul 2018 13:15:58 +0300 (+03)
Date:   Mon, 9 Jul 2018 13:15:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     syzbot <syzbot+3f84280d52be9b7083cc@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        jglisse@redhat.com, kirill.shutemov@linux.intel.com,
        ldufour@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org,
        ross.zwisler@linux.intel.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, ying.huang@intel.com
Subject: Re: kernel BUG at mm/memory.c:LINE!
Message-ID: <20180709101558.63vkwppwcgzcv3dg@kshutemo-mobl1>
References: <0000000000004a7da505708a9915@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004a7da505708a9915@google.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 10:51:03PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    b2d44d145d2a Merge tag '4.18-rc3-smb3fixes' of git://git.s..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d07748400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f84280d52be9b7083cc
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3f84280d52be9b7083cc@syzkaller.appspotmail.com
> 
> next ffff8801ce5e7040 prev ffff8801d20eca50 mm ffff88019c1e13c0
> prot 27 anon_vma ffff88019680cdd8 vm_ops 0000000000000000
> pgoff 0 file ffff8801b2ec2d00 private_data 0000000000000000
> flags: 0xff(read|write|exec|shared|mayread|maywrite|mayexec|mayshare)
> ------------[ cut here ]------------
> kernel BUG at mm/memory.c:1422!

Looks like vma_is_anonymous() false-positive.

Any clues what file is it? I would guess some kind of socket, but it's not
clear from log which exactly.

-- 
 Kirill A. Shutemov
