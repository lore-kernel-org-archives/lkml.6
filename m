Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4+0XY5KHvaaGq3s4oqg7yPRx/TrtWndImGvsryOA1zAMtGwreunMMAZy9YBoe4SdWkIhBdN
ARC-Seal: i=1; a=rsa-sha256; t=1523821930; cv=none;
        d=google.com; s=arc-20160816;
        b=zlivx3uhKaGjaQQVhRXgEO2BsN1/F+t9vvto509cv8Re8ixT8PhbzC6LMw0ZG1wj2U
         pMFDZqadraqZvrlfXWIeRYCRykBvBheZUQH2K1bVASEIS8uAH+z3BtKHBzF2Zpb7vwjO
         LfQmEWbwg9r8CaZJqIcuuJzgGro1TjwMWS71PYyLUmgkTmX8tZrPqQMq5IB+OojU9Yd2
         noYCtHSUBNSt1GopX73NDIwjzFQ8MMxKXWpdbr87f2VCyOs7u/p1Anil0t+i3DQ6bRcw
         jNGM9jZ3+lJ8KadzScD4DpRDjNFNbHmlss/ZCz8U6kC1sqlynnASIXMzATIgCp4zedhi
         6vag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=DGdJeaBg76GXeUH3laldN8Sbf4WfC0Xjn1M+d0a5hBU=;
        b=KLWSUmWhM2rCe6LvoauCxZe8y7bYCgx3zMNKphPncgek9qndYqRBi/plDKlaE9/xte
         fq+3vSR8C4bcL/rrDVkIe0gMyQWzcCkoRwJCcgRx2Gcr+jYwgWkLtDsAeVjJoVO8EYJx
         w8zAnVqTMJneWqH2o49B8GLWpu+wPGWVr10P/6Fwb6aPG2ylmtPSN/N9Fk4akPrOnYFk
         Ve86IRNvPr+uod68lbSpdKud7aRTgWTiyGXZ8O78jHdXKTxG5gkZNVK+f4ShCrcp27BX
         8QPazSxgDCdH7aDT9VUCsAIQ25jSVpYJ3ftoUrc3bmN8BDTn1hxDORhgxj6bmBo9IJf7
         O2fw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778332176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 20:52:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] staging: iio: Remove ad7746 from staging
Message-ID: <20180415205205.71c87189@archlinux>
In-Reply-To: <e82d25e0d82a55eba1097eab3c679ad5f667e999.camel@perches.com>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-15-git-send-email-hernan@vanguardiasur.com.ar>
	<20180415164351.2666a114@archlinux>
	<e82d25e0d82a55eba1097eab3c679ad5f667e999.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649768754128760?=
X-GMAIL-MSGID: =?utf-8?q?1597843104725406364?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 15 Apr 2018 12:24:23 -0700
Joe Perches <joe@perches.com> wrote:

> On Sun, 2018-04-15 at 16:43 +0100, Jonathan Cameron wrote:
> > On Fri, 13 Apr 2018 13:36:51 -0300
> > Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> >  =20
> > > Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> =20
> >=20
> > Please have a single patch (with move detection turned off) for this an=
d the
> > previous. =20
>=20
> > Allows easy review by showing us the code but doesn't lead to a stage i=
n which
> > two different versions will build and hence probably break bisectiblity=
. =20
>=20
> Moving both files in a single patch is fine but
> move detection off is much harder to review.
>=20
Not in this one case.   Here we want explicitly to review the code,
not the move.   The point is to put the whole driver code in front
of people as part of the proposal to move it out of staging.  If we
leave move detection on then there is a barrier to review as only
someone who has actually applied all the patches will be able to
see what state the driver is in.

Sure, side effect is we loose the check on whether it is a 'pure'
move or not, but that is easy to check when I finally apply the patches.

I haven't come up with a better way of reviewing a staging driver
on the mailing lists in a fashion similar to how we would review
a newly submitted driver.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
