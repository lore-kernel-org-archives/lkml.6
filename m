Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx49anDQCfzpRQETq3gIl/WLvdLh5Ps4Dvu5LkngVhHvtoNiXfch4/gZgvFtAQYGNBeKk4Yla
ARC-Seal: i=1; a=rsa-sha256; t=1522879228; cv=none;
        d=google.com; s=arc-20160816;
        b=Wp+FXiWe/VzQ11BaBw4ICNfEScpJE4+WDi1ACSUcz3GQWlJjG1GThuV6PXP+od96bR
         cwMmWOo+etR8+F+U52FXsJ0FTFUIDAHYR2Wl4gyvbK8/h1IPKWe2y4M+OSz47L+H5LPY
         UPqXG3HkLc9c3SuNXkZvICCoJWcseqvNxle7Jb2dvRF6+H4/SwOY1/++J1oag6JqaVFH
         Rqh4eG6F7j9NhW4f8uNm9MmIOaE4kj3ffOWqsCbsEIEp7fUemifO5fxpcSBBjEr5OqqG
         8oZzynlLK++6qLUHXX8dLVhLkbkZQngQ/hgwqQPkR5bcrYzQIgJXUAH6I6PbzPJcE0wY
         5QVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=e2A6sOoyOxxFHiDhTfq4cpqzXjiH7RzPkWoQ3XwUQXc=;
        b=X2deBZp7AsbvvvCT6Xa2KMxrtbuuzBAN5hnaM0MFFp8/dB3G0DfXLKaf7wJ9ZLoTse
         YuMGxxlY/UtyN3e7yPMt9N7V1h+jKxPRKXWkHjdqAYISLWGbd7uy0Lc3NRmxXHukbhYB
         SI86DTkXOEPXA0iQJH8E3qzWL9/gtUFoaapQaEYFWJPM9bzNLEQFyC8iKbqpMNxS+OYQ
         FBDqLRYQZlzULqf1HNwP11DUgUU+RL9VzM0Cx4P3OxHferwCkFzONLTuUM6NPBwGMY4W
         h+Oe5sjc/jGEOJlpWEWrsxXbUmZMuXfebuUAM5EZ68tArKAOyWCUibC6XcrvdEqb19mY
         iW7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: "Dilger\, Andreas" <andreas.dilger@intel.com>
Date: Thu, 05 Apr 2018 08:00:14 +1000
Cc: James Simmons <jsimmons@infradead.org>, "Drokin\, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 11/17] staging: lustre: libcfs: discard cfs_time_shift().
In-Reply-To: <CB90FEDF-3F67-46A7-8EC3-ABC788E7978C@intel.com>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760863.27689.4681198496926109808.stgit@noble> <alpine.LFD.2.21.1803302001440.9681@casper.infradead.org> <0B6A147C-7E98-4B00-AF32-AF8843484CF9@intel.com> <87muyl1bzs.fsf@notabene.neil.brown.name> <CB90FEDF-3F67-46A7-8EC3-ABC788E7978C@intel.com>
Message-ID: <87tvsqy6mp.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244842312934549?=
X-GMAIL-MSGID: =?utf-8?q?1596854609358800526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04 2018, Dilger, Andreas wrote:

> On Apr 2, 2018, at 16:26, NeilBrown <neilb@suse.com> wrote:
>> On Mon, Apr 02 2018, Dilger, Andreas wrote:
>>> On Mar 30, 2018, at 13:02, James Simmons <jsimmons@infradead.org> wrote:
>>>>> This function simply multiplies by HZ and adds jiffies.
>>>>> This is simple enough to be opencoded, and doing so
>>>>> makes the code easier to read.
>>>>>=20
>>>>> Same for cfs_time_shift_64()
>>>>=20
>>>> Reviewed-by: James Simmons <jsimmons@infradead.org>
>>>=20
>>> Hmm, I thought we were trying to get rid of direct HZ usage in modules,
>>> because of tickless systems, and move to e.g. msecs_to_jiffies() or sim=
ilar?
>>=20
>> Are we?  I hadn't heard but I could easily have missed it.
>> Documentation/scheduler/completion.txt does say
>>=20
>>    Timeouts are preferably calculated with
>>    msecs_to_jiffies() or usecs_to_jiffies().
>>=20
>> but is isn't clear what they are preferred to.  Do you remember where
>> you heard? or have a reference?
>
> I thought the goal was to avoid hard-coding the HZ value so that kernels
> could have variable clock rates in the future.

It is hard to imagine it ever being possible to change, at runtime, the
length of time represented by one jiffie.
Durations, measured in jiffies, are stored it lots of different places,
and they would all need to be changed to msecs - very error prone work.
I think it would be much more likely to set HZ to some large value, and
have the clock tick at varying multiples of that.  The NOHZ work already
does something a bit like that I think.

Thanks,
NeilBrown

>
> Cheers, Andreas
>
>> $ git grep ' \* *HZ'  |wc
>>   2244   15679  170016
>> $ git grep msecs_to_jiffies | wc
>>   3301   13151  276725
>>=20
>> so msecs_to_jiffies is slightly more popular than "* HZ" (even if you add
>> in "HZ *").  But that could just be a preference for using milliseconds
>> over using seconds.
>>=20
>> $ git grep msecs_to_jiffies   | grep -c '[0-9]000'
>> 587
>>=20
>> so there are only 587 places that msecs_to_jiffies is clearly used in
>> place of multiplying by HZ.
>>=20
>> If we were to pursue this, I would want to add secs_to_jiffies() to
>> include/linux/jiffies.h and use that.
>>=20
>> Thanks,
>> NeilBrown
>> _______________________________________________
>> lustre-devel mailing list
>> lustre-devel@lists.lustre.org
>> http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org
>
> Cheers, Andreas
> --
> Andreas Dilger
> Lustre Principal Architect
> Intel Corporation

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrFSu8ACgkQOeye3VZi
gbkA+g/+LpzA8EE4he8zHNx0zHIAnZmHACuTWZ+pUd/dj+WeZxuKzJr492rXSNse
QMRgp7Eu4PPNgFsFeXJPb1HjfgunEZ74ITjhovU2+WZPdKkyAIFLK5yIfkj2tzEE
nwgOFS7lGy39rzSV1lTz3DOi1aBvu24DSm9OZS29MdMyMk+KZinzFYoZGoMU794+
7h4KENllzTPHTUcfdF0fex3tr9nR2nokWc12QfwIlFHtXQBWQkUJ3mD89lHPmUdg
B7ZTC8WCmWnp0/N5OgF2v2LXYGcJmr24VWMEpKzEoTG5sVQg+Dv6udo5B2rPCqRG
RDmb2fBz0d2FPCvPIj4wIsRhR6JPqpVxnS+dbQKVXZ3iq9MRnYU4ahtvQKVGYQ+Q
8tYGx7ov0K+wt6cWh86p29GN+TQG74e6IT2u1p51u5td33j8C67xYCtr+/azy4Wf
aEWDH1uO4cWxhKCJqFr+FKquGnHKKl9RQu8XivhAIdfIHx+bb6GOKk86IXC47WQv
XLtgb4mIUxVsBNfi5sr4XpFdsyVZUH7fBbJeKCJFrDWXFbQFu+UYbOwMdUm1vMtZ
YutIi5bqllcDMjihshAw3ipNSvtvPRTgz1dCWq5gbU0+aR74gljVy+Opovb/Wdab
XSKar2iDdyAoCm6EcLZFVyL2npejSDrCLBeMSBVZngYXSVTwRaM=
=qiIm
-----END PGP SIGNATURE-----
--=-=-=--
