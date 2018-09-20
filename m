Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465C7C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51002147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmLwyXxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51002147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbeITWIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:08:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42952 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387690AbeITWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so4607471pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WiSoTJwbUQ3MW9ewSd/IrcUV6TbXa5NwKq9fnIcg46o=;
        b=VmLwyXxAhcLQH9BmHmQxAsH0hrQCMIM7NTrmP6uQMJLGKwkhf2uLPGjcnqW2Ade72E
         2eOm9S3cbDmQi1uC4CvkxrFe2ZjWEwoh0A0JBvni8G/UOrV8pr2LIYZFByUDQooZuNVu
         HUHB6qPL35eNbsAKM9OIrEKmMEerukEmZ/x20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WiSoTJwbUQ3MW9ewSd/IrcUV6TbXa5NwKq9fnIcg46o=;
        b=ExFhoImRV4Uvi9M3BM72P+QiBf1foLXhB+52o1vvU9Qf5pYiO0UrD485gxsTUuv3nT
         DWAEUc4psNqVDUcGh4qJ4M+ZNWsuJkak50QqJcUut5R5xQqo5rhJtqFdoXCmxD42rhfg
         ETt3H6j/NHiDU7prINbi/YIoxCKeZfbb7g0LaYtFDswJl6Z/NDxVGIMliDYNvriFHlHQ
         HHV2RBPWw4slQverbOwE9MDxQ/WXS7tIbl3xlvE82QEKKSVLGo6TCejMzmvjykq1GUTx
         abWiHOS47CcOnjrKFc2NL9La+CF1fnjHFo80tWjBWizI30ghtI17pjasNFmx2IypDYAu
         jDlg==
X-Gm-Message-State: APzg51Dr2NCMqnoruWUSA8fnyarUvs1XaAODKa1hlKOl91i9/zRIwzsq
        0pW3qIbGAljp6xLY/Rkx1yFuww==
X-Google-Smtp-Source: ANB0VdZA1rXiqG32hERqqBAU6LgBPbatqvilzqmJHgIHlgdaxbFVXG1NmmyYRm4MbmvZ3AnvmMqhBw==
X-Received: by 2002:a62:23c2:: with SMTP id q63-v6mr42113386pfj.116.1537460630770;
        Thu, 20 Sep 2018 09:23:50 -0700 (PDT)
Received: from holly.lan ([209.121.128.187])
        by smtp.googlemail.com with ESMTPSA id w5-v6sm29290975pfn.44.2018.09.20.09.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:23:49 -0700 (PDT)
Subject: Re: Re: [PATCH] backlight: pwm_bl: Fix brightness levels for non-DT
 case.
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        kernel@collabora.com, heiko@sntech.de, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>
References: <20180824155402.2822-1-enric.balletbo@collabora.com>
 <87h8ji98jp.fsf@belgarion.home>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <9cc21df6-67f2-e210-33b8-e0e14f052e7e@linaro.org>
Date:   Thu, 20 Sep 2018 09:23:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87h8ji98jp.fsf@belgarion.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/18 01:04, Robert Jarzmik wrote:
> Enric Balletbo i Serra <enric.balletbo@collabora.com> writes:
> 
>> Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
>> linearly to human eye")' allows the possibility to compute a default
>> brightness table when there isn't the brightness-levels property in the
>> DT. Unfortunately the changes made broke the pwm backlight for the
>> non-DT boards.
>>
>> Usually, the non-DT boards don't pass the brightness levels via platform
>> data, instead, they set the max_brightness in their platform data and the
>> driver calculates the level without a table. The ofending patch assumed
>> that when there is no brightness levels table we should create one, but this
>> is clearly wrong for the non-DT case.
>>
>> After this patch the code handles the DT and the non-DT case taking in
>> consideration also if max_brightness is set or not. The default table is
>> only created when neither, brightness-levels and max_brightness, are
>> set.
>>
>> The patch also fixes another issue found by Robert. Before this patch
>> looks like a division by 0 was possible when state.period returned 0 by
>> pwm_get_state(). This is because pwm_get_state() was called before
>> pwm_apply_args() so state.period was not initialized. The patch moves
>> the pwm_apply_args() call before any call to pwm_get_state().
>>
>> Fixes: '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")'
>> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

(and sorry for the delay)


Daniel.
