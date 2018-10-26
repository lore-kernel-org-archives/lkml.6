Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A5C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A742520824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ALERENRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A742520824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeJZRIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:08:18 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:9816 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbeJZRIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:08:18 -0400
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id CE4734BB41;
        Fri, 26 Oct 2018 10:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:in-reply-to:mime-version:date:date
        :message-id:from:from:references:subject:subject:received; s=
        mail20150812; t=1540542726; bh=kmD44+uu8i6HsyUu0jEA0Bw5yoyCOWWfH
        IS4yOlYBgI=; b=ALERENRFscVBNtSe1UucOnVdDmAa4zl3HVaCdWNAd2sNQp45P
        v7QJbKqJWMpf4xCUvvxcGpsQJz/qHEVJ82DjUE/mzgVJ5+93xRuEKZUfHHAoSpwZ
        i5WWu/hSeYOx0hoaVueP3nTi55le88sR5a19lEqQKne3E+uykpIDj2EKiyeisvXf
        WTuTvMh+pJEX02nkKjpYiQ+1DkTOXVHpU+6mhVsLSB2lNd7C/SDfc45c+SQqjwn7
        Fyv0MQMKeabR+UJ/CzRL2xE1v+gxUYztXnj/vL19OPyZb8RbCLI0DJ82YUy+uM3i
        746mBshvB+3lRO+wPnFZSQJhQu4L3ZfL+gTZg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id J17Jcni57AnU; Fri, 26 Oct 2018 10:32:06 +0200 (CEST)
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording,
 and add an interpretation document
To:     NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name> <2341648.lzjnUGKk1z@siriux>
 <877ei56579.fsf@notabene.neil.brown.name>
From:   Rainer Fiebig <jrf@mailbox.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jrf@mailbox.org; keydata=
 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
 6/dT7HxuwnVIkER8kg==
Message-ID: <ffeb597c-9ca2-cf21-ba52-2146ab20c83a@mailbox.org>
Date:   Fri, 26 Oct 2018 10:33:16 +0200
MIME-Version: 1.0
In-Reply-To: <877ei56579.fsf@notabene.neil.brown.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mk6KZKkkzDnuNF6O7Lw1QQ6XNUiNVkUc0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mk6KZKkkzDnuNF6O7Lw1QQ6XNUiNVkUc0
Content-Type: multipart/mixed; boundary="adwNx6T1iwfkUPnjNTpDEaR3eyN6EMFAv";
 protected-headers="v1"
From: Rainer Fiebig <jrf@mailbox.org>
To: NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ksummit-discuss@lists.linuxfoundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>,
 Chris Mason <clm@fb.com>, Mishi Choudhary <mishi@linux.com>
Message-ID: <ffeb597c-9ca2-cf21-ba52-2146ab20c83a@mailbox.org>
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording,
 and add an interpretation document
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name> <2341648.lzjnUGKk1z@siriux>
 <877ei56579.fsf@notabene.neil.brown.name>
In-Reply-To: <877ei56579.fsf@notabene.neil.brown.name>

--adwNx6T1iwfkUPnjNTpDEaR3eyN6EMFAv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

NeilBrown schrieb:
> On Thu, Oct 25 2018, Rainer Fiebig wrote:
>=20
>> Am Montag, 22. Oktober 2018, 08:20:11 schrieb NeilBrown:
>>> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
>>>> Hi all,
>>>>
>>>> As everyone knows by now, we added a new Code of Conduct to the kern=
el
>>>> tree a few weeks ago.
>>>
>>> I wanted to stay detached from all this, but as remaining (publicly)
>>> silent might be seen (publicly) as acquiescing, I hereby declare that=
:
>>>    I reject, as illegitimate, this Code and the process by
>>>    which it is being "developed".
>>>
>>> It is clear from the surrounding discussions that this is well outsid=
e our
>>> core competencies.  It will be flawed, it isn't what we need.
>>>
>>> I call on any other community members who reject this process to say =
so,
>>> not to remain silent.
>>> #Iobject
>>>
>>> We don't need a "Code of Conduct" nearly as much as we need "Leadersh=
ip
>>> in conduct".  Without the leadership, any code looks like a joke.
>>>
>> [...]
>> =20
>>> I call on you, Greg:
>>>  - to abandon this divisive attempt to impose a "Code of Conduct"
>>>  - to revert 8a104f8b5867c68
>>
>> Yes but this seems increasingly unlikely now. However, there may be an=
=20
>> alternative.
>>
>> Jugding by the release-message for 4.19, some people here are fans of =

