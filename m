Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3412421-1519666746-2-3702058428629560727
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519666745; b=TRE3ea1aMa00Jqms6N4lX/NO4xyUXQWwkoweLSQviQP1+zH
    +t+r5atgIZ6TDCbQLF0h8tp4wnPE09qBF26pvTXfQeDrFSQaOX7YgAj3hjKOfF+b
    8PyL3YzmaYg8JF6J+Ntv40jd+5iWEQS97kyfr8aon/I3WMYxTP/9pVwMnYNEZTCr
    MMxlOSUsTCyBJhvPl491hkGDUEUPQgHFMudZyNJSaAoRK5EdLvrNZ+YpckJBqlA4
    gcbSj0HF5jV5jngoA8XK1JaDJ3whWMX/vh6QvrDURqjtg4yvJ6mdvbbyvoL0gCvE
    bq73J9JwxAS0x/6N0U/9zzhhgyMiGYQIGVFP+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:message-id:content-type:mime-version
    :subject:date:in-reply-to:cc:to:references:sender:list-id; s=
    arctest; t=1519666745; bh=cphOsh7BLDhYGB83W5BfTcoDsdQ8CS95dzFvWI
    NVSWQ=; b=Arm0x/EF3y4b3e3A1kBlEl6JrZmjNojwnzx4GDshChT7pwUMfsYN3h
    v8W/bdQD7cPUuXwWtRkad80UIfnYuUcTSCRau59cQRlBe6ZPkNR8Vw1uBPEq/WVL
    3/NVWo7Gz53OgvzQ4+5G5y/fSNErj3JzxQpds7ZBJKG34L9k5gX36HRzWXRfWAO2
    pLuGfI4b2WvagfnMw2QLiC3auDjpYPFe0gJSoGZZ1CvfRlRAM8mG1OjsNSMRxj4/
    AL+UEqeuJWz5g5QuGl0Vzd6vZJA3MN1naEDVCl6e63l4IqlzFKEJcWAAEXAwxv+l
    DOGc2qJgVLtFLECwCRWx3ymZ9w7nhfeA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=me.com header.i=@me.com header.b=2eogp/n4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=me.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=me.com header.i=@me.com header.b=2eogp/n4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=me.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeBZRid (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 12:38:33 -0500
Received: from mr26p42im-ztdg06103201.me.com ([17.111.243.30]:20795 "EHLO
        mr26p42im-ztdg06103201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751186AbeBZRic (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Feb 2018 12:38:32 -0500
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-02-26_06:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1802260218
From: Nathan Hjelm <hjelmn@me.com>
Message-id: <B9A6330F-48FE-4260-A505-3FF043874F0F@me.com>
Content-type: multipart/signed;
 boundary="Apple-Mail=_6A54AC93-1F7E-43B9-A4A6-B8E2291C2347";
 protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [OMPI devel] [PATCH v5 0/4] vm: add a syscall to map a process
 memory into a pipe
Date: Mon, 26 Feb 2018 09:38:19 -0700
In-reply-to: <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        rr-dev@mozilla.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, criu@openvz.org,
        linux-mm@kvack.org, Greg KH <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, gdb@sourceware.org,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
To: Open MPI Developers <devel@lists.open-mpi.org>
References: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
 <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Apple-Mail=_6A54AC93-1F7E-43B9-A4A6-B8E2291C2347
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

All MPI implementations have support for using CMA to transfer data =
between local processes. The performance is fairly good (not as good as =
XPMEM) but the interface limits what we can do with to remote process =
memory (no atomics). I have not heard about this new proposal. What is =
the benefit of the proposed calls over the existing calls?

-Nathan

> On Feb 26, 2018, at 2:02 AM, Pavel Emelyanov <xemul@virtuozzo.com> =
wrote:
>=20
> On 02/21/2018 03:44 AM, Andrew Morton wrote:
>> On Tue,  9 Jan 2018 08:30:49 +0200 Mike Rapoport =
<rppt@linux.vnet.ibm.com> wrote:
>>=20
>>> This patches introduces new process_vmsplice system call that =
combines
>>> functionality of process_vm_read and vmsplice.
>>=20
>> All seems fairly strightforward.  The big question is: do we know =
that
>> people will actually use this, and get sufficient value from it to
>> justify its addition?
>=20
> Yes, that's what bothers us a lot too :) I've tried to start with =
finding out if anyone
> used the sys_read/write_process_vm() calls, but failed :( Does anybody =
know how popular
> these syscalls are? If its users operate on big amount of memory, they =
could benefit from
> the proposed splice extension.
>=20
> -- Pavel
> _______________________________________________
> devel mailing list
> devel@lists.open-mpi.org
> https://lists.open-mpi.org/mailman/listinfo/devel


--Apple-Mail=_6A54AC93-1F7E-43B9-A4A6-B8E2291C2347
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE2GIIdNgp/fA6+otZb+5NXWbsZioFAlqUN/sACgkQb+5NXWbs
Ziqqvg//VVpRs73U8FH12mV10hzJmQEVssOgHVrroVBeg0oRjVFsUp8fJxxvV9iC
DZ+yylG7T5K7V1ixlbv1Uw9nj79CB99HQuTtXARv7Rab2opcWWh2MktEV9+8iM7f
xCXc+JCQfd6ncL/codqUTry+F++1K3fIanRj2/TtK0fr45uNODAPxS8FIxMl5NYg
hym0BEmZkwKm5BKZbWqlDq3ES2HSrIHHXw33liTJcWQSnmsV1KLWMPvJwVWKF/s2
eyrLBASiwbNw+BkZXY3LSqRRXU8pJM1HQo4PKsiMp+caBGypeSgq4WDn6i9vmfFW
qUZmtNYzlnpFLNiFJBIfPYIoYrsondHCDD7U7V2tS+j70hG5/5apj3Mgu4mBBm5L
DQpfyiCPLE6objfpt1qd+fqWTLNpbQAS1elctmxqDL1MgXQXrjMgOrbZJPLUzP5q
6EfTw09wOUjtpl6dmB5g4UvnJztTRTHGTkS/DNl6UhSnGGK7EC442hAhkMjs8/Yh
zbc6/LxXu8B7k5VBopKx8nxISbq00A1Y1loPlsOaKx581RsUaIrpl1bUx3t62QzC
8MbuNZWqj4ogv2VIxJBP3h/YI8Hedzjckzy/aHVkwyj5N+iHjHmXGGPFm/7q9lm/
os5LIAQQ/F5pE1wqZq3EE3XLSXMP8fU2q+YjaVYXr7a+IX4MVbM=
=HLfy
-----END PGP SIGNATURE-----

--Apple-Mail=_6A54AC93-1F7E-43B9-A4A6-B8E2291C2347--
