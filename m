Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B547C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FB520827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FB520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeKJE60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:58:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45572 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJE60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:58:26 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA9JFl6M031226;
        Fri, 9 Nov 2018 13:15:47 -0600
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA9JFlaw046616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 13:15:47 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 9 Nov
 2018 13:15:47 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 9 Nov 2018 13:15:47 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA9JFl18015347;
        Fri, 9 Nov 2018 13:15:47 -0600
Subject: Re: arm64 + ARM64_64K_PAGES=y
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <1ab7ee03-64fe-384a-c88f-f6d519b965db@ti.com>
 <20181108120040.pzupzyqnsxeuv5ne@linutronix.de>
 <99e0b883-cf9f-2ab9-5003-d4506bfa461d@ti.com>
Message-ID: <274c9742-0aa9-b4a5-11cb-b506aeef7761@ti.com>
Date:   Fri, 9 Nov 2018 13:15:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <99e0b883-cf9f-2ab9-5003-d4506bfa461d@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/18 12:14 PM, Grygorii Strashko wrote:
> 
> 
> On 11/8/18 6:00 AM, Sebastian Andrzej Siewior wrote:
>> On 2018-11-06 15:34:55 [-0600], Grygorii Strashko wrote:
>>> Hi All,
>> Hi,
>>
>>> Do anybody tried to use ARM64 RT with 76K pages enabled?
>>
>> 75 would be an off by one but this :)
> 
> Ops 8-). at least subj is correct.
> 
>>
>>> My attempt shows that enabling  CONFIG_ARM64_64K_PAGES=y increases latencies by ~30%
>>>
>>> cyclictest -n -m -Sp98 -q -D2m with CONFIG_ARM64_64K_PAGES=y
>>>
>>>
>>> T: 0 (  772) P:98 I:1000 C: 120000 Min:      7 Act:   13 Avg:   10 Max:      85
>>> T: 1 (  773) P:98 I:1500 C:  79998 Min:      7 Act:   13 Avg:   10 Max:      71
>>> T: 2 (  774) P:98 I:2000 C:  59997 Min:      7 Act:   11 Avg:   11 Max:      64
>>> T: 3 (  775) P:98 I:2500 C:  47996 Min:      7 Act:   14 Avg:   12 Max:      66
>>>
>>>
>>> cyclictest -n -m -Sp98 -q -D2m with CONFIG_ARM64_64K_PAGES=n
>>>
>>>
>>> T: 0 (  697) P:98 I:1000 C: 120000 Min:      7 Act:   10 Avg:    9 Max:      38
>>> T: 1 (  698) P:98 I:1500 C:  79987 Min:      7 Act:   10 Avg:   10 Max:      32
>>> T: 2 (  699) P:98 I:2000 C:  59981 Min:      7 Act:   14 Avg:   11 Max:      46
>>> T: 3 (  700) P:98 I:2500 C:  47977 Min:      6 Act:   11 Avg:   10 Max:      45
>>
>> So this is an idle system?
> 
> Yes (in general) - it's collected with systemd, so some daemons are active.
> 
>> The Kconfig help says "faster TLB lookup". Interesting.
>> Are the 16k pages in between (latency wise) by any chance?
> 
> I'll try it.

no i'll not, at least not fast. with 16k pages enabled I can't boot TI 4.14 kernel
-  4.14.71-rt44.
No msg in log, just "Starting kernel ..."

-- 
regards,
-grygorii
