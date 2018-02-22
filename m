Return-Path: <outreachy-kernel+bncBCK63FO5TUHRBEWCXPKAKGQEAXXS5UI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519313171; cv=pass;
        d=google.com; s=arc-20160816;
        b=pStH4LUpw9fnuNlA+rTWEtWAl8fJ9pSx62dJa1CO2sAKDFm7GxBNpIAQkfXm7f2Cfd
         ttNzHwlnclWfW2wOEInSyGGL3Xl2zFej6CMEmFc50ENqlQIj188L8rbQdjcbjfFD3Cee
         cGU85Q4v1jdNZpzSfp1jvdxUQGsYYO9Uk+mWCmQp85SfNMmdfZrlVTR0NxkpRo38h811
         lCk+A7strYszTNNN1G+bWWidc0oNKTwaEFAghu14k9hj1M5XfNXWy7cKLNsYsaKb7iQY
         ZLpQ02YyM+93M6baH04Ly7T1rC1NQdmd6yQv9Vuy8eo+8kuRG9XqgGMRk2ANuoUE6RHk
         vuQQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=zuAXfZjWAoPy7Rg+BRbSauLDei1JFX7RBt5hIGJIiUs=;
        b=fffpq7O09GT+fw1pcitkPr/+deARUiiz+M0kGagdVyb18mGCK1SIolEl2Q4W/5UkDk
         u573UkG3mWVBtwSkGf1fxONEyoXmlxNTMJ/+e1i83J3ex7KsFyKxoQTUiBQyB3vW9fm+
         q+vrB/VFSpyFtoR/pGvMcQ7RA9PHsozQF8UL1Fhxa43l2hIGvSeaDmztNBR21SZ2M8mo
         V1cWIKhyMMDw5mulWAaTz2gplQcMHho1SjDVzw6+CGiesAMNyvfD4PTxFYdCoFg6g7xa
         58ilnLPcNKEqxqmR9fmR/zZF/M945z64/FwG5/s2kAa6b3EkG81HuQk5pIBy76DbtvAA
         oGPQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=iLD15OhB;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbewcxpkakgqeaxxs5ui@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBEWCXPKAKGQEAXXS5UI@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=iLD15OhB;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbewcxpkakgqeaxxs5ui@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBEWCXPKAKGQEAXXS5UI@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519313170; cv=pass;
        d=google.com; s=arc-20160816;
        b=S/UNUL7Koww+JmfbW8pT5ZBuym2l9apYZ21WSbJqn1la1su//wLbTX4cSWrezb6Dr3
         0jdGQnpTZVpnJFbg4xf9HPjYihCKOLJ79ynpVGUwmoVIwkuBbRP3/KyfD+I00vH4beUC
         KjxtbdXJhfWxjQflJ2uulB0FiMYWXX2UdqFi6ZzIdFHxMWYUoScCcAlAkumwBdkBJSvb
         Nlg28PrlLYndi29P9b22axvb/T78KZTcWiudN47grARM0TUPc4fxyW3n6Giuq6wz1Bj8
         cVeVjgIk7gYJf2xLh33+yiMbRusbirevVukcpEf18yXW17k3xG/J8k5mTRK/xHKlCcYx
         uVtg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=zuAXfZjWAoPy7Rg+BRbSauLDei1JFX7RBt5hIGJIiUs=;
        b=wpbAfyp8A0YLqGEYyer0e9pHjZBrBsy90CqOuLc65TOYCATKYKK/uVqawgcclKX2iX
         viA3rij49DlYRxI5O7wNRHxSfc8ZHu0TyiSWU9vu1eCEiz5/Dgyi6mdiakrcul2Di+8C
         oQqbEIgwE0vPP+prk3AvOO5zQQYZTVm5+NCq+1/fNUh5q+f1VE8egprHbZlPHSjVrwuT
         XaHokR8QD8M7PoepLMg+QDn56566p61csh2y0v024Rx0L0CYhxX0nWRGVVxHNlHFtYJc
         JOJEvuGeQeH/NdRmJIw7/cpsfK5cgMt5S5cPiTKhwCePj8WEHqcoUuG8xeJ8Y+mOhYQo
         89xw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x224onW4iyhs9rHFLmLEuaj3v0vqaM6k8ICK7rlpkQweendGDcssjgfAUz6ZwFgxEJKjiOx080Q==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519313170; cv=none;
        d=google.com; s=arc-20160816;
        b=D3sdyWD6AOwfgYf5vJUN3+6P4E7XK3tP4Azb8MiCY7r6glzi8IeUQB2gOkXOGm5ZsK
         ixQj458BJ+1nX9NDsA1eqbnxuxu0FOWwGICsLZq2FE5ThFr56s9qmMrM+sUKXAE2qHxY
         +nPPKt93YOllFg5YTcq6HBdfC2VeK1/plVprDHPp2uLLDDTVBwyXtRCZC9IKq3Q98N0z
         SUXVo4XVu2KeasG+BocgZOhOun+YbTlqN7hZGHNUi/ZV6aKbWjxc/D/ZqQaWKxYjZ5oS
         nnhSOb+Mgo3e50O2sNL4OnpGzjMVy/OiL4AfdqnWHc0VbyLH6xX6r5kJ2qNgi1FM69js
         OcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=B4Kl0+c89+aFozvqb7k61iNr0+iT253BYVhcimLWW3Y=;
        b=slDa11P83aZWadu4d+LMz3cqndjY80w/Nbwlnt0kwzzZPBwzerbuZ7SUQMsHC1KW90
         21S2VYladctsZbYofA+ZFVbveUsn2+ZtIzzkQuUBivb/5WWlGFhed7duZdXpk0Vfk8qU
         OOdOT/JFjOEj95eR9cW4+nA4YVBVVvs0y063rBaakvenNj/vdlNjbryGBLePEii2mWDY
         QO0jvAtohtv6cRUkPJ01hrJc+cgGkiLFHoFZanf57cV3Qi6VXfo0G9d+e6ZeM4fPWbAu
         Lvjd7LYc7KOAB6VFoK4ZwarRfjvWO4yR7bw0LbX1FkVSKIa9WZ+3zIWjqMjObaBGGvT4
         zXFw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Thu, 22 Feb 2018 16:25:58 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, boris.brezillon@free-electrons.com,
 dwmw2@infradead.org, computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v3] mtd: nand: Replace printk()
 with appropriate pr_*() macro
