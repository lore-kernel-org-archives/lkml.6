Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF307C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E8520658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="VK0eIs9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E8520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJVPcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:32:22 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:33351 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbeJVPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540192501;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=N082TBwdItqOjWCvJaTKJOyv8lwH8iRH9kctVLZxqjg=;
        b=VK0eIs9S2lO2NNP90rmprLoQixIoO6xIhqHwvEM2w9soKHNHcdkmg301yOKgZhZNFr
        5SugyUEuty6KH8yb2c86ZGMYvM3/oCrDRm1vXD9WUMfycaopWsHpso/e7744+sdy0Tv2
        7hjcaB6jNBY7OdiuqQ165iVOtjqh5Gs5U9oDR9L8pI+97u4q+uExJyoV9l4UljJVYZHP
        7CV2V0vbWCg4dBD+im69l2ejVlI22/jPBC+wX0qmnMZ4lO9Wl0ast3aLGMJgXIvbqvMw
        C+lo6tYnXqwsx+yHQd8nOap3vv2oLpMtdwQ1YlsN6fU4z1fHjhBjjPk9h0BR52dIzn9F
        2epA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyMly7vtKoBCSu4zR9/f0shzjGSYbJY5KbsbrlTGd0CtJA="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2003:a:e7a:6200:246c:2a8b:f45a:a33d]
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id j097e4u9M7EkQXQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 22 Oct 2018 09:14:46 +0200 (CEST)
Subject: Re: SMSC9730 Autosuspend/Resume Questions
To:     Nisar.Sayed@microchip.com, steve.glendinning@shawell.net,
        UNGLinuxDriver@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org
Cc:     oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <69e14429-a4d9-dd5c-5e70-c22086490cc0@exceet.de>
 <CE371C1263339941885964188A0225FA44571A@CHN-SV-EXMX03.mchp-main.com>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <ceb49899-3e01-94a1-1555-11e6e6aa5b5a@exceet.de>
Date:   Mon, 22 Oct 2018 09:14:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CE371C1263339941885964188A0225FA44571A@CHN-SV-EXMX03.mchp-main.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nisar,

On 22.10.18 09:03, Nisar.Sayed@microchip.com wrote:
> Hi Frieder,
> 
>> Hi,
>>
>> I recently tested a board with SMSC9730 connected via USB HSIC to an
>> i.MX6S SOC. I used these patches on top of v4.14-rc8 for the USB HSIC
>> support: [1].
>>
>> When I turned on autosuspend, the smsc95xx stopped in the middle of the
>> suspending routine and /sys/bus/usb/devices/usb3/3-
>> 1/power/runtime_status reported "suspending"
>> forever.
>>
>> With some debug logs I found out, that the last line of code that was
>> executed is [2], after that I didn't get any further messages.
>>
>> Then I applied the following diff and the suspend/resume started to work
>> reliably:
>>
>> @@ -1382,10 +1385,11 @@ static int smsc95xx_link_ok_nopm(struct usbnet
>> *dev)
>>           ret = smsc95xx_mdio_read_nopm(dev->net, mii->phy_id, MII_BMSR);
>>           if (ret < 0)
>>                   return ret;
>> -
>> +       /*
>>           ret = smsc95xx_mdio_read_nopm(dev->net, mii->phy_id, MII_BMSR);
>>           if (ret < 0)
>>                   return ret;
>> +       */
>>
>>           return !!(ret & BMSR_LSTATUS);
>>    }
>>
>> So it seems like the dummy read, that is commented with "first, a dummy
>> read, needed to latch some MII phys" causes problems in my setup. Do you
>> have an idea what could be the reason? Is this a proper fix?
>>
>   
> Link status bit is latch low register and needs to be read twice. You may get wrong Link status with this fix.

Ok, thanks for the information. I guess I'll have to do some more 
debugging to find out why the second read fails in my case.

Frieder
