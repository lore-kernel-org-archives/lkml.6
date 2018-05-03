Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3227126-1525387880-2-17702607632596768922
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525387880; b=MGIXHvC7asV/SaM/I6QxV0oo69+Ug3klcy3atC9hKaY0L+j5lT
    0tLhDScI4q4FHEut77j7Cem/75BFuBon78libodQElOUcGqqiqijHzm0AMoOzpZy
    8i24NWN9YeaRx6KMjbZ9PI1EKK8kHGxHTHKnVXCWzetBkM7qZoUSQKetJcq8fptW
    2YaDv/Pf95eeuIKoDH3ziyIUUahE50hfIOCECalLdoJJ+yS2mlIprZI59Xez+kCz
    zWLO706cVRnMgcYol+luSrtFTAJysBCKUDsCOq3hlwAyLEmbkc24lj7If5/WZkhW
    YOiuZ15zLS1k3VkRfSNJsFvn+LUUtfuaXt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525387880; bh=hocXj5sk5f+Upy9+jgJTLX0MVtuKAu9V8vvOPT6hXA
    E=; b=HavIN1mOf8UQzTYjX/Xh3GrQi22ZN+3U85ozD9wSelhuyY1pXu693jsw7K
    v7+oX2lflhD/X1NKx2nVs1mwE39SirCNadUJNj7IZYes4m3tG36YEzFxJXMjdf03
    bLCwOtajKmQA6rIPk0HIggbYoQjSqZ/7P+kzM2iTVWJRQoe1K6guMEl88L/KVKOw
    H0zO+cwn0BEFo8RtjV0iuI4Hd6z4STB7J0eFeEhgw7VYAcxUg9nCwliGtDUk15yl
    YiuitTWc7Gee3sF6opdOAhL3dBQY9atLIJ4MLW+6OEBj4mnFSjYANYSsAiHbbWQx
    rwHLwU+W0j6ywyGeBzxg0XTiURuA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=SEfTLlBZ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=FH1QbQej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=SEfTLlBZ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=FH1QbQej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKKm/5BXX/WS9KtGQ+IWR1TBAgfWx8O5GkRBvABK+avRn24JZE3eSSst8RjhLnGOfKEscSy8OX/E+6JH8Wr/2SgDvJiaS7TRk8rJc7p3f6oAcERfpDDO
    6T9vkfDT06ydEl7Ph+8Ooq/qqufWS3HkUpMfnnOcV1UGWt8NkK+ZYhL6wm826u04c0sWsB5MYDvdrlXHvIbrPS8ZW9VgICa8r7YzBZ82xwwVhHwed0C7ayAu
    HNi1+eTdc2/0vq60L0VmZA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=PtDNVHqPAAAA:8 a=1XWaLZrsAAAA:8 a=C01ViRMlAAAA:8 a=VwQbUJbxAAAA:8
    a=OpAL16lz4yODGrB0630A:9 a=AacGOReDvDGsUO4l:21 a=p17nKbmYlPQBk5qK:21
    a=QEXdDO2ut3YA:10 a=3M2YO-KalRYA:10 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=Iuy1Xl9CZTQdwcv9aEVZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeECWvR (ORCPT <rfc822;linux@kroah.com>);
        Thu, 3 May 2018 18:51:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33939 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeECWvQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 18:51:16 -0400
X-Google-Smtp-Source: AB8JxZp5HBk13fohqyyMR+5z1kH4VBOGH2qodyK2LI3SHcRHqskDar1PeVo21BbchE8ALG9lZMx9mCLrRrFcjSRPO8o=
MIME-Version: 1.0
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87r2mso5up.fsf@xmission.com> <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
 <876044l7tr.fsf@xmission.com>
In-Reply-To: <876044l7tr.fsf@xmission.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 03 May 2018 22:51:05 +0000
Message-ID: <CACdnJut4R-BQCYcT5_OuFezf8046-HmvvdEP4g7=ADgAW+qdeA@mail.gmail.com>
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
To: ebiederm@xmission.com
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 2:59 PM Eric W. Biederman <ebiederm@xmission.com>
wrote:

> Matthew Garrett <mjg59@google.com> writes:
> > kexec_load gives root arbitrary power to modify the running kernel
image,
> > including the ability to disable enforcement of module signatures.

> No.  It does absolutely nothing to the running kernel image.
> Combined with reboot(..., LINUX_REBOOT_CMD_KEXE, ...) it does allow
> booting something different.  It is argubably a little more efficient
> than writing to a file to direct the bootloader to boot something
> different and then calling reboot.  But it is not fundamentally
> different.

It absolutely does - https://mjg59.dreamwidth.org/28746.html gives an
example. The payload just needs to return.

> > Given
> > that it weakens other security mechanisms that are designed to prevent
root
> > from disabling them, it makes sense to allow the imposition of an
> > equivalent restriction.

> Say what.  You are saying a lot of words without any specifics.  Not a
> specific threat mode.  Not which security mecahnisms you are worried
> about weakening.  Not what classes of problems you are trying to defend
> against.

I have a kernel configured with module.sig_enforce enabled - root is unable
to load kernel modules that are unsigned, and since sig_enforce is
bool_enable_only, root is unable to flip that back. Any number of security
models may be implemented with that assumption. However, root still has
access to kexec_load(), and can therefore kexec into a dummy payload that
flips that byte back to 0 and permits loading unsigned module code.

There may well be other mechanisms that permit root to gain arbitrary
ability to modify kernel code. My argument is that we should treat those as
bugs, not use their existence as a justification for leaving open known
cases.
