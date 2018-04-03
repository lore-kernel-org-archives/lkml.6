Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2231918-1522782094-2-2486026718384481963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522782094; b=FfxpW1SHyzqul+R3582wlvKhPfmbm9Gy1VRPToRZ3qEei9JWP3
    9SbLd6Wq2uWvhjaHTxbSllZ4oxYqIhrfxnlNd0vu6YZl+zp7/WIBc6aewiDg1cV4
    a0+bioDOvS4yXsLKtxndY1S47Fws3wFCM0VpI/+ij7rBPiYJDxxGXKIb9pYKtVBb
    q+2THRByMZWEPCSv2wF2GfWgftateaWoWWIO5Ha/8RlDx/kp8D/WIXEBVCuOssVh
    xrQ7aLLNkpCYKM5DgPyBPnpCV8VWaWRu/SrTh1GGlyVMn6roUFsxrY7NhC/eqHuV
    WGGYeOMniY9axobCQBuFtxQJnhKOFaZhONXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522782094;
    bh=1ujeff880Vuf67j5UZdrV+bmWrzWC/es/YmwH5ZWD3M=; b=wnvDchT/OnKR
    fq4WgieZUvMdLtO6rjsVhqibWIqLwoyx2VTqOWqCR48XZFjU3mv+CnwgovKjdVya
    6ApDpNMMrRUpqcibtdH/d2QTD41RCv3VxVj8dzkZTqqFamfrjTbCrPiZhVT0C6UP
    SJU4GX3LpjjPprigIG69k6/RTU/6jwDAUMxiFLhkLdIKrFm9MF48pnEkSwvWJlbO
    p2NvylfpwI2AGnyv6RSlAzbWnNmTFq+gPowc5/H4PRvj/mdLg4LSzjGd/bDewcff
    +kaoDEpDhmcraTq9WZlZE2Lo3ptNyMqKr9fObtyFgE/wErtEiNWfmWJXLBchae6v
    Di6DQC3p3w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJicu4Balzq37FKY68JMBV/rx8nI9eSlkzgpiT/nhN3+tVkNhmiMSa0na8AvkOWYYi0CX+32/8AWZnYunnaa2sUaUF4Onz3/PhQDtR+KPWzQ6ialuScX
    dZ8jcXkc4uRd0Ll5MoTt/Kg8nCBo2ycIWFR+kZGbYzrlczqe31PZ533DKWBByCN4EVu5bA5JmdQLbDzg2XwzVuFUp4L0NFK56FLmXG8VGtgSti7jy4gLg7wc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=F2vHYduPzqcl57cY7joA:9
    a=4mYHZLnFswRnPkvs:21 a=XUbBr8-yiYoaLgdx:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeDCTBc convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Tue, 3 Apr 2018 15:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753207AbeDCTBa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Apr 2018 15:01:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9474A2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4+GP02uML0dG/SMYGzDeag+StosvWra4bOY1h7XvI0nws8p2RXVmLqj7/zZUPx864GPqRmkloyIQHHoht3dP8Q=
MIME-Version: 1.0
In-Reply-To: <9758.1522775763@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com> <9758.1522775763@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 12:01:08 -0700
X-Gmail-Original-Message-ID: <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
Message-ID: <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On Apr 3, 2018, at 10:16 AM, David Howells <dhowells@redhat.com> wrote:
>
> Andy Lutomirski <luto@kernel.org> wrote:
>
>>> A kernel that allows users arbitrary access to ring 0 is just an
>>> overfeatured bootloader. Why would you want secure boot in that case?
>>
>> To get a chain of trust.
>
> You don't have a chain of trust that you can trust in that case.
>

Please elaborate on why I can’t trust it. Please also elaborate on how
lockdown helps at all.
