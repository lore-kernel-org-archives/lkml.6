Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1437415-1521154760-2-7440994140154289919
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
    t=1521154760; b=SqO+gGJikOcErZNc44Yr48OXcp31meRqUa4KwM7IUTpv1of
    kpEp7ut4SytS+3BV2+ucp9P2h/xYGTWjFHY5kKC1AGw83d4GzQGn7v0F6IGRWZm2
    VcZLSBqgfz7VJH2C1qZj9Ztq+6cC+oc/7cfkFsIaTv1W6hINxZ2qrnz8FycWW00K
    EundsWdXMBUqRbh9jemYbT8nu3ijkRk6j6jBRrgVQPcThUn0ldiem9S1pNnEiszw
    KPDlIrAb/mDmrHWFIzt7fQR301rKtK8AtmJRj7amrfU2a7bhufPTqiH9rmR+Pcyh
    SsjYVbmZWJ1jMU5K1c+C0ILQOy63EGvAe6hoxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1521154760; bh=WQguaOFMxPT6JwlRc9NtSd4z800
    ev+gnql4I3WACVb8=; b=lHGeni8RsFFOyzB1xFPuatLfCFIFvCg4cTHkFsoqirf
    mXsItbWXe807GnMYuSEnRXyRIcJ/FRXERUsx4rZspTW3VaA4qwyvv6pNYQFymsUx
    o8C4AAIAH25NzfQHHmjcUbOfzndYnoMwTKpxMMWi26nQ4AeXYCXS794QdBq3Fu+L
    LydN7jkIqBRBxTAjGARYWMHTCNaSSX0nreZ8RCKH2ilFjQpq12AizXM1yJP0EItV
    egq10ns+xIsw9nVAKOak705u1ZL2JtjdWYoCsZh7uoKtcnS8eOGZhqnrAQFKI9N4
    AMUNxncD4k+iU05l4SHjN+BrU6p98je1+DQ6fFX4dKg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
To: John Crispin <john@phrozen.org>
Date: Fri, 16 Mar 2018 09:58:59 +1100
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
In-Reply-To: <9e8e07b4-1a4d-3434-402f-920c19c65122@phrozen.org>
References: <152105892255.22262.1902152685410223215.stgit@noble>
 <20180315104853.bthffdd4hzklzo6d@mwanda>
 <be0d1e2d-67c5-bac1-63d4-72568dbf9d23@phrozen.org>
 <87muz9ayjz.fsf@notabene.neil.brown.name>
 <9e8e07b4-1a4d-3434-402f-920c19c65122@phrozen.org>
Message-ID: <87efklaqto.fsf@notabene.neil.brown.name>
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
Content-Type: multipart/mixed; boundary="===============3721625532213630172=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============3721625532213630172==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15 2018, John Crispin wrote:

