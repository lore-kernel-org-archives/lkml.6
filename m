Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2654832-1522796983-2-14976778836081617523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522796983; b=YL4V/XwGbs0T+ImrWHxlmdFYaxCwYq1/pizqGhCBu3tm1OHhkq
    9QqitNpKEdTizdkFW2/+8HPYUVHtPjTxtw2u2uZCmcygquyjxxm1ddGzHzQ68lVL
    QIit+FjhXRE70VxiMtmPxRRkzUJ8iVZlqAoAN15vTxRGO69ECSylTB65LVeDjzPA
    5hIWzKevPyrX3rVZmDFra2QtInyqoouLc3KfLFRnOcBe/M+WN6viFadyMcyyWgza
    5AiR3C5yTg831Eoltxb/iUk8r4Cq/RiJApAvDVh69yHQnp4r+I7ZSs4LjZb8sM0w
    5jzQZd1X6SYBkYuufRnHYzcFtz73t+hXyI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522796983; bh=HzdpQRlHdHuPXyd36de9GBL8Izo0Mht0TsIMprUY/+
    w=; b=ta8FXig7McF1DtWm6fF1YZsFUG0z1iEDoCnUOXM3e3Rbn9zZFUiq7H5FOx
    haNyyE9J8iDZCayYpEsTGW8Uf3lX/qnge+V3DoPLG9fEc2FCfTYi0DHUJgP7PtC8
    9UISpdjtQKKHIzFfj5Mis/D7aYZMvskuV+PZBPo+pWggBpVcGSTAlav1E7axBLB4
    AhuA8Y2mlD8ROD1l7ZN+0Es244Fhe9KpK3UTTFQ8DrNS+QJodDy/g9IRYdO6O1AT
    jo4qVQG7K/yqDX9iT4qnUo/cgBXyVp147nxLQnM0t5hXtRYM/cLAVHJf8/NPCEN4
    N7t1NTbeeNONYmjHCUbX4PlsFvvQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=jM5bNmCb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kvTY8Ftd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=jM5bNmCb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kvTY8Ftd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIiE8NWCUMB9sxzQYAJ49THiyelZjx7mZ3xjFOV5jqewwgquKN1pxvUvKLF5fdB+Yrw/zRGuTT1CFSwJiRivJfIOn/H30cxPgl/LrOi7ad6rrhnZ1I2B
    SxuEXUtn4YphYGvlzQZxxqdx2Nq3DgTW5qfse7q8IN25QAQNyI6ig9AGSHZB4EPpnh9RRuxMUlQVNu8sty1ByXbMZc5k3XQRdDlmo439S14Fi91pv2XhDb6r
    Aor0CotXgV5XBTaWxfvEXw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=GnypZRjMXmR95pzCGcsA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755922AbeDCXJl (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:09:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32977 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755904AbeDCXJj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 19:09:39 -0400
X-Google-Smtp-Source: AIpwx48LvbbGWb5xzSL0MjVcPKlr3VEO/GzXQ7lEP2d/iDntpnGEwuPVjiUqyw4w9Ldk0THY9c5MGuf2bMRE3IK8nxw=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com> <CALCETrXC-mL07YvGrvqaUQrbv+3fv2G9rGuQoMohaxG=QUQn2g@mail.gmail.com>
In-Reply-To: <CALCETrXC-mL07YvGrvqaUQrbv+3fv2G9rGuQoMohaxG=QUQn2g@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 23:09:27 +0000
Message-ID: <CACdnJuvfsZN_8yATpR+Zas69Yz0trZONACqV07A7-Ua0O5j3Kg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: luto@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 3:53 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Tue, Apr 3, 2018 at 3:51 PM, Matthew Garrett <mjg59@google.com> wrote:
> > Lockdown is clearly useful without Secure Boot (and I intend to deploy
it
> > that way for various things), but I still don't understand why you feel
> > that the common case of booting a kernel from a boot chain that's widely
> > trusted derives no benefit from it being harder to subvert that kernel
into
> > subverting that boot chain. For cases where you're self-signing and feel
> > happy about that, you just set CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT to n
and
> > everyone's happy?

> I would like to see distros that want Secure Boot to annoy users by
> enabling Lockdown be honest about the fact that it's an annoyance and
> adds very little value by having to carry a patch that was rejected by
> the upstream kernel.

I disagree with the assertion that it adds very little value, but if you
want to reject a technically useful patch for political reasons then I'm
well beyond the point of caring.
