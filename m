Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1722532-1521562236-2-11042455796400485818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521562235; b=F7tcyuksCyQGkoJo+3S4NE875AWHi1PWhoYpm5sBbKMjHdv
    wjshiIxcesTs4bfyfK4Z93C0Qfgvo32wLO20yVDMdtxk9+nFxmC+1+0AYEQ8moId
    tLZGPMfu7DlC5+I4AjTgwRRpZBgExVVf2tjj5LLX8+4zCvT92VtGDi3/09Q016wa
    X/SWHIigFNIuiFkC/YPKSgZivMFAyaG5hcPcM2Fc2DjIHHElBNPhpb7YoFIm9KKy
    Vnv+xn9iJVQ5HPWmdy558dLINWvMF8CAonXxMmlk8edk2+v8lqeK993LPUY58Z/6
    P60zqDlTLf/YZ2JmDQH6StcjcyHGTmHq6TX9XGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521562235; bh=rdWHi28qWjm/A/SjN9jcSSquEh
    azy7VpjSLD/NfTRFY=; b=PrII37BtQSMcWTHg8jm0lUuWZDzBKPj2bi/LX2b1oE
    eR5nSvBWZYnK1u44/hf0N5PAGGtPoysPZU+C7Leqhf+a3aC7BTO3xJm6jcjWAgti
    ih+xh0y6GUaCSz7ZQRzUSHyjPBSbKjpRndYgrg3Dx7a8EZxw/twXqMgdAql++TZt
    kcy+DsJJ5On6hgRS1+pySPK5lSwSLnXak/9xVeZCQv/SgCnpbkY224JlcwLCdWNB
    SCHY+U5SRHZ05zSYCHvw1VOWOvd7qEcw8yxefd5U+1ZroK4L9cJsNmqjMgXjAmRQ
    Xf8xavSJns+V7p/+CjVYYIVz2HZAMCiMdgaoBIKIDM4w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qScL0+5w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JUMzHl83;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qScL0+5w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JUMzHl83;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeCTQKc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 12:10:32 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:46688 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTQKb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 12:10:31 -0400
X-Google-Smtp-Source: AG47ELs4eTgqB4jpT8EBF447hQCDBd4FT3tlvukCz2iS7MS9UggbcuJX6OQrXwyyLXRdh0yTSnsb8A==
Date: Tue, 20 Mar 2018 09:10:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/41] 4.14.29-stable review
Message-ID: <20180320161029.GA671@roeck-us.net>
References: <20180319180732.195217948@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:08:00PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.29 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 18:07:09 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.28-42-g5efaf4e:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
