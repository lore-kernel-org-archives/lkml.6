Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2109832-1521045160-3-22442980421915933
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521045160; b=WxBxpK4mA3RGDoSrhMfHQ8P7zYnRzHBRLzvdGqCZCM6y8/Q
    VwABlSdAwu9tTJ6FB8UoPquw4NGlPFRKkQbOCSLURmeD9pNjQdXKuZRANjzwqu3E
    zt/KnkmOIDBQyg3NRfbc11mh4wqSvoYaVXIN1Xm9376Jhq3ka71k+5SNgw1tkDcN
    UY9pCuYP15JkrVFkV4olEITn/cKtgipLJx3a2CqN0eUQzjVSN7A9FeueXU1zT272
    EBam7Atkk/Cs07ReVYj9TUbUO1n7gANt9SllTuJfMPd7oDU4YF+h2tfgnuoa3g4e
    6fc1Udfe1JIpgFv0s7HSPi0EwEvp99ErPXXoDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521045160; bh=n
    Qs8uyvJnTFHlOGcZoSnz6Ny/gbr8Iqsu0JCv0j+jAQ=; b=fMgUHTMQdyzb0D29W
    iimh2mySHxCY4wFbcaoac7RPQEHr+6ZktyFeLAaNmjDih/r7IrdZm/DghCVgDzXE
    gTWYsb5QVU0GiBsORIfqBD5YE08aRm+hjqoBmctsWwk0CjXRAzUbWjcgj3XoXCvw
    OzeG7MO651GR7uXuJBmbRKpwEz/o/j74hBHFg6Zsb7QHXbg3mFRW9LcWDWhWpQQ3
    rI+2ch3gHDtQODNfBQCTCVdZxI8A8j6u5nY4u2hbCAaq+GH6G3s2gVkrt9XOl+jy
    iLF//yg1k+oHZSShCWMSQDWH73/2yVGw3Io3i0g9kOy4QyfBbM0k5o//+fgtFVPQ
    qs6KA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 17:32:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 46/47] staging: irda: remove bfin_sir driver
Message-ID: <20180314163233.GB4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-47-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-47-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, netdev@vger.kernel.org,
 Samuel Ortiz <samuel@sortiz.org>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:59PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this
> driver is now obsolete.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/irda/drivers/Kconfig    |  45 --
>  drivers/staging/irda/drivers/Makefile   |   1 -
>  drivers/staging/irda/drivers/bfin_sir.c | 819 --------------------------------
>  drivers/staging/irda/drivers/bfin_sir.h |  93 ----
>  4 files changed, 958 deletions(-)
>  delete mode 100644 drivers/staging/irda/drivers/bfin_sir.c
>  delete mode 100644 drivers/staging/irda/drivers/bfin_sir.h

I just deleted all of drivers/staging/irda/ earlier today :)

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
