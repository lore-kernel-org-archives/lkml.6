Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E88C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F313F20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F313F20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smarthome-wolf.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757067AbeFSKYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:24:49 -0400
Received: from dd39320.kasserver.com ([85.13.155.146]:55542 "EHLO
        dd39320.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756382AbeFSKYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:24:42 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 06:24:42 EDT
Received: from [192.168.0.65] (x4db530c9.dyn.telefonica.de [77.181.48.201])
        by dd39320.kasserver.com (Postfix) with ESMTPSA id 9BB022CE015E;
        Tue, 19 Jun 2018 12:19:16 +0200 (CEST)
Subject: Re: rf69_set_deviation in rf69.c (pi433 driver)
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Valentin Vidic <Valentin.Vidic@CARNet.hr>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180605031120.GB1981@hle-laptop.local>
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
Message-ID: <50c4e6ee-e5fb-1d27-4e73-1e82080036b3@smarthome-wolf.de>
Date:   Tue, 19 Jun 2018 12:19:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605031120.GB1981@hle-laptop.local>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

sorry for the late response and thank you for all that deep
investigation in the pi433 driver!

> According to the datasheet[0], the deviation should always be smaller
> than 300kHz, and the following equation should be respected:
> 
>   (1) FDA + BRF/2 =< 500 kHz
> 
> Why did you choose 500kHz as max for FDA, instead of 300kHz ? It looks like
> a bug to me.

My focus was always on OOK and ASK. PSK was only used for a few
measurements in the laboratory, I engaged to check CE compliance.
Most probably 500kHz was a value, that's common for PSK and I didn't pay
any attention to the datasheet. So I think, you are right: This is a bug
and could be revised.
Never the less: While using it in the lab, the transmission was fine and
the signals over air have been clean and fitted to the recommondations
of the CE.

> 
> Concerning the TODO, I can see two solutions currently:
> 
> 1. Introduce a new rf69_get_bit_rate function which reads REG_BITRATE_MSB
>    and REG_BITRATE_LSB and returns reconstructed BRF.
>    We could use this function in rf69_set_deviation to retrieve the BRF.
> 
> + clean
> + intuitive
> - heavy / slow

Why not: I like clean and intuitive implementations. Since it's used
during configuration, we shouldn't be that squeezed in time, that we
need to hurry.
> 
> 2. Store BRF somewhere in rf69.c, initialize it with the default value
>    (4.8 kb/s) and update it when rf69_set_bit_rate is called.
> 
> + easy
> - dirty, doesn't fit well with the design of rf69.c (do not store
>   anything, simply expose API)

Up to my experience, storing reg values is always a bit problematic,
since the value may be outdated. And if you update the value every time
you want to use it to be sure, it's correct, there is no win in having
the copy of the reg value.
So this wouldn't be my favourite.
> 
> I'd really prefer going for the first one, but I wanted to have your opinion
> on this.

Agree.

> Thanks for your work !

Your welcome :-)

Marcus
