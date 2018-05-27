Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2071034-1527384819-2-13849712041431937082
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527384819; b=fTsgNslLZSL2rCVCCR/UGv4MAnHsN2OElUHFwOQZ2YcmJFvdvZ
    S/kdZLDfayBL7ttjEEOSWOBkO9fG7I1P8/fXMjEG5ho6pvXc15w4q0w6LpEiUClJ
    m0oUp7Q5UNLV/y9y24YmJ1Yu/m8EQl7fjBO/Bd7Grlhp6mFtRBWMtViU9N2M0/bs
    3K1bVmQzaLrWD5iJvLXuGvb48JCYti3zUL7ZWtZZFcYWC1XhzIQXlCqAV0chqFv7
    AcCOoIHvUF9WgLh2BkjYDp6B1AqG6ohpROmsybXsK5uN/bwY/rTWR4S+vmxVGIHK
    doeHXa+ozmf4VaAX3mllGJin6QfDzRljbE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527384819; bh=GiENAmVajyf48ivBRExwIEwQUAaR3Qw3oQ10q873Xg
    0=; b=REpE3N40SBa5w1FnJzj/lBdq2IpK75qXB8He9f9+Kg7glRZwRlGfMdfEsi
    eskNGAGs6yTIjwQyyhooGTUkJFWHRzFvCkHxR73xiLLwZxRa/Kko/Pw7fLJ70O31
    zVyykLCq80lUfrU3bbkvxzcwo1fxDp1sJyBG2b50UbhYGQOW3FH1z6gY5Goqp8+U
    y2hu8o7oIG2QH2l9CywgMXwfZ/myZp7HbHrsQtD4knAhQZNieDWUuRAuFcp9hS9L
    CcJJzoVkh5GvsSaBCUwCPhEUmYvurCTR03YsXLnBBXYjj+ag7ojGeL0S4HgBUwrM
    NuEAE/DKe3S6ZWoMArjeBazausbA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linux-foundation.org header.i=@linux-foundation.org
    header.b=MrJeSgwd x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Z+dgaKrB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linux-foundation.org header.i=@linux-foundation.org
      header.b=MrJeSgwd x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Z+dgaKrB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOLIpR/u+Tr98PCL4fbPCSLuemdClzn1ica4rJog6PjfWTigAjdQXaIrUtqkN7c0SDy6Cf+m2NHHfW1qJhOqjjYQDK0lKGizF5Sz2kyYJJPgr23JP9RJ
    opy+zj3IfcBN+YiZC9iLRetUmYTjKye22HlFA2xXgvaNH0awYFL3dswfgQhNmyo4MvQQlEgLbx8dVlIIGsQ1DkVmW4bPfIuDCSL6xSex/ml6l+vLJN9Kx/10
    mmQDKtn9ZPHALyAEO2MdsA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=g4PsmzZmft7oP8uSRjsA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032474AbeE0Bdg (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 21:33:36 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:47053 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755097AbeE0Bdf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 May 2018 21:33:35 -0400
X-Google-Smtp-Source: ADUXVKLgrO1t/inyPrd1RwJZ+OzhiGZYV81tg84oVH1QEwFZMZxQE1zFjq8dMSM+JZrgwtzhfSUXWlsA9vveqpJh/Q0=
MIME-Version: 1.0
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com> <CAGXu5j+PHzDwnJxJwMJ=WuhacDn_vJWe9xZx+Kbsh28vxOGRiA@mail.gmail.com>
In-Reply-To: <CAGXu5j+PHzDwnJxJwMJ=WuhacDn_vJWe9xZx+Kbsh28vxOGRiA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 May 2018 18:33:23 -0700
Message-ID: <CA+55aFx6DBp+d33_fytOGPWw11xg_L0MdGp1M2e5Obc0N9kMRQ@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
To: Kees Cook <keescook@chromium.org>
Cc: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 26, 2018 at 5:32 PM Kees Cook <keescook@chromium.org> wrote:

> I went through some old threads from 2012 when e268337dfe26 was
> introduced, and later when things got looked at during DirtyCOW. There
> was discussion about removing FOLL_FORCE (in order to block writes on
> a read-only memory region).

Side note, we did that for /dev/mem, and things broke.

Thus commit f511c0b17b08 "Yes, people use FOLL_FORCE ;)"

Side note, that very sam ecommit f511c0b17b08 is also the explanation for
why the patch under discussion now seems broken.

People really do use "write to /proc/self/mem" as a way to keep the
mappings read-only, but have a way to change them when required.

              Linus
