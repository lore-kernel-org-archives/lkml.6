Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2747092-1518870246-2-7615621245200887311
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518870245; b=JgXXiQOf8fCwIhgy/XUhstFifFVyQvKPyOIeDsNjJSXs5Ds
    zwUPkVCHahhO9N86uoicdqluUvs1ajG8E3MVad+zvK/nXHQSqVHqr7KFM0dCH7uQ
    ry677H+bFCUFjVM3detBd8dVOx0Y8jT62r0QEOf+zz5LAXPU2iteAWM64agz8LlB
    nq1t8gQLqeWWvScWBjnPu8TYyuvqvdmYf0BYxY28inLCiVBTEC4gqwDRiG0zqRiK
    DAoo5J+CaRtR0KQTC/RrpGq4dMwxDzRFJalD5SuZN2xlVP4fw+WyKLKuK+cQg2Vn
    +u5IJMZGt3krUNQGCwxHJWfP67VirlMDgMb5ycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518870245; bh=g
    67L5f+xQz5Wd5tMlK7SAziStxl7BJfIpzW4DBJkQvg=; b=veeHEpy4JwVUgyzw/
    wIKJcbZOSxPBBiMC+vnIlLuBREohVGKy1iGG+a8BCR8xaIj8ecX3CYahEJaFFYFf
    S5jik7TgrB7PNNjiW9nlVUumSs4pCzY6LeqJUH537byz19ZwcRW875qOnwkhKg9J
    X/qzUx3eIajVvC63hNuHBoaUP6OD5deOPcznBgVbxPm3oTknO/H/91eTobyl8GTl
    EggEyevcs0d+tg7QCCbKNbfYEtXVRPu2vJZ1xBD0YtgN8OISjN3wTYavG5KOjARE
    Lg6we89JhCmMrbHr0Ui+5rPlLcIfU6iTTE1YA4tQ67oUfA6aypSE/QsAd880ksZe
    5Onzw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F45A217A5
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 12:23:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/4] staging: iio: accel: Use sign_extend32 and adjust a
 switch statement
Message-ID: <20180217122353.7ee9bf96@archlinux>
In-Reply-To: <20180212131000.h4tbinr4s6m4ckh4@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-4-git-send-email-himanshujha199640@gmail.com>
 <20180212131000.h4tbinr4s6m4ckh4@mwanda>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 12 Feb 2018 16:10:01 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Feb 12, 2018 at 05:24:58PM +0530, Himanshu Jha wrote:
> > Use sign_extend32 function instead of manually coding it. Also, adjust a  
>                                                             ^^^^^
> > switch block to explicitly match channels and return -EINVAL as default
> > case which improves code readability.  
> 
> Greg likes to say something along the lines of "when you start your
> sentence with "Also, " that could be a clue that it should be a separate
> patch.".
> 
> > 
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > ---
> >  drivers/staging/iio/accel/adis16201.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> > index 011d2c5..6800347 100644
> > --- a/drivers/staging/iio/accel/adis16201.c
> > +++ b/drivers/staging/iio/accel/adis16201.c
> > @@ -112,12 +112,17 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_SCALE:
> >  		switch (chan->type) {
> >  		case IIO_VOLTAGE:
> > -			if (chan->channel == 0) {
> > +			switch (chan->channel) {
> > +			case 0:
> >  				*val = 1;
> >  				*val2 = 220000;
> > -			} else {
> > +				break;
> > +			case 1:
> >  				*val = 0;
> >  				*val2 = 610000;
> > +				break;
> > +			default:
> > +				return -EINVAL;
> >  			}  
> 
> I don't think this improves readability.  The -EINVAL is to handle a
> driver bug which we haven't introduced yet.  Probably we would be better
> off printing a warning or something?  But it feels weird to introduce so
> much code to handle a bug which would actually be pretty difficult to
> write.  The original code is fine.

Hmm. My thought here was that it is not obvious from the code
that we only have channel 0 and channel 1.  The if statement
kind of implies that channel 0 is special compared to 'all the other'
elements where as what we are actually doing is picking from
a set of options. So semantically it's a switch statement being
implemented as an if else pair ;)

Perhaps we can compromise on the addition of a comment on the else
case to say it only applies to channel 1?

Dan, what do you think?

It isn't particularly important either way though so feel free to
just drop this one.

> 
> >  			return IIO_VAL_INT_PLUS_MICRO;
> >  		case IIO_TEMP:
> > @@ -155,9 +160,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
> >  		if (ret)
> >  			return ret;
> >  
> > -		val16 &= (1 << bits) - 1;
> > -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> > -		*val = val16;
> > +		*val = sign_extend32(val16, bits - 1);  
> 
> Yeah.  This is a nice clean up.
> 
> regards,
> dan carpenter
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
