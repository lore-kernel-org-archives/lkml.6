Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1731180-1526348297-2-6073342790882554611
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526348296; b=maPiAwXc/Ncg6v/yoIigImyfzuDU0etx9hbE6AY/pc2B9lIGCB
    V09bo8GEm+bmjUz8lo05Oi9CjoJqlcryX0BZKifbJUwvHbEb0LSh1zmaQEmYaCU9
    xB1wnsNbYQWBWnTRobwa2DHWiKaAgD/R2YrzSmA2DoJySpzcfXH68eEQ4ssWLTuP
    isORIUmylwjy0qWJnAUb4r1wQ8Logqu+1iQD5CBCNBOyknnQf40lVQoIEw1tyi40
    84GJ+9a6eWRetXKqtjzrw122R3nt1PDZ7Ag0QApnpNe4O6LgnobveQUq4B8xQaaI
    /hKi+NJYcmEmzm/m5o7HMvR4zTmfGbPq+rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1526348296; bh=FvozX8pUAG1uqxDZTarkob/PRg2KA9d
    X32QDiEVZflw=; b=PV4Fc8lcvOjAEJIfrnUszyXAAXI9Bpz2kZHYgrBj1zVVFGg
    3Rv9QWjBVS8iAp3+UbwftC9TjECmdC+m8uak+Sh5jM9Idvh9dCcRTd7ZcSigzQfn
    Gb3lCm2YUnhHj0/HZi2pjvEQZhDVdXcGWlT0REp19RkyIuuyZPaL4rEdfIh7zUVu
    E2kxcSyJvLDsgm+F0UNZNSSQRSWfAPRz6HPCVGSiLlauNsFoaFbzlN1tWUpzWOS+
    ehqTqyesxFOJF58KjZTYRtS9NEAO2LhEJet9r/8CHtiMgN26H3fvXkRRrHAeA9Av
    i9P1/M3WSqJVn2rOriHJ/A5HzY2ouwZU4odDpaA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=suse.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=suse.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ+G4J50xgA3kVoBGURNza00NflkT0Ptqh4cMdD8H02IeMpO4ZdwgbsQ+cY4tlRiCDCVRYqdXEXP80r66PZ2LeR+J5sjJxR79cVInPfW+Tn9F9XCvaOq
    0iNVEsu/CcCSPsz1s3eeIANIZnJ8mT3xftzhCsz60f2RnYiFpXlGNt/eB+ITKRUP5cWBJXYwuqR9rRlbNlTkTu+PH87vvIvtmyP2uhaP0z4EzQTSK5X2Qz/C
    9IcGoThYhYKGQbACmrHwbQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=1oJP67jkp3AA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=QyXUC8HyAAAA:8
    a=axGCdCNIJr2STHn6GGMA:9 a=WI3ZHISeKM_Q-7cycVcA:9 a=ONNS8QRKHyMA:10
    a=DDOyTI_5AAAA:8 a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>
Date: Tue, 15 May 2018 11:37:56 +1000
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to no
 wait mode
In-Reply-To: <alpine.LFD.2.21.1805150133430.576@casper.infradead.org>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
 <876044fcgg.fsf@notabene.neil.brown.name>
 <alpine.LFD.2.21.1805150133430.576@casper.infradead.org>
Message-ID: <87efid7l6z.fsf@notabene.neil.brown.name>
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
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>,
 Lai Siyao <lai.siyao@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: multipart/mixed; boundary="===============6170230028288820310=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============6170230028288820310==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 15 2018, James Simmons wrote:

>> On Wed, May 02 2018, James Simmons wrote:
>>=20
>> > From: Lai Siyao <lai.siyao@intel.com>
>> >
>> > Currently we set LU_OBJECT_HEARD_BANSHEE on object when we want
>> > to remove object from cache, but this may lead to deadlock, because
>> > when other process lookup such object, it needs to wait for this
>> > object until release (done at last refcount put), while that process
>> > maybe already hold an LDLM lock.
>> >
>> > Now that current code can handle dying object correctly, we can just
>> > return such object in lookup, thus the above deadlock can be avoided.
>>=20
>> I think one of the reasons that I didn't apply this to mainline myself
>> is that "Now that" comment.  When is the "now" that it is referring to?
>> Are were sure that all code in mainline "can handle dying objects
>> correctly"??
>
> So I talked to Lai and he posted the LU-9049 ticket what patches need to
> land before this one. Only one patch is of concern and its for LU-9203
> which doesn't apply to the staging tree since we don't have the LNet SMP
> updates in our tree. I saved notes about making sure LU-9203 lands=20
> together with the future LNet SMP changes. As it stands it is safe to
> land to staging.

Thanks a lot for looking into this.  Nice to have the safety of this
change confirmed.

What do you think of:

>> > @@ -713,36 +691,46 @@ struct lu_object *lu_object_find_at(const struct=
 lu_env *env,
>> >  	 * It is unnecessary to perform lookup-alloc-lookup-insert, instead,
>> >  	 * just alloc and insert directly.
>> >  	 *
>> > +	 * If dying object is found during index search, add @waiter to the
>> > +	 * site wait-queue and return ERR_PTR(-EAGAIN).
>>=20
>> It seems odd to add this comment here, when it seems to describe code
>> that is being removed.
>> I can see that this comment is added by the upstream patch
>> Commit: fa14bdf6b648 ("LU-9049 obdclass: change object lookup to no wait=
 mode")
>> but I cannot see what it refers to.
>>=20

??

Am I misunderstanding something, or is that comment wrong?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlr6OfQACgkQOeye3VZi
gbl7RA//VDzBj1UncUhWv/9vthIv2Vm46k/h5SN4iAmnnIaVRNVWcKkGyoCj62hQ
e1Q1fJ83Xbe2xkEWiuYhjoKd8fJWsG1eaxxlNI6HWEEv1BxbmHyhjYIQ3RbaIapA
wf9GIU2q21CMUvLsGlrLb+yN9Upa10Vyb9LNKqenLq9C9yxKBHy12F7d0XYYUQ6H
js8IjlUWsWO8NgOKzb4WnDbHW3iKIpHISpxaLHvkmA8oLm8dkC6NqLyLkDa1n3Fz
lyZrxeMyx/caZf4ePeyendU4zBnnIuKbTU4GhnAyPaYVfRfrXxqI0JZqje5XxM/y
J+rZ/5Uxhgg7rH+q3Y5+Xeadn9MhbZRxbGWJn//S6IA8Y1lEjRbrU/VbTQrBu2kN
E3xuYtX71oaJOf9iwnBl5oCs81LT7qVNYBUV4cbawJ9EPVVKVpDx5G6jBWH0utyk
5/eGdTCKpjrxf+f25zXfS47KQL/7tPwuCHyJSocHrnE7DMwE/FEgbDu/KTjIP0zG
wUROiDsA/x1oKlKBMTwBnLPqmxL2CSkCZq5ptsf+iuUZqBboE6dPX4Yqt8K5YFJc
h52wPp50BrFaMs6lsmhPdO7wYBFIAQtvVVFvA8Puyc/8sTma9PZoWW/NrJu3n9RJ
AVSnSD75SWaVrnfrR+tZKYF31rjG0qJAhx3FJjV5MY/k1N+fqK0=
=8ybm
-----END PGP SIGNATURE-----
--=-=-=--

--===============6170230028288820310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============6170230028288820310==--
