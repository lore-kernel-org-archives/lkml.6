Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574ABC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8682089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="a2O1HD+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8682089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbeKKHeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 02:34:10 -0500
Received: from cmta17.telus.net ([209.171.16.90]:55483 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbeKKHeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 02:34:09 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id Lb6MggLYXP96wLb6NgF0xl; Sat, 10 Nov 2018 14:47:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1541886462; bh=chq4lRCIFA9c9VB8arC2XcKcz7jKTZN+RdsIca7c3qg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=a2O1HD+okVcuW+8rHx9AUMxEoUmdT8IkQLxM9yv3SQsFw3XMqJMRwETrh1CWh4qfJ
         IQMZR5FdnpL82+lgNZlxBo781Qb6HOwiiF4GAL8/WtuOjSnO8rzvXT7B7VfP+4PyjB
         QRlh1+u+GOvs7GP03ovUk/aPKjVeRm0BE52yC+XVOZuTiICtnFwDxz/5yO9PevtojG
         6p5NKkoRPgeXMCmpPnwqQhXQDqbxQWXCJYxjacSjYHayKTIIN2Em9fStSej6mlL6hj
         H6vsU70Yyk7fYbgLxH/3wVBRBJNMVsAzkeLVDeSnCvgH6hIOwdlpy8nTG7BK/lOGq3
         fTH4pYMKjolCg==
X-Authority-Analysis: v=2.3 cv=G5vN7Os5 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=ugkoA4SMqsBuiJswprwA:9 a=PQ8TymTXbGEOm_cX:21 a=vxPhXtqwuZbslzO-:21
 a=CjuIK1q_8ugA:10 a=5JIPC4SmUL4A:10 a=eM4ghy-HDjkA:10
 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Doug Smythies'" <dsmythies@telus.net>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
References: JLIjge0NMDhAwJLIogChPj KR9ogVaVz6DhgKRFdgxgYz
In-Reply-To: KR9ogVaVz6DhgKRFdgxgYz
Subject: RE: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date:   Sat, 10 Nov 2018 13:47:33 -0800
Message-ID: <001001d4793f$020a7f90$061f7eb0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdR0W8vD4oREAbGoTFqO9uyL0vrNhgCWrS2wAJOvwLA=
Content-Language: en-ca
X-CMAE-Envelope: MS4wfLTmeI/HcROGLdO/H3saieYM74C4fFio9PF+M3tXeY82yU/gEAYmV9F4kbWJilKKMZjYkfCOiJJGuTozVXSG8dciGM8Yx7fNGATaAHLtxIyj94mjad3a
 8CXOlGUFs8I2lSJZmGtB4hmHjgCHnI1t/+BFB4uz6LRoWQjzagxalMWjZi8uESgsdVppZoQospr92LiEltAFtWSLkNklrpHa2f6Fj864hetdqYm/kJ0YV85V
 jHyAoo9SEe5WhuMVxKLssKLgwUaxqeCXzJVMUqXDlr4Sao4Z/eOlcECztanXlMpIBaK6feguXJJGuUg7oCPAvaUfrdcMmIpe9uym3XHywn8mpBQClikKaJxa
 FHUmjHEyAhlPg0FbD2hbQOLcTaoDqsGebXT4QFOuurI5wG86Zlo3Z13k6TVI71N+QF1FYCSnIdk8jp5qDC06V51Litv9MHxwIHvll2/ee+o3JF2/yVRrm+1H
 8v5RQ0XWEaljQIL6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.11.07 09:04 Doug Smythies wrote:

> The Phoronix dbench test was run under the option to run all
> the tests, instead of just one number of clients. This was done
> with a reference/baseline kernel of 4.20-rc1, and also with this
> TEO version 3 patch. The tests were also repeated with trace
> enabled for 5000 seconds. Idle information and processor
> package power were sampled once per minute in all test runs.
>
> The results are:
> http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
> http://fast.smythies.com/linux-pm/k420/histo_compare.htm

Another observation from the data, and for the reference/
baseline 4.20-rc1 kernel, idle state 0 histogram plots
is that there are several (280) long idle durations.

For unknown reasons, these are consistently dominated by
CPU 5 on my system (264 of the 280, in this case).

No other test that I have tried shows this issue,
But other tests also tend to set the need_resched
flag whereas the dbench test doesn't.

Older kernels also have the issue. I tried: 4.19, 4.18
4.17, 4.16+"V9" idle re-work patch set of the time.
There is no use going back further, because "V9" was
to address excessively long durations in shallow idle states.

I have not made progress towards determining the root issue.

... Doug


