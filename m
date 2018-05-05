Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2074983-1525540937-2-9582644732450196392
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525540937; b=dJCN7J/0Px5JgeOChxjt3LYS3aUZGvxdKCIBRnPWQdotzwFRbb
    C0wwdNXv8ZYQLdQw9Bve5714B1wYp28tgHHcNt2YFLX2zYQWwxAap0cd+0hvnfkz
    pBiA74T0Av9MpPhugPbJbMrQKmqlWsvKEP4Oti38BAlqR6TQ1HhjsqtU0Z91r55F
    kWF9FEA2GGj1mY10VNxpKDPzrYEKAewERZyX0bQcxraM8+sdj1VJpi88FbgHLRmd
    6QGPqCp0aNTX9K/nxTAsGpriK7YMm5oRiNH5tupluVzOjjCJOJXegKqRUXk7cFVO
    CGpmsWdp+Oc22BscQ+l55x6yKwKPUIIYMJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1525540937; bh=jQqBul2Fz
    GxJHRNO0f7tkuvze8zW6SuL+m7nnvEN1FM=; b=HWBmWYSVx9lMguDa6+EW6YWDT
    0NAX5r44CnQe4uEbMvcVvqVfFNwjgpAotQUa2LAEmiwjBKf7LyfMVO9GH+BURC0Z
    Pt65yvXUBEvA42P69UUfUIAGv8+JUF4jRZB76j1Zjm4wLrmbhZE3sCn2fFd/Ji7J
    SL+Py90J9o2JVjOR/xjqyCkGb0IN9EUSsyh3Pi5mEYqT4eCouqGftk0W5bGLMdF+
    51T5dnfgtihTBFhiJRP6HMX4hIvIl9qbIzQypGq6Ztk+0DJVEWZuPHm7sr49cmin
    gExvgzCA3hVJ8ODug3M3dLRF3pOYKMYMYq6+ckrrcwE9cEVdXf0xoqBZKEjGw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=l0NlbfMz x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=NWmHttTI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=l0NlbfMz x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=NWmHttTI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLlhlUebq+FfLKd0tfE/tp271jwfqsw7kSxuHa9YW8sRGLwnEdn1bs8p5H1KVqVmME9Yb6xXVx7HOZRf2zXkKqW2IjqH5ZHscfiwouS8sM4go5wgIgjd
    /5xxXoMAYWvLMMtYCRf0fbOwdSfpeO63n5nYVj/qUQTdaGX6HhdYhrOHM8rfoUZDE4Pd+nk7U0Zz7jk4UGraGQQnXeVIPUOs8BSjQkdqnUQpRuNEaLulsSAc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=HKfmKaWljnsA:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=71D7HTsCAAAA:8
    a=W2jhgYHoREsb7tsNe10A:9 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22 a=MPOO32LiSuuV5f9AgKQu:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbeEERWO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 5 May 2018 13:22:14 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43982 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeEERWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 5 May 2018 13:22:12 -0400
X-Google-Smtp-Source: AB8JxZp6SETCfQg5ILcjgO+qT4EqS8ReCwGBiz7+uJmQlaXAqPtwR9XtwKFzxK9/egHRmFsOmPQdxg==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] compiler-gcc: disable -ftracer for __noclone functions
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <1459410252-15531-1-git-send-email-pbonzini@redhat.com>
Date: Sat, 5 May 2018 10:22:10 -0700
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, lkml@tlinx.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BAD64FE-CC59-40C3-9C42-90BB8EEE5453@gmail.com>
References: <1459410252-15531-1-git-send-email-pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Paolo Bonzini <pbonzini@redhat.com> wrote:

> -ftracer can duplicate asm blocks causing compilation to fail in
> noclone functions.  For example, KVM declares a global variable
> in an asm like
>=20
>    asm("2: ... \n
>         .pushsection data \n
>         .global vmx_return \n
>         vmx_return: .long 2b");
>=20
> and -ftracer causes a double declaration.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: stable@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Reported-by: Linda Walsh <lkml@tlinx.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> include/linux/compiler-gcc.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/compiler-gcc.h =
b/include/linux/compiler-gcc.h
> index 22ab246feed3..eeae401a2412 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -199,7 +199,7 @@
> #define unreachable() __builtin_unreachable()
>=20
> /* Mark a function definition as prohibited from being cloned. */
> -#define __noclone	__attribute__((__noclone__))
> +#define __noclone	__attribute__((__noclone__, =
__optimize__("no-tracer")))

[ Bringing the thread back from the dead for context ]

Setting different optimization attributes to certain functions =
apparently
prevents gcc from inlining functions with different =E2=80=9Coptimizations=
=E2=80=9D. This
results in poor compilation - most notably of vmx_vcpu_run() - and =
causes
short functions such as to_vmx() not to be inlined.

Regards,
Nadav=
