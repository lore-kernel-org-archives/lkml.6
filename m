Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3393218-1520952829-2-7592765777184571909
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520952828; b=UjdCbtwon7GnAPoX03lVmJS238+NjnXh32S8XSn4qChWRvw
    OWt17G/2pxWYLi5Q60EmknELld85lLIczqdKUbCMVa+AvVKMlUVOa4Azhps67BIm
    ucCALYNJT6NJLQoJ893WEqEENhe71tCFeVXlUEkviHJ5wI9JuTtKgTcvTQiAbmRs
    Enea/NAAprekpvdEQZe8dL1ZMONFU/RO09gmi9pHo9nCMN3/gA2jhEAlKEaOAh6p
    whv0CSIcFMF189u6QNegGM2MGVNerbfYFaa0BBhCJronME8QMFYBdFN++mgIA4EE
    ojvpy8hX7ujW15RWahbbYzMI+tmupnzuF67gsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520952828; bh=I
    TxIdJR/ayz9UJ1esSAfzoPblnjc7qx6hU3fPoxcXQA=; b=KF66qEfgkIBWE7+kG
    14W0WVBVxUDaHx/9c8x9htwYvNh/wbtrXqWQ8QhrwEDvP4ffydLOrvK5NssHjvyd
    wLXSae+jvXzJQEAIcfSo8mG0JcR9GAH0+oiHOEBwb1tyw32RMRMrQahQCsm1R446
    DWuPf+Zu0bk6VtjtRcR1ikTTb1rGfwHVXUNSztDOPVRVqrUYB5/sgIxINtMtFe3a
    QC3v0JPFDmp8OCSz0giUFZgBMN3JSYXrRB0/CcfF3mnjJ/wjJwn1nsPZQ1eoyYVn
    e4vJ/XTiAzvbqfr60shr4EeOs1INo7BTvhqWbh3YPqChayqmq5tEi/GuNRlVy+Tk
    LJYNw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Pb56OQZg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q/tz+og9;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Pb56OQZg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q/tz+og9;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt7AqQ/JgdZVkhYmZsmizbgsIAI22Vm3LI+cM2eM+drL2ROkoP7loyqkbpYpN4oEf3kP8dC/Q==
Date: Tue, 13 Mar 2018 11:33:24 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/3] staging:iio:ad2s1210: Add write_raw to handle
 frequency
Message-ID: <20180313143324.vlusixa522rqaeoy@smtp.gmail.com>
References: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
 <ae60ca5cf37d1678cb6b498450f75f93f3d498d2.1520878492.git.rodrigosiqueiramelo@gmail.com>
 <20180313090249.cdurikolfwc5qyol@mwanda>
 <20180313130629.c6zmvoy5o7a5ax2c@smtp.gmail.com>
 <20180313135957.jfgxmq7gtcfgwdhe@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180313135957.jfgxmq7gtcfgwdhe@mwanda>
User-Agent: NeoMutt/20171215
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
Cc: devel@driverdev.osuosl.org, Graff Yang <graff.yang@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13, Dan Carpenter wrote:
> On Tue, Mar 13, 2018 at 10:06:29AM -0300, Rodrigo Siqueira wrote:
> > On 03/13, Dan Carpenter wrote:
> >
> > > Ah...  I see why you did the ERROR_MESSAGE define, to get around the 80
> > > character limit.  Don't do that.  Just go over 80 characters if you need
> > > to.
> > > 
> > > 
> > > > +					"fclkin");
> > > > +				ret = -EINVAL;
> > > > +				goto error_ret;
> > > 
> > > Direct returns are better.  Less chance of bugs statistically.
> > 
> > I totally get your point here, and I will fix it. However, just for
> > curiosity, why goto in this situation has more chance to generate bugs
> > statically?
> > 
> 
> This is a do-nothing goto.  I normally consider do-nothing gotos and
> do-everything gotos basically cousins but in this case it's probably
> unfair since it already has other labels.
> 
> Do-everything gotos are the most error prone way of doing error
> handling.  I've reviewed a lot of static checker warnings and it really
> is true.  I can't give you like a percent figure but do-everything error
> handling is a lot buggier than normal kernel style.
> 
> This style of error handling is supposed to prevent returning without
> unlocking bugs.  I once looked through the git log and counted missing
> unlock bugs and my conclusion was that it basically doesn't work for
> preventing bugs.  The kind of people who just add random returns will do
> it regardless of the error handling style.  There was even one driver
> that indented locked code like this:
> 
> 	lock(); {
> 		blah blah blah;
> 	} unlock();
> 
> When the driver was first submitted, it already had a missing unlock
> bug.  I don't think style helps slow people down who are in a hurry.
> 
> The other thing about do-nothing gotos is that you introduce the
> possibility of "forgot to set the error code" bugs which wasn't there
> before.
> 
> regards,
> dan carpenter
> 
> 
> 
> 
> 
> 
> 
> 
> So actually "error_ret" seems like a pretty reasonable name for a
> do-nothing goto.  I no
> 
> I've looked at a lot of error handling and this kind of error handling
> is more error prone.  The single exit path thing is supposed to prevent
> bugs like not dropping the lock on exit and I've looked through the logs
> and counted bugs to see if it works and I don't think it does.  The
> people who forget to unlock will forget to unlock regardless of the
> error handling style.
> 

Thanks for the great explanation :)
 
> 
> 
> 
> > I will send a v2 with your recommendantions.
> > Thanks for the review and feedbacks :)
> >  
> > > regards,
> > > dan carpenter
> > > 
> > _______________________________________________
> > devel mailing list
> > devel@linuxdriverproject.org
> > http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
