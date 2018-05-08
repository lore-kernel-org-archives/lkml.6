Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2957852-1525791835-2-6146742899792287260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525791835; b=j/hbe4VSiXkRkQFclFVIuTMY9uVIcQSo7OLLV028F+F7iinDah
    tRFpMSbtQp9HlkxRmnK9VTE/2U/BgTvmaULX2G1Kx3r7UfZwsNvPJqUxmzNDB/Y1
    a7opXyOiF9rvQIHSxAHGBk8/EPAFh5+mad1WxLHGk3Z6QURqQmxkc4/6nWzojTwL
    peiICNakZoz7JLZrMs9aOcD0c0t05D/3aUKjqIHkQNyhJN6Qr0qSdqrYEPuS4ANU
    f3l7VsBlmLAEPwF42acserq9PWBmQOabl9MO55B5vTHsW6K3QNXfDqZENl35xXU+
    5XZxp+ysaNjRsanswkrgyw+GaGmqu6AjvdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525791835; bh=7TD4lmr/IwuZhGnCXbngWcxeH8stvXwf+zhL+w2nQX
    4=; b=Xs4U2l1ehVp8pxQDR/C7+yVJ67fq/8T5brm86ohtZuqGfxQYFRxW5t95n1
    6sQexxDZi2iyk2a7YxjQ+Yhcyqgiv9p/YzR2PRAnSySbsdcuvgP0molCttyq7GoM
    YuWZ/qGw5slJ31qNjovVsvLrdI9ikZKH10MgL2wj2UwhC7AVjEY7hf0Pg7dDagyy
    vWxOj3JpNPsNBdIyoqa1lccVIIxA+gwGwbtkii5d4o4HDgGfmtqDRf9VjSBdFKVW
    ZfPnfTi5Nn8WUnRFynV4jI6ZyDRHHmS4BUDkeEc/IEncs0RIWVfyQy/ljcaI3WsW
    8MiT2ZTTbceTPRHnUsAHSyFgliWA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=M3khqJTj x-bits=0
    x-keytype="" x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=FWD80XaO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=M3khqJTj x-bits=0
      x-keytype="" x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=FWD80XaO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHZjlyUD+bp9z2597Yt4l+czPDh4p33lLVPgvBPzdDaIT0M1/YDEmMFys2MpsSa4Rv+PYGmv8CxUV5QUaTGR6KGH+iQZrCDi+cxq3B7SpDvdni9R8uI2
    P8knax8JwsQJMXF3zNCjqAUC48dT3p+sekjYxnyVxt9rewAn6v9v3FyNAJ2vxckZXLUD+9isBVs6lmU35XCwNCbs3O25hVByOln9AMCUTSd86IsJLcjfDwUu
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x3-3yhV3NOoA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=rgakPGm3yCeuZKKU_sQA:9
    a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeEHPDv (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 11:03:51 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:41847 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932683AbeEHPDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 May 2018 11:03:50 -0400
X-Google-Smtp-Source: AB8JxZrCaacB1NqasJOlJKg0aj1vG9rBXvVxOwx6hEJY4ww/J+HH/i/5ZJGnirAvV/4QTA+/7eywZZxq5mNS5igJezA=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <8f464b5f-a479-6bfe-3abf-b2ed6efe5eb6@infradead.org>
References: <20180507083807.28792-1-mszeredi@redhat.com> <20180507083807.28792-24-mszeredi@redhat.com>
 <8f464b5f-a479-6bfe-3abf-b2ed6efe5eb6@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 8 May 2018 17:03:49 +0200
Message-ID: <CAJfpegu-MDi21vBYnyqRBKG40ugPNDY9YUZmkmQ7A5pFp=ak0Q@mail.gmail.com>
Subject: Re: [PATCH v2 23/35] ovl: copy-up on MAP_SHARED
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 7, 2018 at 9:28 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 05/07/2018 01:37 AM, Miklos Szeredi wrote:
>> A corner case of a corner case is when
>>
>>  - file opened for O_RDONLY
>>  - which is then memory mapped SHARED
>>  - file opened for O_WRONLY
>>  - contents modified
>>  - contents read back though the shared mapping
>>
>> Unfortunately it looks very difficult to do anything about the established
>> shared map after the file is copied up.
>>
>> Instead, when a read-only file is mapped shared, copy up the file before
>> actually doing the map.  This may result in unnecessary copy-ups (but so
>> may copy-up on open(O_RDWR) for exampe).
>
>                               for example).
>
>>
>> We can revisit this later if it turns out to be a performance problem in
>> real life.
>>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> ---
>>  fs/overlayfs/Kconfig     | 21 +++++++++++++++++++++
>>  fs/overlayfs/file.c      | 22 ++++++++++++++++++++++
>>  fs/overlayfs/overlayfs.h |  7 +++++++
>>  fs/overlayfs/ovl_entry.h |  1 +
>>  fs/overlayfs/super.c     | 22 ++++++++++++++++++++++
>>  5 files changed, 73 insertions(+)
>>
>> diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
>> index 17032631c5cf..991c0a5a0e00 100644
>> --- a/fs/overlayfs/Kconfig
>> +++ b/fs/overlayfs/Kconfig
>> @@ -103,3 +103,24 @@ config OVERLAY_FS_XINO_AUTO
>>         For more information, see Documentation/filesystems/overlayfs.txt
>>
>>         If unsure, say N.
>> +
>> +config OVERLAY_FS_COPY_UP_SHARED
>> +       bool "Overlayfs: copy up when mapping a file shared"
>
>                                                 a shared file" ??

This is referring to MAP_SHARED flag of mmap().  So it's the mapping
that is shared, not the file.

>
>> +       default n
>> +       depends on OVERLAY_FS
>> +       help
>> +         If this option is enabled then on mapping a file with MAP_SHARED
>> +      overlayfs copies up the file in anticipation of it being modified (just
>> +      like we copy up the file on O_WRONLY and O_RDWR in anticipation of
>> +      modification).  This does not interfere with shared library loading, as
>> +      that uses MAP_PRIVATE.  But there might be use cases out there where
>> +      this impacts performance and disk usage.
>> +
>> +      This just selects the default, the feature can also be enabled or
>> +      disabled in the running kernel or individually on each overlay mount.
>> +
>> +      To get maximally standard compliant behavior, enable this option.
>> +
>> +      To get a maximally backward compatible kernel, disable this option.
>> +
>> +      If unsure, say N.
>
> For Kconfig (coding-style.rst):
> Lines under a ``config`` definition are indented with one tab, while help text
> is indented an additional two spaces.

Not sure what went wrong there.  Fixed now.

Thanks,
Miklos
