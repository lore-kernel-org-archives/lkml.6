Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9/5SVqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53660606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeFFMo3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:44:29 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43371 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeFFMo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:44:26 -0400
X-Google-Smtp-Source: ADUXVKKpgVFsH/fztdWMsL/XwqhG+9P3jtls9ZsyamNY5E5uqNKFanpH3/qCgloFv8xC/K7/nliiJM/BiHTpAjh+SHs=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hTTe9zYwYKtoQKjJJbazFeaGVO2SdbaODyvTFiNpGTdw@mail.gmail.com>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com> <CAJZ5v0hTTe9zYwYKtoQKjJJbazFeaGVO2SdbaODyvTFiNpGTdw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Jun 2018 14:44:25 +0200
X-Google-Sender-Auth: hpVfNQC4mNaHqOIQE9M2c522lfI
Message-ID: <CAJZ5v0jHgz1OWHfAhvkP_rZX=m7NCuZxqO5LA4or5WtygEZxFw@mail.gmail.com>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jakub Racek <jracek@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 2:34 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jun 6, 2018 at 2:27 PM, Jakub Racek <jracek@redhat.com> wrote:
>> Hi,
>>
>> There is a huge performance regression on the 2 and 4 NUMA node systems on
>> stream benchmark with 4.17 kernel compared to 4.16 kernel. Stream, Linpack
>> and NAS parallel benchmarks show upto 50% performance drop.
>>
>> When running for example 20 stream processes in parallel, we see the
>> following behavior:
>>
>> * all processes are started at NODE #1
>> * memory is also allocated on NODE #1
>> * roughly half of the processes are moved to the NODE #0 very quickly. *
>> however, memory is not moved to NODE #0 and stays allocated on NODE #1
>>
>> As the result, half of the processes are running on NODE#0 with memory being
>> still allocated on NODE#1. This leads to non-local memory accesses
>> on the high Remote-To-Local Memory Access Ratio on the numatop charts.
>> So it seems that 4.17 is not doing a good job to move the memory to the
>> right NUMA
>> node after the process has been moved.
>>
>> ----8<----
>>
>> The above is an excerpt from performance testing on 4.16 and 4.17 kernels.
>>
>> For now I'm merely making sure the problem is reported.
>
> OK, and why do you think that it is related to ACPI?

In any case, we need more information here.

Thanks,
Rafael