>> Monty Python's. No wonder - as those guys are famous for being unrelen=
ting=20
>> supporters of Political Correctness.
>>
>> So one would be on the safe side if one just supplemented "Our Pledge"=
=20
>> with this:
>>
>> 	"Everybody has the right to be offended."
>>
>> I think, John Cleese would also welcome this.[1]
>>
>> What do you think?
>=20
> I do think that giving certain rights to the community is a good thing:=

> - the right to tell anyone that their speech is hurtful
> - the right to (patch) review by a third party.
>=20
> I don't think the right to be offended really needs to be given.
> Yes, I know it is a joke and I do like Monty Python.  I just don't thin=
k
> it is particular helpful in this context. Maybe I missed something.

Of course it's a joke and iirc it was indeed John Cleese who made it. But=
 he
made it for a reason, out of concern. It has a serious core.

The question is: what *is* helpful in this matter?

Just saying "this is not helpful" isn't helpful either. It's a well-known=

killer-phrase that has been used ad nauseam in this discussion. But an
alternative is never given. And thus it's just an other way of saying
"Eat it. And shut tf up!"

Not even *constructive* criticism is helpful. AFAIK I'm the only one here=
 who
came up with a *complete* alternative - ignored. Others provided patches =
for
certain sections - ignored. Data that indicate that this may be detriment=
al to
Linux - ignored. Almost anything that was provided by me or others - igno=
red.

What kind of community or attitude is this? This feels more like "The Wal=
l" or
North Korea than an Open-Source-project.

And what beat everything was to misuse famously politically *in*correct M=
onty
Python to malign criticism of this Political-Correctness-monster. The
"People's Front" - message will forever be a prominent exhibit in "Monty
Python's Hall of Shame". And the author should be banned from laughing ab=
out
MP-sketches until he recants. Perhaps one should also report this inciden=
t to
the "Ministry of Silly CoCs". ;)

> For myself, I relinquish my right to be offended.  I just don't do it.
> It doesn't seem to be worth the effort.

I don't. John Cleese is a smart guy. And he has a point.


OK, thanks for your reply! But I think it's time for me to move on. "Cut =
your
losses", as they say.


Good luck and regards!

Rainer Fiebig




--adwNx6T1iwfkUPnjNTpDEaR3eyN6EMFAv--

--mk6KZKkkzDnuNF6O7Lw1QQ6XNUiNVkUc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6yx5PjBNuGB2qJXG8OH3JiWK+PUFAlvS0V0ACgkQ8OH3JiWK
+PVFSBAApW00InjnyXN1MaU8ouqtamUmhz7OrwJHxa4HYzTJZvn6BpX6KY6NcfZ9
ygAXdOnvrp9mq6WYy9dydV0VomeIT86tfFK15amHyQuTTgaw3M646nyO0wPmKV9F
4txlF8nlLo+vpIC8vOx8GhpJ3+EFMMUDKBDByhQ83WtF6WpkdP0KXEwwieWPnFG4
8Q4UOxOVJZHD2SahWzvMmwLaBHQT2pNXcjM5VM6VqoHNAP9Tgn9c0eXkCctENiyN
9f8w223r6FhyNag4eXVF3Of8ja6aBqdr3HbKiKIcTV/PzHmA2QEMy7leddTw/O9/
epfQLfbeAOea9BDG7IXIWSUBlKMp0BTEygNqYf8GwuIHSMD2AHRWyXbIydpPNrbj
w4aUYgb64wxMDL6ei3aaIhdr9C1+oT5ZwuimteL6C7EHbAwx5WPkJJ2HIGB8g7wd
/pLAi1V1O6DPkkxtnbFJn49GDoS+fs8WnIOnlJmcucWTXgHHyAxEpHNL4r0vBfQD
R+29Czy8W2hINC/jT5hIhuwFhsIexh1bAzVQLTD67XDFHYXe1MHEyAA25kU/gH9P
wQOah4Vtvh1sKyDtPdHeE9eEKG1BaG2mCQJmgBUcyEOFvycLwnS5n3Q6D1WK73Sr
rblas5W9uOBV+De0nVAUgiPOpXUCVBMpTpKfDknidFwB78rLpr4=
=GsF/
-----END PGP SIGNATURE-----

--mk6KZKkkzDnuNF6O7Lw1QQ6XNUiNVkUc0--
