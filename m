Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FBFC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A1820672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="lQSCO6fP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A1820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLHQYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:24:30 -0500
Received: from cmta20.telus.net ([209.171.16.93]:45631 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeLHQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:24:30 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id VfOvg2cGdVltLVfOwgC4vm; Sat, 08 Dec 2018 09:24:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1544286269; bh=aAB7W9YMqcqu9yRSFUCoFFxoR8urENDF3qKnPnkbiJA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=lQSCO6fPltt49Uy9zOmJDwZ/1D6gE8C1aSH+coeTKDHq4BhWsDiLgrvbmElWDCHQc
         3uABfFqzMq8SUL6A2N2xdH82CucODni6nLJvzWnWzDYWuY2lt7LSjfLiPH7y20adKW
         k5K6V0Uber9JHidf23W6OJkLTXt9uOortkLhqcm3vx7G0Ezlo+zyGIA92Q0rFOCrA2
         bYyeOtyvDm1DDcvuQZ89Q7O1LRZlDndW/Vz8LZorVRM5PdrAbp6hXupHomyUdC4a5P
         VBkOUoJpSyrj2RqKnBVgVibat6E6q2GvxYwlNAQwPfR6/N4OSeZIz+J54+0U4bSSDg
         MhZfk5zOojF6g==
X-Authority-Analysis: v=2.3 cv=d60kNirE c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=OuBNrd82AAAA:20
 a=DtRpAXFkUlvce2cDs3cA:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "Doug Smythies" <dsmythies@telus.net>
References: <42865872.dmYH3PmblP@aspire.rjw.lan>         T62Cgz3BqpqCWT62HgcJvj <001a01d48b24$9aa38c00$cfeaa400$@net> VZhHgXUsnXrKKVZhNgPvLt
In-Reply-To: VZhHgXUsnXrKKVZhNgPvLt
Subject: RE: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date:   Sat, 8 Dec 2018 08:24:20 -0800
Message-ID: <000d01d48f12$7e2e16c0$7a8a4440$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdSO33J5pwC8OHnOTsGCC3MEUe9mcQAMJyqQ
Content-Language: en-ca
X-CMAE-Envelope: MS4wfEC/Xnwq6ho5JhMtSLszSJGHAM//wrtg2sTf7v9F70aDURtjjepZZ4RLMqe0Y6teLqkGZZTGlHMqwyuwDgPfZ2sUDChiYE/69qqbPPauP8p3txa+gSWf
 xYdik8WMaiOv8XsrgLjMUJQXovCLNHV9M9OGqVUQjLYRjLm9UVQa187qNtD9aAlQGAXaviSi+zsnHk9Kd0Z+LXmrREKLVpIdjpTnTc5Muoh3ItsXyEkm33Sv
 epzig2YxGxtKqBrdlnXly9witw3VLpWHdrgaDyzkKnzPn1Fbu4gMvK4cQM5oBzV1L0w1VAW6s2gRuoNWcQHAPiSQaqRj7NkDH2l32IZLjSVEHRtrkRuWsbeh
 5lhBrI5qnXsyKiZYOCl1sstCmRzo/zwOHneL1BpF+MsIH/T5OisSQcfQiR9g02nmmtrUGr5ZNO+B6uTm+AeR8IN56VEFfA7X8J8JE4A4PkqpuDQmDzlsa59B
 oUT/SVaIKO3o42KA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.12.08 02:23 Giovanni Gherdovich wrote:

> sorry for the late reply, this week I was traveling.

No Problem. Thanks very much for your very detailed reply,
which obviously took considerable time to write. While
I was making progress, your instructions really fill in
some gaps and mistakes I was making.

Eventually (probably several days) I'll report back my test
results.


> Some specific remarks you raise:
>
> On Mon, 2018-12-03 at 08:23 -0800, Doug Smythies wrote:
>> ...
>> My issue is that I do not understand the output or how it
>> might correlate with your tables.
>> 
>> I get, for example:
>> 
>>    3    1   1     0.13s     0.68s     0.80s  1003894.302 1003779.613
>>    3    1   1     0.16s     0.64s     0.80s  1008900.053 1008215.336
>>    3    1   1     0.14s     0.66s     0.80s  1009630.439 1008990.265
>> ...
>> 
>> But I don't know what that means, nor have I been able to find
>> a description anywhere.
>
> I don't recognize this output. I hope the illustration above can clarify how
> MMTests is used.

Due to incompetence on my part, the config file being run for my tests was
always just the default config file from my original
git clone https://github.com/gormanm/mmtests.git
command. So regardless of what I thought I was doing, I was running "pft"
(Page Fault Test).

... Doug


