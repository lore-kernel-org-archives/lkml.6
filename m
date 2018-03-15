Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-68257-1521111894-2-3850052330131611235
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521111894; b=Ng07iwRIiAmkTjErNPCLUDGbHm/z9xaLCbJm+gkrc0FtQ/r
    uYM2IAWUeofZ9QO0zSJxF295ZA3RrjM+wik4GqdQLHnGMzFQ3hZ3P6kIJg2VmNRL
    3UG2ZDR+lzqH1XOFaXYhpuCweOkBmdq521DMWUnLDszOiWewA56SsOhSae4QE+Qh
    TQCevzb0DMBv31T6OusEhPxVoCg0mVLviwCbybKX+QsdxeGHwdHKurL1rwEu0TPN
    U+09NXMLa0pqUqmA56zqP4WmLtJYSCJYrClzjs4dYL3DcmiEP9/1J2s4SRJ/Qslt
    YYvU1CnYVfaLgcs/3e/d0HiR2amHRha+lI7DPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1521111894; bh=F6L0Z9nQVQWHFNDcylI88VIwUYE
    4v5wsCdzgcnm9KNw=; b=UsdNe2CpZz+4tlcPF+95sAomat+RGgUlnCIze2DcNzi
    CjBVTKl3FvAfjvoWK74Ds1CzumNKEd3gS6Vi2tQ4pu91wMtfDugBSUGfNZptt0JP
    BCgwRcWBQyRD75gUIyqXV+FMFZQ7B4tpUyDzgHLQHzTAVM1/vbXEKFXntSaBcYk+
    WuEZ/GahcWKTnSA46yr6tIM+Z99t4hM58+ydkMLbotCEzU3sN7ko4AnVQGfoVZpo
    aTB22KpOfImp/1iScFNqy5w4DoeO3cVQwNlxUmwWAhCDxHCTjlw/Tf6Y+Kd/k/wN
    eyhVDnaG3dDcG8l7e9uPO6t3walXa6gTlY7IFjrv75Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 15 Mar 2018 22:04:33 +1100
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
In-Reply-To: <20180315104853.bthffdd4hzklzo6d@mwanda>
References: <152105892255.22262.1902152685410223215.stgit@noble>
 <20180315104853.bthffdd4hzklzo6d@mwanda>
Message-ID: <87vadxbnwe.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, John Crispin <john@phrozen.org>
Content-Type: multipart/mixed; boundary="===============6070353942243705253=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============6070353942243705253==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Thu, Mar 15 2018, Dan Carpenter wrote:

> This all seems fine.  Generally the requirements for staging are that it
> has a TODO, someone to work on it, and it doesn't break the build.  But
> some of the patches don't have commit message and those are required and
> some of the commit messages are just the changes you have made not don't
> describe the actual code...

Thanks for having a look.
It seems odd to require detailed commit messages, when we don't require
the same level of quality in the code.
Naturally when the driver is moved out of staging a properly detailed
commit message should be added, but is that needed on the way in to
staging?  At this stage I don't know much more than is already there.
After I've cleaned up the code I probably will.

For patch 01/13 you asked "what kind of device this is".  The subject
line makes it clear that it is a "pcie driver".  What extra detail did
you want?  Would it be sufficient to just copy the subject line so that
it appears twice in the commit message?

>
> John Crispin's email is john@phrozen.org.

Thanks.

NeilBrown

>
> regards,
> dan carpenter

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqqU0EACgkQOeye3VZi
gbkCPA//XzehKADE/hYzhmcQ9/QaJIPOoNG0IkbWtF7GQ7j4KM+2/l2Z+s2Du87j
zfHhE2sxTU+5M+QZXiKIy3Q60lIdh2w9S5w7gr2HN8YPVh2V5H1kBfuMyelul28H
JBe87OCbxBXaEtLav7N8mXHC8I4bh/l4bCqDvwqesY1VH8OUJkYNa+DCpnUSkEJm
gl40vkw7Q1Mi2+pkxaQ/+Nz8QfHUbhnqN5ZcmWXJvGwpGRWXxbURqlT8Aj1csNxv
KukABeUrrhZbl6m5gyI5eiRkWvaA1KiLdKjPlhtg9LNrPgK2sJToWIQK7BIVONKY
lAIWjaKJaFmBNmZTDVHlTywOIfdn3yu5PtM+27D4aCcM5xsfenyuv6L0l/JBosFY
qPRJovbfqJ+s3ujiBdbxK3+6qVkCYC2yiitAIUXoWoxZ9RBvT24FfSH71VoeoGPx
fUOpyOdaRFH8n/KyhiaIn/qj6GaNohtWX8XzwOHv8cPifQlPrzuARt4Cqyjk4Mh+
bpC7qstvLqAbvDk1TUifgJ83Bs4C7NiqOZty+/a2kQBv7nzJSKpTGuCU7kSrHc0E
2+c3PK1HF6adq66ZvB8CeJ0AIVIPxB2sD4Y5NqZPMFdqLAH8RX7Zec3gEMc8Z9bZ
kfRI/mDvNGCa46ZBFwqDkVhoToZqdgudJxI6b3PaYHms1SVwYts=
=o9ME
-----END PGP SIGNATURE-----
--=-=-=--

--===============6070353942243705253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============6070353942243705253==--
