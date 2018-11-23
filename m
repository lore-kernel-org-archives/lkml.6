Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5938DC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CEA206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZR92b9A0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CEA206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504203AbeKWXEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:04:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45802 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387923AbeKWXEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:04:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so12142573wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CBGvwjaOm1WL4MLoE10hMX/c/DReBErA6e646z0HeMY=;
        b=ZR92b9A0R+rL4oT4dR+au9K1JoWDRbPclNJa5o0PIuK0HBFESDYVa/ANFyJm70l5Ev
         IzuAAlqY5XWG9wPwgCNcuHrfjWSY3RQZ3SxJg9ZJ1/qtykPWwuegOmNDLEGTBJvQc11Z
         TijPSbeiVQzH82AEL36QS1xM8pdAsb0XtQCiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBGvwjaOm1WL4MLoE10hMX/c/DReBErA6e646z0HeMY=;
        b=qwNr7BJmhWV/Drt3x1qVzo8NRMeJopTKyJ1zjE1lAN29Kb6ENa+890GF0akJhjaSZG
         XRZ8aG9W3azzweTudAvD+jWXijgdFCZrZv7LOGJKSOX0dsRUAHOiYjfpSBvWOg+lTVT6
         h/tv6TyyyJ2k6LcqZFyjMN+cCYpG58ZqgzghIUSp0Hfcij/IRyuzcRre3DFXebIRWz6F
         koeg2PEMOX/Yilp8uDBv6eV5wUB8GWjJUK7AiGF8ru0xEcVSwoZPpyhnFb8Vop8u1flW
         KnTNd+noGtflxx861gQ1jB0c0hFBTKVct3UK356GFvK9p4QlQeu8kEdShCjLh7Rltkg/
         FbUA==
X-Gm-Message-State: AA+aEWak445yhpYS7l7OioE2lw7VbhO+OnWUWm2+UsVo2xnS9yjQvbbf
        2nKLIWEAba151V9G0SpPXZyB37fmnNc=
X-Google-Smtp-Source: AFSGD/W6tjLBonycKh/yt3V5FDW8fRhJL66pWhbBM88ywMUwj8rvkgjb6bWHXn2+6loks6ExMUDJmg==
X-Received: by 2002:adf:f605:: with SMTP id t5mr13170391wrp.229.1542975650331;
        Fri, 23 Nov 2018 04:20:50 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id y190-v6sm6186158wmd.41.2018.11.23.04.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 04:20:49 -0800 (PST)
Subject: Re: [PATCH 05/17] clocksource: bcm2835: Switch to SPDX identifier
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Simon Arlott <simon@arlott.org>
References: <1541863719-7244-1-git-send-email-stefan.wahren@i2se.com>
 <dbc12f84-ebb1-998f-dd42-5ad936635744@linaro.org>
 <993d127f-91d6-aca8-256a-87723389ef8b@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <958de83a-c766-c9a1-a9f3-a0c8248eae1a@linaro.org>
Date:   Fri, 23 Nov 2018 13:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <993d127f-91d6-aca8-256a-87723389ef8b@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2018 13:06, Stefan Wahren wrote:
> Hi Daniel,
> 
> Am 12.11.2018 um 07:56 schrieb Daniel Lezcano:
>> On 10/11/2018 16:28, Stefan Wahren wrote:
>>> Adopt the SPDX license identifier headers to ease license compliance
>>> management. Also drop the FSF address.
>>>
>>> Cc: Simon Arlott <simon@arlott.org>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> ---
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>>
> thanks.
> 
> Can this patch go via your clockevents tree?

Sure, no problem. Applied for 4.21

Thanks

  -- Daniel




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