Message-ID: <20180222162558.3f5cfcad@bbrezillon>
In-Reply-To: <1519310758.2359.3.camel@gmail.com>
References: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
	<2093598.TLbMltDcSo@blindfold>
	<1519310758.2359.3.camel@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Original-Sender: boris.brezillon@bootlin.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as
 permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593106783204445682?=
X-GMAIL-MSGID: =?utf-8?q?1593115327650328243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018 20:15:58 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On Thu, 2018-02-22 at 15:30 +0100, Richard Weinberger wrote:
> > Am Donnerstag, 22. Februar 2018, 14:10:14 CET schrieb Shreeya Patel: =
=20
> > >=20
> > > @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct
> > > mtd_info
> > > *mtd) break;
> > > =C2=A0	}
> > > =C2=A0	doc->chips_per_floor =3D i;
> > > -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> > > +	pr_debug("Detected %d chips per floor.\n", i); =20
> > <bike-shedding>
> >=20
> > You are aware of the fact that printk(KERN_DEBUG and pr_debug() are
> > not=C2=A0
> > equivalent?
> > Not a big deal, just want to make sure that you understand what you
> > are doing.=C2=A0 =20
>=20
> Actually pr_debug() shouldn't be used here.
>=20
> We usually don't prefer pr_debug for drivers, instead we use dev_dbg.
> But as Boris told me that it will be better to first having changed all
> printks to pr_*() macro and then think about dev_*() macros.

BTW, I see a bunch of remaining printks when I do 'git grep printk
drivers/mtd/nand', basically all those that don't have a
KERN_<LOGLEVEL> in it. I know your commit log explicitly says that only
printks embedding a log level are converted to pr_xxx(), but it's
probably worth patching those printks as well (choosing the appropriate
log level between info, err and warn and use pr_xxx() helpers).
This should be done in a separate patch of course.

>=20
> > :-)
> >=20
> > </bike-shedding>
> >=20
> > Thanks,
> > //richard =20



--=20
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/20180222162558.3f5cfcad%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
