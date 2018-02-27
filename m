Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-198277-1519697905-2-4605587159759542794
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519697904; b=N+P2zVLX0HHMk+cbsLmmORWejK9S0mLoqEdYHLqUql9nCdv
    jtPPIEKkaDnS5JeE9fMSex70m/EWTwL7LqdLYQp3oiGrTrmfitvr701LBCFXRVf8
    Qak46xgpCsRc4QKGDaabd0ke+wLh/TE9jEGn+srtISERtY/94PY8E9GBwnfVsuvl
    Ur0A2gJjpRp5Ds+Np3F+7MK2VZQWPwLaj5iVNInCVh7sECWVxMVr5q8jihtSrEQF
    qDX4SNdvMTkMuwZU7ATux4g2H08E9+pQnaA/fRAip/ltWgpNFLRKjYe0FyWDfiLJ
    nSteawh43jWzZYhM8qjPUDOppX8KXoArl7JHONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519697904; bh=Y1Hi+wQiTmh5MjfVD79XABdFES
    0XMY9ep+9ZKZNCFz4=; b=aaUa+AGSTiJ48ASd0uIGttFI9UZKHCSaNpAsuR2I1U
    QLK1b7to3YGD0+jV2zYm8Gwvz/LZYLyIOsZe3Zz0NN0HLZVcEYYLPlIRo6g/Ri2t
    5M6le6LRfJ8yGuJXpaPqRj69fyzUdhLZNL3Nu+FvkMCDU0yxwKFZLmuGzEK/W7w7
    qfpN/+gTnyFzcGwhw8nLgscGoMOYLfRsEA4Cl5fpzMLgQEm5rWDpQewguHhmOWwE
    Zhq4LAzQ+/h7VMlFo/fyj2aMXMvQlI35t7JPmXSiHNph7jbWTxPIupDTbtf0E7JZ
    XuzOy9LvNGb/3CjPU0l0yqD+LglY6UxgvnY2wWS8UOuA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=altlinux.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=altlinux.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=altlinux.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=altlinux.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeB0CSW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 21:18:22 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:56856 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeB0CSV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Feb 2018 21:18:21 -0500
Date: Tue, 27 Feb 2018 05:18:18 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, criu@openvz.org, gdb@sourceware.org,
        devel@lists.open-mpi.org, rr-dev@mozilla.org,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCH v5 0/4] vm: add a syscall to map a process memory into a
 pipe
Message-ID: <20180227021818.GA31386@altlinux.org>
Mail-Followup-To: Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, criu@openvz.org, gdb@sourceware.org,
        devel@lists.open-mpi.org, rr-dev@mozilla.org,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>, Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrei Vagin <avagin@openvz.org>
References: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
 <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 12:02:25PM +0300, Pavel Emelyanov wrote:
> On 02/21/2018 03:44 AM, Andrew Morton wrote:
> > On Tue,  9 Jan 2018 08:30:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.c=
om> wrote:
> >=20
> >> This patches introduces new process_vmsplice system call that combines
> >> functionality of process_vm_read and vmsplice.
> >=20
> > All seems fairly strightforward.  The big question is: do we know that
> > people will actually use this, and get sufficient value from it to
> > justify its addition?
>=20
> Yes, that's what bothers us a lot too :) I've tried to start with finding=
 out if anyone=20
> used the sys_read/write_process_vm() calls, but failed :( Does anybody kn=
ow how popular
> these syscalls are?

Well, process_vm_readv itself is quite popular, it's used by debuggers nowa=
days,
see e.g.
$ strace -qq -esignal=3Dnone -eprocess_vm_readv strace -qq -o/dev/null cat =
/dev/null


--=20
ldv

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJalL/qAAoJEAVFT+BVnCUIrHEP/iq2COswEmrUt2Wrrcx4Mqug
xxUPCKfBesxnYe660FjWAXJgy9bRGFCl2E8kz3tQ8w4oaDpGpGGfDhu3dwum7RWM
0RGCkXrLNk4/yGj71DMC3UGp+ENkBaKc5Wu9sYh9E1TAZAaPYh5tfC/KYajN+h5h
QXPINyoAxuWWxNUUHW2sCqql6+1UPGBfKxSkGInqnxg9D5wj6bdzH+n8FgqK+Ja7
B2SUFwGw/WeTZ30p7awC/VYN6mNvPZRr7FauReHvx19wUmkOPmXngnzCp1SbgV1l
5DFOIyHQGt4x5kVMHUutf3m073RQtqlJQ1DzmKWKgto6OMK8/+XQP+aa+R0erM7F
ZDGny+5E9Af6Df0FdOfgvb+mo+AswotfXfYO0i5iTBcRz7VOitOgQZspo+cpQLRI
U7kJ1jD+c/9ZEMXU5IpNpHgyyBks1oma0HNaTsUjiOPO1ulPCPoHFhloqtub/p7c
s1glSej43y35Wj/E0RgkQ/aiULAn0les+BYD9TnpJzx/INo3V7FTMmhSJcV7LaWV
aeTb5o8CW/AoiuHgYvy/4tejDnOvlCvmL0HwOfjhqkh9Ja1nSapFWEddCVK9csQK
i2wFwtwyZXAO82qJns3/w63LfEK93KFPomNvwmuxyJLVQzBJ7U2oZ8ISrsnuLlvz
LibEd0Tf9EiL/Ol4kDHY
=M4cN
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
