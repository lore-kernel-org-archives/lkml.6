Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2527795-1525568429-3-298826957765829770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525568429; b=SQP5ShatZbzUCEc4+2THXEFodxE/3FjqYmg0CNjBfUTtcsQwmU
    J1lOyDUIa3nD9r1Wo3npKsK4TUq12+QsT5cplnUeEdyZTRduKYCYOAxbyWrqS2Ay
    xIFySvlKni595PZiBCN+5PaK6a9yXNaP4U6yACzoonuIiIFSOW9jlGxlDZ/+ALSf
    sAqX8zH6KfQv3cKCCJirqt9yTCuEi/JrQdUKNKVK8vHcHWVbciBE/hZFhTsbxT3G
    rHIv2XGCuoCQ+Qto0TZP35iYx1hCEGTz44k6PoG/1D7ShEpfeJuPQnCL71iNN0T9
    xx2aZfGUhov+1tWfJQunsDBG/sZRHwJG5Yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525568429; bh=Kmb5ikneXfr/9F8M5VmAWp3JuYnOIf
    OZJmTA6WfgoeE=; b=IB/OwYgtY5gnz7sSofyb5q/QkpbRe3IRYyRfsg3YKnclqv
    BMTLXbk5qmObY5Rx+EGkkCmkTETQqTf1nPMTPOAU39stuQqFYTzbM9jkvn2DYyHn
    zMhfBjaARk584n3U+jucKjSCUpg3GQ10q+Zx9ZGt+p4xyZw/4bh+DBX/hXZ0RDem
    kcvvcAmUcVNdT2eaLgPU5xo+BxjOECwxaVfEEgOoIvQg8JIA4CPqAKf8YE45FdFf
    XeyehAmPSSFjVYDnkh5H8ceVKRWWylpuKUVjNyd2fP1tn1AzUSkE5rnsC6s2ZNhD
    7pXeUJ/tszh6QkKaBBljMplV5lKOD/FJgkDzP+gw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHMwEN++kvmuQ/NAnwzezWOnoTjbfHEv/KmRGL5MUwF4qi8vMRXV4/xwcr863xuWoqFlP8UCSn+tJFJWE/jb28fi5kJOrHuCJhZf3hJcAa8pIed1nBFe
    b2zyPfL+vMBR7Z4mA4v7h+ksRDW4EiaHhIZaMvqyo30p1fwotvZr7HDLqGLuBiFUHitUJYwNHXnAMIliZVD3BKVc7r2AhcUYEWnR+RDelnB9cUDtQaqFqJgD
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=X8rsvPtmAAAA:8 a=ZuO3l6faAAAA:8 a=gJcQh2trAAAA:8 a=PEN_4dZorEWS9r-IfQUA:9
    a=CjuIK1q_8ugA:10 a=iFvzNDAcT74_nAS09Xtt:22 a=jhS11inhvYEtIRtj4HQL:22
    a=orh-YdTTE9rb79OYXCg8:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeEFBAZ (ORCPT <rfc822;linux@kroah.com>);
        Sat, 5 May 2018 21:00:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59970 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeEFBAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 May 2018 21:00:23 -0400
Date: Sun, 6 May 2018 01:59:51 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org,
        Debian m68k <debian-68k@lists.debian.org>
Subject: Re: moving affs + RDB partition support to staging?
Message-ID: <20180506005946.GI30522@ZenIV.linux.org.uk>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org>
 <1613268.lKBQxPXt8J@merkaba>
 <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 12:45:41PM +0200, John Paul Adrian Glaubitz wrote:

> Exactly. It works fine as is:
> 
> root@elgar:~> uname -a
> Linux elgar 4.16.0-rc2-amiga-16784-ga8917fc #650 Mon Mar 5 15:32:52 NZDT 2018 m68k GNU/Linux
> root@elgar:~> mount /dev/sda1 /mnt -taffs
> root@elgar:~> ls -l /mnt | head
> total 0
> drwx------ 1 root root      0 Mar 30  2001 Alt
> -rw------- 1 root root   1352 Mar 27  1997 Alt.info
> drwx------ 1 root root      0 Nov 16 14:39 C
> drwx------ 1 root root      0 Mar 27  1997 CS_Fonts
> drwx------ 1 root root      0 Mar 27  1997 Classes
> -rwx------ 1 root root   1132 Aug 14  1996 Classes.info
> drwx------ 1 root root      0 Feb 10  2004 Commodities
> -rw------- 1 root root    628 Jan 14  2002 Commodities.info
> drwx------ 1 root root      0 Apr 10  1999 CyberTools
> root@elgar:~> mount |grep affs
> /dev/sda1 on /mnt type affs (rw,relatime,bs=512,volume=:)
> root@elgar:~>
> 
> There is nothing at the moment that needs fixing.

Funny, that...  I'd been going through the damn thing for the
last week or so; open-by-fhandle/nfs export support is completely
buggered.  And as for the rest... the least said about the error
handling, the better - something like rename() hitting an IO
error (read one) can not only screw the on-disk data into the
ground, it can do seriously bad things to kernel data structures.

Is there anything resembling fsck for that thing, BTW?  Nevermind
the repairs, just the validity checks would be nice...
