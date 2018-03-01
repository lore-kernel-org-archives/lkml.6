Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2070142-1519886253-2-9423643562670435050
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
    t=1519886252; b=qcXi7XtttAZ1SIm8Xa+yfZDMjWAWGRUuhqrxl8tD+Osykl7
    AGVkcZ8HbQjEN0IoxF28Ca1OLPZOKVAkla/WASldwkAjo5AHjc9mtnJuNIMkWHXB
    W8lLDVONqqnYo2jlcIi32GBwxE1p3ugFhCTi7MBA5mkXBH6hYAwtnL40Tnq6r9w3
    ymc1Nxyc0iwPTNInj75WP6FIw0fuGfLI6Nht5tdfVbT7mxJ/ihZKUHoDLgm553tt
    BZK9c+F/g0ldvXZNpYmq8Xk2SwArJkE666kfY+YEdGy8KJObOPw43WOYh8tDneJK
    Z9WekZKU2jDedDUZqxf2h0n105jGhPg2ALlE96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519886252; bh=d
    tW0KQPOnHqvHo5jLFDnXrrPGmOzms5F0cvUkue8j7M=; b=HuTGIzrl6ke02nVLW
    ABUbuq02qYQ1i1zPInvRoIA2djEKDkh8a14m9mTSyOvQ55B5fvvOyfr0BocvHBt9
    0UQosocqVeq0EbG8HMGW2BOPzQ3f0C1jHeAgFBetRb4B+BstXEqvkGXT9Wwp2CM3
    fhdIjio0MQWIi38RrIFhLK4Y+rtoHvfr1s3SCpL/yWqCS1u1x1G/lSA/jYqKDMKD
    FEoFAhtqjJWrBeR4aiJE0VgsgT7I9towSWZOiUsPZVOi+0Q7VTVyuvRWFXRriCQ+
    8YYzUHXiCiXlAkj1OHvKjBpBPB47a7oMf1rrw9zcfpYy7WKZwOyoPmd8YyWszsQ6
    0qrxw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=WakIrCcd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=Y4d4MNRz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=WakIrCcd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=Y4d4MNRz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:o5-XWq8b2fm4UNdIMjxZH1RMV3DLwO4vKhNMWf557B8Cpe3PdkdAuw>
Date: Thu, 1 Mar 2018 17:37:21 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 3/5] staging: ks7010: Factor out repeated code into
 function 'ks_wlan_cap()'.
Message-ID: <20180301063721.GD4059@eros>
References: <20180301051911.1314-1-quytelda@tamalin.org>
 <20180301051911.1314-3-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180301051911.1314-3-quytelda@tamalin.org>
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 09:19:09PM -0800, Quytelda Kahja wrote:
> The code that generates a WLAN capability mask is repeated in five
> functions.  This change refactors that code into a new function, which is
> called now in each of those functions.

Perhaps in future something like:

Code to generate the WLAN capability mask is duplicated five times

Add helper function to generate WLAN capability mask, refactor code to
use newly defined function.


See Documentation/process/submitting-patches.rst section 2 for more info.

	2) Describe your changes

Hope this helps,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
