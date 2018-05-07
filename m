Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-109822-1525668900-2-14608207892140533563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525668899; b=GPlTvecpt50iFa0ah4ENAMSIZLOceKQcB8J15p+dcnfe1wG36F
    zSPma1qXnksUbGmfEXlUYtqEsfXozCzJckOR39L6LIfZ4UvCRhDRESaFqCb0UueX
    D3rg8O3YYdrZ1YL68pZOs5sUe7aNL5Hl7YwxNK5pI8apP263KqMBO3+BekFIpfrp
    +Ck/k8rVAM/JnXlRPNch0gDnkwWQpG9IS4sFSkNX6mG9z2gzYglsR1+6n8aXKaHM
    XidJHaffBQnD4it5shzkSxRLbkp11lG1vmxFhYMroNtC8qdoj94ZRhwwqXXiwsvE
    h1mlOHqGyyKEM/6A0ICpvOu/KARTI4aFVMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525668899;
    bh=hyb7ExrMzbFXTk/OLKlTyE44bayZUqdIJzf/sQ6fuoc=; b=I1CJdqdjjJYW
    Kc/IDM0jZpIh+cSc7i3VwUz7hslfie9LFQhY6LudoMxZDfm0Y1Dzl6pXWzY95+bk
    W2QBGFu06ryeaUjujF/YTe/vaenALsTMCBadKJRCH2P+NLeNbJQiMha3LBNcDrwt
    8ZOeq1ugzREMOOcxMj6qCGsYXc+YAOiZh0miz1N9KDovAIKhT5TmZfKUsmxvXhme
    Wvx+n8PVQDt/hbeTuTWLms5ucmNmyKMDmZyObDb8SmwXAhEuRFyza688uH6vRQ6x
    6H6x8O6RzcXKTKhFamELUEZ5EIQzx2piCV4Gkhv6aKIoCIXx5Ljly+TLwPWecavM
    y2oCFIf9Ag==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=earthlink.net
    header.i=@earthlink.net header.b=ZtQ/6RGC x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=dk12062016;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=earthlink.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=earthlink.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=earthlink.net
      header.i=@earthlink.net header.b=ZtQ/6RGC x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=dk12062016;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=earthlink.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=earthlink.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDgubGa0BTmERQ0hESz28BioiLD/Zb6iSejzr+c1yEo3PT3L2nsxAg7zeXOCu8qLEg3HXK+P/19vZLLDdnX0MJJXjGzwdx0tk6UrZ5hhaY2Uze1dishW
    OQoH2VUpaEs6sfCI4sdSEZnJ5OTI1p2G44Ou6VUuay9aED09VNNmrIjoxJqApm8IXGMMxg6kXFSwoC1BmcLcsnUvzrzCzsWtoPPyO3kauysg39a4XRdcnOOX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=YuCtMMwzBvcA:10 a=IkcTkHD0fZMA:10
    a=x7bEGLp0ZPQA:10 a=VUJBJC2UJ8kA:10 a=QykXmDxI8zQA:10 a=S9NBJA-kmUUA:10
    a=bHyYafpNlUC-qHGgpocA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeEGEyz (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 00:54:55 -0400
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:33538 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751082AbeEGEyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 00:54:53 -0400
Subject: Re: moving affs + RDB partition support to staging?
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Martin Steigerwald <martin@lichtvoll.de>
Cc: Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba>
 <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <7a997bb7-7f1c-e8b4-667c-3993f1d82e7c@earthlink.net>
 <f8a044e8-01b0-7008-49ac-7e9c5ce7defd@physik.fu-berlin.de>
From: jdow <jdow@earthlink.net>
Message-ID: <fb889f9a-fce1-e4d0-0ebc-8dc06e40a533@earthlink.net>
Date: Sun, 6 May 2018 21:54:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f8a044e8-01b0-7008-49ac-7e9c5ce7defd@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120c608774229b1867d772ad4168e56cb39d1be6a00da4cd729350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.23
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20180506 01:52, John Paul Adrian Glaubitz wrote:
> On 04/27/2018 03:26 AM, jdow wrote:
>> And before I forget there are two features of the RDBs that I heartily recommend never implementing on Linux. They were good ideas at the time; but, times
>> changed. The RDBs are capable of storing a filesystem driver and some drive init code for the plugin disk driver card. That is giving malware authors entirely
>> goo easy a shot at owning a machine. Martin S., I would strongly suggest that going forward those two capabilities be removed from the RDB readers in AmigaOS
>> as well as Linux OS.
> 
> I assume removing the feature for AmigaOS isn't really possible since we don't have
> the source code for that, do we?
> 
> Also, if I remember correctly, Mac partitions can store filesystem drivers as well
> and its actually a feature being used in MacOS. parted received a patch some time
> ago to fix the correct handling for storing the filesystem driver in the partition
> table.
> 
> I would be generally against removing these features as I don't think the security
> risk is relevant for the majority of users. The Amiga is a hobbyist machine these
> days and AmigaOS has certainly way more on than way to be compromised through
> vulnerabilities.
> 
> Adrian

You do not necessarily have the source for the device drivers. However the 
DriveInit code and the filesystem code get executed by the OS initialization 
code. The objection I have to the concept is that it's invisible to the user. 
The Linux filesystem code is either compiled into the kernel or is available in 
the libraries where it can be monitored at several levels from source code on 
up. Within AmigaDOS it can be monitored fairly easily by an AV tool - in theory. 
Alas, this is trying to lock the barn door after the barn has burned to the 
ground with a clever enough piece of malware. At least AmigaDOS AV tools should 
be expected to examine DriveInit and filesystem images on disk in the RDBs for 
malware modifications to those blocks. This is a burden Linux should not be 
forced to bear. So loading filesystems from RDBs instead of the more usual and 
accepted Linux practices should be disabled. And at least a portion of this 
discussion is Linux related. That's why I mentioned disabling the feature. While 
I cannot see much money in AmigaDOS related malware I can see it in Linux 
malware. And there's no real "glory" in launching malware on AmigaDOS. It's too 
easy a problem last I knew. "Whoopie, you have just proven you can ride a 
tricycle. Can't you do better?" (One could argue that AmigaDOS 1.0 was 
self-inflicted malware foisted on marvelous hardware for the era.)

{^_^}   Joanne Dow
