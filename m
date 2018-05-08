Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3215875-1525803176-2-13975209642686925126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525803176; b=ks93o/uskvj7Hov3uwB9aBH0GLjZ/jjQ5FWGo+PdnKNbPgPxJW
    jkMaX7qqg9VUWFfnu4pnM1bWV64QtE8oCMzXFj+CYSBZhWRC2ryjRCq5sQ7efo12
    qVe9R5anFqzrAfy1YCeouJLYnHPFsfppLcCumzb0An38YHhmKQP/JgRid86GSZoP
    zl5Hi4hTX1lX8s7vNFeYocS2UronCFW4URXBEMzO33BcndcuiftR50dREcDPTDdv
    0UTlhHSc5JowQf2Fyy1/BycMWMSZ7xqBuUK7a4uh+Ab5n9e3MRckTvd5VGdZOUfT
    rcZrYIaBjWTP8n06dgnrls0dLZhLs5wpIVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1525803176; bh=iT9+ExdEW
    ud7Mw0vf3Fr6BrUX16fYlapg6l0+BnYnAU=; b=VwoMX2TX7GTMNSk5nxSacE57J
    ibY3B8DZ4q1DYOXvp61+3D7iLeYK2xw5jLbHLRhuWNhr2pt+F16GQnuQ1vUEyFnj
    WGjBcNxm22YQfffmHAzK/D9DX5ozXA1rWIVFJj7TeHgPnayO3CVmNpzgWwv5MupU
    XRFdRfBHpgPF2KSOFVS8ttFcOA+ZDbbqjSUdFLgIAcwCNHSByoC9wNnERns/7Erb
    nGTG9hqiX2NaB5dR9CI3iACHTYbGq+E4FC8EobkMfgDp5jfNJIH9c7n0fNzgzkJI
    yhOhgPf2K6CnyyJUK/OCMm3ryfl2QB/JfMLyHs8cLeLa09EUcyAAS0Lj7Q1hQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=DDt8SD2i x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=exCEj6q+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=DDt8SD2i x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=exCEj6q+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIHxN3jkmcPxeUkVnDAt7KX1yP8/4R/z1YAW6GVb72A13BVNHb4V+DEs2fLRU2anZGMGDT+CU3sTsouS1lcDylw8QJCIxoiaCvXCcYspHtt2dMOgDhp/
    UrNDWAZ2VErCp+GJHzgPbb2u5971+RjV6Kum+WTN1Krg7bmJSeAGK54qh0ziES5+/MyXNxoX1daxChx4RIOsa61bZAro/gUHQMEeykgKjl2W4iyEHtZsrplU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=HKfmKaWljnsA:10 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8
    a=VwQbUJbxAAAA:8 a=71D7HTsCAAAA:8 a=ZF-Rt8gxhOySW7GZ6qIA:9 a=QEXdDO2ut3YA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22 a=MPOO32LiSuuV5f9AgKQu:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeEHSMf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 14:12:35 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37208 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933026AbeEHSMd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 14:12:33 -0400
X-Google-Smtp-Source: AB8JxZpn8YotiDjey9gcEcXDLm9f62D9CcjcYDJOZgLS5nvG8cK1CZtaZVEONIj266qKarht4uLaIg==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] compiler-gcc: disable -ftracer for __noclone functions
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <86f2fb42-b0eb-46d2-0aed-7efdb306bfe0@redhat.com>
Date: Tue, 8 May 2018 11:12:30 -0700
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, lkml@tlinx.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E5A36F3-F83E-4022-BE3A-88F1BADA3EEF@gmail.com>
References: <1459410252-15531-1-git-send-email-pbonzini@redhat.com>
 <6BAD64FE-CC59-40C3-9C42-90BB8EEE5453@gmail.com>
 <86f2fb42-b0eb-46d2-0aed-7efdb306bfe0@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 05/05/2018 19:22, Nadav Amit wrote:
>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>=20
>>> -ftracer can duplicate asm blocks causing compilation to fail in
>>> noclone functions.  For example, KVM declares a global variable
>>> in an asm like
>>>=20
>>>   asm("2: ... \n
>>>        .pushsection data \n
>>>        .global vmx_return \n
>>>        vmx_return: .long 2b");
>>>=20
>>> and -ftracer causes a double declaration.
>>>=20
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Michal Marek <mmarek@suse.cz>
>>> Cc: stable@vger.kernel.org
>>> Cc: kvm@vger.kernel.org
>>> Reported-by: Linda Walsh <lkml@tlinx.org>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>> include/linux/compiler-gcc.h | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/include/linux/compiler-gcc.h =
b/include/linux/compiler-gcc.h
>>> index 22ab246feed3..eeae401a2412 100644
>>> --- a/include/linux/compiler-gcc.h
>>> +++ b/include/linux/compiler-gcc.h
>>> @@ -199,7 +199,7 @@
>>> #define unreachable() __builtin_unreachable()
>>>=20
>>> /* Mark a function definition as prohibited from being cloned. */
>>> -#define __noclone	__attribute__((__noclone__))
>>> +#define __noclone	__attribute__((__noclone__, =
__optimize__("no-tracer")))
>>=20
>> [ Bringing the thread back from the dead for context ]
>>=20
>> Setting different optimization attributes to certain functions =
apparently
>> prevents gcc from inlining functions with different =
=E2=80=9Coptimizations=E2=80=9D. This
>> results in poor compilation - most notably of vmx_vcpu_run() - and =
causes
>> short functions such as to_vmx() not to be inlined.
>=20
> Hmm, I suppose we need to disable -fno-tracer globally...  Has this
> changed in recent versions of GCC?

I don=E2=80=99t think so. I played with optimization attributes of gcc =
some time ago
and saw the same behavior. Unfortunately, I don=E2=80=99t easily find =
the place in
gcc that implements this behavior.
