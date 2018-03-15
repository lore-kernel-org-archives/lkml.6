Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1115141-1521144735-2-13053521592904802255
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521144734; b=EJR8or5QLXvTngurjahteKkkZ9h274/KlDfMCjYTP/nMTGV
    blRBEpadjwY+D5yqcsLJWqCBOYX1w6Zle+BmarWm7v8v9hdpz+AjU1swbjw5wZez
    /nD1MvZEuv+BiMva3qajUZYL7zInXW1ywiCEwjQB/HbOrfVEJLmsnwbmbckiwDJu
    AklkEIUPd75udN8P1FpASbEE6mbqLbVP3ehS9IyqO5at+WAZvDT/XMWEHq9qruRw
    kfsS5aKy9h0khCJoaMePkHZTKp7kp0+SfxVMsVugJF9YjswsTfEg8kJ8nnQqCCVG
    H/MAWIFGABYLQViTwcUy9y1UduDT+v053nlok6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1521144734; bh=v42ICUqaQJ6zn7IEBKXn/lW8Efx
    V+0KBzVxLGrRiBfs=; b=l3CozWPHDwMgrf+Elm2/FgvTlXIgFqKbLiLfj4FwNwe
    edxIwCiKU5SDKfmuvtj3hyUsKjXm6jVqmOrdC+td+hlY1+H3IJpSFGBF9xvGfg6W
    IDbHOU9SwE3nPDaduJI0a9i4qgKxEO1AI+WPn2V8mWkpHpjPpp7N8aqHHyWfkBJ0
    +l93dHFvWV8fN/tbQbLm34eOJPBNB+WJSGMr2XC67TKfAtIQQ765ugmJJcI15KB6
    XZKFfMwL/iVihODBcHfo4Z98bpMtKp67bIG6vH4CnV+XTQ0EhO+mxR6J5oPh/58A
    9E92MUgFO8gdrjn26kHqI12n6eo6Z8gcSCiLjvQ8m+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: John Crispin <john@phrozen.org>
Date: Fri, 16 Mar 2018 07:12:00 +1100
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
In-Reply-To: <be0d1e2d-67c5-bac1-63d4-72568dbf9d23@phrozen.org>
References: <152105892255.22262.1902152685410223215.stgit@noble>
 <20180315104853.bthffdd4hzklzo6d@mwanda>
 <be0d1e2d-67c5-bac1-63d4-72568dbf9d23@phrozen.org>
Message-ID: <87muz9ayjz.fsf@notabene.neil.brown.name>
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
 lkml <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: multipart/mixed; boundary="===============4713637934009758055=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============4713637934009758055==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15 2018, John Crispin wrote:

> On 15/03/18 11:48, Dan Carpenter wrote:
>> This all seems fine.  Generally the requirements for staging are that it
>> has a TODO, someone to work on it, and it doesn't break the build.  But
>> some of the patches don't have commit message and those are required and
>> some of the commit messages are just the changes you have made not don't
>> describe the actual code...
>>
>> John Crispin's email is john@phrozen.org.
>>
>> regards,
>> dan carpenter
>>
> Hi All,
>
> looks like i was CC'ed on the openwrt addr, which no longer exists. This=
=20
> series makes no sense. None of the stuff posted is anywhere near ready=20
> to be upstreamed.
>
> * we dont need a dedicated pinctrl driver, pinctrl-single will work fine=
=20
> on these SoCs
> * the DMA/sdhci driver is a hacked up version of the SDK driver.
> * drivers/net/ethernet/mediatek/* works on mt7623 and is easily portable=
=20
> to mt7621, same goes for the gsw driver.

Hi John,
 I think it makes sense in that, with the patches, the hardware works, and
 without the patches (at least the first) you cannot even build with
 CONFIG_SOC_MT7621=3Dy as pcibios_map_irq() is undefined.  Having
 working code is a great starting point for further development.
 It certainly isn't ready for upstream, which is why it is heading for
 drivers/staging.  This is explicitly for code that isn't yet ready.
 By putting the code there it should be safe from bit-rot, and can be
 worked on by multiple people.  It gets increased visibility so people
 can say how bad it is (as you have done - thanks).  This feed back is a
 valuable part of improving the code and getting it out of staging.

 I'll add notes to various TODO files based on your comments.  If you
 have anything else to add, it would be most welcome.  Thank you for
 making these patches available in the first place, so that my hardware
 can work!

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqq05AACgkQOeye3VZi
gbk5Iw/+NPdW6TS1ThKS/gXFj6owZBOnEcfDFU/vfLviOKra13dVetLwTnLLM1M3
Gh1GUN+hkPCnFXRbxVkrAd7OGOogJsOw1hFAx1MijiFpikW3P4vxM7XI1D9wUvr3
EUCtKW6HzwaKt6A52hbgP7oZj1uDUqTue3SG729Z9fP0kyBmUm2d1I4nfmnqRYeA
/VBjc9QhCY+jf6uVsbC/sUFUhQ8KEDrob7S8hitaysBzjjkyVFqZZv7ZTL5Zat5b
qI+33Dg85x4pLNj26M8M+cow5UW7DoKomklN/zDwpPQiDfrwv3M29KyQPXDFGyaz
JlpXHq5X+rSA5Efx9qlxtH4EzWZZmqX8W9Drg5VsqTac798DBIhErApsd4uQ71c1
OkrQ0vK83TdGXqpPcp9g+AZiFdLuX70QKPtQ2v8QOqrjgTwoOBhq7e5Yt73iSpkb
ANWlJdlp8pURdygFa6Oc3XwSGl91gBXn0w3zWAb2j7PQtBx0mI123mReivy/+yzL
KwWP6Fbxly/qiBxo02qTwuW1lHIZ5o+W0TX7/dcBcOlewOmnUr70Uvk/yJcNJfsO
nV5dceAjQetD1hJ1wjVEN6Vme4QbXa1IIv9Rf0+n/aGdL0NcP34ZhVAL9hXmchCw
/iDYsAli1bwXqP1738jlD6M0As8FTfI36pRh5z8fSmbNZc46R9U=
=kppU
-----END PGP SIGNATURE-----
--=-=-=--

--===============4713637934009758055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============4713637934009758055==--
