Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeCMOGr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:06:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38838 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbeCMOGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:06:45 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: scpi: add thermal dependency
To: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20180313114607.2061209-1-arnd@arndb.de>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <882eb475-4cb7-98dd-8c16-dbab8df04d24@arm.com>
Date: Tue, 13 Mar 2018 14:06:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313114607.2061209-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/03/18 11:45, Arnd Bergmann wrote:
> A built-in scpi cpufreq driver cannot link against a modular
> thermal framework:
> 
> drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_ready':
> scpi-cpufreq.c:(.text+0x4c): undefined reference to `of_cpufreq_cooling_register'
> drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_exit':
> scpi-cpufreq.c:(.text+0x9c): undefined reference to `cpufreq_cooling_unregister'
> 
> This adds a Kconfig dependency that makes sure this configuration
> is not possible, while allowing all configurations that can work.
> Note that disabling CPU_THERMAL means we don't care about the
> THERMAL dependency.
> 

Makes sense,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
