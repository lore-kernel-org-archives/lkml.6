Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB6C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E212083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E212083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeJANuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:50:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35555 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbeJANuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:50:02 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g6sOj-0004Fr-OD
        for linux-kernel@vger.kernel.org; Mon, 01 Oct 2018 07:13:41 +0000
Received: by mail-pg1-f199.google.com with SMTP id i189-v6so14418796pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 00:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7O0M1ezcrlZqv+QIxjCov5BTT+qjV7K93kfAfVlYG/Q=;
        b=FI3Ubo5urC1uX500notCOZCRVVCf2+q0vGK2pp/BWfdF124H2tgp3i1Z6IwDZm/vXG
         dqHtFenpMOnB3Y9tDK1IX8kS7hPQzZHNJivAz6laFPjl57ItxOiBVAyRQ7LCZ8JdT6Bw
         ad/UWZXgmKGHQb06U/Ca13x/jgpFv0HSsvIsyeoseCUediuj16XSQfSCBt98ShWv/dNP
         drAkVT1L8jVnM4BZ7cNEj8610oceovko3KScTTzUxm/nCjKgKQtpx0cwRH6YmZvY12Py
         kFouMIynhOT0fwU8lEfr2mhl+U8+2uVZK0hMHFDZAImSPHGZH9Cwte55gg0+wHJ4Kj19
         M+lw==
X-Gm-Message-State: ABuFfoiOYgLfL9206c5dPdauYEoD13vNfU3rWujaFmwrSKZ5du0RbD/6
        Nykeh3ixfJbob7g02nS5cXtzSSApF7QHHhZzCQfPUkf5GWtZw3okYLfudMZW+eOX8yk0Ey1/8uT
        1eAsSKVlmeiLO0Ut9pBlw5brnVO7tAEH7sJVo+jMh/A==
X-Received: by 2002:a62:4ec9:: with SMTP id c192-v6mr10008391pfb.221.1538378020233;
        Mon, 01 Oct 2018 00:13:40 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61YMtD2KLi5GqoNbkZJYWbRxhUlmMNTJKsznkDvcuPyxyq9jYXxhWrkds6VbFXcVU8VSJPY0A==
X-Received: by 2002:a62:4ec9:: with SMTP id c192-v6mr10008369pfb.221.1538378019966;
        Mon, 01 Oct 2018 00:13:39 -0700 (PDT)
Received: from [10.101.46.95] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id q25-v6sm15646109pfh.113.2018.10.01.00.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 00:13:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] HID: i2c-hid: Add a small delay after powering on/off the
 device
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJKhyVjfNsiEK-a16KGPdtfgrtnQ0XgxLyBqUhHVaS8AOA@mail.gmail.com>
Date:   Mon, 1 Oct 2018 15:13:35 +0800
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D7895636-743E-4F43-B916-DB4326693A3B@canonical.com>
References: <20181001035313.21453-1-kai.heng.feng@canonical.com>
 <CAO-hwJKhyVjfNsiEK-a16KGPdtfgrtnQ0XgxLyBqUhHVaS8AOA@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 1, 2018, at 3:00 PM, Benjamin Tissoires  
> <benjamin.tissoires@redhat.com> wrote:
>
> On Mon, Oct 1, 2018 at 5:53 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Raydium touchpanel (2386:4B33) sometimes does not workin desktop session
>> although it works in display manager.
>>
>> During user logging, the display manager exits, close the HID device,
>> then the device gets runtime suspended and powered off. The desktop
>> session begins shortly after, opens the HID device, then the device gets
>> runtime resumed and powered on.
>>
>> If the trasition from display manager to desktop sesesion is fast, the
>> touchpanel cannot switch from powered off to powered on in short
>> timeframe. So add a small delay to workaround the issue.
>
> I think you want something similar to
> https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git/commit/?h=for-next&id=807588ac92018bde88a1958f546438e840eb0158
>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/hid/i2c-hid/i2c-hid.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index f3076659361a..ff5682cc1bce 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -409,6 +409,8 @@ static int i2c_hid_set_power(struct i2c_client  
>> *client, int power_state)
>>
>>         if (ret)
>>                 dev_err(&client->dev, "failed to change power setting.\n");
>> +       else
>> +               msleep(20);
>
> We shouldn't have this error in the first place, so adding a timeout
> will just add a band-aid on top of an other issue.
>
> I really think the solution from Anisse would work in your case and
> will be nicer.

The Hantick one requires 2.5 seconds delay, the Raydium one requires much  
less.
Also it doesn't have the input shift issue.

So disabling runtime PM entirely is a little overkill in this case.

Maybe there's a better approach?

Kai-Heng

>
> Cheers,
> Benjamin
>
>>  set_pwr_exit:
>>         return ret;
>> --
>> 2.17.1
