Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1055825-1523542281-2-3322403871425117365
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
    1523542280; b=Ew/5oZOE6XztgsYbEdq+HEgRh4K2k+zqr7F5QDLYJI/QXg8Qpj
    laNw7cQVqqqAvXCTEd0oHaIllsL6aTqcLvekde9gPDfOc7RbLl7yPipkjOvAYEE3
    h+8qYJnx+yjbmHRRtGRgFyR9o+xcH11ovA7WZyA+DtYeU60RwqK0wSuB7qf0iQiI
    gV0cgAj9WhzF33RIrryX5b8x4K077axR+j+dDA0shD8GY9q8w9xWfZy4ISarcM3d
    bWsgoKu4uj4dhJt1IYfEnDBmpDKs+eDoHuSvb7bWUY5v70rvEAMxLeIjI5497azR
    7gLrW1mt9Gr48DRvB32Bk4u0jOJJKadw13nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523542280;
    bh=LOuQcHzHQC8adWOs75qkTxcNo9U1wK/uUBAIi6Agob0=; b=T491cHsqjTjj
    V7xrBtKv3g+ItDeMe5oE6i23ZjwaE2PXTNHU/RDayJh30zHxmED9U4se2uNKC98n
    e4iSA+opYnjkDra4DZzn1fXGUaqcO2BRhKa6LR1gx8xQ0ipipJPe+eXIKAc43fsQ
    5AnTtksechNbB4+nFf5LOQZiFMHqMCQ2BVhoj8Q6IQadF4WiwTGoxqCAyOl+m9bP
    b+oDbhrdReeW73qOnFGaVHmJDZ2d2NlJbBDkOFSrQYBYFGCo9HnAdMQosBItZXKv
    u389dBMchBd0QEXDjrtUn8gg+GGdp8Dgi0RsTgSIiYnDVChXiO7nVnLmdgqCzrgg
    kUBT9UoZZg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=q4y30nRp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=pdwuvHb5 x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s+qCHsLM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=q4y30nRp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=pdwuvHb5 x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s+qCHsLM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCs19iT/4zpVQreswGugLYE1F4bLQ2TDBRqFl13qpf/4vINuaXC/sEs29413Wu2jGACoAjvw/Jr9M1iaU+gBYomiJAQOJx2rHezw+7U0Ej/zMA7bljXx
    LMO8d3fZJACoo9UYO7Tsg3ERuADanw4TkkhAUso3M+eHoey8jneLOpYNSovoqB3/aIkF4RZZDRF2iJ4zBXfQ59D/BQqYbbpBl+rrPEoV7eGd2sgNjQMR3b1k
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=PNEW9ARZo1rx-qFoxskA:9
    a=catItlxApSXnirOe:21 a=1mmffojyOfov0EKF:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeDLOLA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:11:00 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:41240 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753068AbeDLOK5 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 10:10:57 -0400
X-Google-Smtp-Source: AIpwx49YSg2ywniQ2veaDJ6P5iiX6+oAx4aDetle04Vd4OxiJzAsqVvvfcBnFkVMuQrLgStYUj1Kow==
Subject: Re: [PATCH 4/4] dt-bindings: Document the DT bindings for lan78xx
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
 <1523541336-145953-5-git-send-email-phil@raspberrypi.org>
 <20180412140409.GK28963@lunn.ch>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <0bcc10cd-2a25-311f-d006-ddefe47567dc@raspberrypi.org>
Date: Thu, 12 Apr 2018 15:10:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412140409.GK28963@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_07:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrew,

On 12/04/2018 15:04, Andrew Lunn wrote:
> On Thu, Apr 12, 2018 at 02:55:36PM +0100, Phil Elwell wrote:
>> The Microchip LAN78XX family of devices are Ethernet controllers with
>> a USB interface. Despite being discoverable devices it can be useful to
>> be able to configure them from Device Tree, particularly in low-cost
>> applications without an EEPROM or programmed OTP.
>>
>> Document the supported properties in a bindings file, adding it to
>> MAINTAINERS at the same time.
> 
> Hi Phil
> 
> How you link an OF node to a USB device is not obvious. Could you
> please include either a pointer to some binding documentation, or make
> your example show it.

Thanks for the feedback. Would you consider this (lifted from the Pi 3B+ Device Tree)
a sufficient example?

&usb {
	usb1@1 {
		compatible = "usb424,2514";
		reg = <1>;
		#address-cells = <1>;
		#size-cells = <0>;

		usb1_1@1 {
			compatible = "usb424,2514";
			reg = <1>;
			#address-cells = <1>;
			#size-cells = <0>;

			ethernet: usbether@1 {
				compatible = "usb424,7800";
				reg = <1>;
				microchip,eee-enabled;
				microchip,tx-lpi-timer = <600>; /* non-aggressive*/
				/*
				 * led0 = 1:link1000/activity
				 * led1 = 6:link10/100/activity
				 */
				microchip,led-modes = <1 6>;
			};
		};
	};
};

Phil
