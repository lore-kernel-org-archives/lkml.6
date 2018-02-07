Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AH8x225JADCEXY8F4XXiQlcQ6E5SQqyCvNXZGv2nO3us9z9tIl+neeskO541BiQ0gNcOug7qseaJ
ARC-Seal: i=1; a=rsa-sha256; t=1518005849; cv=none;
        d=google.com; s=arc-20160816;
        b=SNVvvM8i7q4sOnTwXG4HKSjEOL8IV5x9YR19lAX0xBPzig9mB/t6jF0HlKiZbmJCq7
         6hDxmUeOQZrSOnH1uXvmQ8G1yAMM022OYL4Wf1mP59zKQ3uAqobG6Jx78qLuXmEqzpXL
         0Ss6ZTolCaqgbutPx8pj380A/cyodIRzHDkIvPJXTHz5cysTB01GqCMvvbonnDki+zT2
         0GpOQb2Gb1c21B4RLkz+68WYVtpodH6fOjkYUnTeRQwwuKWYMpe4DiEgN77Gt+YIKAGy
         P+WjztTGunVsiQblDc9lcFEnmGpKS6OOQ3mKkCyxikVY67oJDuHUuIyaMyPLgECqjDmv
         142A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:subject:cc:to:from:date:arc-authentication-results;
        bh=rfzE0+NIbwOdLJcF18W1eVgNGACILKKRP8WSxcGkXc0=;
        b=h1QBlwZdCZIYO9krO3J7zFhNC20aEMVnaZ1WdF0ksIuoK9eHPBrwmHFEZRZJbQkfza
         pzOUWBIVu2MmpdyMtITUmhPX0fGR9Yg3xILbyH4TXnlkUOx03mM92w6IMqe+YySR7lMx
         4WM406802WK06drBwqiX/v8GL+2EiamWTOHDGpiLOc7lcK91G6z9d8kqQz4PFJsOyRqK
         y2VNxHXH4Ur6duFEjrueJ7K+LJJpRX2NUg/EuQUCt9acnooxZdUkP3/503/1pr3CfHYA
         wo998Vhk62uj6NhK06QWEi9HF60bsUgynnJKpitm1mQbuumOjlEp2txEo+q0/VVLSiw2
         vaxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Date: Wed, 7 Feb 2018 13:17:19 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck
 <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Dominik
 Brodowski <linux@dominikbrodowski.net>,
        Alan Cox
 <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
In-Reply-To: <1518005275.3677.112.camel@infradead.org>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
	<1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
	<20180207100726.GB31392@amd>
	<1518005275.3677.112.camel@infradead.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 18020712-0012-0000-0000-000005AC4A7C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020712-0013-0000-0000-00001928018C
Message-Id: <20180207131719.4aeb316e@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724559737732044?=
X-GMAIL-MSGID: =?utf-8?q?1591744501884839321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 07 Feb 2018 12:07:55 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> On Wed, 2018-02-07 at 11:07 +0100, Pavel Machek wrote:
> > This is really unfortunate naming of kernel option.
> >=20
> > spectre_v2=3Doff sounds like we are turning the "bug" off, but i somehow
> > suspect you are turning the bug _workaround_ off. =20
>=20
> That's consistent with what we have on x86.
>=20
> > > +ifdef CONFIG_EXPOLINE
> > > +=C2=A0=C2=A0ifeq ($(call cc-option-yn,$(CC_FLAGS_MARCH) -mindirect-b=
ranch=3Dthunk),y)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0CC_FLAGS_EXPOLINE :=3D -mindirect-branch=3Dt=
hunk
> > > +=C2=A0=C2=A0=C2=A0=C2=A0CC_FLAGS_EXPOLINE +=3D -mfunction-return=3Dt=
hunk
> > > +=C2=A0=C2=A0=C2=A0=C2=A0CC_FLAGS_EXPOLINE +=3D -mindirect-branch-tab=
le
> > > +=C2=A0=C2=A0=C2=A0=C2=A0export CC_FLAGS_EXPOLINE
> > > +=C2=A0=C2=A0=C2=A0=C2=A0cflags-y +=3D $(CC_FLAGS_EXPOLINE)
> > > +=C2=A0=C2=A0else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0$(warning "Your gcc lacks the -mindirect-bra=
nch=3D option")
> > > +=C2=A0=C2=A0endif
> > > +endif =20
>=20
> That isn't, though. Linus asked us to drop the $(warning) part.
>=20
> ... and then spent a week building with a non-retpoline compiler and
> not noticing, so he might have changed his mind ;)

I found the warning to have some value, it helps for the case where my
fingers are faster than my brain and I type "make" instead of "smake"
which uses the alternative compiler with the required support.

@Linus: do you want a warning or prefer not to have one ?

--=20
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
