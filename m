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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F2AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF2D21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEbYiiLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF2D21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391488AbeIVCuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:50:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35338 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVCuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:50:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so13153597ljg.2;
        Fri, 21 Sep 2018 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BZihNCEuy8MerKbQ4LuabDjpIZF8tZN6e03YcKw9+v0=;
        b=tEbYiiLUzjBK3Xl2NjDGq+A3sWQEbOgILBj4jg1IA677dMUVD47XiDNh4piuRt33tM
         Nm2GvzDGePHlRjz+rYDLwIoDi03m45b5uvYBgbCI7c03eajJlFEK+MuGZ1r7YJOdMVhU
         EZxi5rDO7SJEZumvdCWfhPke7Dt5KiqpSajsw2VIRV8wvjlel45KGhgssPVbIdYBcL0V
         qpnTgVJqt6odoZfOV+oTptmWqSZBQe2smFNvCUtWC7FkcCIkZs3vdeIBsTQjKkp16rBK
         IE0ve69TT0Xs4pYXopn4iI/iY29H+RBqCbs1o8Skwau+vNi0lpiiQAwzk2WLkjJC/y1E
         eeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZihNCEuy8MerKbQ4LuabDjpIZF8tZN6e03YcKw9+v0=;
        b=M6D3PpHfhPpKWosxUBlzV0TtYIb00ZAqWUpLy2wIWNUDiE8GwS5+IE7AYjpPxfRUP7
         8TDLL0ScdahdDSOpvs7SzZP5zd/vytWeL/KidnNszfwA4Uoo5dYGHZ0JFD3S46qttYOw
         gsQnHYX5lfflZDmXCwVxhn+mUrQsxR0IMLXAG6DRI/0D8FjNpq2mhNpdZkjObNuJ9oNR
         462BsluBeAl7immelV68/CNUD/p+EpEJodqj7hLTo/diNclvXFmQ13437falnJtzKNYp
         vRcncaN5XRSmWc88A7rWLp73LV4mXTsIDzTuspD/VViqbqXoKzHfGf9uwkcwUlMP4Avq
         n5kA==
X-Gm-Message-State: ABuFfogksWKz8ll08Wh5ZwLVAOwbvq0Ax01BZC/8OoDc8681N0heYhNM
        OPo9yLTuTW3zB44Ev8uI7tlOfiEN
X-Google-Smtp-Source: ACcGV63Au5AOlp5aOhV23x74rMR5hdfTA45oj7jFtDbTtSBN/X3mtYXRckEF0LeYOKP4EWDu3wlcGw==
X-Received: by 2002:a2e:299c:: with SMTP id p28-v6mr2001354ljp.12.1537563583517;
        Fri, 21 Sep 2018 13:59:43 -0700 (PDT)
Received: from [192.168.1.18] (chj43.neoplus.adsl.tpnet.pl. [83.31.7.43])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2442667lfa.9.2018.09.21.13.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:59:42 -0700 (PDT)
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>, Pavel Machek <pavel@ucw.cz>
Cc:     rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
 <CAMz4kuJx9twJ=wM5qsucV3JH_VS-AC1aWMqpQOwAMkCuKBHLRg@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <324778a9-a32c-ae6e-337a-39845f214bfc@gmail.com>
Date:   Fri, 21 Sep 2018 22:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJx9twJ=wM5qsucV3JH_VS-AC1aWMqpQOwAMkCuKBHLRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 09/21/2018 05:31 AM, Baolin Wang wrote:
> Hi Jacek and Pavel,
> 
> On 11 September 2018 at 10:47, Baolin Wang <baolin.wang@linaro.org> wrote:
>> This patch adds one new led trigger that LED device can configure
>> the software or hardware pattern and trigger it.
>>
>> Consumers can write 'pattern' file to enable the software pattern
>> which alters the brightness for the specified duration with one
>> software timer.
>>
>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>> pattern for some LED controllers which can autonomously control
>> brightness over time, according to some preprogrammed hardware
>> patterns.
>>
>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v11:
>>  - Change -1 means repeat indefinitely.
>>
>> Changes from v10:
>>  - Change 'int' to 'u32' for delta_t field.
>>
>> Changes from v9:
>>  - None.
>>
>> Changes from v8:
>>  - None.
>>
>> Changes from v7:
>>  - Move the SC27XX hardware patterns description into its own ABI file.
>>
>> Changes from v6:
>>  - Improve commit message.
>>  - Optimize the description of the hw_pattern file.
>>  - Simplify some logics.
>>
>> Changes from v5:
>>  - Add one 'hw_pattern' file for hardware patterns.
>>
>> Changes from v4:
>>  - Change the repeat file to return the originally written number.
>>  - Improve comments.
>>  - Fix some build warnings.
>>
>> Changes from v3:
>>  - Reset pattern number to 0 if user provides incorrect pattern string.
>>  - Support one pattern.
>>
>> Changes from v2:
>>  - Remove hardware_pattern boolen.
>>  - Chnage the pattern string format.
>>
>> Changes from v1:
>>  - Use ATTRIBUTE_GROUPS() to define attributes.
>>  - Introduce hardware_pattern flag to determine if software pattern
>>  or hardware pattern.
>>  - Re-implement pattern_trig_store_pattern() function.
>>  - Remove pattern_get() interface.
>>  - Improve comments.
>>  - Other small optimization.
>> ---
> 
> Do you have any comments for the v12 patch set? Thanks.

We will probably have to remove hw_pattern from ledtrig-pattern
since we are unable to come up with generic interface for it.
Unless thread [0] will end up with some brilliant ideas. So far
we're waiting for Pavel's reply.

[0] https://lkml.org/lkml/2018/9/13/1216

-- 
Best regards,
Jacek Anaszewski
