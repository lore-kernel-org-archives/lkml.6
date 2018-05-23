Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-353908-1527091876-2-5538646196477917642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527091876; b=S+StyqKuoq8Wl0slN8vwkDq04y0wz0YVQf2IQQR1cWwOhxPU00
    uhXYwAMpu9Np4MgzVj+qv1MO8lzCL08pY7vl3E4b4OZUFKJ/ghn87cG0YWXiy5NZ
    o8VmynhACHc2Zs4PZxgiOdf78DGrYEiPa/8Zw1P4f3398N4oebdkYW4k5VLu6su9
    s/RD4hGCqhuTF3jEjPH8dWzBe0BMjaDp+b7TCkWNf57wKRoD2ocJkQqgTG7v1Fln
    qBDb1GqhWFluSKQxItYGzq3jCqYVB8RrUeirkwXqNSSLIqb+cfH1Pj4K50fVPrKf
    DHRkrwINekOnN3pvGmZeRgK4v9t8WGS8x8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527091876;
    bh=mlDNsAUeKhsutVS68V7sJLTxJ6PieipHaboKc3Zbt8k=; b=RD4Z1BoD2c7B
    oZtfOJM5K3kkYkg6MGjSPXusgwIZ0W9H5f7D+CoTzgVx9dvuxF1IFb+aZJbc59wN
    JrLIl0hOeIbRwWfbxSjmaUjlMj753xH2MDhSBj5U/u5rou3rA1HLl6YseRCuxt4C
    PAHqdcbqOnuBTsdIVfHOzD/D/hquRDjV8Ykpopq3KOh6FktZg+drzHztSqJd4KiE
    dg8NK9oL+J8B9OPqm2yeyAXM1uZNvSDYcX2T7zG1n9ldSjLdmldfsf3Bkh0/kcK3
    xbNm7bmvBfKsoEIZSxuJ/fj10+gG+J+Y5Nhxm1SGfmJzUvV40Fvif5C8ocucj5dH
    qSF3U5gP+Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=cogentembedded-com.20150623.gappssmtp.com
    header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=d2ImTX8h
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=fssGka1S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=cogentembedded.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=cogentembedded-com.20150623.gappssmtp.com
      header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=d2ImTX8h
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=fssGka1S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=cogentembedded.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBmf65LcF0k6gvHsfaUAUEOQcQn7NikkpMuICYF6DSktAwRV3faZrZKjJr0TmWdWgOjdhFMCN6GLyAHgKsZtMjkgag/twagMFTpnLk0y6cwnZ6aJKp7M
    okMSJluqpy9MCkcdhJMApDIAQQy0dJ2N5MdExdJ7Q+jBbJKBSAVHP2nivRpQgkjLO/NqAcY8KWjsyoXEZDrvMSSM7n8bHTEglBQt0nfeLmmbjrLAiD8JK3c/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=UCrAJC-9XGb1wfOoQMIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754573AbeEWQLD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 12:11:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38876 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752655AbeEWQLC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 23 May 2018 12:11:02 -0400
X-Google-Smtp-Source: AB8JxZpTYFTxd4hsllkRvCeN5D+iLyFfMxjVReLKJa79HG8y6yl1gUzlc+i9+lihGYjUZ61r0jOXYw==
Subject: Re: [PATCH v2 1/3] usb: roles: intel_xhci: Always allow user control
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
 <20180523143758.66348-2-heikki.krogerus@linux.intel.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bb07759b-44c7-33bb-fff8-18910667d4a0@cogentembedded.com>
Date: Wed, 23 May 2018 19:10:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180523143758.66348-2-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/23/2018 05:37 PM, Heikki Krogerus wrote:

> Trying to determine the USB port type with this mux is very
> difficult. To simplify the situation, always allowing user

   s/allowing/allow/? Else the statement doesn't parse for me. :-)

> control, even if the port is USB Type-C port.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
[...]

MBR, Sergei

