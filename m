Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1421432-1526128600-2-15626599613042920816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526128600; b=ko3QO1IAb3YROc07l/qBzAksCA7XDm3yWHdP4oAFx8vodKJ/Hk
    OgH4k+3frPViXQCKeJej2AN1x2eBBo5DlG03uAV+dwwcGQ+97bQJf4IhNeskFpK2
    Trqmi/F4FHy4zjnKbWGNFRzWLAhBUHcyKmkyii7QkgQuXLDwItqhHTnSjoH/kYsA
    T7/LSEH7mA/Qc28YlARBB6VscwkXYcUCqzWImVVf30SDc9V0Zt2ccasDYv2hJBmb
    OwCBtcxL8TuvFIaIOjb4N1fPBwZc26w8/kPu3gX+NhG0+pUEAuJ4AOGyw4VoyYQP
    yleevL9XZdppbLg5IyztrJzGAgGLgs3eEXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526128600; bh=Dd97N
    LuvT9Bjwjsia3lbvsW85qHDMLFKoc6Y1jAfUY4=; b=YCFZvwh6XFVrhS2WoC/Q2
    tRPa/33qB/Gq84ss/gEzesaaNxS6kawnN5N+5SBjcaTvsLt8WKPtAQduMYZ002n3
    GPDa1v1zJiHqiYcZoZxDgjl3zO26MRmB6fxVImOaao2PCFWCEgoKEPP8+TW7IZdX
    MtRBWdxL9CLhFwZoxCt3InrdNAtwTUKALjAPfufCDxI6p9TPMfQS0zXN+NDJkw2L
    H3eQe0U3phR3UPsX88IDGt9XXbVuBcO/btE5M2D9iO+4vUbmKAu2RcIHNPSQf1ji
    yDgHKIgv1L1lxxOvbozE7i6saKWsfiFu9yWDGf9zU2b4349rfNEnbntiROMWY/5K
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=B4rsXigX
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=onstation.org
    header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=B4rsXigX
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC70szKR2ndDA4HuhFxN35ze2Cz8JBQoxlfjsJpB4Xgb1KttZAdyb0NaqmdcneLLJfShKTF9dCKxuAPA/VhSwOdNNYnrLJx3SEVHDHky8wtdU1Yyoe9B
    ksSqa48E9ZiP88UKZz2AfrKDR92ouYl9EXnIZF77t54R/1+czJTYk1HDKFVQ7j9fvAgtjhSi0xBFd3gjpOWF3UR7F6JrbM/K9ajvamnu1TS9D10S1PhgBypu
    rhLGmCeoAah+ly194jabvg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=NEAV23lmAAAA:8
    a=DDOyTI_5AAAA:8 a=kmrfREXqXcUkQmjdjicA:9 a=OehbugL-hEWRqLFC:21
    a=_PZJKpjOG75DO1cA:21 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 12 May 2018 08:36:30 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 9/9] staging: iio: tsl2x7x/tsl2772: move out of staging
Message-ID: <20180512123630.f2b7opaob3cb3fom@a2245dbc7726>
References: <20180511001223.12378-1-masneyb@onstation.org>
 <20180511001223.12378-10-masneyb@onstation.org>
 <20180511003206.pgh244sd5t6v4njx@a2245dbc7726>
 <20180512124437.6526c6a0@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180512124437.6526c6a0@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de, drew.paterson@ams.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 12:44:37PM +0100, Jonathan Cameron wrote:
> On Thu, 10 May 2018 20:32:06 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > On Thu, May 10, 2018 at 08:12:23PM -0400, Brian Masney wrote:
> > > Move the tsl2772 driver out of staging and into mainline.  
> > 
> > Hey Jonathan,
> > 
> > Here is the .c and .h file to make your review easier. Thanks for all
> > your feedback on all of these changes to this driver plus the other 3
> > that I've already moved out of staging. I've learned a lot going through
> > this process.
> 
> I have the great pleasure to say APPLIED! 
> Congratulations Brian.  This has been the longest and most complex driver
> cleanup I think we have ever had.
> 
> 64? patches 
> 
> 930 (+ 366) insertions, 710(+ 368) deletions (brackets for the driver rename
> which only sort of counts.
> 
> + this is the 4th driver as you say.
> 
> Particularly pleasing is that we no longer have any light sensors in iio staging.
> 
> So what's next?

Great! Thank you!

I have two things that I'm planning to do next:

1) See if the tsl2583 driver can be cleanly folded into tsl2772.

2) I have a Google Nexus 5 phone and I'm going to work towards being
   able to run an upstream kernel on the device. There has already been
   some work on this so looking to join forces:
   https://github.com/flto/linux/wiki/hammerhead-upstream

Brian
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
