Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2445070-1523451830-2-16067491475772470402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523451830; b=NGfyBo14LWDs372cMP3fUg3UfjXxZswe5IUyLUeRlUxDz2/HCC
    KmxcFw2qNGJRLXQ04WAAqn2cVVnivPQuCHY8sZDL6e8lcQhJcXkzETJw3HNDc/vl
    EsKgG5fJq3P9KUvbT9s8G3dRIKh0pOEcy4SVhJ8oY6pjYhdBvveI6LEbWtRwGtcs
    V+25GwRq7DyF382+Jx698yCa/MnYh4r10/jdaZQpUL4a98Ul+kCccMjzH0i0n2sL
    qm8nDAkSmLkxfno950OB0ll8a+Y8RldMzwYPJyif6ESccBSgntVkin+Zs+3rrU4e
    nvetY9io/yMNpAVldg6EIub04ZoRwmHWuj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523451830;
    bh=pPRf+YToI94fkAhzWHQMcFG0ZHVGhmvQdZbdc+aEVno=; b=JdKYJcBH1Yms
    C3hRkBIhY3NuOcmWY9b8IdKYPPoTeKRnXSBlMSLOrH5Y+MMSdpc5nWVW1oli0g76
    Xt0PDQRmom4LZ0Sb/qcD58Ap3zzgKyK2xM+bVnmdT22+UtF3ynGkJiHIc+vSDYSI
    w8DcgGQvZB9gKg13UC1dEvrAt7C7/mINOb0VG3D+ym7zBxLn9vZAjnh+529SO/bi
    Z+onyKvBR6wL0qVU1d3JgF9xmIlhC8X+hFU+1J2WaJKJllJozdl+X2kM5Vvp/ndx
    bPQpAS/2GT9BazqvOfbywyiegnmO8Xp0o6cxJXqSvz0pZtMSd5XA+LZ6Y4mWZCW3
    /19DNxVy5w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=mvgzkp7R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=N0BhAEii x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BTeM8Q/c;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=mvgzkp7R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=N0BhAEii x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BTeM8Q/c;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNyz5xymy9HeBbxPEMM7Cw+geM9IGnYv2592nHGkwtqnBNdgiikmRje22C+WZVg0I+pizCCTPlOFXoWeKTrbldnJKak/80W1Ol4zkbW1RcCf4QLsuVmf
    TLWP6mwjV2SJNIZJOLcJ9YG19xFSlNXty5frBsnhpm13zA0D3u4Hu+9lA1A0x7XtxDgqBxfLC2PX2X0V69BD5CynoVRytwIas2fkKEQoWr1QYY92fFRPSPNe
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=_PUi6ysPFxcmx_umH68A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeDKNDk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 09:03:40 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:59272 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753064AbeDKNDi (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 09:03:38 -0400
X-Google-Smtp-Source: AIpwx4+7CVBE0ZwbUJU6r7HDdUfJPzud8bmq4wr8MAtW80DPBWY/yMMv7mS6/hQcGgn+tP3sHSRb/g==
Subject: Re: [PATCH] lan78xx: Correctly indicate invalid OTP
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523440757-127451-1-git-send-email-phil@raspberrypi.org>
 <20180411125737.GB6119@lunn.ch>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <6615a0eb-a0f4-d964-bab7-e2105b589f3d@raspberrypi.org>
Date: Wed, 11 Apr 2018 14:03:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411125737.GB6119@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrew.

On 11/04/2018 13:57, Andrew Lunn wrote:
> On Wed, Apr 11, 2018 at 10:59:17AM +0100, Phil Elwell wrote:
>> lan78xx_read_otp tries to return -EINVAL in the event of invalid OTP
>> content, but the value gets overwritten before it is returned and the
>> read goes ahead anyway. Make the read conditional as it should be
>> and preserve the error code.
> 
> Hi Phil
> 
> Do you know that the Fixes: tag should be for this? When did it break?

It's been broken since day 1, so:

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
