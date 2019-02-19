Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80612C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD6D21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfBSKA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:00:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50828 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfBSKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:00:27 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 35ea91a1e58b3c4d; Tue, 19 Feb 2019 11:00:25 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     viresh.kumar@linaro.org, rafael@kernel.org, gcherianv@gmail.com,
        pprakash@codeaurora.org, george.cherian@cavium.com,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com,
        john.garry@huawei.com
Subject: Re: [PATCH v3 0/2] Work around for Hisilicon CPPC cpufreq
Date:   Tue, 19 Feb 2019 10:59:00 +0100
Message-ID: <12311117.DSx6JT7Gj8@aspire.rjw.lan>
In-Reply-To: <1550375655-58007-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1550375655-58007-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, February 17, 2019 4:54:13 AM CET Xiongfeng Wang wrote:
> Hisilicon chips do not support delivered performance counter register
> and reference performance counter register. But the platform can
> calculate the real performance using its own method. This patch provide
> a workaround for this problem, and other platforms can also use this
> workaround framework. We reuse the desired performance register to
> store the real performance calculated by the platform. After the
> platform finished the frequency adjust, it gets the real performance and
> writes it into desired performance register. OS can use it to calculate
> the real frequency.
> 
> Changlog:
> 
> v2 -> v3:
> 	Recontruct 'cppc_get_desired_perf'.
> 	Rename 'cppc_workaround_info' to 'cppc_workaround_oem_info'
> 	Drop 'get_rate' member from struct cppc_workaround_oem_info
> 	Change 'cppc_wa_get_rate' pointer to a flag to indicate whether
> 	we need to aplly the workaround.
> 	Move the new functions to the beginning of cppc-cpufreq.c
> 
> 
> Xiongfeng Wang (2):
>   ACPI / CPPC: Add a helper to get desired performance
>   cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
> 
>  drivers/acpi/cppc_acpi.c       | 39 +++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  1 +
>  3 files changed, 106 insertions(+)
> 
> 

Both patches applied, thanks!


