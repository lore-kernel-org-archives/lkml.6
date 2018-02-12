Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518473929; cv=none;
        d=google.com; s=arc-20160816;
        b=FaqXf5uGgA5m+IpE1glDKd8MtfbDxI06uAUMTOQyOFJLRuAA1FUd/5NB8VRrbVWhAR
         A/mg+UpmeMd0rYwbBu/O5vrehF5zBR0afx9C6sATm3tWpDc1EHAue/bDC9YU+YpCgzFz
         lbxtF3gcVZJlw2j86NHDruaXXJfBhiG6kebMsEFFYeablQOmeh24d60RbQfMvGQGa9kJ
         Xz7zSOQ5CQOrFKOy3pOxqPSIZ1G7vxkpQkZSp4zCbCuZLoPJP00lPDSw/mBacugS0zpU
         bIA3Y+TMqZ9SyFzWjPmsMGbj7I3jNUnL7cJ6dbtUxGzrTNduVQ5Bhf8Ac0upL1ZKwTQz
         O3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=E8Ld2KeteG5yulF6cIicSzMNUAm/T+nA27V2cGqnig4=;
        b=Hgyd6h1yPrEJ5DBjvem8/3Nr6VuWwmtihnpjzccH59LDeObFduZTGHpVlxOKTrT1aK
         +26UxVaXsPK/DlFSNelPnNuwyAQr5H3DwIZxhInGY7Eb472TNxKT9dOSuRb5p830nLc+
         GzQEtf8CgQD3/hWaeNJU2aLBU0TPUz8/z4ueZqop87NOLP+LMMIeTnWCTM9gyTu3RiNK
         vA2kCl5swk5vtTPEoAAIpmxVwdE4bIW3Of3u6orsd/Tqq4hhQPxQpoe/YMhjRI+8t38q
         YTY27awe1JgDGDBamDxE7xUNqWXfkLnCtJcmhxd3FEpVUg2/rx1zdjMKrVFCQJ2h9BXF
         Ibgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=iVeOzS5D;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=iVeOzS5D;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x224TE0cO5LJ1yWN8slmAjDC5a4Nxfgyff2Wyt4d0JgwdamD154sTLzaMzebXFYJ4AG0EqOHGwanMMbbvxL5NXOo=
MIME-Version: 1.0
In-Reply-To: <20180212143750.GB12142@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
 <CAOFm3uFOy+Rea8yz798sEoCGRfavsR9gwY9-d_RQ75K5yoq1=g@mail.gmail.com> <20180212143750.GB12142@himanshu-Vostro-3559>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 12 Feb 2018 23:18:08 +0100
Message-ID: <CAOFm3uFM3gUw+SHQ5-qLh=YkZ84b02rntWrOfhzJ0Y+BHvPK8Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of staging
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592196122159605134?=
X-GMAIL-MSGID: =?utf-8?q?1592235318591951758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 3:37 PM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> On Mon, Feb 12, 2018 at 03:10:56PM +0100, Philippe Ombredanne wrote:
>> On Mon, Feb 12, 2018 at 12:54 PM, Himanshu Jha
>> <himanshujha199640@gmail.com> wrote:
>> > Move the adis16201 driver out of staging directory and merge to the
>> > mainline IIO directory.
>> >
>> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
>>
>> <snip>
>> > --- /dev/null
>> > +++ b/drivers/iio/accel/adis16201.c
>> > @@ -0,0 +1,315 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>>
>> <snip>
>>
>> > +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
>> > +MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
>> > +MODULE_LICENSE("GPL v2");
>> > +MODULE_ALIAS("spi:adis16201");
>>
>> Your MODULE_LICENSE does not match your SPDX license id.
>> MODULE_LICENSE("GPL v2"); means SPDX GPL-2.0
>> MODULE_LICENSE("GPL"); means SPDX GPL-2.0+
>>
>
> I didn't knew about that! Thanks for pointing.

Sure thing. I reckon this can be a tad surprising.
FWIW, the reference for the SPDX tag is in
Documentation/process/license-rules.rst and for the MODULE_LICENSE
macro this is in module.h
It is unlikely module.h will ever evolve there as this would break all
third-party module loaders/tools that rely on the documented data
values and conventions

-- 
Cordially
Philippe Ombredanne
