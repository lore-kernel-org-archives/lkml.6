Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3191653-1518888307-2-5111268417801001449
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518888306; b=F6ogk5scNfzTtHRMLwb0AQ9t89/jfmyXXTRDgfeuTnKhqpL
    cziBpPJ5xEO3U7mt1vI5JNYojQWgYKN4wTd6SCfNQOE/Uxp7RELOZ93cEi2F/F2D
    bhuNYY0Gu+Sw+rpUmsELxXDehy3IsICmiZvgQGXVtReeSpQQLvRMhban249WAjzR
    WDh+VKCIXulEi/F7iofNCWnBjouhZpLr9iuFS9XLNLdN629Aj2bD+DoybJBu0OlR
    uJVnLUo5vftYKAZqQlyXZXkAo9OLTQ0VwMnJF8ZJ7fApTiS+EZ6DR1H5jjzGrG5O
    GDM3ItnYWPc2YX5iPncYEzMcFoNEIV2ZT/QfELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518888306; bh=Z
    5L+TOtvelLsfl1mVEVTWo4z5lcO7zmgD0J3OBGVFto=; b=SRdXoQjmbhcfmgXtc
    BLYvO6nsNR6DD4Mgi/WqOb5r8CmixDgnCQUnC1Hx23+VVEw8ilUTEHw9K6N/hagL
    Xxb8VgYU1TrC9/anWVyZJ7++U73yDbHhDfGSkAOgynx3TsbKJOr9s329uWb92thS
    bID0Dn22+zhWN/mZnHo38e231XyiZKd0iOJFTwpQuV7cXxX5QsrTpz9uKolejcmz
    4YSt4jS7uOl80cCkPHiLlEVz6VbpgV8p0WzGTp/N9D6AZ7B1NVDa5yhoIP1YHPuc
    56s493RoSGAvtHgHwMQTvuJwMGUUDbDo0bkQscl0t6h81d5Fo3vaBgsQWLOuPLYZ
    Qyixg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=H9LoRTrA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=H9LoRTrA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 17 Feb 2018 20:24:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/4] staging: iio: accel: Use sign_extend32 and adjust a
 switch statement
Message-ID: <20180217172441.2nl632jc3u6himnd@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-4-git-send-email-himanshujha199640@gmail.com>
 <20180212131000.h4tbinr4s6m4ckh4@mwanda>
 <20180217122353.7ee9bf96@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180217122353.7ee9bf96@archlinux>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8808
 signatures=668674
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802170231
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

On Sat, Feb 17, 2018 at 12:23:53PM +0000, Jonathan Cameron wrote:
> On Mon, 12 Feb 2018 16:10:01 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > On Mon, Feb 12, 2018 at 05:24:58PM +0530, Himanshu Jha wrote:
> > > Use sign_extend32 function instead of manually coding it. Also, adjust a  
> >                                                             ^^^^^
> > > switch block to explicitly match channels and return -EINVAL as default
> > > case which improves code readability.  
> > 
> > Greg likes to say something along the lines of "when you start your
> > sentence with "Also, " that could be a clue that it should be a separate
> > patch.".
> > 
> > > 
> > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > > ---
> > >  drivers/staging/iio/accel/adis16201.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> > > index 011d2c5..6800347 100644
> > > --- a/drivers/staging/iio/accel/adis16201.c
> > > +++ b/drivers/staging/iio/accel/adis16201.c
> > > @@ -112,12 +112,17 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
> > >  	case IIO_CHAN_INFO_SCALE:
> > >  		switch (chan->type) {
> > >  		case IIO_VOLTAGE:
> > > -			if (chan->channel == 0) {
> > > +			switch (chan->channel) {
> > > +			case 0:
> > >  				*val = 1;
> > >  				*val2 = 220000;
> > > -			} else {
> > > +				break;
> > > +			case 1:
> > >  				*val = 0;
> > >  				*val2 = 610000;
> > > +				break;
> > > +			default:
> > > +				return -EINVAL;
> > >  			}  
> > 
> > I don't think this improves readability.  The -EINVAL is to handle a
> > driver bug which we haven't introduced yet.  Probably we would be better
> > off printing a warning or something?  But it feels weird to introduce so
> > much code to handle a bug which would actually be pretty difficult to
> > write.  The original code is fine.
> 
> Hmm. My thought here was that it is not obvious from the code
> that we only have channel 0 and channel 1.  The if statement
> kind of implies that channel 0 is special compared to 'all the other'
> elements where as what we are actually doing is picking from
> a set of options. So semantically it's a switch statement being
> implemented as an if else pair ;)
> 
> Perhaps we can compromise on the addition of a comment on the else
> case to say it only applies to channel 1?
> 
> Dan, what do you think?
> 
> It isn't particularly important either way though so feel free to
> just drop this one.
> 

To be honest, I dont care either way...  The original and the new code
are equivalently clean to me so I have a "leave the code as-is bias" but
if someone else is invested in this code then I like to let the person
who cares the most be the one to decide.

This patch is actually fine but the patch description makes it sound
like it's doing two things.  If the subject was
"cleanup adis16201_read_raw()" then that would sound like one thing.
I obviously review thousands of staging patches so some of my responses
are pretty mechanical at this point.  If it's a two random things from
the same file then split it into to two patches, but if it's from the
same function that's acceptable.

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
