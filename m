Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3370208-1522951437-2-17649164093761133232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522951437; b=S+bDnJnlnSTvYwRKAv1RzRRGjTZKAY6eLq8hZfOjh4YyNVBcb4
    bCbiE6y+av7KHdQb74cilj7xw7Ge0K1TedY4Jo81tGH0BhDG2JkbGWlrtGSouU5J
    hClgnay0Ts6BpHDV1WFwDfbYVl87skoKL4piVcWvauPOLBjZJaJZxrtP1J1NxapY
    hH59JLFyLck1Z7XhTCuN9rOgexcugpHM5zkrsdZweAIxMAH2jO1p1QK7LVWuiw4s
    H3vcdusBefSaoTyA6OzgYBR31cJ3FyP+Wr35SPVl2csgMMJ3n0YakJdoO4gvXgq+
    j9NBikAgcO7K0sxfCnlvWsSd6vKwjbkSQR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522951437; bh=MS0Bj0zDA2VtcA/RM2NM9NRWmkM9n5Cl5CnXQONi3C
    I=; b=bHI0odmIC3Stt5MGmY1SdEIStLl/86KAbHSYbW4mKYrdQsg91OVP6HbuPU
    BaH1C33fB3b31wnlKK2f6JA4tOvivBX17s20aynwQuqrq6AXo06Q5xcJVwmBDPTD
    2Qeq2RCc3rDk+0kt5FyYF/xd2A7oNMPdJccpBWFzO/Yq3XhyF+qRp7QHJ1Nksgd2
    lHfDgyACVMkJnKjyDi9kbcQGEhLAvVP5mRh9Ss5lu7tWzty+UBnofXMdK7uNyZSz
    h5PSKGxOreRjSaErIP2o5AJTObEm2B4lq8k3lJ3V2McTzx9grNRjwinAw8eC7Fhs
    tJZ5FcHqJSKJcHttonLja7narwrg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=mJw3+7vT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ucJXgoDF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=mJw3+7vT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ucJXgoDF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO6cAyVQqP6I2BObdhHndRh5YI6fLBd1wg2J572aq2O3+OfyLD3Sv8bMo4z1ypfGtNuHM8MU3MiGz7rbEc0fZRVI0gsL4AJg8wamXq83s0hxCoRzNTp1
    vCSKqv66Z50NeDVp+eAj4fwZEIs2m3XQLXwRu2uv6lNFY0tppEAns15mGirLMjerW9bA1JhIYfImqA50EPG1CUyi9oY5cYsIs4g0fH6zE6BsImapTn1QTa59
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=z1H5ADGQAAAA:8 a=VwQbUJbxAAAA:8 a=xEF2CVU4gBzIhv91_zAA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=cNhwqobjEIRUxE0uuXBi:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeDESDx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 14:03:53 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35218 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeDESDu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Apr 2018 14:03:50 -0400
X-Google-Smtp-Source: AIpwx49TW290zBT9v4+XPtLk4M9HKu+eoLF3vgZliA/kdcqlROwjEtu41swJuwyYs3xlWGn+iyOeGa+HKoC9v8f6cxc=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
 <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CA+55aFx9u-O81MwSq8zpb+MKaWYjYvtEcFu1NLP1_s63ED6_3Q@mail.gmail.com>
 <CACdnJutkO9dgz=HZpPRR9PZC=+cHh97dRUiGB+D3gruZr6U9Kg@mail.gmail.com>
 <CA+55aFxZN_p_cU94z7QN8=HnPanRrpRHH7UUkOBaFDSjfrivnQ@mail.gmail.com>
 <CACdnJutOAPTmPm6dmHiw4+8rj=M7B1SiCkPaRZLmi9-CCuRyNg@mail.gmail.com> <20180405185949.309216bb@alans-desktop>
In-Reply-To: <20180405185949.309216bb@alans-desktop>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 05 Apr 2018 18:03:37 +0000
Message-ID: <CACdnJuuXexHPCkK5GW-XH2bjjXiRRg+9TFWfzeZt63-q4=Je0w@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 10:59 AM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> VT-D

Once Intel provide that on all hardware and actually make it work reliably
with their graphics chipsets it's certainly a solution for the PCI DMA
problem, but right now it's still effectively undeployable for a lot of
real world cases.
