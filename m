Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CC2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB9C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QourDXBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB9C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbeGRTdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:33:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38534 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbeGRTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:33:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so5680210wro.5;
        Wed, 18 Jul 2018 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DWZw+AZwDfd5nuF2JVpIoTvtb5TNNWegKIOtU5pMya4=;
        b=QourDXBIsZ/CHmgDS+ySMXN2U8d1TfcUF/SVaJC50BIzWya615u7i7Je5lK9P9aXOu
         WKmsjFq6xfL4GXiXCwIjVFsDU4CzBPWBuzBeGkbHr3wLE4hRo71HQQ8VavLL0EFOfc6I
         VpDfWaEWdp+H81n5vdx7bWorgY7cJAvK0FiqiyAAFKnftppVhgmvPO6R8+If6BttT4YJ
         XP5xIYUNQR2FuGFN/e73/5FXBiZSstwgH1eMgKLI8UB80137X0z4ysde+/QCwUyTE/c6
         LZKUbWVIm/i9OEYf1ILwTUN2gNhkTt3eZoEHbR09KSBhwxfZH03UpSHKlVGAGmxJoD9q
         UkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWZw+AZwDfd5nuF2JVpIoTvtb5TNNWegKIOtU5pMya4=;
        b=nViIRjPcewCH5+8QwF6q971bxuEFO23/I8AfpGqtFagG4FmjwKzrlAC323uxtD2Qak
         TNtksoQphwCqv9RbDzJ9RJF2kVzJDCltSy3biG4jLIj4JsYozwiDP2BmXoZ3hHe7RT+n
         VcUT5tRCCVBwOOalK8JAZYSR3exlqtYgUX2S0rnHUB0GAduJqwMMQl1ZINXIcNIG3FnF
         +K6TX+CshMIaVmnGWjN26hfbvfhKOlE/Z1QZA95qpo4n3RhOM6ELAv3TsQiujxWmHcM2
         DNPf7pN5S0VR/+6e8D2a0Xo+0SGjPlKQqDnfOkComeb9fwyF5HRCN83/zygyEBlmL5QY
         oTsw==
X-Gm-Message-State: AOUpUlGBeg/R/KTPIRzXtgsWqQs82Cd2awRBadz/a6R0j6xLlupulagk
        ildhxgbpX7EtrFdteYm6uBcUNTGQ
X-Google-Smtp-Source: AAOMgpcD8t9sYKyW7p5vNx8zpP6Ur2XdaacWNo59TNTWrbBU8GHIMqS5CwVxmUe2qQg21Q0baWuwJQ==
X-Received: by 2002:adf:e584:: with SMTP id l4-v6mr4955632wrm.190.1531940071409;
        Wed, 18 Jul 2018 11:54:31 -0700 (PDT)
Received: from [192.168.1.18] (ckg128.neoplus.adsl.tpnet.pl. [83.31.82.128])
        by smtp.gmail.com with ESMTPSA id n17-v6sm2140646wmc.13.2018.07.18.11.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 11:54:30 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>
Cc:     David Lechner <david@lechnology.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd> <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com> <20180718075637.GA10279@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <913151e4-c19f-9a22-697c-52a9fb48cb32@gmail.com>
Date:   Wed, 18 Jul 2018 20:54:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180718075637.GA10279@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 09:56 AM, Pavel Machek wrote:
> Hi!
> 
>>>>>> I believe I meant "changing patterns from kernel in response to events
>>>>>> is probably overkill"... or something like that.
>>>>>
>>>>> Anyway -- to clean up the confusion -- I'd like to see
>>>>>
>>>>> echo pattern > trigger
>>>>> echo "1 2 3 4 5 6 7 8" > somewhere
>>>>
>>>> s/somewhere/pattern/
>>>>
>>>> pattern trigger should create "pattern" file similarly how ledtrig-timer
>>>> creates delay_{on|off} files.
> 
> Yes, that sounds reasonable. v5 still says
> 
> +               Writing non-empty string to this file will activate the pattern,
> +               and empty string will disable the pattern.
> 
> I'd deactivate the pattern by simply writing something else to the
> trigger file.

Please keep in mind that this is ABI documentation for the pattern file
to be exposed by LED core, and not by the pattern trigger, that, as we
agreed, will be implemented later. In this case, I'd go for
"echo 0 > brightness" as a command disabling pattern. The same operation
disables triggers, so later transition to using pattern trigger will be
seamless for userspace.

-- 
Best regards,
Jacek Anaszewski
