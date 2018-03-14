Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2877095-1521071118-2-13351135876022005779
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521071117; b=M1+D5nkp5mvLWf4z0PVZ2QXxaAfGovX/2Aa9YhcswuAMDB3
    pB9cnJ0euf9+b4lpL1Fa77FRoAhkuILPv+7EW8U5UIyGpVpIoeeQshyS326p8l8s
    tRHuYQ7bKVsrJyJf0odEQt9FrB6/fhTp3Zvti1IdxC+csamQyb6rBz04GeLOV4I8
    mMFgpsheW0O2jRs33EfG9LTXRcYRaz4lBbS/BmpMEKs98LtA7kY58yNuFLAOFRJ7
    KqDnWgvPq31M8T5/i/JfArqEckV4/3PxEjuikKItP6yQyHGcwuv4I9GxCVqSenK1
    GW7irh3MOkmP4PY3a62cMjLIJ+rfGcGA5UNz4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1521071117; bh=SN1IMdFtkGGrzgP4XXrPoGj22Dx
    3ONH2Olonjzvl1tU=; b=vpqBrI2/OfLPB4pXl9A+xCAcPAoYRANG2HvXDpV601Z
    B0oEyNcp3jC/qdKj670tbyrmEUtu74+qAZKfNJeLpSbrYvHEhonUo48a3OMv8+jh
    ChZam1Pb2ddxKk1cl2Pl6s5+gtoDYiOUqWob/ZPstCDICP5fyLrK0lnaifHlFSMw
    bkD3VvToH3wqodurUa2R9e0mYnl7dAUZWp/HsghWFiJ2+c5k9u0giYplFwHNkBfe
    1hSR+73akqxces0j8HbvIg2vrwkdn/brOgT+qtqeBRGAwKZ92x5Y7Bvpd7ImaFZr
    Uc7G72ZGv21jQYE4R+mXImbM9QstnpZXSr6S5e1JilQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 10:45:02 +1100
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
References: <152105892255.22262.1902152685410223215.stgit@noble>
Message-ID: <877eqecjcx.fsf@notabene.neil.brown.name>
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
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============4818070232991106095=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============4818070232991106095==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Thu, Mar 15 2018, NeilBrown wrote:

> Hi Greg,
>  I'd like to submit the following drivers to staging.  They
>  are all for components of the mt7621 MIPS-based SOC from Mediatek.
>  I lifted them out of libreCMC and (for the ethernet code) out
>  of email posts from about 2 years ago.  I forward-ported
>  them to mainline, fixed enough bugs that they mostly work,
>  and moved them to staging.
>
>  With these patches the GNUBEE is almost usable.  It needs
>  one patch to arch/mips/kernel/setup.c because mips_cm_probe()
>  is being called too early.  To successfully reboot (i.e warm-restart)
>  it needs a small patch to drivers/mtd/devices/m25p80.c.
>
>  I've made a point of only included code that I can actually test
>  on hardware that I have.  That has meant selecting only a few patches
>  from a series and in a couple of cases, discarding some files from a
>  patch.  I haven't discard code from within a file that I need part
>  of.
>
>  All the driver patches had a From: of John Crispin so he is cc:ed -
>  thanks John!!

Unfortunately the email address I had for John bounces.  So if anyone
replies for any reason, you might like to delete his address from the
Cc.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqps/4ACgkQOeye3VZi
gbmY7Q/9EvldRXg3ndVsAldR3bPy6Tpv+8cx5Q1MoBibgavncOKRuJizGGnRNAmF
E6pIuUn3Fay8/sfbXPf5v/YIK7wn6rPtn1cmBPqhJRNC+a4tMjEEH+Ahi73w+axC
VKrxdnwXhmdFLrvXw3m53QrZXZEa9QYd/4/i8n54TtE0IrW5gB6gUmkpPdhxyHiV
TlSO/xWIYyXNhB9YmG1Kz+PzzYXXwNJk5sBxxNE5kIjzjzDeE/TYIuxznTRw4ft5
MZKCm5FHITJAuWBV1nAxu8fnQsTAirtArsjQexL07YNvrD9zqesyq2ob+C9NkcTZ
yPKp0u86+CMRC5PulCaVRwjEZlTaH8fV6Yb1BOLfDBMlYQdSpONQYRROaK6lLyW6
Yw/P3YuVqMXjejrW1IR0tDbdoW5TPDDr7MoQXHwzmuDDLAUezorG55YFhex1m1/l
1KV1OLGns+4A6MQaO9j4d5ix2KGyINMJsa9GfN0lTfrFPQyIRH/rLvxmCky0FPNK
hvlWYADNOCKjBer9N61ArSfMJpzCjkXi1/vNqnFB2EowrAIfpAT04qvST08X5mOG
1QPNe0Uq4ApEnWxNRn1hOlc+fJdWizLCoXOILyrse51tmRpjIguHHrNd/4lKwPNE
QDcL+met/tM8fx2iBxdA4L2gZEAMi2Ee89Zdn7fejJlp0giffD8=
=VAVn
-----END PGP SIGNATURE-----
--=-=-=--

--===============4818070232991106095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============4818070232991106095==--
