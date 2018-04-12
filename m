Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1135939-1523543650-2-6439561222919017140
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
    1523543649; b=gji35gMfSLSq+ld96J77TNro0zEbf8XgyeOjG1aymf1dH4hGux
    h/Frx9zPfJ0xAHlUsgNdTfQ8yD/Kt7Vnc23yihD31KR5yuIVgIJUobsy9URuqoAC
    JRUyNdBkCRpVNehoCBsWl6fCG90kTpiR+OVlbCmzUCBGzqWrOoI6xEOCin+G8QfR
    M6PAyrCwy/uopZEWhr99yH3ru7eyCayDgonJ8Uuzi/qlTHb5BoYOKZOCgJlP9r4w
    qZLxOXUMDPT2vR5J+Eg+Td1QkhsEUYK0NRshjvbY0IxJ8mOidtoiEcK3xfTJSKyI
    pEKdR9F1D83ZKddrRzR6iE/mT/MFUWmrnbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523543649;
    bh=uc+I48srgyvVVbcmjQmUyipkd7wIOPwe99luS2byoVw=; b=AoUTJFhfEyiA
    rvdbAOU5wIVg+Wjrke46TgooKwStztm5gs0Jt1lVhG3I/vSIevYmRI+yr16B4Bs9
    e3dFSPKHz6OVJDooxmNK69Ne3IvYjgE6A701MkJbfV/0ilo6/NAS9AsQq3fPU/lA
    tTTRZ312mwGfZtzA6Cj//oLSa+N2Dfu5RFo0UOHvvbSWCkEujmhCy1pk+0lP7z97
    W/5NYQIItGOvo5HSdBoMvjZjaxzEHiY95Urgr8UE2EaCbyPod1J5ttho9t/LHfNC
    T8tzUn0kAiEIWzd4sFgFPCWOcQCwNKKwy9Zvsrm+DQwjELvx4GPaNDv0sJJvLPsq
    pb8YkyoH5w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=RnLVv4ow x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=gE9jhNTn x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tW/hY0xz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=RnLVv4ow x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=gE9jhNTn x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tW/hY0xz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK8+JTT73hwQ2rLUxBWHGQ/mwkJWqAsJZ9jFscqGA+MN9XM6BbJ5IFZigvhL158UZYgPzJehopqFIVbXFozKJk7F1Rqxc+C7IqQrDAKLuXqUthIEhij+
    oHpG4FMDiLLZThf3eiQM3zsDUrloMaUCU/Ij/GJmlcCV/yrhkxinx3bgyrZo2Tx27A7jy89YhtibuNq6lMQwbHcCDiEcewZPEvihyTxcLjnWs9rE8vjRMti6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=QXWLXoly_IzZJv7RnlkA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeDLOd4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:33:56 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:42542 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752951AbeDLOdy (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 10:33:54 -0400
X-Google-Smtp-Source: AIpwx4+C9gs+On0b5HBTzU0y+RaEP7AhrzwOWIy4HQ4wuYmYsQEquJpRdpviAN6791tBi+/BB8Pm5g==
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
 <20180412143007.GP28963@lunn.ch>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <fd303b96-b01b-3fef-c36a-e7ae25c2ad30@raspberrypi.org>
Date: Thu, 12 Apr 2018 15:33:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412143007.GP28963@lunn.ch>
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

Hi Andrew,

On 12/04/2018 15:30, Andrew Lunn wrote:
> On Thu, Apr 12, 2018 at 02:55:36PM +0100, Phil Elwell wrote:
>> The Microchip LAN78XX family of devices are Ethernet controllers with
>> a USB interface. Despite being discoverable devices it can be useful to
>> be able to configure them from Device Tree, particularly in low-cost
>> applications without an EEPROM or programmed OTP.
> 
> It would be good to document what happens when there is an EEPROM. Is
> OF used in preference to the EEPROM?

Yes it is. I'll mention it in V2.

Phil
