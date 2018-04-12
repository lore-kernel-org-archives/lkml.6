Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1114600-1523543467-2-17367148773374899364
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
    1523543466; b=Vjvc3a7QxfdHb0a+pL4eo8Oe+72td4LHiInEpbfuV3pJCHRjGr
    Tcz3vaa7DciisH5lWWkd5iROY6rTrR0V6eNJo/NBDwDZkJeCcFTfxSxFyc4xAkin
    D+H+/FHGu8S/fFD2UfWbDOoTDQNdSzmX3bokCJX/nQ/4dXeONC9lEW7vE9MjZ3HG
    NKuIXALUahImEA+dDnGCxzmFmrMUsf+UF73gbU8kZ6Du/d56WWOYjb24uyP+f+bz
    CXUVV3cPItdPaZPAGiuSHnuJuhxt5fs8wHCTCxkCb3UYDADaIrF5gM46mYnX6b9j
    byKaEaOhjDN6TL7s2Xe5Oi8iQ3luoceYG3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523543466;
    bh=enyjGHCJc4c0SsecADWSeA5WpbLFYoy9G0Ne3x9/nLk=; b=kwTM4rXC/Fc2
    iTqAAThxV0bTCgCcs5NgCGdE1DfieqNeEJ71tpk7nCWuRlQBxwTCaMF8vL7xgn78
    lQLHB28p6C+XY8oXdOY8iuMJGf/0fhB8y79qruLE8cOaHS8Fzq+Ww0evYwO47XcR
    h6aEfhQreNBxB2sJ5LNc0g4pqwM6myfSahQAHFw/LmBkRGoY8tuECeQiwgvHsPr3
    3x48pT62o+gGaw1+nfOlmIyRUT2UipYgdvRI2uPIbasT8yLx4c/H7ViA+waLjd/W
    yr2BTD8qNFKWL+WqKGFNxTYq4aS2dAS88oeHyWJiOU4DwU9jcBgRuvi5uFVPoEEs
    o1pVYc514w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=I48mnqsi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=qfC8fMSF x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mLWsx6WP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=I48mnqsi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=qfC8fMSF x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mLWsx6WP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBwBezKFaX/YXa3428mRxU5q/XdC2vtszIAg2wsOyP96IyTumdkaEMsZPD0BDKyT9kQhsTvXpkDnvm65qQ14yRMx1VhWyuVm/1WtUuNbrbi+uZ2Qqk2r
    VsyBtSRlIvocEQYnPB/G6P4+FkVf1uXFreQ/c7yTTQxm0maUMiYEa9WieDNlBR2hAzmu8bbPxdBEkkiHIYXB5a2mT+6i6q6DJe/YnCrEcnrCJA8qpULujZI/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8
    a=Uvy9I8dBe6cug09T8JkA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeDLOab (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:30:31 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:42350 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753100AbeDLOa2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 10:30:28 -0400
X-Google-Smtp-Source: AIpwx4/NS8jQuuzxgx/JIBGXdO2Ed1IN19jgf0FXJa7JfYgONdWaOerfW7gNTxXuRTSwbP9Ff0M3WQ==
Subject: Re: [PATCH 3/4] lan78xx: Read LED modes from Device Tree
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
 <1523541336-145953-4-git-send-email-phil@raspberrypi.org>
 <20180412142615.GO28963@lunn.ch>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <50bd418e-9f26-5d4f-f4bf-6355f08b22e1@raspberrypi.org>
Date: Thu, 12 Apr 2018 15:30:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412142615.GO28963@lunn.ch>
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

On 12/04/2018 15:26, Andrew Lunn wrote:
> On Thu, Apr 12, 2018 at 02:55:35PM +0100, Phil Elwell wrote:
>> Add support for DT property "microchip,led-modes", a vector of two
>> cells (u32s) in the range 0-15, each of which sets the mode for one
>> of the two LEDs. Some possible values are:
>>
>>     0=link/activity          1=link1000/activity
>>     2=link100/activity       3=link10/activity
>>     4=link100/1000/activity  5=link10/1000/activity
>>     6=link10/100/activity    14=off    15=on
>>
>> Also use the presence of the DT property to indicate that the
>> LEDs should be enabled - necessary in the event that no valid OTP
>> or EEPROM is available.
> 
> I'm not a fan of this, but at the moment, we don't have anything
> better.
> 
> Please follow what mscc does, add a header file for the LED settings.

Good idea.

> 
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> ---
>>  drivers/net/usb/lan78xx.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
>> index d98397b..ffb483d 100644
>> --- a/drivers/net/usb/lan78xx.c
>> +++ b/drivers/net/usb/lan78xx.c
>> @@ -2008,6 +2008,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>>  {
>>  	int ret;
>>  	u32 mii_adv;
>> +	u32 led_modes[2];
>>  	struct phy_device *phydev;
>>  
>>  	phydev = phy_find_first(dev->mdiobus);
>> @@ -2097,6 +2098,25 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>>  		(void)lan78xx_set_eee(dev->net, &edata);
>>  	}
>>  
>> +	if (!of_property_read_u32_array(dev->udev->dev.of_node,
>> +					"microchip,led-modes",
>> +					led_modes, ARRAY_SIZE(led_modes))) {
>> +		u32 reg;
>> +		int i;
>> +
>> +		reg = phy_read(phydev, 0x1d);
>> +		for (i = 0; i < ARRAY_SIZE(led_modes); i++) {
>> +			reg &= ~(0xf << (i * 4));
>> +			reg |= (led_modes[i] & 0xf) << (i * 4);
>> +		}
> 
> Please add range checks for led_modes[i] and return -EINVAL if the
> check fails.

Will do.

Thanks,

Phil
