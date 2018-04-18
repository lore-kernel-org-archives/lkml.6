Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/vKCWZQuUSiDanCPRCoTxqdlGTvLY58p4K1BsS3TPaBv0syuX1EhBH7uktF9rZcLalPKKb
ARC-Seal: i=1; a=rsa-sha256; t=1524018557; cv=none;
        d=google.com; s=arc-20160816;
        b=LtLjSA7OT/QjdBiWecEbqr5O9ZZ+QQ7u0I5zm8H/x2H06y53VMpeA+DHO3nWxn3rWJ
         0QJEm9MTNBOtTDfMa8umq968DXFgOY4con/W87zGV0D6dRaLaLaS62iE+PWPM5eA2VcO
         Vowm0pkCp6Ou5HT8DXrCARXsXzq5NBShpV5N8n5zuDCZkTOGbEuCY8tSz1j9l885HBUP
         dd0Z2H8BX2A8WxnIRe8sJmxCrtw7syFZ8RaJLT7z1EJBO/HndTfjTxivh5o0SS92gvEZ
         eFpGLl1RPGbzo3hSuzfNB0eaaJVRDXKGt5X9McRj0mJlnapQu5GtfIjHZuRnLEtSaKEu
         Ltrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=dILz2Exi3rnQFYrwopsa0R+Qhiysg/iYgBCilLNKGfs=;
        b=WyKQ6STf0ozgKSwfWSqIrA7O+lmoAcNRYZxCF3WK8aqC/HiinQ7w3/nlYRakMyQ9ig
         uwCCYgvu7BbevH8Bnxyicpszoeuc9zuX5OxrMeKrG2EKCzZ8HgfPgGlkVzqQRNIJ6L4d
         +AFqWPFjRgaMzc79ccWJcsLAu65sN45vcNE2p2U4Pc3vwBmvXta6v6RFwGJaU8QXAWEP
         /KaM02Pu6BJ6EMCV0WyToMMQ+2h+QptgQXjlkSpMcoHWZGeBJk62wj+vUxh+ZGh1NCP2
         3r7zLt40BHte+IaGZrkBMVGnavm5BdRmU8Ou06K1d9yVFFonRRJry/xzcdB2hfdwhwUj
         THbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>, Patrick Farrell <paf@cray.com>
Date: Wed, 18 Apr 2018 12:29:08 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 1/6] staging: lustre: move stack-check macros to libcfs_debug.h
In-Reply-To: <alpine.LFD.2.21.1804162336220.14398@casper.infradead.org>
References: <152383910760.23409.2327082725637657049.stgit@noble> <152383935730.23409.6748888065027051683.stgit@noble> <alpine.LFD.2.21.1804160438220.16188@casper.infradead.org> <6D3C7935-E7ED-4826-B459-0C4888D6048E@cray.com> <alpine.LFD.2.21.1804162336220.14398@casper.infradead.org>
Message-ID: <877ep5s0wb.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861409409058351?=
X-GMAIL-MSGID: =?utf-8?q?1598049282661847428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16 2018, James Simmons wrote:

>> James,
>>=20
>> If I understand correctly, you're saying you want to be able to build wi=
thout debug support...?  I'm not convinced that building a client without d=
ebug support is interesting or useful.  In fact, I think it would be harmfu=
l, and we shouldn't open up the possibility - this is switchable debug with=
 very low overhead when not actually "on".  It would be really awful to get=
 a problem on a running system and discover there's no debug support - that=
 you can't even enable debug without a reinstall.
>>=20
>> If I've understood you correctly, then I would want to see proof of a si=
gnificant performance cost when debug is built but *off* before agreeing to=
 even exposing this option.  (I know it's a choice they'd have to make, but=
 if it's not really useful with a side order of potentially harmful, we sho=
uldn't even give people the choice.)
>
> I'm not saying add the option today but this is more for the long game.
> While the Intel lustre developers deeply love lustre's debugging=20
> infrastructure I see a future where something better will come along to
> replace it. When that day comes we will have a period where both
> debugging infrastructurs will exist and some deployers of lustre will
> want to turn off the old debugging infrastructure and just use the new.
> That is what I have in mind. A switch to flip between options.

My position on this is that lustre's debugging infrastructure (in
mainline) *will* be changed to use something that the rest of the kernel
can and does use.  Quite possibly that "something" will first be
enhanced so that it is as powerful and useful as what lustre has.
I suspect this will partly be pr_debug(), partly WARN_ON(), partly trace
points.  But I'm not very familiar with tracepoints or with lustre
debugging yet so this is far from certain.
pr_debug() and tracepoints can be compiled out, but only kernel-wide.
There is no reason for lustre to be special there.  WARN_ON() and
BUG_ON() cannot be compiled out, but BUG_ON() must only be used when
proceeding is unarguably worse than crashing the machine.  In recent
years a lot of BUG_ON()s have been removed or changed to warnings.  We
need to maintain that attitude.

I don't like the idea of have two parallel debuging infrastructures that
you can choose between - it encourages confusion and brings no benefits.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrWrXQACgkQOeye3VZi
gbkn5Q//RimpJj8Twvxzyqnt8GZ840xkrOwfML15FXuIh39DnGWxHOzC6y3hjvxo
oemIRum606H/Crz99kF9uVfXkqvD2rkPW0bqRoWJ1UAvfTtfEpbJA6sW4uDBEvQy
N3UBvwJxhSML1Hjvq/rWHA3JuYoFJf2hy4S66hgT8m6oOHcNgLJTTbZCHWj77+Bb
koZvVwt2MeqARRoYaxjY+MG3BbJaq84/RirZYKkMGTDaVE2tlHwRkQpcDrnG5bIl
X+5XLGazYK+lGyrisUBNgOVwIg7UMrDwhOlTNVj9qNwd10FdlCCyR/NWsO9M3C4R
6zLpq6FH7qj8Fmx2mSCUX97uRFpbfIqlVSM88KN+z4XQJMe8Bhhi3u5J8OJPESzM
SZ7ZfmHp5C/DZvo7htLpeW6E7+9TgvzRr0zWtI40ljf6XhmKzwXa0KSQpgBoqiXq
uYgb/MG5QCUtLUlt456VN8cwD22LEqjqjhnvpnYvY0KKhi4dhg/w/SA53pbi2BMr
Zia6axtqyl42aHmbhdIOStUGkSh57ORS38FtyM4grRXbpRpp8rB/4MwWkBOHHod5
lxixvr3b09pzz0WXTWgpo6PeJixM8XF0i27UmWeft0Sml948XbmUoKZ3dxPYPSOS
iXdjk7O4Xwsy5Sld1En10yiN6fg1W8av2NE1Q3e3pAjy0hO12PA=
=3OUa
-----END PGP SIGNATURE-----
--=-=-=--
