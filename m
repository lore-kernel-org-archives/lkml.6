Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754DDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F8D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F8D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeIFLbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:31:02 -0400
Received: from foss.arm.com ([217.140.101.70]:39478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbeIFLbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:31:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46E387A9;
        Wed,  5 Sep 2018 23:57:04 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.Emea.Arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B11C3F557;
        Wed,  5 Sep 2018 23:56:47 -0700 (PDT)
Subject: Re: [PATCH v6 04/14] PM / EM: Expose the Energy Model in sysfs
To:     Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-5-quentin.perret@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c012c934-d861-eba6-0c67-63e8308ae37b@arm.com>
Date:   Wed, 5 Sep 2018 23:56:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820094420.26590-5-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 02:44 AM, Quentin Perret wrote:
> Expose the Energy Model (read-only) of all performance domains in sysfs
> for convenience. To do so, add a kobject to the CPU subsystem under the
> umbrella of which a kobject for each performance domain is attached.
> 
> The resulting hierarchy is as follows for a platform with two
> performance domains for example:
> 
>     /sys/devices/system/cpu/energy_model
>     ├── pd0
>     │   ├── cost
>     │   ├── cpus
>     │   ├── frequency
>     │   └── power

cpus (cpumask of the perf domain), frequency (OPP's of the perf domain) 
and power (values at those OPP's) are somehow easy to grasp, cost is 
definitely not.

You have this nice description in em_pd_energy() what cost actually is. 
IMHO, might be worth repeating this at least in the patch header here.

[...]
