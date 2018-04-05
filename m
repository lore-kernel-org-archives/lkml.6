Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3387485-1522951228-2-17249865043088130160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522951228; b=tD0XFDh814Cw+QNpuNUIjNLDtbrlEHCWNBdS/DVEb/IwigcgAB
    JI3/MgefYdSsxdMDTxHT7e7m6K1nzGYyqiSb441+Fn+Kf+qhDTq+6cvyMvg+EohP
    Xvn0nWslee3d4o0CK1RPV1mZP/VP9tkbuF9QIpH9K6IJ0E6Ml/ZoTaXnHkhZBnll
    rxGcOkt7apPOepiKYcIsaMOjCBa0su4T8z7eFrgX+zHj0tZDjkkDv/eF2g9kRezg
    vITCcpxv+0ktfoLA2HXAxSE5hQ5+SGqFKe+y7WaxWTJVRJ8OSK8XxS91cN8cxyQW
    SjEf33472T4Qu5QPyG/CMp7wZJmSvQmBvf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522951228;
    bh=IAzDVoLtSimf2nVlbozmhIoGLkVjVBSvW+Sw87yBIng=; b=iIAe3CT9C0TW
    E4fMg24pmasaGSFhD8Yui14khqmeZSz41CcT4B1Aq9ALfbJS9Sf1gPHrsJ7HNp4p
    dAuvMu55/icZtcWLhNJXLcjD7NvuZUZ1ffO/kwqDOPXTGnTQjh1qj13SZBs/JfXO
    9J4GsYNHZ2y/ADp5cLpVTmj872cMyF9LAkgqjEr4X3zgDTIIXVscWu5ZrB4/5lu3
    LA6ptKh5E8nknGT7LG7FGCszDbDHT4vO3Q6IfUzQtP3qOOJMR2n8Jle0n+5pmFZ/
    GgX5gK8JXQXr0pq71Lc2fNRgWOsEBBhpeiVVNIJCjY1WQU3WojS5huArduim1tO1
    82DSzzuI/g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC2d+JlnavNU7YPoMALFcAbXApf01TvPfPNuFP4oDTAXV1lc2D+yFLY1pxfTX2F1fCoN9FPEdKk+rUjn6s8hza+MT1i3G5nrdHRTq9HvfsAqORLoZVEE
    7/SumLY7lw2lLM55YMFyFhqM68jzQ12IrgiRRuqkIQL++0rMLyetT9/M1eVetjkQAEE4dG5h1UzYIoR+x0nVWLP7Syi1NnaoLKRn8XoW8OmmJYW35isTnMge
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=dMM3dnUDmWgZgfLgEMAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeDESAP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 14:00:15 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:51566 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751318AbeDESAO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 5 Apr 2018 14:00:14 -0400
Date: Thu, 5 Apr 2018 18:59:49 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg59@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180405185949.309216bb@alans-desktop>
In-Reply-To: <CACdnJutOAPTmPm6dmHiw4+8rj=M7B1SiCkPaRZLmi9-CCuRyNg@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk>
        <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
        <13189.1522784944@warthog.procyon.org.uk>
        <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
        <9349.1522794769@warthog.procyon.org.uk>
        <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
        <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
        <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
        <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
        <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
        <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
        <CA+55aFx9u-O81MwSq8zpb+MKaWYjYvtEcFu1NLP1_s63ED6_3Q@mail.gmail.com>
        <CACdnJutkO9dgz=HZpPRR9PZC=+cHh97dRUiGB+D3gruZr6U9Kg@mail.gmail.com>
        <CA+55aFxZN_p_cU94z7QN8=HnPanRrpRHH7UUkOBaFDSjfrivnQ@mail.gmail.com>
        <CACdnJutOAPTmPm6dmHiw4+8rj=M7B1SiCkPaRZLmi9-CCuRyNg@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> How? When there are random DMA-capable PCI devices that are driven by
> userland tools that are mmap()ing the BARs out of sysfs, how do we
> simultaneously avoid breaking those devices while also preventing the
> majority of users from being vulnerable to an attacker just DMAing over the
> kernel?

VT-D
