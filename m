Return-Path: <shreeya.patel23498@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520093656; cv=none;
        d=google.com; s=arc-20160816;
        b=euoZYumkMwMs4g/YtmPOkPDeNFfEZJU4ui22ug+k6fs1Jl5uzD5+SqtygB/kvxyrA4
         bdx4w64gHg4DJ/iuZZ/nIUgoVRuqEy9RtDo+/qc1b/WxN9suX/aOfOmPUJ1IsdiO3SgA
         ZtFd9R6DOu4enHMCKjPwXNhoSTLQepBjzPxP7HYWnzrD3AjTFRMUxeTkQ/e/EpKaU7Qp
         EIfhtvR/v8bn8ZDvGb1+70EnPHoWKKllgMHwAVYuMzAJHvWQOEK6wSogCoU2xxVEusRr
         rUosu6/zQVTMRIC1OZFSqiet/XDQgjpvLc9yUHvuh30/qlD6b6z/448mrbdSNHsBTdtE
         /okA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=8ewASwwSq2j1XOV26QVx7JixywjZ0QeU4ZVXWFheTh8=;
        b=peZ5vvN5RtgxGZFHB7ry7vx/hvcOMVtJKFgszoE3x6LzazXtn43IlBDav8f0rC8O0N
         VHMI0zMfQbukzJOM9k7dbaKzX3vyWjasSr68T4sp11tlpMLrZhDfgqAuXbvV8t+K3CMT
         o2FrNG6vbGCtHziWqICDe7IJMdDxUPkEm+RZhGCXIbvK7TdB1OFD6Hq+oOXk7s8U11uu
         6ODC1fbbEtvkWiiHZjILdny/VEk0xGRk2NSvAL1cBrNFsYeNEbAgwxXt7UP13oR+H8c0
         OTShfw7Oz8xf0Ue6l+3wKrIS8En9MyHBF+4D7Ui4V6F203vF/0fnjLuRkBVXCn4qaW4N
         2+8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VSeLzVZo;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VSeLzVZo;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtE/kiqB0BJdypRZPzsuC9SG0EtbRFX7ugT+k5shtr0H9VbiG9hAzxJXOyXWmhmIbbN71V+sA==
Message-ID: <1520091473.3137.4.camel@gmail.com>
Subject: Re: [PATCH 6/6] Staging: iio: adis16209: Use sign_extend32 and
 adjust a switch statement
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com
Date: Sat, 03 Mar 2018 21:07:53 +0530
In-Reply-To: <20180303160557.26462aa7@archlinux>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
	 <982b80d683b8c8e8c61cbc5b0864c265ea2ac768.1519995673.git.shreeya.patel23498@gmail.com>
	 <20180303160557.26462aa7@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593833102938062784?=
X-GMAIL-MSGID: =?utf-8?q?1593933726386124759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 2018-03-03 at 16:05 +0000, Jonathan Cameron wrote:
> On Fri,  2 Mar 2018 19:04:49 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> 
> > 
> > Use sign_extend32 function instead of manually coding it.
> > Also, adjust a switch block to explicitly match channels
> > and return -EINVAL as default case which makes the code
> > semantically more clear.
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> Changes are fine, but 2 changes to different things should be
> in 2 patches.  Please split. I'd probably have taken this anyway if
> it hadn't been queued behind the requested changes to the previous 2
> patches anyway.
> 
> Good work on this series though so looking forward to v3. 
> Note please mark the set as [PATCH v3] to make it clear it
> is the 3rd version of some of this.

Yes, I'll do the changes.

Do I need to include the patches which have been merged from
this series in v3? 

Thanks
> 
> > 
> > ---
> >  drivers/staging/iio/accel/adis16209.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/accel/adis16209.c
> > b/drivers/staging/iio/accel/adis16209.c
> > index 7363fd0..5ab44a4 100644
> > --- a/drivers/staging/iio/accel/adis16209.c
> > +++ b/drivers/staging/iio/accel/adis16209.c
> > @@ -150,10 +150,16 @@ static int adis16209_read_raw(struct iio_dev
> > *indio_dev,
> >  		switch (chan->type) {
> >  		case IIO_VOLTAGE:
> >  			*val = 0;
> > -			if (chan->channel == 0)
> > +			switch (chan->channel) {
> > +			case 0:
> >  				*val2 = 305180; /* 0.30518 mV */
> > -			else
> > +				break;
> > +			case 1:
> >  				*val2 = 610500; /* 0.6105 mV */
> > +				break;
> > +			default:
> > +				return -EINVAL;
> > +			}
> >  			return IIO_VAL_INT_PLUS_MICRO;
> >  		case IIO_TEMP:
> >  			*val = -470;
> > @@ -197,9 +203,8 @@ static int adis16209_read_raw(struct iio_dev
> > *indio_dev,
> >  		ret = adis_read_reg_16(st, addr, &val16);
> >  		if (ret)
> >  			return ret;
> > -		val16 &= (1 << bits) - 1;
> > -		val16 = (s16)(val16 << (16 - bits)) >> (16 -
> > bits);
> > -		*val = val16;
> > +
> > +		*val = sign_extend32(val16, bits - 1);
> >  		return IIO_VAL_INT;
> >  	}
> >  	return -EINVAL;
