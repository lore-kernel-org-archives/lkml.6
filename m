Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E911EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9096A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhXwf+5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9096A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeIFN1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:27:45 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41636 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeIFN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:27:44 -0400
Received: by mail-pf1-f180.google.com with SMTP id h79-v6so4930146pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=abN3XthGw0GVRZvdl4K4WzWpy3nzbMAfcbVj+VbsH84=;
        b=QhXwf+5NMY+MYEHibIv50jIrtRQYvOxNFhRruBDzvsWdWEnT+BRH53a00OQ/WvgM1c
         N2Ljvugp23DVrZ74u1nv6eeqa0StWgU4MAuF7yYX3dEE2mpTlsameQH7NmnZvpF7Q+KQ
         74f6Q6nrh3BHl//+FkwBV8Gm262fRXjPur3T/OTs5TcyFGv863f9aGWna9XVu1It+qlM
         mf+qeJpybl5acQyZn04+8OU4y/HspoJSNzkfk1eZRicI1OzaRSIiP6I/1h6KEElOmeq2
         /wyDBLrqpdh6TaXYzUovj0K3YPjqolxeNWvgoiAxCpkRvey+2ES07MqfKY6D9sgRnBN1
         aAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=abN3XthGw0GVRZvdl4K4WzWpy3nzbMAfcbVj+VbsH84=;
        b=Mjo3y2JN0VdCmX4Nv33QoKE0uQ19tKS3SnBv/tII/k44FFlI4sPveJmKcYZ/UUp7HF
         cg1FSipht1KJ/eUVHLTYohlae9lJs5K1g1ZX93FCNqXKetPRTFpvk9jbmO0HDDa2q1+k
         g4VYDEYhJ4vOqPUKkXJHvT/hGGuWXGAGUJPJQ34fpbLkvC2vySiXPRDyKjcAt0oVfnz6
         0zc4ajYXJCkDApCZu02XAqiVjbSRZPrfdejKucHU7WhvZis2v7WqsQMV4fz0C83lKZpJ
         rtyjP/WrZzuOW1zJheLVOrQw3U+Esml2NUdPVcwuSrU87fTUJFmrbDVenC18ou8yk0Ub
         bZOA==
X-Gm-Message-State: APzg51CXWyDCxbGOxqnubd9lLTG4N7QksSGoeKORGx9IkHUHPg0s31sU
        WRu1yy8NXiJM6DuddVS/yHfHsjSxxvV1E+XvsCJYBQ==
X-Google-Smtp-Source: ANB0VdaXaC+Az9UADX+Ni0z4MHCMIW2uuUBhlRPwy7OwmMdVJdyyNbTDe3Wt/ketf+fQEVkkLHNKd1lgJlUtKHjSq1k=
X-Received: by 2002:a62:2a48:: with SMTP id q69-v6mr1806499pfq.86.1536224000043;
 Thu, 06 Sep 2018 01:53:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 6 Sep 2018 01:52:59
 -0700 (PDT)
In-Reply-To: <29979.1536223287@warthog.procyon.org.uk>
References: <0000000000006082bd05752f92bb@google.com> <29979.1536223287@warthog.procyon.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Sep 2018 10:52:59 +0200
Message-ID: <CACT4Y+ajxhUaRg+XSuqQZN8rD96S820yMTWx2GpRVRb9Maz50g@mail.gmail.com>
Subject: Re: linux-next boot error (2)
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+762a577f56cfb1574647@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander" <alexander.levin@verizon.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        nikolaus.voss@loewensteinmedical.de,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 10:41 AM, David Howells <dhowells@redhat.com> wrote:
> Do we know what type of filesystem is on the root device?

ext4
The image is built with this script (you can find mkfs.ext4 there):
https://github.com/google/syzkaller/blob/master/tools/create-gce-image.sh


> Also, is there a way to tell if AppArmor denied something?

That I don't know. I guess it would have printed something.

This configuration worked before. And we don't see any errors on other trees.
A relatively recent addition was ext4 options "-O
^resize_inode,has_journal,ext_attr,extents,huge_file,flex_bg,dir_nlink,sparse_super".
But I think we already tested with them and that all worked.
