Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx483qkPP1nhIUbRW8tpMeNBOP2EMvNENNiLs/wIW5b7b0WK/0AiuhZaXhhzeMnmZKvK7HKGq
ARC-Seal: i=1; a=rsa-sha256; t=1524018729; cv=none;
        d=google.com; s=arc-20160816;
        b=MPKSuV3ZynxQaQyaaPniNF1WXzXXqXLiKRrIBEbU8DbwlLO76BA4QSNOJXAs8zY9Cl
         KgsRN8puk2fiiNuk9K1bkik3Aw1U/MM6oPfjQGtziq5UrpUiK/om65tGzl0SjLSfvpq9
         SAVHEprpeN9//nEr1zIBPH31l5KzRZdTl3qiyyJ9DR8TItYAXLfbMtJOWuMKBTt36jZN
         sqV2wPuFy/JfId5A6lIqFk6akgcWjpcXP2FvqHq+EwELkBKatCq08nCG5YzF0nvLxvia
         CVEvOwJVn50CgHD0qzYt2MTutHM7fxSEZ/8uAqXBiH65cI0t6gNCbcmW3lDKTK9bX4Wy
         zb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=CwzHYAUo9Bm6JScKSGVRkXDSXw7F2vHkjMFm1OfzeDY=;
        b=QOw8c9YLHSR8F6uVvE6CX7ID9ErxsEnXY09yLEwtIRT/0WF1P8/JGczf1t6CqvAZ3W
         osrohM+Dx883/0rvRb+7Vh/GXikoNrVs8chZ19RviGKC7htnnY4qxCKQNZCWRSyArUp4
         QuZVQSBRzv3X5xjqufP/oqVB1UBpENUMvVnoTBN5Mqs6aeYUQZL6P+XgElxqIe/1wbhZ
         pAWC6/p3BCVrWAKct7xY1f17heVgMM0iExTMmrdW0JiTE2XjEHuHs5y/nEYZ8ClGSGU6
         9KA8fa3E4akR0C0yawa5pYCzEu1Pqkh8jjpG7NIfcwbO5ZvyEiTFcLzMQCWvtW7ouwD0
         hR+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>
Date: Wed, 18 Apr 2018 12:32:01 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Dilger <andreas.dilger@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 2/6] staging: lustre: remove libcfs/linux/libcfs.h
In-Reply-To: <alpine.LFD.2.21.1804160431550.16188@casper.infradead.org>
References: <152383910760.23409.2327082725637657049.stgit@noble> <152383935734.23409.11654775387996961581.stgit@noble> <alpine.LFD.2.21.1804160431550.16188@casper.infradead.org>
Message-ID: <874lk9s0ri.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861416639795430?=
X-GMAIL-MSGID: =?utf-8?q?1598049463086950700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16 2018, James Simmons wrote:

>> This include file is only included in one place,
>> and only contains a list of other include directives.
>> So just move all those to the place where this file
>> is included, and discard the file.
>>=20
>> One include directive uses a local name ("linux-cpu.h"), so
>> that needs to be given a proper path.
>>=20
>> Probably many of these should be remove from here, and moved to
>> just the files that need them.
>
> Nak. Dumping all the extra headers from linux/libcfs.h to libcfs.h is
> the wrong approach. The one header, libcfs.h, to be the only header
> in all lustre files is the wrong approach. I have been looking to
> unroll that mess. I have patch that I need to polish you that I can
> submit.

I think we both have the same goal - maybe just different paths to get
there.  If you have something nearly ready to submit, I'm happy to wait
for it, then proceed on top of it.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrWriEACgkQOeye3VZi
gbmYXA//SzzRCt5Akx9xfIAKtqygbbQw2MoCPyG+Ad1CPAj5qx2trBlIVuEOAYm9
5541vj9pi5PRSNg7m9VJBQ3tAEV8vcl9Uvi4lYUAnbDulgagTs7za5DCkd20Kcpb
xuNM8OKFSCprN1kXPaUorwzjGAxdzVkywb7DR4uX+zUy/7qLgJpbKnDFs11ATCMB
kt8Ug30GPXEE71nt/AciVolMcJKWnyEsUTCo1cqdKuG3XlWR1eDpRxwdS/6N6xQT
qJAzO2Kjb//dFVhmGILSM3L5k3AsNG/v07riJsjtZBtPROkKbeTnW6/iCRz5x0Yp
5HqDfrKU7k4ehQeTUGoTYPL1JFqQuEOyT7jq6FmK4PvM5AkugpuMRfGj2oLi5Ie3
TyEw20NYKPzX1H3m0nTGKdUKb/6lgEahPfEkONNPKtnCEbqZOzgLop6ydy3kPxca
jqmmmDkNB7HSrRxg+m6iW3sgT4bU2ZUQkSVs34NqE4jo7/2mxuW9AC6p/IwSpmPB
gWbCw/SIFzWBkNwyN8fn0PSxkLIiRmBBZiKTSo1xIaXCdBuZEXzlzG56SKUcvBId
+tbBZ1bo9P6F0i9LkpmFxyiv8623R04PI7kONgH4ln/zUQHwOwbbx6G8HoHkLUt7
gm9SZy5fCASzyKjwbNJqUnBvRlPqI07EtqUZvXO5vCPzq1kSw+k=
=cvrd
-----END PGP SIGNATURE-----
--=-=-=--
