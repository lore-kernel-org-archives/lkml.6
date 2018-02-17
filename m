Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2796125-1518870421-2-14587513030514474052
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518870421; b=JziLk10wJZHH47mMMefxLDwb6Q+h6giBvxh48zcWF5zeiWe
    FWsPCzya4d29mWMNvnWx+w/bjvjpsTxsTa4cM3vGUdbHdDwvS1fH+i2+sXUnVbQw
    OE1DU+19+Bcm7NWCpEg+31qHW93zG130Lxrc5qxNZGq4vEM5V+CW1Szk9LU8PAyb
    ivLz/Psc+k+uiOTm2jzWHzHLyRn+AZoPEu5K4slhy1R9a6tJ72uDWwTiyZwYlgV+
    Xb/feEaJY/PxI5EYYCZms5FEfrzC7/Y0fDKyeEQ1lyd3V3g/ZHSOZtcEa4A3vjCd
    hT8BXmAI2oIFFm3W75JVz06xO+kllM2wNr42Big==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518870421; bh=2
    Uduu+rG9iOTei6OMtQp6mk8Z+JLQmWziOC63JGKZ3k=; b=EbzraxC39r5aFC+SR
    eZiPInC5XGmygJQbmyQjAKSF0M+gtOiZw45MvIHvzNV2CYg1lN3FoFvYbVekj2Zy
    iSEkdRbDLjL721i9vJt2fjPq0YNpzlvL6X3f5q49r0jRsnCJ/IifiLnwtTHIQYAp
    x/ztzOJ0O+5Hyamj5jlO5iKKFQI8f1rGCEKDp58zNDkLojifPCkDAwhyu60ZHvVQ
    sAdMJGL/lF1Gq+KTXQyA5JRsiUmgRbY99upNDbpd9ITDcoTWWsqJUDY2WhoI5nuR
    6+xFRW/15Qz8FXQxCix8RxogFYFR/P6bJCKJNvJZrN66gbruya8mq17/cmCRAN8e
    dr2Cg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D5E217A5
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 12:26:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180217122649.1b476787@archlinux>
In-Reply-To: <20180212144542.qievoq76rvjigwm4@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
 <20180212131826.ebazvmp6iv7i5fav@mwanda>
 <20180212144157.GC12142@himanshu-Vostro-3559>
 <20180212144542.qievoq76rvjigwm4@mwanda>
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

On Mon, 12 Feb 2018 17:45:42 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Feb 12, 2018 at 08:11:57PM +0530, Himanshu Jha wrote:
> > On Mon, Feb 12, 2018 at 04:18:26PM +0300, Dan Carpenter wrote:  
> > > I think -M is prefered for these types of diffs?  Not sure.  
> > 
> > I wrote about that in the cover letter if you missed. :)
> >   
> 
> Yeah.  I seldom read cover letters.

For anyone else (like me) who also doesn't often read them...

This was a specific request from me to not use move detection.

The reason is that it presents an opportunity for staging graduation patches
for people to have the whole code in front of them allowing them to do a full
review as if it were a new driver.

I personally find this very helpful in this one case. For any other
code move I'm as in favour of short emails as the next person ;)

Jonathan
> 
> > > > +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> > > > +	if (ret)
> > > > +		return ret;  
> > > 
> > > We should clean up the IRQ which we enabled in adis_init() instead of
> > > returning directly.  
> > 
> > I'm not sure about how to do that.
> >   
> 
> I believe in you that you can figure it out.  :)
> 
> regards,
> dan carpenter
> 
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
