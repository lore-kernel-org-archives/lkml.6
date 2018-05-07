Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1604446-1525726711-2-1412660888931692028
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525726710; b=LlMTiID653uodJHOSfwQrdufmEuipRkjs2JxYpUdKvz83Wz6ls
    Bypxu0oUwDRX78cpzEvx+6ieoyK4/S5n8XgfwK+ND4IezmVEZprFh3+z3S+3hvnZ
    NpAcB+WypAsN5nLeJ1Hx0ftp+7Qli1HBwiKm3YJFZ59dW3XbwVk45rONPWFEuzm1
    A1V1D+CkhZyMvwZl8jKF7lcDh+bsxYDtk22KhDBGxXkxqOSXMrKVQjAQlbRGCeuF
    LPOBOUXgH75vuRPnN7Is5xltg8VqxVJgW8X5jqTUCBxOegy1RpgoWCHIkFpzdFaj
    zO2EbjqXgpovi4EufiFXYSnZBrpJFP/RAcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525726710;
    bh=RyAixUSKFbL2xnAK1AA7AWnMD0REKB8n8O/hrGegixI=; b=cYZRl5bAoYHV
    KqKGyFItZXQnB8bOum3t8XlWXT25qg6wcMWdvznafUpqIHeyjPD2bGHhpAEks3wb
    VBTpPOPP1YZ8ycx3fBomQdI51+4yLKwJutTuqC4FtfEh2+4QPguZecuZbyTHdcDX
    7ywR0xuZPDlN26DEuRF/jVBMAn2RzROlGPyJDC2elDwmkhH9nclzsj64NmQgJk6m
    DQe2f40H0aCUEZ3YsGzlSy+GmZQXG02Ih2qPKdxuTWUsmZKoCrko52c5H6i+3l0Q
    EM3eIuEoNku2f3D4583rhK3Xtm+6FohPr9oQ/Td6L71+VVym1mavvB9I/rJ0caGO
    JzDdgp49FA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=physik.fu-berlin.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=physik.fu-berlin.de header.result=pass
    header_org.domain=fu-berlin.de header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=physik.fu-berlin.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=physik.fu-berlin.de header.result=pass
      header_org.domain=fu-berlin.de header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEPLp+hc5csKFP4jComXamuCCVpRlm+o+ZFtt6hwRwRltiQoEo15tYPDjCXKkNLqy9v8FNLs+W15DNF4e0QfDYU5nEzhk9FhSeSh+fI8z5e4PPO9njOQ
    1d+ESfq0/XeJ9x+K5fRFM6DImbQVSjyzpOj7t4G8LBgs8HkO8t7qWN47hd1NoOnv6DWNa72r7A0aX/mjh8dSY83i9fBFkN1fs+2dO3I0khxQFz/4bx2ukKjM
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=sm51dqHkRZoA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=fxQmKilqAAAA:8 a=xNf9USuDAAAA:8 a=gommdg4dQcCst321jEQA:9
    a=QEXdDO2ut3YA:10 a=GN7KdCoLTWsA:10 a=YDDkSwQ3hvqTdS8KZhgp:22
    a=SEwjQc04WA-l_NiBhQ7s:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeEGU61 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 16:58:27 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:45911 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752855AbeEGU60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 16:58:26 -0400
Subject: Re: moving affs + RDB partition support to staging?
To: =?UTF-8?Q?Ingo_J=c3=bcrgensmann?= <ij@2018.bluespice.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Debian m68k <debian-68k@lists.debian.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180507021554.GN30522@ZenIV.linux.org.uk>
 <CAOmrzkLAm99UTkzV0n+rtLg4XTrxHrCkR1ccitsyhf6XLztkpA@mail.gmail.com>
 <4217788.NhxQeTpgEt@merkaba>
 <CAOmrzkJ-ao=ACUTw9NK-77s2geXL4bpT-EWMO1YnAx9sC4ORZw@mail.gmail.com>
 <BFC260B3-5E0F-42BC-8E47-5CC630B24A87@2018.bluespice.org>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <eb658823-f266-046b-6fb5-47ce25fd411c@physik.fu-berlin.de>
Date: Mon, 7 May 2018 22:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <BFC260B3-5E0F-42BC-8E47-5CC630B24A87@2018.bluespice.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: 80.136.166.253
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/2018 10:56 PM, Ingo Jürgensmann wrote:
>> Haven't seen a Linux driver for that 'some USB card' yet.
> 
> There is for example RapidRoad (<http://wiki.icomp.de/wiki/RapidRoad>) which
> is an addon for the X-Surf 100 NIC (<http://wiki.icomp.de/wiki/X-Surf-100>).
> Adrian already has this addon module, I will buy one this year as well. 

Michael is the one who has started working on the driver, so I think
he knows :-).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
