Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-725065-1527741019-2-10034139265637584435
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527741019; b=aS/kE/SAH9ULwYp9y0YY3YxESjGEPz80y1Wu2F3AJlzDz/8u0J
    GhS8FJupMVSpQLy4R5D4kNkFOnPb97iQaCSg8RaJiPBcmgj9VF86ZHx93bxHvv6+
    5wGmuEFtXxVnMT25Y3IOtQyzkHa3zt9mh31QzH3KT5ZcNyrBxyXGLWv/hY95wz7F
    TyfdINDqkhvILbgzb/ZLymOBJhq72lzOj8zDb01my3BFHa7cUIiOwin5I290cb65
    mSqZEPM5qOGOFhB8MaRkN4ULPy7Zga4tf+9diqxwXERY1n7SXWqBAHEFzZf7fE+2
    a2ywivovLWdMlIaQzpGHiHL5UGtqr3/XN+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527741019; bh=atMpDTv0WEuowgcJGxcH4CAogbIzvQ6+AUN6mr52kr
    M=; b=CDWm08ekpcCnbvmJ0Vp86XbwFarchZRw7oplrGZuWlRuV/zgsgxfqhNB7+
    6AMtoTeMuJ3EixrNTOB7yicMS41pLEADkduMo9HznvaHK08XlVMxwsMBED8efrN/
    8FObnt0+ybo5dIHMjlEgqQFMJj5K0Gb0FDNctzl2mGlMo1n8iI0BF9RfMBGoHvci
    Eo65mhkNn0QocEanLRAxdkVf/mZcARcXAc2kK2JA+aTZa7wmLuivtxT50gudVMNL
    Y97PSA4pVdWzz9GcqmOsAXhC3zpQikQVxYl8f6zvwx1wL0gbCJ+TFtVyoukpxH+8
    1jkAgxtRS9GNMw375GtAKk5ZW1Mw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=KXntgBHB header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=cegv4M/p;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=KXntgBHB header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=cegv4M/p;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJF/9M7bcqo1HqeaEFDMa9giSC6LGSdGh1f+spB187lnNnbrPPzcKYCV0rfREAh0w8KbjD1i73fHnZfphg1YvBqVmgxz7tzaHA4qqqz/Mtf+AuIuBc/B
    rglzSnE8eWfEh2qJLLA2mm6PLfhQVEn73YkKg/Fqu63Q3DY7y5WyMQyz8ubHdfO+Jc1GtN6UHSOMBzwoUmVPxRa0ePr4UE8zgU89CIIIljneHz/yoYCFYosI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=r3nPLSDzUwAA:10 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=so8oFCSUSSi386K3irUA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeEaEaJ (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 00:30:09 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41600 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeEaEaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 May 2018 00:30:07 -0400
X-Google-Smtp-Source: ADUXVKJMTZvnOBRSw5BAaNf6/bWMyuaMmg33xi0p8mvdwH4HEBwxlngSn10hpjP8vH9yVMAy/Sc4nEgN0kHMOM0alyo=
MIME-Version: 1.0
In-Reply-To: <20180530210556.GD2717@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com> <20180529144612.16675-17-mszeredi@redhat.com>
 <20180530210556.GD2717@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 31 May 2018 07:30:06 +0300
Message-ID: <CAOQ4uxjNzc+=AyfhYBAi_-NkMss7HS3hTRBjYUgkmuFdB6-sRA@mail.gmail.com>
Subject: Re: [PATCH 16/28] ovl: Do not expose metacopy only dentry from d_real()
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 31, 2018 at 12:05 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Tue, May 29, 2018 at 04:46:00PM +0200, Miklos Szeredi wrote:
>> From: Vivek Goyal <vgoyal@redhat.com>
>>
>> Metacopy dentry/inode is internal to overlay and is never exposed outside
>> of it.  Exception is metacopy upper file used for fsync().  Modify d_real()
>> to look for dentries/inode which have data, but also allow matching upper
>> inode without data for the fsync case.
>>
>
> Hi Miklos,
>
> I am not able to see how in fsync() path d_real() gets called. If we
> decide to do fsync() on upper metacopy, then opening upper will not
> go through d_real(). And we never issue fsync() on lower.
>
> So I am scratching my head while trying to understand the d_real() and
> fsync() connection.
>

fsync() exposes real meta inode to vfs, so file_dentry() needs to
be able to find the real meta upper dentry.

Thanks,
Amir.
