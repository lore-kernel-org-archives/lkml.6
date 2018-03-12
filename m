Return-Path: <kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-3703740-1520836716-3-13172412739173052879
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520836716; b=nLZklkRWs1+XmQOoI/NkmxL83rCApP+b+vFlU6del5v9Uck
    +agk3kTWN0dyd2T5yr6cXEUlWT4kV2nrHfcQ2vHBx2WUdHldO69gg6ot9+MAn3Tb
    vneN0QIpxVxi0eSob2EqtT9Ys7UiLULmu4MCVRPPaNMqnOGSgOP+IQO2dl18lCbR
    G3tmu8XLZhPkeGGhRAXLZCN4O8YJAjXLHynK6u9kfUSufgiAhu+E1p2lY53SAZqX
    AYTy40zU7kWP1oT23YpFzhwL+oGFfOV855NOsjUJILtx3PkwN5vgSLUzWRylDDpJ
    IWSJPwdshWyeTYL95zm/o0sblsTqGoXO/vKV0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:in-reply-to:references
    :mime-version:date:message-id:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type;
    s=arctest; t=1520836716; bh=9k76MAmXNhoiqDRPoSKEao3sNGcJGvKFRI8
    KHBEOySM=; b=SlsTtSe+1p0Rx7ZNUf/JaMRuXH3L6aKjLsvJcooxLYOHVvGyMB0
    60pGuWY44iCCmAfL1RnzYs+qBkOdlAWHmSg0qcyV5cIZyexjDbZ4QQdmjrKMxcbZ
    u97L4wZQC9WEHTCYJCjtLb5TUr91U8aP3ymJH+GCnhEDdgSSRgD9Hgz789GJSJbZ
    qwCd74lX3PbxQ72Rip8lcbz0woW3GTx0NJ2iMCq+zcgodSzH96thENRzcCTsWT+g
    J0ruUD+aVY2amXN8e4h4ZtQAhpgmY2tbYaZLDZRWX7md6hs67GYDnqPGTJDPM2sq
    c3CgFHmfr0j5aBGNSgoNH4OKhl1N9kHdjCA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=vt.edu;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    smime=temperror;
    spf=permerror smtp.mailfrom=kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hsXiP4gZ;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=vt.edu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=vt.edu;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    smime=temperror;
    spf=permerror smtp.mailfrom=kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hsXiP4gZ;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=vt.edu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELs2r8/3UqbcjMbnnBGW8RGaXfhLTz0mXZvQ60ubC0c6/PEG/jmwS4+C+HBje0QbD/HAqI7InQ==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: "Tobin C. Harding" <tobin@apporbit.com>
Subject: Re: [PATCH] scsi: eata: drop VLA in reorder()
In-Reply-To: <20180312030834.GC8631@eros>
References: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com>
 <20180312030834.GC8631@eros>
Mime-Version: 1.0
Date: Mon, 12 Mar 2018 02:36:38 -0400
Message-ID: <134937.1520836598@turing-police.cc.vt.edu>
Cc: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 kernel-hardening@lists.openwall.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org,
 Dario Ballabio <ballabio_dario@emc.com>, Kees Cook <keescook@chromium.org>
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4498544342012028521=="
Errors-To: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============4498544342012028521==
Content-Type: multipart/signed; boundary="==_Exmh_1520836598_3502P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1520836598_3502P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 Mar 2018 14:08:34 +1100, "Tobin C. Harding" said:

> removal patch that 768 was a lot of stack space.  That comment did,
> however say 'deep in some transfer call chain'.  I don't know what a
> 'transfer call chain' (the transfer bit) is but is there some heuristic
> we can use to know how deep is deep?  Or more to the point, is there some
> heuristic we can use to know what is an acceptable amount of stack space
> to use?

The canonical "why we put kernel stacks on a diet" configuration:

Imagine a bunch of ISCSI targets - with IPSec wrapping the connection.
Arranged into a software RAID5. With LVM. With encryption on the LV.  With XFS
on the encrypted LV.  And then the in-kernel sharing it out over NFS. With
more IPSec wrapping the  NFS TCP connection.

Oh, and I/O interrupts, just for fun.  And most of all of that has to fit their *entire*
stack chain into 2 4K pages.  Suddenly, that 768 bytes is taking close to 10% of
*all* of the stack that all of that call chain has to share.

And I see that patch is against scsi/eata.c - which means it can plausibly end up
sharing that stack scenario above starting at 'software raid5'.

(For bonus points, the alert reader is invited to figure out which stack each of the
above actually ends up on.  No, it isn't split across enough stacks that taking
768 bytes out of any of them is acceptable.. :)

--==_Exmh_1520836598_3502P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWqYf9o0DS38y7CIcAQLwGwgAsbjEunB2hZFHsWdo75SIaBMf5iCRpt18
8TZdZJwgBLqT/6mndzwmwc4DynfPCoxsE+fNsfTcTumGNiqWiBVPKM9YQhCvkdu4
Iygpn6H23C6pgSzExzwNuGGstGyVh9fLsiLBiU07aFQA0ReINi9XZGZscrrDbO2T
cr4XIuJ0onTJX7367zOGBDNrFVfpO9ZJby7Zjy/1FL6XPg7IV6lUz4ciYAK2tcbv
0gb6AQdDSyz3BJcEorYoLc1wmdEBAiJ/UjGYL8c6V4O7jazhNl0pMn2HWuhupqKE
HhlMt5TyCpt6fHYgSQqiNPidq5fvmqWut4bKY3EZwRf8YKUMHgNeAQ==
=jNqk
-----END PGP SIGNATURE-----

--==_Exmh_1520836598_3502P--


--===============4498544342012028521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============4498544342012028521==--
