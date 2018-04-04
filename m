Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2804109-1522800171-2-11607057126824198398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522800171; b=It/D1Blj320V3wiZd5I0ZT60HFPDGprR8n1JZ4D5+aXA8iqwzz
    Co9z82HKalLgPEIaiPecTUi2/p4okK503w556JU8dhDlwoThuMAsl8xZdyksCdPn
    DqeupAngJHrEAZzUh0LJbhc/y/C3xb0TaDrLdH3LPKPAl64VBz39RVSe5FXc1Rto
    wqsfieebFd8hApZJp1Lm5G4xO7Iw/mD4IS35A+DcuNivC9GZYktxOReQfc3Q4m2b
    vqVrC0msVS/Sh/jQ6paD9mz+DjXAcREi1tyGWg4kXSG46CpF16kIvq24c8HL7IiV
    yaLfvgdFjoKpjjY+SZFTEkc/Wp/fc2f9lTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522800171; bh=3nCMl9USQPZyTzt5fnvLH37vu1pzudiXPZ41458k7G
    0=; b=sHEQQCASeQu/ylzXYEfTxDBh+Mm5XQfBxYxI/uJoGIhPGp8OAa1JtjjMp8
    JNvLus+mh9eYA8+F31hrNaqhO9m2ZV7bVz+yhzD8507n8ltPBVCgMQrAmUPqy6Gg
    d8xizl5X0u5MIM8qMBnMTMJwnwGS4NIaGQUyeiaaPc1lw4PjNUwBvtSY5pHqTXp3
    8wrIwbzrfnpU9s+pYf0Iv/L91RT9fOVyWZNZJKA1DwsVq/UkWAVy8XXl3ucol39v
    kd+kNHlrGnFiqNmWLNvUPfhAgyIFBv5c1csngIgXYDTXLBrEtQM4f1b7p2oXlu13
    FDNrZ+4bamvz9thzsKJhpyRp+vnQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SbJH5NPP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ld26bkXG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NIRzkx3f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SbJH5NPP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ld26bkXG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NIRzkx3f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFc9z/BGFs+0HdAnsQmyXhd5cDnvbR8Dbk2Fs6pDwE875jyJL4dAkF5yTb4a2GbMn4yId1KFNUoGgRY5z4gIRNCZl/z6Y6S5BcSTgJqoz1IQsp9ySXoU
    a7/WfMaPAxq0JUoiRELFTWIEixFAkGvaYSc1OauA11CxD7VZZnzOKx18eca/DZDsS5cczERpxsreeFX+o53QWk+qnxnmn1mdtJ7UzjBBkjF7qSQov48z2wrl
    FuGRVvuIDaa9sNvh9JGNdg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=BYZcy7MrEKLFxpYovX0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755886AbeDDACt (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:02:49 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:43176 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754252AbeDDACs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 20:02:48 -0400
X-Google-Smtp-Source: AIpwx4/rwp0OjpzikWaiKpe+7Zl5kFSLfuvWnJT+0MNPd2cZG0cNHGSnQWc5zGKkT5KDDgoiwsPI52HWh7ZKP20ehtQ=
MIME-Version: 1.0
In-Reply-To: <CACdnJutkO9dgz=HZpPRR9PZC=+cHh97dRUiGB+D3gruZr6U9Kg@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
 <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CA+55aFx9u-O81MwSq8zpb+MKaWYjYvtEcFu1NLP1_s63ED6_3Q@mail.gmail.com> <CACdnJutkO9dgz=HZpPRR9PZC=+cHh97dRUiGB+D3gruZr6U9Kg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 17:02:46 -0700
X-Google-Sender-Auth: eDqYmoq99RbdZDXbar6h841eSxc
Message-ID: <CA+55aFxZN_p_cU94z7QN8=HnPanRrpRHH7UUkOBaFDSjfrivnQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 4:47 PM, Matthew Garrett <mjg59@google.com> wrote:
>> Another way of looking at this: if lockdown is a good idea to enable
>> when you booted using secure boot, then why isn't it a good idea when
>> you *didn't* boot using secure boot?
>
> Because it's then trivial to circumvent and the restrictions aren't worth
> the benefit.

Bullshit.

If there those restrictions cause problems, they need to be fixed regardless.

In fact, from a debuggability standpoint, you want to find the
problems early, on those kernel development machines that had secure
boot explicitly turned off because it's such a pain.

And if they can't be fixed, then the user is going to disable lockdown
regardless of how he booted the machine.

In no situation is "depending on how you booted" a good choice.

Either you can enable it or you can't. If you can, good. And if you
can't, it has nothing to do with secure boot.

            Linus
