Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6275BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241D420684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hizt7hwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241D420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394595AbeKVVu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:50:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54891 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbeKVVu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:50:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so8584433wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 03:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0DLWFlyfH/W8c5PJNdJ/DKXv+ibf+/DQx/08sZ5a9R8=;
        b=hizt7hwkxBEXQi50Sc1+8RnY5oYZXFt59hHsudlpVd0CM1ESadj7ITP1wTH1Co9OQy
         byKBZOvrQwC09SSG3VfUxdPpyMHMVslttyPO1JnQCHn7h9AHykTw/NWKjCJYAqK9JxKt
         CUSoRsuUagqCUTav2RqK1F1shTcvb3BJ3iGvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0DLWFlyfH/W8c5PJNdJ/DKXv+ibf+/DQx/08sZ5a9R8=;
        b=fbQCjC2Q2LuJWWYh4ecx760rT8OY05R8cXJFD53r4crnhsEIbbHuCZzJyNorzz9egf
         NB3xmpRj4Bwh6TwQStki+KwldjLXpH8YYQyj6R5WObjtq/M3Rclvem3rlcELWFKpe0qq
         SeYmkVEDWUSUeAzDWFI7CAICK3L0sOVZ8wAY3/id0xOsl0RSDj+vivUb9ilg+n+jcVDd
         jzADuAm4P3Im91IJay76ox8lr/0gexDF96NvJ0ZQ6JaKoc21BeOMYFJL807F4R+dJfTd
         L43DccS6MsVxxV+V1BQFuHik8mBkQEZbMbz8DkgGeRkLB/RqBmucjPe3YQMKl2iDQpyL
         BhMA==
X-Gm-Message-State: AGRZ1gK9D61KD2YI9JGuldMyxJdvEq7XlnrHUTHfLF8z9sgKMpqhOgu4
        YhiPw0n+cpRg1FgkD5OHj4CBdg==
X-Google-Smtp-Source: AFSGD/XVkwlHergtHJ/G8yy8LsUpE1ZssQN6xF2dWGF01786aDe8TYdCFcoKFf/bwWfro0pdKf30Jw==
X-Received: by 2002:a1c:8d86:: with SMTP id p128-v6mr9873673wmd.48.1542885118893;
        Thu, 22 Nov 2018 03:11:58 -0800 (PST)
Received: from [192.168.0.40] (189.35.136.77.rev.sfr.net. [77.136.35.189])
        by smtp.googlemail.com with ESMTPSA id q14sm8430498wrw.39.2018.11.22.03.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 03:11:58 -0800 (PST)
Subject: Re: [PATCH 4/4] base/drivers/topology: Default dmpis-mhz if they are
 not set in DT
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-4-git-send-email-daniel.lezcano@linaro.org>
 <20181030085845.az2dstibnrcl7im4@vireshk-i7>
 <3c3890d2-8b46-797d-328f-bd5dee11b22d@linaro.org>
 <20181122042900.u6eefkbw32vvi6xm@vireshk-i7>
 <b507cf16-aa78-303e-7459-ad380266317e@linaro.org>
 <20181122103114.epqwwta5ug7v5l55@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <50affce1-6d1b-8072-42f5-309e5da9cc59@linaro.org>
Date:   Thu, 22 Nov 2018 12:11:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122103114.epqwwta5ug7v5l55@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 11:31, Viresh Kumar wrote:
> On 22-11-18, 11:29, Daniel Lezcano wrote:
>> Oh ... actually raw_capacity is not needed at all!
> 
> It is required as another routine writes some values to it I believe :)

Well actually it is accessed 'later' by topology_normalize_cpu_scale()
by a call from arch/arm/kernel/topology.c and arch/arm64/kernel/topology.c

This code deserves a bit of rework, I don't have the time to take care
of it, so I will resend with your suggestion and do some cleanup later.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

