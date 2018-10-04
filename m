Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98962C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481782084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=herochao.de header.i=@herochao.de header.b="b0Fh0Hle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481782084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=herochao.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeJEF12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:27:28 -0400
Received: from mail.huaman.de ([88.99.34.23]:56082 "EHLO mail.huaman.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbeJEF12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:27:28 -0400
Received: from [192.168.0.8] (ip5f5acd5e.dynamic.kabel-deutschland.de [95.90.205.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas@herochao.de)
        by mail.huaman.de (Postfix) with ESMTPSA id 395C01A172F;
        Fri,  5 Oct 2018 00:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=herochao.de; s=dkim;
        t=1538692312; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjOUACzsjJ37hOfbchNUDGyqm6E44u5hnkH7DZMzjOM=;
        b=b0Fh0HleBvkVyHG4RTIFcvrk1jp3f+ex8BjAuuicOabgyNNxJWqVRsvS6oZi+Zt+ll/ugS
        BimtVzJqaE+1tY38eMRQDbkbydzfV3pmTK2KCJdqWvzfkoRpDaMIRo+/IuAhzDe0Gok4eE
        eg7gV7GH0hPBsM4z4vKUfPDI5KLKWuE=
Subject: Re: [PATCH] ALSA: usb-audio: update quirk for B&W PX to remove
 microphone
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20181004144205.18153-1-nicolas@herochao.de>
 <s5h7eixl9d9.wl-tiwai@suse.de>
From:   Nicolas Herochao <nicolas@herochao.de>
Message-ID: <f1db1306-7156-7d0e-7b71-b8b1b43e840f@herochao.de>
Date:   Fri, 5 Oct 2018 00:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <s5h7eixl9d9.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=herochao.de;
        s=dkim; t=1538692313; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjOUACzsjJ37hOfbchNUDGyqm6E44u5hnkH7DZMzjOM=;
        b=P8RE8dk9ogqUWj0N1UuppBEuBvcdNFQS0tQAkfjbVNOZhyNwqFzW7IqYz3/ZRCeIu4bdVJ
        XLZMkIN2m1h3cTfbin1dIWit3I8t7yNxsPYESrF6q3q9r8Oi4rs6K1hwHoQ2BGOSwr9CdL
        6+1UZn+lKOkV+M3ukowRkxv3/yniiEw=
ARC-Seal: i=1; s=dkim; d=herochao.de; t=1538692313; a=rsa-sha256; cv=none;
        b=HLeiWJ5eBE6U0mtgC87UngN8oyBERcpUVD6H78casD7Xy7Sm9zcqpkMuunpPc1Sw+Csh40xlO0yPK/NBucFbGyRcKgpiIfD6OtBkuJcZBcuxy5dlK7SRIYwdnydbSChm5ZZSOb4MBK0yC1gD4x50tIzECG2jVL7Spm07OG7wIU0=
ARC-Authentication-Results: i=1;
        mail.huaman.de;
        auth=pass smtp.auth=nicolas@herochao.de smtp.mailfrom=nicolas@herochao.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Thanks for the quick response

Am 04.10.18 um 22:55 CEST schrieb Takashi Iwai:

> On Thu, 04 Oct 2018 16:42:05 +0200,
> Nicolas Huaman wrote:
>> A quirk in snd-usb-audio was added to automate setting sample rate to
>> 4800k and remove the previously exposed nonfunctional microphone for
>> the Bowers & Wilkins PX:
>> commit 240a8af929c7c57dcde28682725b29cf8474e8e5
>> https://lore.kernel.org/patchwork/patch/919689/
>>
>> However the headphones where updated shortly after that to remove the
>> unintentional microphone functionality. I guess because of this the
>> headphones now crash when connecting them via USB while the quirk is
>> active. Dmesg:
>>
>> snd-usb-audio: probe of 2-3:1.0 failed with error -22
>> usb 2-3: 2:1: cannot get min/max values for control 2 (id 2)
>>
>> This patch removes the microfone and allows the headphones to connect
>> and work out of the box. It is based on the current mainline kernel
>>   and successfully applied an tested on my machine (4.18.10.arch1-1).
>>
>> Signed-off-by: Nicolas Huaman <nicolas@herochao.de>
> Thanks, that looks much better now, and I can apply it.
>
> But just to be sure: is any quirk required after the firmware update
> on this device at all?  What happens if you remove the whole quirk?

Yes, the sample-rate problem is still present. I initially tried 
disabling the quirk, but then I needed to set the default sample rate of 
pulse to 48k again for the headphones to play sound, which is why I 
wanted to find out how to fix it completely.

This problem doesn't appear on windows (I think windows defaults to 
48k?). Perhaps that's the reason why it wasn't patched in a firmware 
update up until now.

> If this modified quirk is still mandatory, I'll happily apply the
> patch.
>
>
> thanks,
>
> Takashi

The headphones I got already had the fixed firmware version, but even 
older headphones can be updated using Android, IOS or Windows.

My Fix corrects detection for headphones with all Firmware after 
February 2018, so I think this quirk probably presents the best solution 
for now, especially since the nonfunctional microphone of older Firmware 
appeared on all platforms.

Thank you for your time, the help and feedback!

Best Regards,

Nicolas

