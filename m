Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2031234-1520786808-2-16000787160673931541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520786807; b=GWXM/1PJtBAff8Cx9F+SaKJe6khoCux7de0bAW8Xee+wgkf
    d0ix+qEpPaKZFr8drqpJUQol4tBU2UZ440shWgSpwIAdDJdemUrqvtD/GnWS8xZs
    6gp1rvc1SgNhHvOUi2PaVXcvMMGuldiFcLbNNKBTSduYcPJmRK3qBrRn7k+Rf4GE
    nkIM6Fi8QwQ98HgEnQF9hbxtixx3RhkVW4PL78ESbWelDWPLvGdibj4j2cQEnhIZ
    yPCfm8QwKadebgG/1sdxrEf36khQ46W7s5h3Bu4ehUdpYx6De+13GJNaji1iCLvJ
    JcMYhc8E3KmecyE5w1C6AYb0ndndA+l9DVYKk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520786807; bh=tq4soiLwjy5XocasSLSgXiL/4YhC7+xb2CpJzyQTZmQ=; b=b
    hh/t/BEA2zjvM9lvuVb2D4RDwb6TU3mKvIz8kiIBRR0drXXDyUbJQyozfN3W5zcb
    LfpxyvwsGee8PpH5TVKu/6gu2f7TGDlvnOLuqsYrxGiW2tHBRa5xvsjo+JZ/ofaT
    RMl6haBJZQCo3WqosaWuf+lQZwi4MWwzK8eAywDNYdWW2Au59f0yXzT9PIlYKoHK
    caP7M0EuNEoG2k0YO7cTPRPZtojCfSMpbNWecdDle364kCn9npbSs6K/5bc4aYoS
    3NU+5rwS+bo034jzy2pVTtQt9nm+7r0EVZkt9odFFaLRP93ykU4eXwvBa+cWM0/Z
    4MvccTiEhIRhH4Jjx6P/g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeCKQpr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 12:45:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbeCKQpp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 12:45:45 -0400
Date: Sun, 11 Mar 2018 17:45:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.26
Message-ID: <20180311164546.GA23941@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.26 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/virtual/kvm/cpuid.txt         |    4 +
 Documentation/virtual/kvm/msr.txt           |    3 -
 Makefile                                    |    2=20
 arch/arm64/net/bpf_jit_comp.c               |    5 +
 arch/powerpc/net/bpf_jit_comp64.c           |    1=20
 arch/x86/include/asm/nospec-branch.h        |   37 ++++++++++++
 arch/x86/include/uapi/asm/kvm_para.h        |    1=20
 arch/x86/kernel/kvm.c                       |    8 +-
 arch/x86/kvm/cpuid.c                        |    3 -
 arch/x86/net/bpf_jit_comp.c                 |    9 +--
 kernel/bpf/arraymap.c                       |   33 ++++++-----
 kernel/bpf/lpm_trie.c                       |   14 ++--
 kernel/bpf/verifier.c                       |   42 ++++++++------
 tools/testing/selftests/bpf/test_verifier.c |   84 +++++++++++++++++++++++=
+++++
 14 files changed, 198 insertions(+), 48 deletions(-)

Daniel Borkmann (5):
      bpf: fix mlock precharge on arraymaps
      bpf, x64: implement retpoline for tail call
      bpf, arm64: fix out of bounds access in tail call
      bpf: allow xadd only on aligned memory
      bpf, ppc64: fix out of bounds access in tail call

Eric Dumazet (1):
      bpf: add schedule points in percpu arrays management

Greg Kroah-Hartman (1):
      Linux 4.14.26

Radim Kr=C4=8Dm=C3=A1=C5=99 (1):
      KVM: x86: fix backward migration with async_PF

Yonghong Song (2):
      bpf: fix memory leak in lpm_trie map_free callback function
      bpf: fix rcu lockdep warning for lpm_trie map_free callback


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqlXTkACgkQONu9yGCS
aT7YuhAA1nNZa6eqtjUNPEzaPc+gQU55J1NSRfFsWvQfnYzMA5lwXnNOgUt2bo30
sZUEoHsWaM6/jDvaCjvnDLCJ/1MLuW3JoG/oPXPUINwQDTGxlGsXSWw2z8dXMAZk
7qH82sn0LVbfEh+S4+xWPgKocG+kSNyGFutn5ql+8jwB8WsmqjH8XPpw4ZsjXbb8
iSyrKWj52c/giwXVe3Fqoaq+SHNtMU6VqADZAmNeteT4K/uLTM5KlMPyBApBMjhh
6QKDzLlIDIju5GTkKFse+0H4gtoYezms1k0GXt1IRhe+79B3TvG6qXIRDTYbxr+p
XzuQOpHQDmbdUcscdS0nI03obYA6sckgpjE5SwxHQcykP7ahS3wArFUYSkzXIVim
rNgD1xsMEud37iFTdW4+HFHB6pOdMDGYYcA8VgvnMeOKZs9fkoqZWJlKWZJ/z9Ad
3wbigthh4qb4lJ44OHNtk54KPTNqNjkVcaX1lBig9OnUsbAqs7SAOxX7K4KD5Bf+
HASVhYu0sIRyvq8NE4VbiEEVCw05V0dMO0OX/jAxWyOflrj44tTJvl/hLTiJvHts
nsydDFYFxWY+GcaYhY2lRPTp0yjR7LqwGvOZ5ihdqiJ1mNuxM0XpPS0RWnf/o2YY
ENkn0P/1wQoMd3p540vNrmqdvuj21/GVm0ioy5HxLZ9prdDSpjE=
=SpcM
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
