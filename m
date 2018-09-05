Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74C2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6AC20867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmXnf/FV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6AC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeIES4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:56:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43247 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIES4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:56:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so3512734pgb.10;
        Wed, 05 Sep 2018 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJ15nCupgUeJFAlXcGCC40bGXaqOIVf9cKtdp3m/FQs=;
        b=PmXnf/FVFXhNH+8rPAEJCgV3+1dGMr5UvnAJHQ8iqSD51O0K5HV6HoF9nfQCquBceX
         Ynko/7KiWHi+VuYahrLLcCtmbKBdhNceGPY2/odjrgwmBtcJhkin1Q39DZtCMx+6Bupi
         qjF+uDXtXCIX1Pa/m6dVedwlSDeBiQ5sfHDmIxhKR4c6WhKTPgDc4TQmJpltId7WXdSN
         MBj+11XuyQwHReVp6Kj6TWdtYYVjx10LYCCYttBg2YeiaKiOsyJplDu4/OLc3rFntuGg
         GjlLGKCytZyEd9vMx+I3iZjnbkoYShgskvD6dTR7vgHWFlhgTn9eGLIvs3nPXgmRv6gD
         XlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJ15nCupgUeJFAlXcGCC40bGXaqOIVf9cKtdp3m/FQs=;
        b=grDQ//mzJpu+0ckEUGS3azRIUoe/7ubzmijIvUXxWItIHQ89jeFMrAiYKnIkbGMnt8
         5LaIT6Z/aem1K7A4MTb7+JVojWbbAh0HH/LMqpg0nWsXcqOvz3tOQFN1bqsj7XYAr8py
         rTvBBWvs1EaRMpR7Dn8mLO9hjsyGPPn90cd/OklAT92G2Ritw4qSaiJuex3RSo9q1S29
         mcj7zfAy3IJOOalooGa4Qwd9k96qoi6/cYenkXcfB4RZdNbLfMb0meIGcwNnT4Hely07
         RdDBMFkoaKUtt0cmrVCHM+d/z0TI0rISIhNl6oKJld3YkpQyGpaVZVyi9wBCaNzb+D9f
         2erA==
X-Gm-Message-State: APzg51BRoHFOrG/NUKsiU+JE/oJzgIr664ARriS4OqZ9E8d1KOmHXwX6
        uVhq0sg3GrUCPC4VhCuuwn0XoYIB
X-Google-Smtp-Source: ANB0VdbGh+rsP7cO6Z9k+sU1Qw9Th2QF2hZiuRQn74Rkn9L4fBpcnPH3ov+UALSinMR0wfrHXtXPeA==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr36967623pgj.15.1536157578033;
        Wed, 05 Sep 2018 07:26:18 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:cbf:8500:e2a8:f094])
        by smtp.googlemail.com with ESMTPSA id u25-v6sm3180230pfk.177.2018.09.05.07.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:26:16 -0700 (PDT)
Subject: Re: [PATCH net] devlink: Fix devlink_param_driverinit_value_set()
 stub return code
To:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536066265-18641-1-git-send-email-moshe@mellanox.com>
 <2bf31ad0-c3f8-cdfd-8b96-1a8e3280064d@gmail.com>
 <7fd426d1-61a9-7f45-bf26-05bd9e180277@mellanox.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <b660e196-9277-f66a-5be8-4288f73b9305@gmail.com>
Date:   Wed, 5 Sep 2018 08:26:15 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7fd426d1-61a9-7f45-bf26-05bd9e180277@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 6:48 AM, Moshe Shemesh wrote:
> 
> 
> On 9/4/2018 7:13 PM, David Ahern wrote:
>> On 9/4/18 7:04 AM, Moshe Shemesh wrote:
>>> The stub function returned -EOPNOTSUPP while CONFIG_NET_DEVLINK is off.
>>> It caused false warning during driver load. Driver needs to update
>>> devlink on a parameter value if devlink module is there, if not it
>>> doesn't need any error code.
>>>
>>> Fixes: ec01aeb1803e ("devlink: Add support for get/set driverinit
>>> value")
>>> Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
>>> Acked-by: Jiri Pirko <jiri@mellanox.com>
>>> ---
>>>   include/net/devlink.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>>> index b9b89d6..b467357 100644
>>> --- a/include/net/devlink.h
>>> +++ b/include/net/devlink.h
>>> @@ -781,7 +781,7 @@ static inline bool
>>> devlink_dpipe_table_counter_enabled(struct devlink *devlink,
>>>   devlink_param_driverinit_value_set(struct devlink *devlink, u32
>>> param_id,
>>>                      union devlink_param_value init_val)
>>>   {
>>> -    return -EOPNOTSUPP;
>>> +    return 0;
>>>   }
>>>     static inline void
>>>
>>
>> This should be handled by the driver -- check for -EOPNOTSUPP and not
>> log an error.
> 
> This is a stub inline function.
> The return value would be ambiguous as the non-stub function can also
> return -EOPNOTSUPP, in case the driver-init mode is not supported for a
> parameter.
>>
>> devlink is generic infrastructure. If a call is made and the operation
>> is not supported, then devlink should return an error.
> 
> In general the stub functions should take care that the driver won't
> feel the missing code as much as possible. That's why
> devlink_params_register() returns success and so should this function.
>>

A driver is accessing core infrastructure to set a value; core infra can
not because the code is not compiled in. The driver should be told that
the option is not enabled, and it is at the moment with the -EOPNOTSUPP
return code.

That is similar to devlink_dpipe_table_resource_set which returns
-EOPNOTSUPP when devlink is compiled out.
