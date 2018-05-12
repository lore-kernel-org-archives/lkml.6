Return-Path: <ukl@pengutronix.de>
X-Google-Smtp-Source: AB8JxZqWtRDfyoPeiaBUMVFS+b1aL+IsnurjH15+rfgbGdqk+KOE+wMtyUpESLPH6HAgzunxBzjN
ARC-Seal: i=1; a=rsa-sha256; t=1526151625; cv=none;
        d=google.com; s=arc-20160816;
        b=ihP/WKvaOAfBicLh2kGGsxQU+tlQJOOmVh99mJO+9K1Oquj+5gXVVOI/yW+oV9+2ae
         RFHRdMZmB/TQmvdBBVRAfJT588C8jCC04W4YO2kgCc4v2LLBgbmimUqwFveNSWkaZ40d
         yJZmkfItZoamOwiJxeuBrZQNyVtQOvWxZjnPEvNCo/7JAjnkWJBCrrzH3M04hPzsm/Fy
         DJE4TT7rzxYGGgEZVSYCpnppNEigiCszO+1Ky8QM892u7PK/+uQhz33wS2tgtpJ7GT+X
         NQ6LNanG9kys4zOeFtpYg+X7iuFDnOkjxPxvdzdPqtczdWAzTdGFt4GmyhU/z6A8cNhN
         RPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=FLrNZYwws4JBpwKcYIRbhCqswhVnkQPkYbtNYSDQfDw=;
        b=1J5JV/LKpQ3TuLSnQxA54FLSmZUA99Wfbm48OJj+fyrSkGxkPRWG6DsIVu3lXVqjDK
         5XH3fns1iqEx0HlEAkhNGrjEEbvYg2t83X6E3uyqNoVZI28on8MIGPmI8chvYJc2bw1p
         A7uhfynkYPRYJ2WXpBPW4W4HfMKICqJPaPnFEas4izWpWTp6C8lpu26Bj5kuu68jn3wu
         yXR+O4YHjvEGASYGincGs1VO3/f2OnRkRvIN2hFMc3yJdWnc0Z66rbaILPuJ25wqzNba
         dQ93Be+iXs74fhnLpHe1KD2C1x7bJcJU5R+D5Fr7VSaCG2c7As8nc85QrCAFh13UNW1N
         z7IA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Date: Sat, 12 May 2018 21:00:22 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Johan Hovold <johan@kernel.org>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] tty: implement led triggers
Message-ID: <20180512190022.rx7ix5gpx5kncvcj@pengutronix.de>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
 <20180507092710.GQ2285@localhost>
 <20180510111434.GC6977@amd>
 <01dcbf5c-70a0-b067-20c3-f99e22ed4512@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01dcbf5c-70a0-b067-20c3-f99e22ed4512@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599475610182983981?=
X-GMAIL-MSGID: =?utf-8?q?1600285967144175403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 12:25:21PM +0100, Robin Murphy wrote:
> On 10/05/18 12:14, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
> > > > > >   		struct tty_buffer *head = buf->head;
> > > > > >   		struct tty_buffer *next;
> > > > > >   		int count;
> > > > > > +		unsigned long delay = 50 /* ms */;
> > > > > 
> > > > > Comment after the semicolon?
> > > > 
> > > > Given that this comment is about the 50 and not the delay member, I
> > > > prefer it before the ;.
> > > 
> > > Hmm. I personally find it hard to read and can only find about 30
> > > instances of this comment style (for assignments) in the kernel. And
> > > arguably the comment applies equally well to the delay variable in this
> > > case too.
> > 
> > It is not too traditional, but I believe it makes sense....
> > 
> > (and yes, I wish we had kernel in Rust, so we could have real units
> > attached to our variables...)
> 
> Well, the variable itself could always be named "delay_ms" if it's really
> that important.

FTR: That's what I did for v3.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
