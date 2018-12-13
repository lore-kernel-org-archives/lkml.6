Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C6EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC6B20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC6B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeLMAXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:23:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48321 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeLMAXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:23:53 -0500
Received: from [125.34.48.71] (helo=[192.168.1.109])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <hui.wang@canonical.com>)
        id 1gXEn7-00033q-Cq; Thu, 13 Dec 2018 00:23:49 +0000
Subject: Re: [PATCH 4.19 096/139] ALSA: hda/realtek - fix the pop noise on
 headphone for lenovo laptops
To:     Thomas Zeitlhofer <thomas.zeitlhofer@ze-it.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
References: <20181204103649.950154335@linuxfoundation.org>
 <20181204103654.341269777@linuxfoundation.org> <20181212234517.GA15065@x1>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <1fe3ba5d-d77a-4592-c5c9-67d788d8b434@canonical.com>
Date:   Thu, 13 Dec 2018 08:23:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212234517.GA15065@x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

I have sent a new patch to fix this LED regression, after applying this 
patch (ALSA: hda/realtek - fix the pop noise on headphone for lenovo 
laptops) and the new patch (ALSA: hda/realtek - Fix the mute LED 
regresion on Lenovo X1
  Carbon),  the issue will be fixed.

This is the new patch I sent (also CCed to stable):

http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/142747.html

About the noise, if you follow the steps as below, you would hear the 
noticeable click/pop noise:

1. Hookup a set of headphones that you can separately place in/on your 
ears. (ie. ear buds)

2. Put only the right headphone in/on your ear.

3. Go to the Gnome sound settings and bring up the "Test Speakers" function

4. Play the left speaker test

You would expect to hear nothing in the right ear, but instead you hear 
a "pop" at the start of each word spoken. ("pop" Front "pop" left). You 
can repeat with the left headphone and see similar results. I even tried 
shifting the balance all the way to the left/right and get the same 
results.


Thanks,
Hui.


On 2018/12/13 上午7:45, Thomas Zeitlhofer wrote:

I have sent a new patch to fix this LED regression, after applying this 
patch
> Hello,
>
> On Tue, Dec 04, 2018 at 11:49:37AM +0100, Greg Kroah-Hartman wrote:
>> 4.19-stable review patch.  If anyone has any objections, please let me
>> know.
>>
>> ------------------
>>
>> From: Hui Wang <hui.wang@canonical.com>
>>
>> commit c4cfcf6f4297c9256b53790bacbbbd6901fef468 upstream.
>>
>> We have several Lenovo laptops with the codec alc285, when playing
>> sound via headphone, we can hear click/pop noise in the headphone, if
>> we let the headphone share the DAC of NID 0x2 with the speaker, the
>> noise disappears.
>>
>> The Lenovo laptops here include P52, P72, X1 yoda2 and X1 carbon.
> [...]
>
> on a current Thinkpad X1 Yoga, this breaks the LED functionality on the
> audio- and mic-mute buttons. While the buttons still work, the LEDs are
> permanently off and do not reflect the mute state any more.
>
> Reverting this patch restores the LED functionality.
>
> Here, even without this patch, there is no click/pop noise noticeable
> when using headphones.
>
> Regards,
>
> Thomas
>

