Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3085648-1525601549-2-1900086729043888114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525601548; b=G9FZF21ezFlL4fob5LopX6maHCoHJUcvggtbyvGCg5Kzof8RdX
    kAjX1sIBMQLwC00Nk+qKG0HsIy5RyPK+oiAqsTsLwqZ7U8prZ0o8T1IVJDN2y4iM
    VyJvhjsMgj/aNOd7Dn/2jxYbDxuTHY5wnJU9iYdbRBy2H20lsyu+S13lxcDepNmb
    pxpwLgvgDZDd7DL6RszP9l4LOCFzZMNDmAdoT7IzX0pM2v8mlzLUG9r/Nb7JwBiT
    VjRfAsVwI34kg7ZofwQvesqZNco3Txu5sNMMUEoN0Q4jhzLB5QPEgvKHSAHN3mX6
    Kpaoud0QaB0FXUqnq3/jXcAyO3M1uHN75YDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1525601548; bh=O5btCn/p5+
    CqjRkT1Lrwek0KqatWLmORTxnjDnGQRuI=; b=Sok7v8hJ4K06LrMcBDL/zISgyB
    obwEdDZjuX2pO0e9KRWbLFKNcHegy14mmYQcjx2ST24FlfIexldE9XQwO9PHbkNy
    8O3U0Y/AYAFBzghXVzaW4h13WL1dAoiZIv7hkqn0hsvqpnqM5SdFPLYHXxrVitDl
    hBl3Uy1vxnZusYDZ4MTuIFXxyXv1gK7GEip5WT/0lfJQgb+IjEUM5X6dSkxBkqH1
    9tUGmOgGKAcJMQPHKIKTqRk2V2TtZpfBbVTr+3eYg+Zp4A7v6Mg8rt44u8b1zoGT
    hAuMTjsOQOrGshJPNL33fnbGu1p3qygn1ItCE2GOMuQ5vt0P1dOKEeZJ8/Fg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lichtvoll.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lichtvoll.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lichtvoll.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lichtvoll.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGUzkQNYMns0chTjrq4WapauDvd0KYxReMa7Ra0zV6d2nfB5BEjK6V6JOhADP2VAyHYXiHF91IhGrU3HJ8bD3Hjm0/0EbrnYuZr4ZTqj5MQceYycbb3e
    IkP977xQeRBcVm/RuiV0VPgpfUHz3HTI+lYUVmINr9jdYLZXT/qbSuBtN5Pfgd0aJUHk3bkYFZr1jZ/w05j7oUPjh5eula2Sag02UBsNLFco5ycyADiZ2qRe
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=X8rsvPtmAAAA:8 a=ZuO3l6faAAAA:8 a=gJcQh2trAAAA:8 a=1XNltsQq8YCeB7VZYuEA:9
    a=CjuIK1q_8ugA:10 a=iFvzNDAcT74_nAS09Xtt:22 a=jhS11inhvYEtIRtj4HQL:22
    a=orh-YdTTE9rb79OYXCg8:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeEFKMZ (ORCPT <rfc822;linux@kroah.com>);
        Sun, 6 May 2018 06:12:25 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:47991 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbeEFKMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 May 2018 06:12:25 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org,
        Debian m68k <debian-68k@lists.debian.org>
Subject: Re: moving affs + RDB partition support to staging?
Date: Sun, 06 May 2018 12:12:22 +0200
Message-ID: <5644198.Giea1MT2Lg@merkaba>
In-Reply-To: <20180506005946.GI30522@ZenIV.linux.org.uk>
References: <20180425154602.GA8546@bombadil.infradead.org> <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de> <20180506005946.GI30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Al Viro - 06.05.18, 02:59:
> On Thu, Apr 26, 2018 at 12:45:41PM +0200, John Paul Adrian Glaubitz 
wrote:
> > Exactly. It works fine as is:
> > 
> > root@elgar:~> uname -a
> > Linux elgar 4.16.0-rc2-amiga-16784-ga8917fc #650 Mon Mar 5 15:32:52
> > NZDT 2018 m68k GNU/Linux root@elgar:~> mount /dev/sda1 /mnt -taffs
> > root@elgar:~> ls -l /mnt | head
> > total 0
> > drwx------ 1 root root      0 Mar 30  2001 Alt
> > -rw------- 1 root root   1352 Mar 27  1997 Alt.info
> > drwx------ 1 root root      0 Nov 16 14:39 C
> > drwx------ 1 root root      0 Mar 27  1997 CS_Fonts
> > drwx------ 1 root root      0 Mar 27  1997 Classes
> > -rwx------ 1 root root   1132 Aug 14  1996 Classes.info
> > drwx------ 1 root root      0 Feb 10  2004 Commodities
> > -rw------- 1 root root    628 Jan 14  2002 Commodities.info
> > drwx------ 1 root root      0 Apr 10  1999 CyberTools
> > root@elgar:~> mount |grep affs
> > /dev/sda1 on /mnt type affs (rw,relatime,bs=512,volume=:)
> > root@elgar:~>
> > 
> > There is nothing at the moment that needs fixing.
> 
> Funny, that...  I'd been going through the damn thing for the
> last week or so; open-by-fhandle/nfs export support is completely
> buggered.  And as for the rest... the least said about the error
> handling, the better - something like rename() hitting an IO
> error (read one) can not only screw the on-disk data into the
> ground, it can do seriously bad things to kernel data structures.
> 
> Is there anything resembling fsck for that thing, BTW?  Nevermind
> the repairs, just the validity checks would be nice...

I am not aware of the fsck command for affs on Linux. There is a 
partitioning tool called amiga-fdisk, but for checking a filesystem you 
would need to use a tool under AmigaOS.

-- 
Martin
