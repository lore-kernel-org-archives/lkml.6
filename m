Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D37C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0775A21741
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoSNAPd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeL1BfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:35:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46244 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeL1BfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:35:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so16333854oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 17:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qx+xOrtf5aIwVOrAj7bVsl9Jc/HCNCAmUBz24+oOR0Q=;
        b=qoSNAPd8634wrWR8Qw7P4NJDRozTGFx5IDqWgBGmOQVNS0r+6hqXWW2yfrt3vk5Jt4
         3kBH3NHicF/Nq0kez5szyMOoMYqM765eG1+a793hPPj+wdVC36Ir2IXYAYEq+VhVUxOU
         TkdoEyzoGHpqYSJMELsWYPXyQeDh81ehztrTfDtWCAcllQjNy0v2duEc1/MQzUNIlThF
         Yv9romwMG1L+6sUwJMZPVvN+5oPAQe0VlT2OyaDPrBAAuckt4cyNkqT/mCAytPGEfjd2
         3H8iXMznMUXS5GM5HzpJ+k+Ju6y6XJI7TUTF05w3tU9Lu9UiFaPxTcccQradcomk7aK7
         fsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Qx+xOrtf5aIwVOrAj7bVsl9Jc/HCNCAmUBz24+oOR0Q=;
        b=olBkeHHUIvg/P4qP6a1All0oLWSzfSElJb2i3REzIHZzcDuPZRl5GRi3sX6+3xNxGG
         DimkUrLijwIzTZuANvlLqGAMY161mBTYxyDjOzCs1ytmzP8K5sZAnGd8OgwUDOaxIq5N
         TXev/ADUztluE3GoaOp6Alq8zVukn4fxef7LHxFbVFsCXnM205/NnqjwWSZJADTEaSmL
         EQMWJScQeSOkmYRpZn7jQGFj3ya5wzRuyG9GrOm/jsixeqGciBmTQROqqlYLQAeJBaOI
         iY2PFchso9TVL9aQ2vl7jLeymDJhUXmvjfj/fRTJ1dh65HP6+pa1hNXssQW4OPy1e5bR
         v+iQ==
X-Gm-Message-State: AA+aEWYkqCnRoCpmOQRCyDavQ507/mBHrVUwojoNvTRf+XIhGqVvVhtC
        hJKzG4U028EzFOYEmHS+57M=
X-Google-Smtp-Source: AFSGD/VH8nsEFH6Q5wh+amnMKr33q2FxcazAvDAAAlj/WgwS4SurnVagpbItoKCoLMFv883S6LAuWQ==
X-Received: by 2002:a54:440d:: with SMTP id k13mr17578159oiw.263.1545960921032;
        Thu, 27 Dec 2018 17:35:21 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id c19sm19620018otl.16.2018.12.27.17.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 17:35:20 -0800 (PST)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de,
        kernel-team@lge.com
References: <20181221034337.26663-1-f.fainelli@gmail.com>
 <20181227105539.GA4521@sejong>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Subject: Re: [PATCH v3 0/2] perf tests: Check for ARM [vectors] page
Message-ID: <27ac27b2-c373-2831-e7ce-4e898365d517@gmail.com>
Date:   Thu, 27 Dec 2018 17:35:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227105539.GA4521@sejong>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/27/18 à 2:55 AM, Namhyung Kim a écrit :
> Hello,
> 
> On Thu, Dec 20, 2018 at 07:43:35PM -0800, Florian Fainelli wrote:
>> Hi all,
>>
>> I just painfully learned that perf would segfault when
>> CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
> 
> Could you please elaborate?

Sure, I was debugging why perf was segfaulting on my systems and saw
that the faulting address was within 0xffff_0000 (high vectors); and
because CONFIG_KUSER_HELPERS was not enabled, nothing was mapped at that
address so this was a legitimate crash. This was on a variety of ARMv7A
systems, Cortex-A9, Cortex-A5 etc.

Later on, I found that in tools/arch/arm/include/asm/barrier.h the
barriers are unconditionally defined to make use of the [vectors] page
that the ARM kernel only sets up when CONFIG_KUSER_HELPERS is enabled
and this is the reason for the crash.

Testing for the page itself is pretty harmless if you think we should
make something more robust around checking for HAVE_AUXTRACE_SUPPORT
(which appears to be the specific location making use of barriers), let
me know.

Thanks!

> 
> Thanks,
> Namhyung
> 
> 
>> it. This patch series adds an ARM test for that by leveraging the
>> existing find_vdso_map() function and making it more generic and capable
>> of location any map within /proc/self/maps.
>>
>> Changes in v3:
>>
>> - remove find_vdso_map() call find_map() with VDSO__MAP_NAME
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
>>  tools/perf/Makefile.perf                      |  4 ++--
>>  tools/perf/arch/arm/tests/Build               |  1 +
>>  tools/perf/arch/arm/tests/arch-tests.c        |  4 ++++
>>  tools/perf/arch/arm/tests/vectors-page.c      | 24 +++++++++++++++++++
>>  tools/perf/perf-read-vdso.c                   |  6 ++---
>>  tools/perf/tests/tests.h                      |  5 ++++
>>  .../perf/util/{find-vdso-map.c => find-map.c} |  7 +++---
>>  tools/perf/util/vdso.c                        |  6 ++---
>>  8 files changed, 45 insertions(+), 12 deletions(-)
>>  create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
>>  rename tools/perf/util/{find-vdso-map.c => find-map.c} (71%)
>>
>> -- 
>> 2.17.1
>>


-- 
Florian
