Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DCAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECC720828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw7y+OaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECC720828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeK0LXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:23:53 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37329 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeK0LXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:23:52 -0500
Received: by mail-yb1-f194.google.com with SMTP id d18-v6so8332573yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upaAYPnV5iffyx3OgwSGDZq87TL22iwJEQS396VwPxQ=;
        b=Mw7y+OaVKIX+Ho/DejxjLCTY225C4b+nMZJu3lhYt80ujmuQ4h3phJOboeNtlb4Xd/
         xJLyihG+HUUcO0BqlkPJx2eYR2iVA+SI63LFvaMqRvoeGnrRD6xFOl+TBT7VYFpSh29U
         +MIbsbiqsZNBF2Nh9DCBR+UU1/EByATOs5+p15HaVkQbMOvzllU/tayNmCwJ7b6bbqMa
         vwiWlQ/M5cJDJtY5VmM9cuRyrhKtNHFMVgHTEXsMWKDgKVrjRCA4cBheeKPDYku9QHld
         XxIXG93EM9gm8vB+Xk3s4Y5pmy2yRvrSgtOqWB3Oo6k2PHBVPGQXLXUbaLoL+VAYfUXQ
         SAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=upaAYPnV5iffyx3OgwSGDZq87TL22iwJEQS396VwPxQ=;
        b=kwRe0VrMA8DPfcg8810wYFTzQngpIT5R9Q/7DRNQHGx6jlNuljRVGnxZn2TMrAtWi6
         kdqOg1CKGbWT7FL+OwH8BgVdazk9hdMkjld3gx6RJuMWO7hYdk2OcE1uMFvi7siojWNh
         F9Y7wFIcMPrrYVHbfrQfvXPYxKOoTZ1/aFKWdwlS1M0jDKmRoB2i7bMzE5zQMGxxMUKv
         aH6TIDGTYuv/eOWMeMVsgGc8s9KhHzY8NA/Gx7yxfNBVlW2ZlXRcCT/JoJdC5ow1DcOn
         gp2NhP6mvEd8SxVNYhys4wMSdo+WAeo4GKkoZ46HERgvPZurw5NVzOgKIyMECK0Yg2SQ
         l12A==
X-Gm-Message-State: AGRZ1gK+RzD0Sv2fDDGK89UBctaNjBVy6hYKWDp3keJ4I10NqTT/eAdG
        MCjpnfp+8N1piKbci0crq+A=
X-Google-Smtp-Source: AJdET5fdLq6EeW9zbZ2hLscz6d9kzAbWaSSO/rsmJFAL7Pq3HLJwEoFtPTFiGxgmJAvufMwNQRCHgQ==
X-Received: by 2002:a25:8041:: with SMTP id a1-v6mr29549813ybn.53.1543278473984;
        Mon, 26 Nov 2018 16:27:53 -0800 (PST)
Received: from [10.67.49.109] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id u84sm493929ywb.12.2018.11.26.16.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 16:27:52 -0800 (PST)
Subject: Re: [PATCH v2 0/2] perf tests: Check for ARM [vectors] page
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
References: <20181025175508.6967-1-f.fainelli@gmail.com>
 <29ea3732-0018-42ff-da09-646ee71a61cb@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <149abe10-7ce5-5bf6-6182-6ca05969719c@gmail.com>
Date:   Mon, 26 Nov 2018 16:27:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <29ea3732-0018-42ff-da09-646ee71a61cb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 2:44 PM, Florian Fainelli wrote:
> On 10/25/18 10:55 AM, Florian Fainelli wrote:
>> Hi all,
>>
>> I just painfully learned that perf would segfault when
>> CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
>> it. This patch series adds an ARM test for that by leveraging the
>> existing find_vdso_map() function and making it more generic and capable
>> of location any map within /proc/self/maps.
> 
> Did not get much feedback, you are all probably busy attending LPC
> conferences, but I was wondering if this did make sense or if there is a
> better approach that should be looked at?
> 
> I am starting to see additional tests failing that require some ARM
> (32-bit) specific changes, and not accumulating too many of these fixes
> on top of that series would be neat.
> 
> Thank you!

Ping? Would you prefer a resend to avoid any possible conflicts? Thanks

> 
>>
>> Changes in v2:
>>
>> - use strlen() instead of sizeof() -1 since we made the page name a
>>   parameter
>> - use TEST_OK/TEST_FAIL in lieu of 0/-1
>> - added an error message indicating CONFIG_KUSER_HELPERS might be
>>   disabled
>>
>> Florian Fainelli (2):
>>   perf tools: Make find_vdso_map() more modular
>>   perf tests: Add a test for the ARM 32-bit [vectors] page
>>
>>  tools/perf/arch/arm/tests/Build          |  1 +
>>  tools/perf/arch/arm/tests/arch-tests.c   |  4 +++
>>  tools/perf/arch/arm/tests/vectors-page.c | 24 ++++++++++++++++++
>>  tools/perf/tests/tests.h                 |  5 ++++
>>  tools/perf/util/find-map.c               | 31 ++++++++++++++++++++++++
>>  tools/perf/util/find-vdso-map.c          | 30 +++--------------------
>>  6 files changed, 68 insertions(+), 27 deletions(-)
>>  create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
>>  create mode 100644 tools/perf/util/find-map.c
>>
> 
> 


-- 
Florian
