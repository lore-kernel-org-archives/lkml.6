Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4028164-1523372395-2-4478996846952014403
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
    1523372394; b=VsrPhGNhHIgzKvv/08xGxpdBhRLkre4GKdR6gXTCIANhRtoRYf
    ovG3Efu1noNWs6OrxVE3btIw3RTiyk9SjFUYZa3aKb0xCWIEkAawGS+p6XdmoHrB
    QahwN+bU4mzuuZZsGm59EGeg3C5YIbfZmUBt5Jv4QtehRBq0YhqeIHcO3O2MpIWA
    KyCCztyJ/mUkhl2HyBmB5MRYGxfVs9ue2MjIwD3rO2rrIxsAAgEmFimcr7RrtTTo
    yTSkQ4I+CxbcPIPRuI6jNZCPe6H9d6QjP6Ue1rIJmsnjgW1k1W04BB9xgw4gT95C
    dsWbFHJL12dyI6EZrQmE21n+4HoikKuA2cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523372394;
    bh=qYO/Yp4pwHPDTP68G280gYZC1VpGqDtkIBRrgr5jo9Q=; b=CPwLjFL2+ZMG
    jqKWJex605V4s51j19VxYoosFborG6hYk3SXcGQ1K0ibGHPejHPGhZeSOCX166jK
    IRlnetGgnxO8X4ELFI3VLUYZIfI+fP84iUTh7CFnGTPA7wQymjmZzDRuKySmvMKo
    rD2sQvC+KWP32KLDK00HzznOAyKdmaG7tf7Aqc0jWzm9Y95+oM2hKjOXD0AiCtvf
    Sb63zlyf1yOwuKGeWdCVfuSfTkWo6XqGqMcdxchMj5VKxhSexfPXR2JlvKwx3Jcl
    CjikNlnXObI8iD+4+9e3BmuyOx8vJT54ar3UXAlc9834kp9f78ySYRlPGonq+FcE
    3nXnaB4TKA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=EBNT1jhB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=bwd1IFMr x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AaJY1pbr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=EBNT1jhB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=bwd1IFMr x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AaJY1pbr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAT9bfuvInbCM0xErbZnOwxwDz0bVVgrph2tWcCP7lbUDKnshvNFJNLKVz1aDwQkIIvFX3Y+xZSiL2mYS/In7Au5kdWO00vysAZr6LNZXrNCrZ7MLqLY
    jtwKn8PbLcOERecvyvFC9ZTeEWlauLomhDHIP5hhs1TmieHR3AReSZ2r6Frv4HF11ISgdV76vBwbHEOIO0ml6u4fjV4vfJ7A1QxqW/qhnfYkyRslIdqhx4vT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8
    a=hAwG8S0E_sH0CUgCzqEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeDJO7w (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 10:59:52 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:62911 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754065AbeDJO7v (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 10 Apr 2018 10:59:51 -0400
X-Google-Smtp-Source: AIpwx49Lgif1ufu1LP8BcF2SXPIDkWb5ViQo9/gy4CARxeQhdqe99nhAc2jo5+mPGUKaZA63ysgs5A==
Subject: Re: [PATCH] lan78xx: Don't reset the interface on open
To: Nisar.Sayed@microchip.com, Woojung.Huh@microchip.com,
        UNGLinuxDriver@microchip.com, agraf@suse.de, tbogendoerfer@suse.de,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523362705-30032-1-git-send-email-phil@raspberrypi.org>
 <CE371C1263339941885964188A0225FA3A3F82@CHN-SV-EXMX03.mchp-main.com>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <dc7f30e2-624c-17d8-911b-d20ce96c2652@raspberrypi.org>
Date: Tue, 10 Apr 2018 15:33:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CE371C1263339941885964188A0225FA3A3F82@CHN-SV-EXMX03.mchp-main.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_05:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Nisar,

On 10/04/2018 15:16, Nisar.Sayed@microchip.com wrote:
> Thanks Phil, for identifying the issues.
> 
>> -	ret = lan78xx_reset(dev);
>> -	if (ret < 0)
>> -		goto done;
>> -
>>  	phy_start(net->phydev);
>>
>>  	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
>> --
> 
> You may need to start the interrupts before "phy_start" instead of suppressing call to "lan78xx_reset".
> 
> +             if (dev->domain_data.phyirq > 0)
> +                             phy_start_interrupts(dev->net->phydev);

Shouldn't phy_connect_direct, called from lan78xx_phy_init, already have enabled interrupts for us?

This patch addresses two problems - time wasted by renegotiating the link after the reset and the
missed interrupt - and I'd like both to be fixed. Unless you can come up with a good reason for
performing the reset from the open handler I think it should be removed.

Phil
