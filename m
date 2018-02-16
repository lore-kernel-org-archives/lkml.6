Return-Path: <rodrigosiqueiramelo@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518787022; cv=none;
        d=google.com; s=arc-20160816;
        b=qdy4kt7bPTttbvlROXtZ4MagVc4/g8s4SL2AYM6c3f/J5JWSA+ufIQaua1F3tF54JV
         wGZZci/BkcL1+CcsteuLXrj4WSPx0TzOBexC9e5YeI7ypq8QVoJZCOivsCC5VK/KGfbv
         pf2FySIJ6tHTFPtHmGv9TmdEceI80nCwNvgiQNq8LnimJOMji7BWtqsdrFG1KLGdbv2t
         2dKPn+UWvHcOInS7x3e/RypvNSpjI9qDsz4l8lMkj+PNz2LFqMuaaGH2rqzJ9ouAJvxr
         nVE/ktKo/aFx2T1iGo7j7qMKKUutCglO7WAG3/eEyHfRzFBIdwwb6z15qD2qmXSO6mmn
         Yw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=Zy0b6GGsjDhaF0wMvOBPa6L+/IQEJRvq7cIe9awTme8=;
        b=HhLE2LAhrikNxr71y8Wwtvo1LLDFmoidzDMIBsA/lCDzuZAxHp/ws5KGbRwr9ncvTu
         HUMhlQwZz8F9qmIpJPt9WbhbdIHEYZXD02jqCJt61fl5Z74AjaN8dQHled7QJ9F7eZqv
         dbWdgad7zSX+gOQL+YruYkx8iDBYbdBYJOjlhy+BZY/nLuvtlR85wCZmOXqDChuOPJKh
         CoeJNxxQkFuuENYoyBOhJdGMG7zkWl78EfQkC4RgRr5cbOk2Nsy//2xKFOrDpGjm5Bm6
         bZQMQKCfTh4uu7JPDX0r5FM02IyA2hTfcU5u/RwUIfVPZdI7Oar9T38TTtFNWlXqO1b+
         pXwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DLgoLfbV;
       spf=pass (google.com: domain of rodrigosiqueiramelo@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rodrigosiqueiramelo@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DLgoLfbV;
       spf=pass (google.com: domain of rodrigosiqueiramelo@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rodrigosiqueiramelo@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224jluAdMHH0rIe1rxiLNL52PQXUplFEVxsweq2NSF/3/b5d5mHKzOfmybk+gQos2hCWHbZqoA==
Date: Fri, 16 Feb 2018 11:16:58 -0200
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: iio/meter: add name to function definition
 arguments
Message-ID: <20180216131658.h7b2y2ckkucetnzj@smtp.gmail.com>
References: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
 <1518785796.9517.25.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518785796.9517.25.camel@nxp.com>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592561969326261427?=
X-GMAIL-MSGID: =?utf-8?q?1592563621686093576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Daniel

> Hi Rodrigo,
> 
> I think this is a nice finding. One comment inline:
> 
> On Vi, 2018-02-16 at 10:50 -0200, rodrigosiqueira wrote:
> > This patch fixes the checkpatch.pl warning:
> > 
> > drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
> > argument 'struct device *' should also have an identifier name...
> > 
> > +	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> > +	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 value);
> 
> 
> Any particular reason for using val vs value? I get that one is a pointer
> and another a plain type, but I think the name should be the same.

Before I selected the name, I figure out that read_reg_* and write_reg_*
was assigned inside the iio/meter/ade7754-(i2c|spi).c files by function
like ade7754_*_read_reg_* and ade7754_*_write_reg_* .

I considered to use 'value' name for both functions parameters, however,
I noticed that function ade7754_*_write_reg_* adopted the name 'value'
for the last argument and ade7754_*_read_reg_* named the last argument
as 'val'. So, for consistency sake between the header file and the c
code, I decided to use the same parameter name patterns.


> thanks,
> Daniel.
>

Thanks 
