Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1229063-1523546245-2-7368815677048803693
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
    1523546245; b=HaA72j0Dpg+bTP8Qn/+bl+GBk7Gud44Ps5UCrl1plURXK+02tm
    14hSyW9p6/19ysmqEw19ASnqmPd27KFNgGWpDaX1SPEkBQhgnAGNa1BK9joXVzKq
    7k7ZRig4vcwHgE6t3RJfmK3y4z1dUbn2aP9FsFXb4W7dw8ceXcL+UUxk2IfQbxXs
    wgtPWGhE56btuW7WnP2af8TRD94G4jrtlLkJyu+ho59rjtKPFztJ4zq4vYLrfcsZ
    WISOMTfMjcHzgggbYP0RFp5cXunFDk2e+GvyO03yGeN3wBlobaHR8tt5GRJxDH1Z
    LSSrk1uBd5hTIaE9D2OlGjnp/qaDBmxJGpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523546245;
    bh=HPdj0bSFgSzIN6B8RqRVnGNNNdbTgQm56Sv6WSoG3IQ=; b=DOvuBmj6qk9Q
    Hy0K60Xj4QdUzIGuIj6jfIjKGiBrkkPXRzFosRe9Iofo5nV8K86twR0j6BsytmVu
    uJZxQWlbk+y7OAswp8lrO1zrY1TWiYpMWD5pER80252aiA4IqWxKqtK6Os07wwqH
    wu2lCHkiczUdaW6/cFgpEezqxzSMxzY9G4p5se80cnPUQc8UDx8WtU52BZIneIC1
    ODGpigPNhLop7SUFIf3L50j8YOx1nJvXlJwHn+03w1OaVfUZDKk7evdMkGePN3C6
    bsibiG+FM0bub0u0DkRffBUPg0jk3d+mtE+Y7xKtTIp7VNSnxKTOq2mDbNtl11g6
    SH0cSPeDKg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=IDt62dLj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=E/pPRGjd x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RCxbHwI/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=IDt62dLj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=E/pPRGjd x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RCxbHwI/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLgRBXBHauodqGolE55PAcy8YB5r7C5B6IAdZHn+7WeeMDjZlt8DQc2N8LiOKCfGpZw0pH3nDSBDzX02E9McnbkrrfMrw/wfhZY4l0PgKnfPEbcv659/
    bHXmTrx8N1IUswdfmYwl/k1+tsz4Zi7XRi07dFn7BKaa40yBlLGr2pl1YQdoeRgzfe4SNC7Kz+U6OqNjUt+NCletDPHYjOjPuf1kZaFL4TR9e+BY73yellkN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=MGeqcaCBN32jYyg8Q6IA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeDLPRI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 11:17:08 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:44872 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753704AbeDLPRE (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 11:17:04 -0400
X-Google-Smtp-Source: AIpwx4/6wyZfVs4GH13Vx36Zdgdur75VySXJ/6bKPbhe5gNU1PnsXatNwtVzrcpbMcxoJ3nIxALcoA==
Subject: Re: [PATCH 2/4] lan78xx: Read initial EEE setting from Device Tree
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-3-git-send-email-phil@raspberrypi.org>
 <20180412141630.GM28963@lunn.ch>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <27e04eb4-bf75-d5ad-c0dc-bc0153fd8769@raspberrypi.org>
Date: Thu, 12 Apr 2018 16:17:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412141630.GM28963@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_08:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andrew,

On 12/04/2018 15:16, Andrew Lunn wrote:
> On Thu, Apr 12, 2018 at 02:55:34PM +0100, Phil Elwell wrote:
>> Add two new Device Tree properties:
>> * microchip,eee-enabled  - a boolean to enable EEE
>> * microchip,tx-lpi-timer - time in microseconds to wait after TX goes
>>                            idle before entering the low power state
>>                            (default 600)
> 
> Hi Phil
> 
> This looks wrong.
> 
> What should happen is that the MAC driver calls phy_init_eee() to find
> out if the PHY supports EEE. There should be no need to look in device
> tree.

If the driver should be calling phy_init_eee to initialise EEE operation then I'm fine
with that (although I notice that the TI cpsw calls phy_ethtool_set_eee but I don't see
it calling phy_init_eee). However, it sounds like I need to keep my DT toggle of the
EEE enablement and parameters downstream.

Phil
