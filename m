Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62CBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906AF20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391915AbfAPKVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:21:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732324AbfAPKVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:21:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BFF380D;
        Wed, 16 Jan 2019 02:21:38 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 254D03F5AF;
        Wed, 16 Jan 2019 02:21:35 -0800 (PST)
Subject: Re: [PATCH 1/7] perf/aux: Make perf_event accessible to setup_aux()
To:     mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org,
        gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-2-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8b217adf-6af0-e1c9-32ce-57e707fe7f60@arm.com>
Date:   Wed, 16 Jan 2019 10:21:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115230742.13730-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/01/2019 23:07, Mathieu Poirier wrote:
> When pmu::setup_aux() is called the coresight PMU needs to know which
> sink to use for the session by looking up the information in the
> event's attr::config2 field.
> 
> As such simply replace the cpu information by the complete perf_event
> structure and change all affected customers.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---

Looks fine to me. FWIW:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

