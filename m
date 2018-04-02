Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1895878-1522640515-2-12027771366475111632
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522640514; b=NmXB71asfBCWEghBt0SMvzmHEydSndjYu5og+YZ39JZVUMPo1c
    MJrw4MY7SnwKdtW+09qVma+RHduJL302deGE5mcCMtFOr3AlmRH/iXOxpd6T5TLn
    8L6GhGchANTXFsHBN1k31XIRACF8OGaKdpVgQ2V9IH9G4w7m7CQO6lbv4wu9HxT+
    MOex3DpTor5RwkwA1laaIwNYTP5dw4PTJJ/Sm4ug65YNXNLEovNWGlrsKTLo1an+
    AhpEGDA5Wiua1SXN9trwZXwKg2FytTJyF1wKSAg1fTxLR0vx91tNB7jbzDAsQzHA
    wEgIqttRz0Ei287ooWp6hQbMpXbwFK1gDh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1522640514; bh=QOI/OmZ2hLQgb3vDO+Ebsqjn4PCpJ1h
    6w6acrZEa8es=; b=cLkpdlCNavkeUNNufFqEOvHk5SgOLC5Nb4mGW9AUTwekROK
    b8tmFhiCW02/Sqa1RhtQGFKwPDIn23IjNYoHKp0nNN43Fh2n6cuwPB28n/DlChQ/
    hE/qA1GfvoeYZqe8Cf3rnqTthbKHWVYePA0l2Dvl/608pkdZn8xknPtGpwiHIG29
    uSzowDk4wbAZg0S1zOTbA2Vwb1g1jn6K+lde1RgKuO1PQaefbKvWxcgP0g/tapWU
    kvVQVRq3XM2IC7k6Em43aMCFrSz+Esv77AbE7WllPnyE2hAGR0fYu8QI2FrMbZh1
    catVkUKziSOueZxymm1VmZgZiclSVLiR7eEjrGQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNdOH/ks5cj7ClUKjfGYqnEhuHeKW3Ynw//5atZw9bmg9xzjopJqFHLbYsO04JrK9wy9yyzilc8z8qHvTvSPsA1X2eYupVQHyNUj8+8zlxFIiMFdcWII
    C5izjEhu1DQM10KLPcqOF3vRCiEyVFA4nso9Nd4fphmjcl6aWLnvCjdOaHEK+do1b3tPaYC9GvHWQ5etR6lUuBQbk3stYpQ0SrQGTpdnxjF4YToMIesqMHcI
    dObueAb8yl11qUHpdmKQRw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
    a=Kd1tUaAdevIA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=XVhiXIj6AAAA:8 a=NEAV23lmAAAA:8 a=eDT7s8iTRNmMRCbrCxwA:9
    a=H86bcfhBO9-JZXqS:21 a=HIS6wogoCq0JAaPJ:21 a=vvlQtnBGGs9KxNLGwn4A:9
    a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8 a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10
    a=pC-h2on8RWMA:10 a=bPq-zhyswAju2HgL2p1_:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Sean Wang <sean.wang@mediatek.com>
Date: Mon, 02 Apr 2018 13:41:33 +1000
Subject: Re: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
In-Reply-To: <1522638255.18424.44.camel@mtkswgap22>
References: <20180329095637.GA16778@kroah.com>
 <20180329124745.24694-1-cmc@babblebit.net>
 <87vada1owt.fsf@notabene.neil.brown.name>
 <1522638255.18424.44.camel@mtkswgap22>
Message-ID: <87po3i1dhu.fsf@notabene.neil.brown.name>
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
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Chris Coffey <cmc@babblebit.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3089209571626973336=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============3089209571626973336==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 02 2018, Sean Wang wrote:

> On Mon, 2018-04-02 at 09:34 +1000, NeilBrown wrote:
>> On Thu, Mar 29 2018, Chris Coffey wrote:
>>=20
>> > This fixes the following sparse warning:
>> >
>> > drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
>> > 'mtk_set_ethtool_ops' was not declared. Should it be static?
>> >
>> > Signed-off-by: Chris Coffey <cmc@babblebit.net>
>>=20
>> Reviewed-by: NeilBrown <neil@brown.name>
>>=20
>> Thanks,
>> NeilBrown
>>=20
> Hi, Neil
>
> Forgive me I cannot find the cover letter in the original series in my
> mailbox to make a reply, so I rudely made here just letting you know
> something good to the growth of mt7621 support in upstream.
>
> do you have maintained an out-of-tree branch to boot the mt7621 machine
> with those staging patches?

I can boot v4.16 plus staging-next on my mt7621 with no other patches.
An important fix (a63d706ea71919) landed in 4.16-rc7.

It do have
  https://github.com/neilbrown/linux/commits/gnubee/v4.15

which was part of preparation for this, but now that very nearly all I
need is in mainline or on its way, I won't be doing much more in that
tree.

>
> If so, it would become a bit easier for me that maybe I could give a
> hand for migrating these staging driver for mt7621 to mainline. I
> thought mmc, pci, ethernet, gsw and hsdma all could probably reuse the
> current mainline code.

I agree that it is quite likely that several of these drivers could and
should reuse current mainline code.  I would love to have some help
sorting this out.  I won't have much time myself to dig into it for
several weeks, but I'll make time to review and test any code that is
contributed.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrBpm4ACgkQOeye3VZi
gbmclBAAm+NewuKw08BlxuB0AgbPrKV346xZiq5N/FdHhQDHIIob0GvAxAZmDtfi
LrjAwO4gmliAFkY6vk6qcWSj8EmYxdn+t5gx1BJXaZaumJ5nZ64XtgZ2of/S7wkH
fUwNzbAGsKe9IuXKPbXoJhvjITwTtMDii2FQ2YjIM6wBhWw6GIbmeUIm3aVRWB4W
+wYdXo8pgYY6ULPdGwadxFh5xwrLk6sMIIPsE+aeteoC1px+/kVmee5LKKpJdo99
XbSXjZHIMgwfVSQfzpWabrv+SiwkRjygTrHk0tAXNsuRhPWTpg69xfVIQCQG0Da/
m/CiayXJRWCD2TAfoDecyffvkT8+NQEJ2Z1ow7EGDcvisVY+PtgZ2fJHNWdu9a+z
/+87l6zOjvBlPRR2JBKv4HGSW72NeJTeMP+4jAn4zXZ+Ks7Oj9E+LaXgCKvfBLih
VLYR1NOR+JP3qn3fQNsx8bFLFfRzjs0nEGl7c0C1z/xD2Lw843n+kx4UbdHO8lTd
dhWyJvl+wCfiGbVnMMjgJLGj4LtVCcFoGgImQyekAVZnO3Vr3pGQXVmM3/wBerE2
feVSJaZkI5En5cgha8RG5Z+uy5/UOja8nAoiPxR7BuqvsnMW/Nk6utwiSOiqHJNp
ilU2vg85eWRg9PcTbx5t/lFs7utVB3a5kfplR8OTjPAeNXL6wg0=
=RzAz
-----END PGP SIGNATURE-----
--=-=-=--

--===============3089209571626973336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============3089209571626973336==--
