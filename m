Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D18C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886AB21582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="T+Fp2sL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886AB21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeKLNkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:40:15 -0500
Received: from cmta16.telus.net ([209.171.16.89]:47579 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbeKLNkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:40:15 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id M3DYgXa60PTKIM3DZg8LmV; Sun, 11 Nov 2018 20:48:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1541994539; bh=Yfo/AnEADA7m5Pdb7biAcHpkR2MrBe+e9fa+7ftBwxo=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=T+Fp2sL0bEW0UN4au7bgAbtNPUb9UTHTmRPyROrgoHwOUYLx3o5FpwPrRwSIMvM0q
         iKbkURpgiho8P+H/dHrv/DjyaByILcInapY6Kx4WiUpvDD19X5ZCsJ87fDsTpYse1V
         RplT1fat5fAQPUcyVXspm370zGN4ojTy2ny9bNj+mMqsfCloMHqAe+dQlJ591Hxl0W
         D0UH7DloSHDmhcn5h/sbwhKZe8joHvdlJNM6U+JHhP8HAdIh1YQJ62LxipNtOlaF+x
         ES90CBOvQc7I4ery/FO4CCIUPPgCuFm+0Es/YEHBSfsxaw3kmHb9vEA7moenTsG9vI
         jm9zDLr8dBUdg==
X-Authority-Analysis: v=2.3 cv=ScEmicZu c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=pTBt3e4HGWyJHFOnYdkA:9 a=qDq-Y2p-iwLrt0KP:21 a=CFiCtkeVyVkWwzcQ:21
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
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Doug Smythies'" <dsmythies@telus.net>
References: JLIjge0NMDhAwJLIogChPj KR9ogVaVz6DhgKRFdgxgYz LaclgNKRzDhAwLb6UgqZPJ
In-Reply-To: LaclgNKRzDhAwLb6UgqZPJ
Subject: RE: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date:   Sun, 11 Nov 2018 19:48:51 -0800
Message-ID: <005901d47a3a$a49420d0$edbc6270$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdR0W8vD4oREAbGoTFqO9uyL0vrNhgCWrS2wAJOvwLAATRB1MA==
X-CMAE-Envelope: MS4wfFbb8D/YiXqnEBVQDCVJfHFiqS/hyUwCyloqNlm7Qppb9xho2B1Y3lQDmOspUGzEFbLETq+EsxhbiPZ3k5l4R/eRQ/oGROUjm5wP168GlvyhRnPSAdqS
 0Xk3MwZjGYmdn2ArQnj3ry2Ps4g24YsBK4x1E2kVAel3+bUoVRJ1A8Eygp6F4LE5Dr/iwIZuwUM189s+zLCKh6pXlfxZ8SM3SDGE1K2CQBDF+Hpzq6w4lGDs
 488NYgMTNy7WDfirhIxd+p82/TdA8fTsYgVK+oK9/+dLLcA1vFC4I6DuHcrk59/11kMfkIHzOx1oJTHTk9YlhSOwNoe8URxalCwBsSQWpPhyPQR87vbJl+4y
 Jh9Zx0dG5QJXDSsRhhsW2UU5RwVXTBjmMDo7EYCZNeJcC1l2wE4eSCyOWPgbzWQ1m5E47+/C+dBv8P23SFhD1sALLH+edMX/ANnG2xjPEQn6ylq+SrH3R7DJ
 ssmEJ/CvHhPmUEM7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.11.10 13:48 Doug Smythies wrote:
> On 2018.11.07 09:04 Doug Smythies wrote:
>
>> The Phoronix dbench test was run under the option to run all
>> the tests, instead of just one number of clients. This was done
>> with a reference/baseline kernel of 4.20-rc1, and also with this
>> TEO version 3 patch. The tests were also repeated with trace
>> enabled for 5000 seconds. Idle information and processor
>> package power were sampled once per minute in all test runs.
>>
>> The results are:
>> http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
>> http://fast.smythies.com/linux-pm/k420/histo_compare.htm
>
> Another observation from the data, and for the reference/
> baseline 4.20-rc1 kernel, idle state 0 histogram plots
> is that there are several (280) long idle durations.
>
> For unknown reasons, these are consistently dominated by
> CPU 5 on my system (264 of the 280, in this case).
>
> No other test that I have tried shows this issue,
> But other tests also tend to set the need_resched
> flag whereas the dbench test doesn't.
>
> Older kernels also have the issue. I tried: 4.19, 4.18
> 4.17, 4.16+"V9" idle re-work patch set of the time.
> There is no use going back further, because "V9" was
> to address excessively long durations in shallow idle states.
>
> I have not made progress towards determining the root issue.

For whatever reason, sometimes a softirq_entry occurs and it is
a considerably longer than usual time until the softirq_exit.
Sometimes there are bunch of interrupts piled up, and sometimes
some delay between the softirq_entry and anything else happening,
which perhaps just means I didn't figure out what else to enable
in the trace to observe it.

Anyway, it seems likely that there is no problem here after all.
 
... Doug


