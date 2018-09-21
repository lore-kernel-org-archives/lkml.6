Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54592ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FEB21476
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwzUuGxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FEB21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeIVECY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:02:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39016 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIVECY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:02:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so13340930lji.6;
        Fri, 21 Sep 2018 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lzoIxcsvjeuWbBJ2BwMGQddtfd5tWiJc/hW7M9Dqtlc=;
        b=OwzUuGxAgrSPpzdVu3bs79+yctI/cyjGvsjuhBZJ48+iDm+9UjBAJXwIGhClfYbRZn
         QxegES7ZiASBhkebknCIZrYNI0TfHmY18qxMY1Q7T0e3XvKhT0Odx898hfg/pLJ29FW4
         JNSVzByC/PIik+PwkIugFQb14VOr2142s0pm9PTMwzB10nVvGYw4q9ri5iCNiqQrpGEP
         920PYrMuze3IalW5IfWQvd4PElMHxsPFPAK325daS8SHOVOvXSOrhcdkAzcKHrS3xTpa
         eVqsX4eYg1QewZ+v9Km+jBOb3i43Ysfny30ue0Hi5sonu19oeLNiQbkJA+FvKOxBWcKG
         3stQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lzoIxcsvjeuWbBJ2BwMGQddtfd5tWiJc/hW7M9Dqtlc=;
        b=Yhqj++scMvfH7n1lCawTPmCebGVNeK3oLE7tCm9FgIu0pGhpjh/CE6Tc3pdVjLnmVp
         1s5dniO2J9u1AL99M5PmWlDha3IYRLKSEOlifzAe+jYkoeaWfitZOaRjrQdLR3FuaLnn
         qlA1ulRYnJmlQW/qMZJ0b/Mz4dbKPHTxqFOKaY08IcIbTegPfSkVGdYCRiABIbyq3M3f
         38SDvnx8lgSl+xsFx4vlKuENeagsSbHXp+w6rSV6HHFL1kwWrzHV8/DAbxX5/S/ze2/K
         sSFpJbMVBDGo9BC3nSc+aG5lqV+UH0lByZRKigtYasofxJtWh6zS5K/usIIbzVfAk1bE
         yfJQ==
X-Gm-Message-State: ABuFfohufaIAkNuDSQ1qAlUYPgYIKLsXqynVe5icsSrlP3irVdnKGQ9y
        8/pEXqqmMH5ed0bjtXkGrRW+6e80
X-Google-Smtp-Source: ACcGV63QBjentgnsrgEMnkvYrScVYS3Gkpvd7HoHnberIiZ0lPtOV93yHfATMwwkhBxgnWLE+0nPIw==
X-Received: by 2002:a2e:7014:: with SMTP id l20-v6mr4031231ljc.141.1537567892251;
        Fri, 21 Sep 2018 15:11:32 -0700 (PDT)
Received: from [192.168.1.18] (chj43.neoplus.adsl.tpnet.pl. [83.31.7.43])
        by smtp.gmail.com with ESMTPSA id w202-v6sm1572631lff.17.2018.09.21.15.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:11:31 -0700 (PDT)
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
 <CAMz4kuJx9twJ=wM5qsucV3JH_VS-AC1aWMqpQOwAMkCuKBHLRg@mail.gmail.com>
 <324778a9-a32c-ae6e-337a-39845f214bfc@gmail.com> <20180921211758.GC18062@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ccac8e5f-e122-9f7d-aa43-fa89c79cb1fe@gmail.com>
Date:   Sat, 22 Sep 2018 00:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921211758.GC18062@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/2018 11:17 PM, Pavel Machek wrote:
> On Fri 2018-09-21 22:59:40, Jacek Anaszewski wrote:
>> Hi Baolin,
>>
>> On 09/21/2018 05:31 AM, Baolin Wang wrote:
>>> Hi Jacek and Pavel,
>>>
>>> On 11 September 2018 at 10:47, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>> This patch adds one new led trigger that LED device can configure
>>>> the software or hardware pattern and trigger it.
>>>>
>>>> Consumers can write 'pattern' file to enable the software pattern
>>>> which alters the brightness for the specified duration with one
>>>> software timer.
>>>>
>>>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>>>> pattern for some LED controllers which can autonomously control
>>>> brightness over time, according to some preprogrammed hardware
>>>> patterns.
>>>>
>>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> 
>>> Do you have any comments for the v12 patch set? Thanks.
>>
>> We will probably have to remove hw_pattern from ledtrig-pattern
>> since we are unable to come up with generic interface for it.
>> Unless thread [0] will end up with some brilliant ideas. So far
>> we're waiting for Pavel's reply.
>>
>> [0] https://lkml.org/lkml/2018/9/13/1216
> 
> To paint a picture:
> 
> brightness
> 
>    rise hold          lower       hold down
>   ^    XXXXXXXXXXXXXXX
>   |   X               XX
>   |  X                  XX
>   | X                     XXXXXXXXXXXXXXXXXXXXXXXXXX
>   +-------------------------------------------------------> time
> 
> This is what Baolin's hardware can do, right?
> 
> This is also what pattern trigger can do, right?
> 
> So all we need to do is match the two interfaces, so that hw_pattern
> returns -EINVAL on patterns hardware can not actually do.
> 
> I believe I described code to do that in [0] above.

You said that we should get the same effect by writing the
same series of tuples to either pattern or hw_pattern file.

Below command consists of four tuples (marked with brackets
to highlight), and it will activate breathing mode in Baolin's
hw_pattern:

"[0 rise_duration] [brightness high_duration] [brightness fall_duration]
[0   low_duration]"

Now, I can't see how these four tuples could force the software
fallback to produce breathing effect you depicted.

-- 
Best regards,
Jacek Anaszewski
