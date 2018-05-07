Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1682199-1525729348-2-8378308671962469827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: from='utf-8', plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525729348; b=eaS5Lh7/o6Tp5R5/zNWUBuuyta9HEJtwBBKRywFOD2g2i++8kZ
    YomoUCsac4k8zCfFvvVBcQ2ExwRR7JtANRdepzFFQ07AS0uBN/Bs1Q9zaonf/BWw
    61rLOJJePLWOSQf4MDzd0P2+9WcAsx1uBFJBenHTYo2Hmvcu32ZV6ryr1LAMzXWo
    VP4Ah2bgfL4OyeIDFB9HxBc911M3uR54lZ+rqTucRu8FjdXcVdrL9dl9GAPD0FR8
    JTRMSVWFFKp3Afmw+djOa+DsUtQ9bwDJbTux7uZt/zGV8k3fj0g4yobE2E/skH3t
    EiLMxLVN0fCTNMO7j3zk5llcsUWHCcAVTpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1525729348; bh=I21NyQpB7
    ER5jbx1kRquhQKrVIKkWYWYtXDinHRcnvw=; b=MQYFW2HYLFHGX0fHTs8lrgivd
    0IPQFOi4W0nrUOwaj3jPQER74WBH5FYEO06hs0wGJek6GBRs+zYB2WLY3RkYOd/X
    sVjHxO1h+5X8QWmw9Bhayh2tWgdAEHlyVryBHGCfeOU8febmAEzCfuNIfGwrlOn9
    FKduNQDdIHClbT7tIHtKz+PZCsGzNngmeIsNXFU+f/NKvrljtRS9Vr4eh6ZBfifo
    MXhsfsegd7MedUJlVAgw/gaNENXIXE+Nq7JVNnNKYAJGjY6Il/gza6FsYtvYp4kl
    X6PnZT72eMYXNmEYEY+ul3zvxd3VFlkpBQoCsTheJunfaa2BxgtBo8FNV4tgw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=2018.bluespice.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=2018.bluespice.org header.mx.error=NOERROR
    header.aaaa.error=NOERROR header.result=warn
    header_org.domain=bluespice.org header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=2018.bluespice.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=2018.bluespice.org header.mx.error=NOERROR
      header.aaaa.error=NOERROR header.result=warn
      header_org.domain=bluespice.org header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEwRMtjz/Z3M6b3IAAUrdsyvPDV8lyqeNLM7/aLnFWk7zYxHhpWRKpb5Q6y488QucP8QfLbucEo10MSxqWHr3r5Q9SnyJGMbeuzyjzvWvmh9WOCql4xE
    9ck1lAfwTgIBd3xxUJBcsOyukdGF/mAZpi5PbhfVyEu7ubT2lSUxKswx2zW6JmGG2QFdC7Z68JYO73HNLfxh2UiPUgMnt5jUmBxbYUL1IeSGrSsjvLD9ISmJ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=fxQmKilqAAAA:8 a=uQT4uFbPAAAA:8 a=SzYmXD9iAAAA:8
    a=U0ZQ2HiqSV6SYaxN1MUA:9 a=CjuIK1q_8ugA:10 a=GN7KdCoLTWsA:10
    a=YDDkSwQ3hvqTdS8KZhgp:22 a=stQhUvwLjlunSvVCN3vz:22 a=qNJiN2NOeeb0LUVam8Qs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbeEGVmY convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Mon, 7 May 2018 17:42:24 -0400
Received: from vserv.windfluechter.net ([31.172.31.194]:40882 "EHLO
        vserv.windfluechter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752764AbeEGVmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 17:42:23 -0400
X-Spam-DCC: : vserv 1481; Body=2 Fuz1=2 Fuz2=2
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: moving affs + RDB partition support to staging?
From: =?utf-8?Q?Ingo_J=C3=BCrgensmann?= <ij@2018.bluespice.org>
In-Reply-To: <CAOmrzkJ-ao=ACUTw9NK-77s2geXL4bpT-EWMO1YnAx9sC4ORZw@mail.gmail.com>
Date: Mon, 7 May 2018 22:56:09 +0200
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Debian m68k <debian-68k@lists.debian.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BFC260B3-5E0F-42BC-8E47-5CC630B24A87@2018.bluespice.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180507021554.GN30522@ZenIV.linux.org.uk>
 <CAOmrzkLAm99UTkzV0n+rtLg4XTrxHrCkR1ccitsyhf6XLztkpA@mail.gmail.com>
 <4217788.NhxQeTpgEt@merkaba>
 <CAOmrzkJ-ao=ACUTw9NK-77s2geXL4bpT-EWMO1YnAx9sC4ORZw@mail.gmail.com>
To: Michael Schmitz <schmitzmic@gmail.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am 07.05.2018 um 22:50 schrieb Michael Schmitz <schmitzmic@gmail.com>:

>>> I don't think there is USB sticks with affs on them as yet. There
>>> isn't even USB host controller support for Amiga hardware (yet).
>>> 
>>> Last I tried USB on m68k (Atari, 060 accelerator) the desktop
>>> experience was such that I'd rather not repeat that in a hurry (and
>>> that was a simple FAT USB stick).
>> 
>> There is USB support available on Amiga since a long time.
> 
> Good to hear that. I stand corrected.
> 
>> On "Classic" Amigas AmigaOS 3.x with Poseidon USB stack + some USB card.
> 
> Haven't seen a Linux driver for that 'some USB card' yet.

There is for example RapidRoad (<http://wiki.icomp.de/wiki/RapidRoad>) which is an addon for the X-Surf 100 NIC (<http://wiki.icomp.de/wiki/X-Surf-100>). Adrian already has this addon module, I will buy one this year as well. 

-- 
Ciao...          //        http://blog.windfluechter.net
      Ingo     \X/     XMPP: ij@jabber.windfluechter.net
	
gpg pubkey:  http://www.juergensmann.de/ij_public_key.asc
