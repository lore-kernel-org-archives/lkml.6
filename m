Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C5BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCB720A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU1v9YEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCB720A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeHXXZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:25:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39780 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXXZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:25:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id o37-v6so8363442wrf.6;
        Fri, 24 Aug 2018 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ru+wvZiJTsANwUteOAlyY/jldnlAmHkLO3D/zxuRlUU=;
        b=TU1v9YEZoa+124yfF1GOjssmFET4kzIIk9QI6sqvcW/KUOTZ8BCy/ag0CeODz7axVa
         S4oJVJplSDE1rWGlmBy4xtN90l/ftsDva6nvVB8/YDpR0U1Www0QTURtZ91A2xi4LLaq
         oHGiMbI8ojPteFeDIT0iGQ2b+mFgWKM6Ao33/BSd5GV+0xj3IjsZndxpy9vRDubUlvgL
         5s3U7094rfW16e/sK44hWIyRckCYEQDtUNIHcHDstldDoC5lJ+IdUla9atXGFUPsGgpu
         WkFeQoQ0lDcVrtfd0EAn66CSWjydndQw3PJ/ei3oJN7xmeObdOmgU1n8ka7tNBsNDz+X
         wc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ru+wvZiJTsANwUteOAlyY/jldnlAmHkLO3D/zxuRlUU=;
        b=Cyr4xiehoZXTxV94kpV7cw4LaGq4UnWps9cweeSRcKefjUUtukLtlBUtKP4mFMEYeR
         e+1U3tCo44DHfo/3y+XRQvyTcreSjTZWRyRbhCoaXIedVSlNiFDx4+177pOUJN06KocI
         upw+KUCy1YuDFwTOefsLuyzKRxgOH+1NChTSjMb1hFV/q1I3fQOEjtK27bmhW9jrSnP6
         3xxYhp8MlVqasAmM6uvSV2KKUSiW7xIQrZ8Id7UuGStdHYxnX923YLrgTlDgAq0rkU7Q
         k/p5Lj/gMhssRCyBeu9xGH4aWg3I5rHMZ2+naeosC/A78ietkJKrOCqpSTo63r1uIGOO
         NKPA==
X-Gm-Message-State: APzg51Dj6PtmOC6Iy8ZtWZbJSJtU6KsHILp5yRNGsiMjr/VZHyehiUD+
        2gryoTJsrQA06xLhhoHrApdHhplr
X-Google-Smtp-Source: ANB0VdYqUAw3mOfe8E939KoVqfAYorPwDKroo4asoJXZ44hCSoNpBLf1ZqZTYyJ8Tvetj3Y7k7PULA==
X-Received: by 2002:adf:8485:: with SMTP id 5-v6mr2134120wrg.34.1535140193125;
        Fri, 24 Aug 2018 12:49:53 -0700 (PDT)
Received: from [192.168.1.18] (bga163.neoplus.adsl.tpnet.pl. [83.28.64.163])
        by smtp.gmail.com with ESMTPSA id y206-v6sm4000800wmg.14.2018.08.24.12.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 12:49:52 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <20180824101145.GA1510@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com>
Date:   Fri, 24 Aug 2018 21:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824101145.GA1510@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 08/24/2018 12:11 PM, Pavel Machek wrote:
> Hi!
> 
>> I think that it would be more flexible if software pattern fallback
>> was applied in case of pattern_set failure. Otherwise, it would
>> lead to the situation where LED class devices that support hardware
>> blinking couldn't be applied the same set of patterns as LED class
>> devices that don't implement pattern_set. The latter will always have to
>> resort to using software pattern engine which will accept far greater
>> amount of pattern combinations.
>>
>> In this case we need to discuss on what basis the decision will be
>> made on whether hardware or software engine will be used.
>>
>> Possible options coming to mind:
>> - an interface will be provided to determine max difference between
>>   the settings supported by the hardware and the settings requested by
>>   the user, that will result in aligning user's setting to the hardware
>>   capabilities
>> - the above alignment rate will be predefined instead
>> - hardware engine will be used only if user requests supported settings
>>   on the whole span of the requested pattern
>> - in each of the above cases it would be worth to think of the
>>   interface to show the scope of the settings supported by hardware
> 
> I'd recommend keeping it simple. We use hardware engine if driver
> author thinks pattern is "close enough".

The thing is that in the ledtrig-pattern v5 implementation there
is no option of using software fallback if pattern_set op
is initialized:

+	if (led_cdev->pattern_set) {
+		return led_cdev->pattern_set(led_cdev, data->patterns,
+					     data->npatterns, data->repeat);
+	}

> If human can not tell the difference, it probably is.
> 
> We may want to do something more formal later.

-- 
Best regards,
Jacek Anaszewski