> On 15/03/18 21:12, NeilBrown wrote:
>> On Thu, Mar 15 2018, John Crispin wrote:
>>
>>> On 15/03/18 11:48, Dan Carpenter wrote:
>>>> This all seems fine.  Generally the requirements for staging are that =
it
>>>> has a TODO, someone to work on it, and it doesn't break the build.  But
>>>> some of the patches don't have commit message and those are required a=
nd
>>>> some of the commit messages are just the changes you have made not don=
't
>>>> describe the actual code...
>>>>
>>>> John Crispin's email is john@phrozen.org.
>>>>
>>>> regards,
>>>> dan carpenter
>>>>
>>> Hi All,
>>>
>>> looks like i was CC'ed on the openwrt addr, which no longer exists. This
>>> series makes no sense. None of the stuff posted is anywhere near ready
>>> to be upstreamed.
>>>
>>> * we dont need a dedicated pinctrl driver, pinctrl-single will work fine
>>> on these SoCs
>>> * the DMA/sdhci driver is a hacked up version of the SDK driver.
>>> * drivers/net/ethernet/mediatek/* works on mt7623 and is easily portable
>>> to mt7621, same goes for the gsw driver.
>> Hi John,
>>   I think it makes sense in that, with the patches, the hardware works, =
and
>>   without the patches (at least the first) you cannot even build with
>>   CONFIG_SOC_MT7621=3Dy as pcibios_map_irq() is undefined.  Having
>>   working code is a great starting point for further development.
>>   It certainly isn't ready for upstream, which is why it is heading for
>>   drivers/staging.  This is explicitly for code that isn't yet ready.
>>   By putting the code there it should be safe from bit-rot, and can be
>>   worked on by multiple people.  It gets increased visibility so people
>>   can say how bad it is (as you have done - thanks).  This feed back is a
>>   valuable part of improving the code and getting it out of staging.
>>
>>   I'll add notes to various TODO files based on your comments.  If you
>>   have anything else to add, it would be most welcome.  Thank you for
>>   making these patches available in the first place, so that my hardware
>>   can work!
>>
>> Thanks,
>> NeilBrown
>
> Hi Neil,
>
> I understand your reasoning, however ...
> only the pcie driver is worth merging. all other drivers are already=20
> inside the kernel for mt7623 and can be easily adapted to work on=20
> mt7621. having duplicate drivers is a certain no-go.
> cleaning up the pci driver is a matter of a few days work. merging a=20
> shitty pci driver just to postpone doing the 3-5 days work involved to=20
> polish it seems a rally bad trade-off.
> i strongly oppose having any of this code merged into the kernel, even=20
> if it is only the staging area.

Hi John,
 I don't understand why you would want to deny people easy access to code
 which makes their hardware work.  I'm sure that isn't your intention,
 but it could well be the effect.  If you think you can make it work in
 3-5 days, then please go right ahead.  I will happily test anything you
 submit.  I suspect the most likely outcome, however, is that I'll end
 up doing all the work, and I'm sure it will take a lot more than 3-5
 days and will involve a lot of learning.  I'll be happy if I can get
 all of this back out of staging in 6 months. That is an extra 6 months
 (at least) that people will be able to use a mainline kernel on their
 gnubee.

 With respect to your suggestion that "having duplicate drivers is a
 certain no-go", I don't think that is correct.  As an approximate
 counter-point, I'm in the process of cleaning up the
 drivers/staging/lustre filesystem with the hope of eventually moving it
 out of staging.  It had duplicate wait_event() code, duplicate PRNG,
 duplicate workqueues, duplicate resizeable hashtable, duplicate tracing
 infrastructure, and more that I haven't had a chance to look closely at
 yet.  This duplication certainly kept it out of linux/fs/, but has no
 bearing on whether it belong in linux/drivers/staging/.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqq+rQACgkQOeye3VZi
gbk2Pg//as1Du5z35UlPj7WIRrrxfcpszMR6olXn8yjzZVD1x9Oj20xfKvX3F+I0
4UrXPFKUCh8xFjcAPwSU4/dq09j8b63ajGdnz+NNqQtvDCrhHNXgHbRxb7UXO9PB
NQyaR6Yv85zn9fJLsKYeWG2wZ7zADAcS3yH9VxNjpqlouQ6LqtAb0Y9VQX4hXAp1
763kfX3uXbCozsh/KkeUPv7xpaeza3ak4KDx8hqAxGfiH6/ahGTR2XyazSmzHVA/
2KmYP81MegdcNORPBwNAhaOxKYbkDthoPv8o+FA4SCNDiRsPToMiDH6qmxOIjYWV
BvA98dh+mvtfeeiWMsC1x4EGTsERQ7t28BMQQuhpJKJ1zMFtYxShQwLaGKKfAePW
wklHvSoIM9GMU5iwMx9B9iDZsqWSP2XOECBiH7LmK17lqqtW3oxXIdim3ZXipUyr
aSNAhGSc7S6GbDCMPIcZOKklhDDKX2oh6oBtn1bHNs01p8BM0/J8JBnywP4FiUun
m4FNDlmRwSUcE9KwiaBCFyQTGbzY0hxu2m4GpEklJ+M0wiPX2tPa33YysSXGTVUB
6YlI/u8Gx/VJnZYvFTOBzq6r/YjINwLrO71i6o3IaYoeae6DK28020mdnKlmU4N1
ke++Z/QxGAwt690la3F4jf2DYF/nYWWBkJF4wy+CbsJG1oc0Twc=
=5bwv
-----END PGP SIGNATURE-----
--=-=-=--

--===============3721625532213630172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============3721625532213630172==--
