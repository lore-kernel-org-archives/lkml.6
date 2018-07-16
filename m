Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FB9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D92208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DI7Y8drq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D92208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeGPM1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:27:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45884 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeGPM1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:27:52 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6GBvBwV109664;
        Mon, 16 Jul 2018 06:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531742231;
        bh=b/gCI5s9yZbBpu/yZcLhJIPo741w+nDakhEVj15UIY4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DI7Y8drq0ud7vloX09tT8/fmIeLOGnC5iPAXb/BfiNeSc3/tLBV+W7vkJ9SXnkwHU
         dPRFXZ2ZhwMchxM4amSEWDW5fUPLveXI//esk/DvpU+4Uwm96uBcLAdA2np+kkojcp
         2+wl8R1NnQgIJJ18LIo4p7nyV8Kp8IofWCeWL34k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GBvBbh008289;
        Mon, 16 Jul 2018 06:57:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 16
 Jul 2018 06:57:11 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 16 Jul 2018 06:57:11 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GBv1sd003890;
        Mon, 16 Jul 2018 06:57:02 -0500
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ladislav Michl <ladis@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
 <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
 <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
 <CAMRc=McO8H9Aw8a7h318a=hJjKBOgeC+9_hreBnOY3Tc3Fh7sg@mail.gmail.com>
 <d7f03763-982f-5e3e-d0ad-54e024b10f97@ti.com>
 <a70aebb0-408c-c61f-897a-227114888585@linaro.org>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <3b53a8a7-3f3a-4341-35b0-e7b52854fa9b@ti.com>
Date:   Mon, 16 Jul 2018 17:27:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a70aebb0-408c-c61f-897a-227114888585@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 July 2018 02:26 PM, Srinivas Kandagatla wrote:
> 
> 
> On 16/07/18 09:50, Sekhar Nori wrote:
>> On Friday 13 July 2018 11:30 PM, Bartosz Golaszewski wrote:
>>
>>> We're getting close to rc5 so I'd like to make a case for this series
>>> again.
>>>
>>> I understand that there's more to do than just the changes introduced
>>> here, but we shouldn't try to fix several problems in many different
>>> places at once. There's just too many moving pieces. I'd rather start
>>> merging small improvements right away.
>>>
>>> The idea behind this series is to remove (almost) all users of
>>> at24_platform_data. The davinci_emac patches are there only because we
>>> need to remove some MAC adress reading stuff from the board files.
>>> Having this code there and calling it back from EEPROM/MTD drivers is
>>> already wrong and we should work towards using nvmem for that anyway.
>>>
>>> Currently for MTD the nvmem support series seems to be dead and it's
>>> going to take some time before anything gets upstream.
>>>
>>> So I'd like to again ask you to consider picking up the patches from
>>> this series to your respective trees or at the very least: I'd like to
>>> ask Srinivas to pick up the nvmem patches and Sekhar to take the
>>> first, non-controversial batch of davinci platform changes so that
>>> we'll have less code to carry for the next release.
>>
>> I think those are patches 3-7. I can take those if I get an immutable
>> commit over v4.18-rc1 from Srinivas with patches 1 & 2 applied.

> nvmem patches go via Greg KH char-misc tree, if it makes things easy I
> can provide Ack on nvmem patches, so that you can take these patches via
> your tree?
> 
> Let me know.

I can do that.

Greg, are you fine with this? It will be great to have your ack for
patches 1/8 and 2/18.

Thanks,
Sekhar
