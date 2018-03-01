Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3861594-1519937689-2-10445084361986851569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519937688; b=OF2ZOXcufMYyR9bkKAbEE5ubRK0cWQC6zBfQVGBjNhlbyyK
    oWu+bil/hEFsNmuMKF3LdEcnQGtH4wJY2B6n9gQ2+sFy6lxtuezckelc2lRSIeGc
    rg9lRdwvPNCU7ldTAbIaq2f8DaJnNoveqrMokuC3ySV4viqjVizPtzGv+O6gntXj
    15ZpUepi288YQhLMCpz5WoVX1TBKHDOOn8ArO1v7Lzk4nmCbxEar6yukr4c+w/bf
    rJl621V12LDdQ3qnRcUSDfxHnWodUMO2en6RAMzU93psg8yJVzq3q9zbgO8XytXV
    w6AKm7mEuox1AnwEjHXz8+97gFXEMMRZeWDh0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519937688; bh=f
    FC2jwkfXj2OIg1f3hpbU8Vm4Qhcmn2JmRBL4DRRQvU=; b=Gm4TrBhxV97tGHbgN
    blK508OpeMZ9mdUxB5pjb3hRtGJsQfZtUzwpWbs59daUFtZzDRnx5B+jFSNmCDzq
    InRls8+oP1TtOTk97OrUmY7sj73073mvHHFSYwG3+ecdqVZxx0zRtzxHyPqn/lGl
    ukmoXtrY/6v1sHvz8uT0fhs2p5J8XYGuH0fXY4nJ2zKqXkqEG3+XB3JDbVuGXE6k
    vif92Lq9X2fDYDz2JjmlCY+r8FMj2sxR/tgdJoJXMSgav2uKPLhbwEI1U5kmKRW8
    8OJHdinMy/EkdcandH5qt1pcfx2GmW3cQG9p6dGdnajnMXUGxVxwTyIoPNrg6r6Q
    nwG6A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVmg1ITL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=i7UlSThp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVmg1ITL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=i7UlSThp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:kGiYWiSiVrXVvI8ThX6NRu_oVPGLe6DLp2yYTIznBZvLnpmPCwBj4g>
Date: Fri, 2 Mar 2018 07:54:36 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/5] staging: ks7010: Factor out repeated code into
 function 'ks_wlan_cap()'.
Message-ID: <20180301205436.GE4059@eros>
References: <20180301051911.1314-1-quytelda@tamalin.org>
 <20180301051911.1314-3-quytelda@tamalin.org>
 <20180301063721.GD4059@eros>
 <20180301111500.lxge4yqfyi2najt6@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180301111500.lxge4yqfyi2najt6@mwanda>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, wsa@the-dreams.de, gregkh@linuxfoundation.org,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 Quytelda Kahja <quytelda@tamalin.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 02:15:00PM +0300, Dan Carpenter wrote:
> On Thu, Mar 01, 2018 at 05:37:21PM +1100, Tobin C. Harding wrote:
> > On Wed, Feb 28, 2018 at 09:19:09PM -0800, Quytelda Kahja wrote:
> > > The code that generates a WLAN capability mask is repeated in five
> > > functions.  This change refactors that code into a new function, which is
> > > called now in each of those functions.
> > 
> > Perhaps in future something like:
> > 
> > Code to generate the WLAN capability mask is duplicated five times
> > 
> > Add helper function to generate WLAN capability mask, refactor code to
> > use newly defined function.
> > 
> 
> I honestly don't see the difference between that and what Quytelda
> wrote?  I understood the original changelog just fine.
> 
> regards,
> dan carpenter

I had a feeling that the sentiment of the suggestion I was trying to get
at didn't come across, thanks for pointing it out.  I was intending to
suggest not using sentences like this

    	> This change refactors that code into a new function, which is
	> called now in each of those functions.

And instead use, as suggested in submitting-patches.rst, imperative mood

	Refactor code into new function ...

FTR I find the English bits of kernel dev (and programming in general)
the most difficult even though English is my first language.  I would
like to write it better.


Hope this helps,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
