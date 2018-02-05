Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3465232-1517866550-2-10622750051010213457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517866550; b=fpHBwTyCXVWTm7AiZdhKJxEkCPymrCf6nNrPxyPOAqFx7QG
    /ATGLI/WnXj8C1SUge+8yOvAkq2OoGESOrYc5uSwQgAvrBT09h9RIj3OihqqyNGn
    54TznYLzWYr0/4sdP+aCFqAfFxDJ/CVTs44+D60oIDV/IRy+sAQzrBQhivZvogQ2
    Tz0VuO18Whhx13MZl/2DbFcTfakqIDIFfAc29/DialE5F1UDvOjyhnZtgcH8qsar
    FSWMM5gQxMwKI0qdQVv7SYvT6ThqtmviTulqlWe3V1cpGcbxI+T62Yclhrf0scdk
    v3h/b3OKTlq22Wu/aXjmshwV2laVPILhzOB9oxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517866550; bh=rHYOsqw9mk90edbuadTAuC8ya4
    ZAxGXwIYO4wMI4MZo=; b=Xg7cKJfMiuajgGwCn8GMnG+Vg0jOloJdYvn5HlRANY
    YC5I4rEBUe4qFFRwENjrLL5wNFAG54SnL+7Kj2WNdZaScO+xmLDZJNkmmV+DKMAA
    qaa0KTv4O7vrMx85ZqiYhV8gWuF3MPo0QvGBV8aYFiS487vhlHVocMsdUJiGgSWF
    ltviHIm8cgPLnVgM4yPArStT58a+g0p95cm6qdDio2ePv9UM0cV0cN9c3dBqZPMs
    WTWXpC07iuA2xZ2qJiZ1+vJO6f7fB8/ZbKB9o1om2qsHz8OLtePCOlL8rQPXhq4J
    1CK7DwKHVmj9TC+fFY89t6ero+M6RyX8G8j6t00l2uLQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oNmV6s4m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OebvSpB1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oNmV6s4m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OebvSpB1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeBEVfs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 16:35:48 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43674 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeBEVfr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 16:35:47 -0500
X-Google-Smtp-Source: AH8x224/heyvBu+AGQTsVOeMZ8gFcx7OOQ448Rq2NuSCD9a1zwE727QKiFocBD4GEMNGbDsznE1hCw==
Date: Mon, 5 Feb 2018 13:35:44 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
Message-ID: <20180205213544.GA28867@roeck-us.net>
References: <20180205182351.774761393@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 10:23:28AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.94 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
> Anything received after that time might be too late.
> 

You'll also need upstream commit 0b5aedfe0e66 ("um: Fix out-of-tree build") to
fix out-of-tree builds for um.

Guenter
