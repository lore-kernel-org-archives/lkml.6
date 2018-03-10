Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3418695-1520696625-2-315471760146572964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520696625; b=md6rwiXUvYVmcGKnE3bKxxdZSH1xo945CgQn7Ryw1nHnzrl
    BTyzNskyXJk8prNr1D1vcJDnyry7A8arpO6Lw1ig/GiNOJ5iK6vyGps4fC/31V0A
    E1y2emsq1wzEwGBAPPkksCglNaYJt5LWTcadpli0n0Ft8wS6hay7x7TSHR32fjgF
    lTwJbM1j4dlB6MeNrHCxmtyq6SRjLiUorJT/quWkUT0ncP8/Th0mrHcK4RlrEgpE
    xMFGMed31gZ8eCGXSoHM2x5JQeRNOU+yAJKYMTp9XPYTxwja+aNwCud9JJDZEtg+
    t0FwU0CYwvjbIzYCHdPp1XTB5EgDovY4tt0mLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520696625; bh=LV1Azqc2lr3yTyrrQ09buxQNLaZCBHuMyx/2MbZtDAA=; b=P
    gapLjTiubH8/C5Bh/jWIEE0eeBEm/fSMlcDKUg6rWi4+ugWBGyEScLUlAzMf1RHm
    RpOiJrAuMwwF5slh2FbB7jmIIWUc98DaBxULlOwGqwYHzeFzYEXGxvZ90sumeEvq
    OKxi6VUEFFE+Fz1UoH8R0YdVeRoOKlMJznaQlksgAH3YgbtXvi+dF+9tA77OTCFj
    /MfpL+yljwMVr0vRn5uDw9QKpI7HLmIYOERtmlRohj+anHt5sl/sNMWzFNr8hg9r
    Ek1+1tnugA7Ndr99f7SVFBd+oQH8gn50mwLzU18Me9yGffNMAJJLOQt4DPrghKwG
    MXRBZ8s5X+iR18hDy32bA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rpgPT3wH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BWAuF5MG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rpgPT3wH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BWAuF5MG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932284AbeCJPno (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 10:43:44 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:40434 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeCJPnn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Mar 2018 10:43:43 -0500
X-Google-Smtp-Source: AG47ELsEKqG9RXkW0q9+dFiFgV3mHnzJKKR18Ges1AfNeIcDbXV7f4KmBZRw2x+CIwzIb4dhwZPAog==
Subject: Re: [PATCH 4.4 00/36] 4.4.121-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180310001807.213987241@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <796cf64c-5797-3337-f9a6-fc032db4c6de@roeck-us.net>
Date: Sat, 10 Mar 2018 07:43:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/09/2018 04:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.121 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 12 00:17:54 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
