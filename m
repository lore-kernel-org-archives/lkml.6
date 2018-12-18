Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBB9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D632F21850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeLRPVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:21:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:38415 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbeLRPVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:21:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 07:21:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="102462626"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by orsmga008.jf.intel.com with ESMTP; 18 Dec 2018 07:21:47 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>, acme@kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for sink selection
In-Reply-To: <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org> <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org> <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
Date:   Tue, 18 Dec 2018 17:21:47 +0200
Message-ID: <87va3qeu7o.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>> +	/*
>> +	 * The HW mapping of a component is unique.  If the value we've been
>> +	 * given matches the component's start address, then we must have found
>> +	 * the device we are looking for.
>> +	 */
>
> To be frank, I don't quite like the idea of passing the base address of the
> component as the key to locate a device, (even though that is unique and readily
> available). I would rather prefer a programmable way to map the keys to the
> "sink" devices, which works platform agnostic (e.g, ACPI support, where the base
> address is not obvious from the name). Also if we decide to use a platform
> agnostic naming scheme, it becomes even more complex.
>
> We could assign a static "id/key" exported either via the device sysfs dir or
> the "pmu" dir. I prefer the latter.
>
> Thoughts ?

So, my understanding is that we have a bunch of trace sources and a
bunch of trace sinks to choose from when we set up the perf event. The
current model basically treats trace sources as PMUs and relies on the
sink configuration process to be done via sysfs, which is not ideal as
an API.

The first thing that comes to mind is: can then the sinks be made their
own PMUs, so the above can be done via the existing SET_OUTPUT ioctl?

Regards,
--
Alex
