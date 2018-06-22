Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B15C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3062323EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3062323EA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smarthome-wolf.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeFVICw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:02:52 -0400
Received: from dd39320.kasserver.com ([85.13.155.146]:37658 "EHLO
        dd39320.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeFVICr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:02:47 -0400
Received: from [192.168.0.65] (x4db6f200.dyn.telefonica.de [77.182.242.0])
        by dd39320.kasserver.com (Postfix) with ESMTPSA id 073382CE0040;
        Fri, 22 Jun 2018 10:02:43 +0200 (CEST)
Subject: Re: pi433: initialization of tx config in pi433_open()
To:     Hugo Lefeuvre <hle@owl.eu.com>,
        Marcus Wolf <linux@wolf-entwicklungen.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180622024741.GB1914@hle-laptop.local>
From:   Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Openpgp: preference=signencrypt
Autocrypt: addr=marcus.wolf@smarthome-wolf.de; prefer-encrypt=mutual; keydata=
 xsBNBFn0gUABCADPoYmxJeUTvkgBA/fTa2vTIzv4pQy0gfdS23EounKFNBTUu8RurWN1/Z/r
 C6aF6867U3F6rppc8bvRSO4lkYgwWkEwPWswCTEPlVOzy1tVZSoD6fk6dcJ73ZOdN3lasYq0
 zWa70mofIH/rzBJ5ppO2aQdPgUInJuClushR/zCgZOz6ta93A8pLApcFwLA6cikY4FvyiCtX
 D+Zkv5/kn5z+wIQmQ5UI3EkTzqE/H7N59duSIXeELZjZVV2uuwZQLU+xxouqZG/flVoEDqVe
 wvXcHQ5NPofdlI0NcIIoQasleVuWiYXN/sC90vcOPHyWfmrsOUJNKZSEhgIp5shTWE+tABEB
 AAHNK01hcmN1cyBXb2xmIDxtYXJjdXMud29sZkBzbWFydGhvbWUtd29sZi5kZT7CwH8EEwEI
 ACkFAln0gUACGwMFCQPCSPAHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCxe3Gartc2
 v7/rCACfWZzsPuEY7szndbaNRmh0OvS380xYWYDAkklKTL2Re7Fose9TwjkdjYdN3V5DeqBH
 8uej0h8qL4iHNt7vjFFjD+oxRQ5ugRItEJeDnp3AQf4pQa7DshGGTz7XUJ9lwBioyv7L04YD
 PMAXl3HhzuMAC36Gd6TJvXkS2uQXvZPuE/wCjOUq86sGe8ek+5k+WrqPIyoRYJIM1N2mT5E5
 J6LIrOjbLVtWhga3xUEghcCk+7zjTMaRUQY7OGPEhp0vamfq9T4s3v67GKN+EXEXoOm7KhVH
 oDHhbcsnlNNJEYmgpe0/KqNoDB8sI3mGAyIqcIztiVy1w8wIEvQKVnVfCfUKzsBNBFn0gUAB
 CACmLkuEMDK2kolURQp9AKGvpX52ZDavYkxsYXNZptWUyOJbjJmZStXzNTlT5LSx6QrXr8Ja
 mtDcrkFWGYVmfjgDyltV+vEWmx+qNv/R3lvXyTncXWyJ63RRDQcjx212nvhud0A+WjpL7HFn
 Oka1RBSrMpdqzPw3GC5yXl+khG0C3gVkakW2E7eAQimuPXtXCg2IUx2jeyiB5lLq7V5cqzIf
 5fcxtxIuFz1AG4gTnIysYvTmJZzoKHWBpJ8SKp42w9Ir/L8iiB9ae/G+UubDMacjDagzwTds
 w+1vR7t9T39uV/+KOpZfqbwZx7Wc2trr2k7L+puBJght8xUTBlafa/EzABEBAAHCwGUEGAEI
 AA8FAln0gUACGwwFCQPCSPAACgkQsXtxmq7XNr+IIQf/Q6H5zTJNrq12vPMRZbXWS+1gytGM
 jDgD7AbJy2tr5C0X/kpcxHrohwLvL8I2xCt3rXB28nQMwT1FJJ8zCoHTVDMX921KKVaqGN1D
 SxP3yQULbrcUYXlp2+iBAVzFQETjWaLbS0zYif7UMIZ54x0pGw/0pspEYLhjnykgnjFjPoMr
 79JhTMgKFwzOuINRGSHtHw8KIrfPymr2DrpGAXuIAXdjrel7nTVC6D+hVf7/qvFSgNS1sHky
 RNbd3S3GhFBT1zypnMRro+o4Qke5huxQ4mTLbFveo3f3T+u602PYbv4pz9tLwTPBKaKtJBNX
 kqgUYrGFKWlJJbaXegzkY9WmWg==
Message-ID: <108baf56-d8a2-1b8f-0e0f-72c0605a051e@smarthome-wolf.de>
Date:   Fri, 22 Jun 2018 10:02:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622024741.GB1914@hle-laptop.local>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

thank you for all your work on Pi433 driver.

For a better understanding some info about Pi433 and the ideas behind it.
Pi433 was developed by me in order to have a simple to mount
CE-compliant 433MHz shield for the Raspberry Pi. I wanted to put it on
sale on the one side and develop a further product for home automation,
using the Pi433.

After three years of development and hard trying to find sales partner,
I almost gave up, since after three years still earn on those topics by
far do not cover the spendings. If nothing changes, I'll have to close
my company at the end of this year.

At a distinct point, the work on trying to sell exceeded the technical
work, so no time was left for the driver development. And now I started
over in freelancing to earn money. That's why all of you nearly hear
nothing from me - very sad about that!

Back to technics:
There was already the idea of equipping the driver with default values.
I see no benefit with setting the default values from the data sheet,
since they do not lead to a good, maybe even not working setup of the
rf69. Idea was to choose settings, that allow to use pipeoperators on
the command sehll for transmitting and receiving telegrams. There was a
longer discussion about one year ago with Marcin Ciupak about that topic.
Most important point from my side was, that the defaults should be in a
way, that CE recommandations are meat. You can find a lot of
configurations, making Pi433 work in a way, that it isn't CE-compliant
any more.
The 4711 sound like just beeing a place holder.
Since - like I told before - I inteded to use Pi433 mainly for OOK/ASK,
my idea was to use an good OOK/ASK setup as default. I could provide you
with a source code, I used the Pi433 with - but I think attachments are
unwanted here.

As far as I can remember, there were some more details to modify on the
driver, to use it with pipes on command line. But I had a rough
implementation. At least send was working... To long ago to remeber :-(


Since it might happen, that Pi433 will go off the market in a few
monthes (tears in my eyes), I think it's a good idea to modify the
driver to become a generic hope-RF driver.
I already did investigations on different hope-RF chips and asked
hope-RF for a little support (e.g. partnership), but they were of
opinion, that they don't need such a driver. It would be easy to cover
up to five/six chips of them - even their brand new LoRaWan-chip. RFM-12
will be a little bit harder, since it works a little bit different.
There were already preparations to support several chips - e. g. by
capsulating the HW layer. But even hard discussions one year ago didn't
help - according to kernel guide lines, it wasn't allowed to keep this
capsulations. So the strict capsulation was broken and some of the
basics for supporting more chips are lost now.
Also on this topic I had several discussions with Marcin Ciupak, how to
realise the support of the next chips.
Maybe you can search the mailing list? If not, I can try to find the
discussions in my inbox.


I would love to help you with these extending topics, but since I am
almost out of money, at the moment there is no margin for complimentary
developments any more :-/

But if you like, I can discuss some stuff with you from time to time.

Thank you so much for your interest in Pi433 and my driver!!

If you need hradware for testing, let me know.

Marcus



Am 22.06.2018 um 04:47 schrieb Hugo Lefeuvre:
> Hi Marcus,
> 
> I'm currently working on the following TODO:
> 
>  966         /* setup instance data*/
>  967         instance->device = device;
>  968         instance->tx_cfg.bit_rate = 4711;
>  969         // TODO: fill instance->tx_cfg;
> 
> If a user calls write() right after open()-ing an instance, the driver
> might try to setup the device with uninitialized garbage. In fact
> nothing really bad will happen because the rf69 interface abstraction
> will filter out wrong values, but this might be a confusing behavior
> for the user.
> 
> What do you think about initializing instance->tx_cfg with the default
> values of the rf69 datasheet[0] ?
> 
> Also, is there a specific reason why you chose 4711 as a default value
> for the bit rate ? I couldn't find it anywhere in the datasheet nor on
> the internet.
> 
> Thanks !
> 
> Regards,
>  Hugo
> 
> [0] http://www.hoperf.com/upload/rf/RFM69CW-V1.1.pdf
> 
