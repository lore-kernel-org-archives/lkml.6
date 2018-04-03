Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-237307-1522720042-2-4263050093928818854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522720042; b=iWoOOMGyZMluKbAmdYnlh2sKthd+2E3ic4d7auGSsLO11uAHC+
    /PgcSW6YSVvIrG6bEGV7dO12QsgYaPn9WMTP6yTj2rhVVRrz5f8FFQChhePbx1WQ
    vgzroNDyimQm4f6ACyLYL4trDKFz9Ws9wruuMmAgBACLi2lTDRvARMVzXkJFOytB
    +r7jGzzTbiecx0MfcjdECVshC92J9hMIikP13v5aATo6lrQ5SCMz/pPT2H0WuJ0D
    7OuNT0vNhM+LwKCjeEuMSJHoZonuBNwDg+ZSkIZ119WZgExfm1xrCFb1QLNvhM1y
    aNIpFHqXvfxOqDXCVQpAv1fwUHotMg3cH/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1522720042; bh=lfGVLQaWX
    cn7fED9RMk/NHD9ymumvniNENUrq4Yuv3k=; b=vLQhcgcxKcFZa/zwt+2Kpiac3
    y1m1hWnCeFA6HdKDpINVmRcQ9OmN4AqKKb99tuh4cJBD2QWV8PKysMhc7yKQhbaW
    cw38wXoyDeG2auFHGWgVA2Mn3rcRFGmTZJNd2XJpwAZ3ZMzAA64ij+n+yoCNbR2M
    r17AZbihZLKHyzCXcbqlOxEgr3eqU2O1T5W5cebislcLgnDgz+NYHpwYBhX8AD6a
    AcHe6yHjiB2hKDRsO1xbH4r1dp+PonHqnr1gxhWPJ5iBZWHuUEdtZlEjcBrsB+D5
    dFgyIcFfnkDMIRExvmtnklQJquIFZLLJ4SYO2M+XuhkCAoNligrQ/FvotGAXg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=ROe2A6fl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DrSF4EbM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=ROe2A6fl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DrSF4EbM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIX2Xke0DN1fX9+KYX6b+RYTP3DRDflqRwHktQ0M1/hohEjNQfXV5H5GAAWsMPnmS2YU8C+w0lHW/gtx/jnSusLNfXaIs7AQ/QkZdrBrwaNogBV3rpf6
    mFdILkrpYf9hu88tW51qwQHTTR/P0owCxVEE6+m2KFB1IYf2VF0YWGaiWTsh/zQQDtL3o2dONFu3xRRIxIQlpdvJB9aayEfRRLLUktOiITjbTlNJUsAl0EvK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8
    a=F3Iv0LtgPt91XtbWnV8A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754777AbeDCBrK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 21:47:10 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39172 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754778AbeDCBrH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Apr 2018 21:47:07 -0400
X-Google-Smtp-Source: AIpwx4/Dl2EKF2/ZydFSqseXUj5hBK/Z3lRcCL1az5hzrr2Ei8mnLtdD7gpSD8sdkptJy3ihKpiCmQ==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15D100)
In-Reply-To: <CAGXu5j+UWQWDacMvvRCke3xUOb7uTkxn=WaHzG4kJTKWh-6tAA@mail.gmail.com>
Date: Mon, 2 Apr 2018 18:47:05 -0700
Cc: Andy Lutomirski <luto@kernel.org>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70C7A8C3-3DCC-4448-9FBD-534ADDE2D6E6@amacapital.net>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org> <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <CAGXu5j+UWQWDacMvvRCke3xUOb7uTkxn=WaHzG4kJTKWh-6tAA@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Apr 2, 2018, at 5:59 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
>> On Mon, Apr 2, 2018 at 5:37 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>> On 03/30/2018 05:46 PM, James Morris wrote:
>>>=20
>>>> On Sat, 31 Mar 2018, David Howells wrote:
>>>>=20
>>>> Date: Thu, 26 Oct 2017 17:37:38 +0100
>>>>=20
>>>> Hi James,
>>>>=20
>>>> Can you pull this patchset into security/next please?  It has been in
>>>> linux-next since the beginning of March.
>>>>=20
>>>> It adds kernel lockdown support for EFI secure boot.
>>>=20
>>>=20
>>> Applied to
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git=

>>> next-lockdown and next-testing
>>>=20
>>> Are there any known coverage gaps now?
>>>=20
>>>=20
>>>=20
>>=20
>> This is an attempt at a review.  I'm replying here because I can't find t=
he
>> actual relevant patch emails.
>>=20
>> Cover letter:
>>=20
>>> Here's a set of patches to institute a "locked-down mode" in the
>>> kernel and to trigger that mode if the kernel is booted in secure-boot >=

>>> mode or through the command line.
>>=20
>> I think this is seriously problematic in that it's not well defined.  It
>> sounds like "locked-down mode" means "make me feel good about something".=

>=20
> Naming of this feature has been multi-year bikeshedding, so if we
> could just leave the name, that'd be nice.

Fair enough. How about enum kernel_lockdown_level with three modes?

>=20
>=20

>> "Restrict /dev/{mem,kmem,port} when the kernel is locked down": this shou=
ld
>> probably split into one restriction for read and one for write.
>=20
> I think splitting read and write is only useful if there is a use-case
> for only blocking one of them. I struggle to imagine allowing write
> and blocking read, so really it's the case of wanting to allow read
> and disallow write. Is there actually a use-case for this? In all the
> "locked down" cases I've seen, both are desired.
>=20

Let=E2=80=99s suppose for the sake of argument that UEFI really has a good r=
eason to block writes. Blocking reads (kprobes, perf, etc) sounds extremely a=
nnoying, especially if running a stock distro, and I=E2=80=99d much rather n=
ot do it unless there=E2=80=99s a specific use case that needs it.=20=
