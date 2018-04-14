Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1002442-1523676337-2-848577551818777764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523676337; b=qGVoBgkG8Wp/sviqp/OWpUvOUwuHsQA0HwTdWID/Xduv42IZPU
    /2+Jzmz0Sg2TwP7q/idyj9niZBNqJ8C73au6bHcDwTYU2OEjSd4E0pW6VPsOi3nq
    FCmJN9YXkRj4q92GwPXNJ3P+2L2LEqvXrECgWiPKE+zF2ZbWHX1XyKInhKq7i/MS
    yIVTv3Jd3uBzOomOvz4L5KdyzNW1oSj1ibvgSRjUXxFB7waryUz94VFqmWKfo6/5
    2A4mfcBDBWkCNo3fo8hwn4uvutkCRIURLx44C3KAe2K6BSu33mE+QzzeIQ8iByAe
    7q2FSCVngGli9r0FL6HmxKrmVwjnYyu4wqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523676337; bh=X3xNz
    kA/xrcVvGErE81PE+NQ/FIAWeEBYNDYFtU0ITI=; b=goWUpYJgmv2Ll3TSAiPgi
    gHIE0H0H5OGZ8GXpWxG1v5Vfpim1oOhBfKT0JSebyw81W1wDRz4gHCBt95c5HTKm
    Zu04oa0O2RgUbGqzhGEhogMq5JuJw3VFrE5X9fpYJtLcYZQr5GZuZvrtSb5tImd6
    JdENp/yYIN/RO6H6/+M1EAS2e0+U+dbsCywLPSn6PiylbK8ltiooVwcDYtvPw/NM
    7m6FPU1KqmAwF5ZgIz9m3jfp8IyM+TYKILXO0cEfUN3ShBSkDg5JYo9wvigr7w+C
    dJJJ5YkJ4jdZqhzTmOHCqZV1Q+EbNe8i4OVvAoLzkBbpaS0b2ygK0ocJgxV/BnSj
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SikgflpJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qbc3AG0e;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SikgflpJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qbc3AG0e;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCKQXo5w2mKnBb/ryTh37Nmw+GyG+tpkUlo6wnjiDnY7tcF8a40ck5ULg8ca2Y/WirlQoTz2hEi5ODLXjqQCM0FLqcCEolQbwyLX6QPZrK7WubZsjUn0
    Ofe6rBTxN+19lnCn2qpqfsxcAfXDM1CJ3mFJ2wztnocVz1GgTFIXwpRuRwNo2cicmg5err8qS0dbaTUM7qZiSE4hh8Vkl/EGSks0cXTYWLU/44D5fTOGMkbK
    lnDZw1tKa4L9Y3RokGHZqg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Y44SiAWf95kA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=DDOyTI_5AAAA:8 a=gOayJS5D-P_K3pGDLKgA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+haCNhsBfXiNBL3gzBcY/0n4fSqZWzkgKDs3W6vdz/dzHIBxaBjm9wZWxIZrUp6JV60q9NBA==
Date: Sat, 14 Apr 2018 00:25:21 -0300
From: Renato Soma <renatoys08@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging fbtft: Fixed lines exceeding columns limit
Message-ID: <20180414032521.GA6039@rys-Inspiron-5420>
References: <20180413001602.GA18920@rys-Inspiron-5420>
 <20180413125747.ccynu6twioa22fee@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180413125747.ccynu6twioa22fee@mwanda>
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
Cc: devel@driverdev.osuosl.org, lkcamp@lists.libreplanetbr.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 03:57:47PM +0300, Dan Carpenter wrote:
> > -	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset, 0); \
> 
> I feel like the original is basically OK but if we're going to change it
> then align it like this:
> 
> 	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,	\
> 				 0);						\
> 
> 
> Etc.
> 

Alright, I'll fix this issue then send another email with the fixed patch.

Thanks!
renato
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
