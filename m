Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523890046; cv=none;
        d=google.com; s=arc-20160816;
        b=XUO0rn5HhpeOvvUdHj4141iwJzci5jIX2/lY9rWUwzHUhojxvPQ0DTPnXb7W7Sd0bb
         +4fTlxC5W3KCgYR/pXHgV2mrBm7b/CTOOhas46+lylrTl0XQn1/UeHE+NUDbkGNL4e4b
         0kBqy+edVwk0GhqQbpcG9JnjnNRVIhFNbO/4WbHlv4gDmPPFSQgGr1D9WrgVMNVqccvr
         Clza3+2JQuzcu6SvA8j78NAI/ebgV3F1IDclZGIqULZ/zY4PaWLLGAWTTbwHiROfb/Vc
         X2kzUcJ4IBRFidBJluyFtmCpfcvu0lCkj9eKY4r3bjEKrliKQY0veemIfzkCj/1ElL/K
         oFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=V8JU4ZKRUgO5kQfNLel1uGf2gV5B3sbcfYFFnwMjr3Y=;
        b=IsQmata6F8cB/2KNyoYPMckKbP9HN/x+JdH1nUMQ/7L9qqv1djSvNGVPT4y6Egvrg4
         AkqkDY3C9x16gTs3BOmO4rWCCmoDhas0VD1msihMTKyMAO4MtyYK0uQnLfpXat6YV6Ff
         FCqcnSozgNczSvTlGT07u8vSKPTmOgnmhZPelF51QcEAke2v7W/NkkgUAOkU6DMjqSSy
         5svEAgxYskBxW1zJ11IOiEcavcB3J+B/ekIGSL1swC7sfG1iHZ8qTWp/agArixICfY6Z
         ztjTLCQ8u4gjs7m4LzFJu3VQ+bPD6yG3AJ1UdtXxjaBL3zZyyvzZn1MGjEZIo6WUYV7I
         VHPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=09HnfZ7D;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=09HnfZ7D;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx49a/vZvl3cpse/57IMyhANUGGmz5bBw9FSV49Nt+MGvqcjJ6o+oXLzQwNwIuKDFems8xnKopl7rKjUVXJNc1h8=
MIME-Version: 1.0
In-Reply-To: <20180415160550.4705667e@archlinux>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
 <1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar> <20180415160550.4705667e@archlinux>
From: =?UTF-8?Q?Hern=C3=A1n_Gonzalez?= <hernan@vanguardiasur.com.ar>
Date: Mon, 16 Apr 2018 11:47:05 -0300
Message-ID: <CALfa3vFgh7jtb=B6doOu-y2Bm77wu4zVdLE1LuxbruTTKjLU=A@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] staging: iio: ad7746: Fix bound checkings
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649691066295032?=
X-GMAIL-MSGID: =?utf-8?q?1597914528862246918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 15, 2018 at 12:05 PM, Jonathan Cameron <jic23@kernel.org> wrote=
:
> On Fri, 13 Apr 2018 13:36:40 -0300
> Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:
>
>> Also remove unnecessary parenthesis
> I am probably missing something.  I'm not sure what you mean
> by fix bound checking?   There are superfluous brackets, but
> I don't see any functional change to indicate there was anything
> wrong with the original checks.
>

Maybe I'm wrong but | is a bitwise operator while || is a logical one.
There are no functional changes as you said but, from K&R, "One must
distinguish the bitwise operators & and | from the logical operators
&& and II, which imply left-to-right evaluation of a truth value. For
example, if x is 1 and y is 2, then x & y is zero while x && y is one"
so it'd be slightly faster if the first condition is true, and it
would be the "correct" operator to use in this case, even though it
doesn't affect the result.

>>
>> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
>> ---
>>  drivers/staging/iio/cdc/ad7746.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/=
ad7746.c
>> index 516aa93..d793785 100644
>> --- a/drivers/staging/iio/cdc/ad7746.c
>> +++ b/drivers/staging/iio/cdc/ad7746.c
>> @@ -458,7 +458,7 @@ static int ad7746_write_raw(struct iio_dev *indio_de=
v,
>>               ret =3D 0;
>>               break;
>>       case IIO_CHAN_INFO_CALIBBIAS:
>> -             if ((val < 0) | (val > 0xFFFF)) {
>> +             if (val < 0 || val > 0xFFFF) {
>>                       ret =3D -EINVAL;
>>                       goto out;
>>               }
>> @@ -470,7 +470,7 @@ static int ad7746_write_raw(struct iio_dev *indio_de=
v,
>>               ret =3D 0;
>>               break;
>>       case IIO_CHAN_INFO_OFFSET:
>> -             if ((val < 0) | (val > 43008000)) { /* 21pF */
>> +             if (val < 0 || val > 43008000) { /* 21pF */
>>                       ret =3D -EINVAL;
>>                       goto out;
>>               }
>
