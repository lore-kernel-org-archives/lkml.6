Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1611488-1527777920-2-15318177402066304596
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527777920; b=TcAW83XNKQ4hU0mFalGEiD8MoeIV/kAR13Q33AjakK6XlqM/og
    pWdvL6dn3EcKSJjh6ikvOSFmfJYTWds0FWk6rQ3Fpx/6a7p01isXH63bsiQ/yNfr
    i4zW0FhVWJEtopA3pEfGUrEnN07EJrwCgk6DVro0dS8Zs5dYDvhNXn2cFVdWmD23
    KDFdFTBO3chLb3srzFOdMYSEKMcMw3iuuNy/3Um7aOI8vYroOGDCS5koHERz2aIj
    Qq3KomX5uJoViC92pBZHHnrz+3vKVMuTu0P4FVYnChlBYNPGKSyc+lE6fDXuEkZH
    ynUBETx4eJx3Uodgaskm45Dsz86O7HpjXugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527777920; bh=cT/PJHLUfmPD1x2XPuvgBlXO2G32l7P5aIvnq5dT5S
    M=; b=KIA/GA0d4JIIpuqIBaVkfU1QFkyEffeiddJyM8e+WgqjnIDo3qHYnEE/C1
    TMRSaZcpeUZRnzrNdJtkAfmUOcrFanck9oEHlc8rMHNWU5gAxDKTRygiG1/5ni7R
    mLAuLg3j+zQd1EG60+fcOJ+I7+nvMbRKpb5RBxNViBVF4r1lzZyj/cuH0NtFlSgG
    7Ph9BOWFJrbu/A4jmzxuVFPwbrRXtry4hR6XoUKUeXfQ2TUsep5FuQ5nQshJY3vw
    gT1GYtxaeVsZqFJ0fIvvp6ebDLk3TC7r34fEsIVxJnItYOZVAEb8yKO1qWJnUU4T
    IfY6yHUsO6W3MtMtbwreVfoR2TjQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=LdD1LYMe
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=qKhtDn/V;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=LdD1LYMe
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=qKhtDn/V;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG1YJh0G/bciJcnxyIofPsCxRV5TG3benA7U5lUIO1IHGR+h8DBVKpgY9Kh+2FKnyu580v+CBz2PzFIBdsoW36vN4mvBRL/t3z9d0aOSOsIEb/naJac1
    yArg9nLuF3bdTZt+KetN8FvgX7fw1bs/vbW4Geo1P42yPnEnZsfJySLlpe+2fswS06eJFIXZe7kb1wg5mKjXe0SlJXwioXQ9VyjnQOWz+x0wd0GWCtC5gBni
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x3-3yhV3NOoA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=PtDNVHqPAAAA:8 a=Bh1iemdzq6F8wOZY9BAA:9 a=QEXdDO2ut3YA:10
    a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbeEaOpS (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 10:45:18 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37352 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755042AbeEaOpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 May 2018 10:45:17 -0400
X-Google-Smtp-Source: ADUXVKKt2JxGI0diuHUTGzCJJnjnYN7BcPuDmuLCSZoY89lT1ed5YVArQJJp3F5icp3VxjcwAsi+UMcEjKHHzNyq6Ys=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <87tvqqo8w1.fsf_-_@xmission.com>
References: <87r2mre5b3.fsf@xmission.com> <87wovubbdf.fsf@xmission.com>
 <877enmskec.fsf@xmission.com> <CAOssrKdS9gOsZrNfqJbk_j0Z8-hrqrYWW+=_Z5mUEX1KE-Kw6Q@mail.gmail.com>
 <87zi0io90k.fsf@xmission.com> <87tvqqo8w1.fsf_-_@xmission.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 31 May 2018 16:45:15 +0200
Message-ID: <CAJfpegtNonpOkxcmk2B+6LZSKxLq18UVsieOm0pZip2eQ6Kbvg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Allow fully unprivileged mounts
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 4:04 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Now that the fuse and the vfs work is complete.  Allow the fuse filesystem
> to be mounted by the root user in a user namespace.

Thanks, pushed to for-next branch of the fuse tree toghether with the xattr fix.

Miklos
