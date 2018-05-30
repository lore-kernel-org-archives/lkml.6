Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3573297-1527668942-2-8736521839993840046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527668942; b=UB0qxxOBeDWQFt6+VLsVW7jdky/aPn4+j4Xbm2av0QNXtgd8Cn
    3FP4Lvu1AkmJeOdJbuqm0y1T8fQQUhiEzIjDhkFIAhuzzIp6CLaKnk/sNZbUww9g
    ne1nQsLqQTeCLVDLfWkjqi7UnE9AXFIwCfwLSRTBXlkO9MaFB/PfZxMo6YZG3uLj
    4m49qd89xI8apw8VIl3uSelsY/zHiCfUdexYS4h9ioDUNcRoGPzKEBeKdqb/cEAO
    PL74ezZzGgK0biCnaMdV5h+5u/2uIcYBYLtPzwqx5ZBqYRkLS3LIZwhAembeTsEc
    sJdEzyo8n/+LZYQgJkIcLYJjL99zXc1STxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527668942; bh=ZXLBoztKZfE/QVO+C2zD5JVR2qYYBJ/BABPHFBl+8Z
    g=; b=KCRfqzjCjUPkyknFjidBifgtxyw6D+LH267zAINes8HtaekNjglI0zXZv0
    t4Tc4Bnib4WPrYSNzJGlgjAuUeTHBQcwxJ08ZEu4foYeV9hKNjNyw6xF4wfcbOmT
    2mpVx5JOZ1j3xn9WR+vJfqOFdpUxarrS/GxxDnPaexbe1aPd2sG7KBHFvCUURzIx
    8Qh6yCtOenemfxypQwGdEvuuq7XWg4nixOFPTIltqoz9E6Nw1Tz1huwDeb2SP3n9
    TQT+GCn8mHN2XRdY0QdbW7SnyidYWz+Hk9TDeFOuBBZQcYmvIt/F+lwgv7b/Wy4C
    4uMzxN0ctxD64J7t1My10mO6hdbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=Jj36XSsq
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=fq3lfIZK;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=Jj36XSsq
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=fq3lfIZK;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFAcZwGT27hoAkTlwe5Onu1U9qF6u+pldL2unN70dM7+pVUDgw2qVg60hKA9VTDdxqiFNJFnKJtgEj323TcCA0WgvH00HE7BpIhKiCHvqvRwBBRaOgEj
    4synUuyL96nb9vLV5lsQ6JmvDjeh6wGqtJvqbxKgYYVHNbZXAsc708kUTALRjQmxLbY0gwL5Wb52jbVMy6xNialdypZrCnih96M4U+jVSJw3pelkyx4Tij+E
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7YwWrYXYVYkA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=9EazHPMCSytDOZw-kdkA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936020AbeE3I25 (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 04:28:57 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44477 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935918AbeE3I2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 May 2018 04:28:55 -0400
X-Google-Smtp-Source: ADUXVKJK2sASaMDTMX5jru7jYgrSwgPj8HKuf5PyOCLl05o7L0tXBacmOdaWcOQP4bQW/eLhU/JiMvCpgoJH9GbvdVI=
MIME-Version: 1.0
X-Originating-IP: [194.176.227.33]
In-Reply-To: <CAOQ4uxh0XUgOZ-tZ_1jTxBLFAdWv53kamh-1=hTuLkVpEVA08w@mail.gmail.com>
References: <20180529144143.16378-1-mszeredi@redhat.com> <20180529144143.16378-6-mszeredi@redhat.com>
 <CAOQ4uxh0XUgOZ-tZ_1jTxBLFAdWv53kamh-1=hTuLkVpEVA08w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 30 May 2018 10:28:54 +0200
Message-ID: <CAJfpeguYLeL6GCmtScw0fMGJFscCEWWUz=CQFrTBDssA9VKhWA@mail.gmail.com>
Subject: Re: [PATCH 05/11] ovl: return dentry from ovl_create_real()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 5:24 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Tue, May 29, 2018 at 5:41 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
>> From: Amir Goldstein <amir73il@gmail.com>
>>
>> Al Viro suggested to simplify callers of ovl_create_real() by
>> returning the created dentry (or ERR_PTR) from ovl_create_real().
>> This prep patch makes Al's patch change less callers.
>>
>> Also used ovl_create_temp() in ovl_create_index() instead of calling
>> ovl_do_mkdir() directly, so now all callers of ovl_do_mkdir() are routed
>> through ovl_create_real(), which paves the way for Al's fix for non-hashed
>> result from vfs_mkdir().
>>
>
> It's good that you split this patch from ovl_create_temp() patch, but
> the commit message it utterly not related to the patch anymore and
> possibly should retain Al's authorship cause there is no relic of my
> work in this patch.

Fixed headers and authorship assignments.

Thanks,
Miklos
