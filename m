Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCVX04 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:26:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58910 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeCVX0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:26:55 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: scpi: add thermal dependency
Date: Fri, 23 Mar 2018 00:27:19 +0100
Message-ID: <2123076.Z6YobIbZNI@aspire.rjw.lan>
In-Reply-To: <20180314050954.GE15832@vireshk-i7>
References: <20180313114607.2061209-1-arnd@arndb.de> <20180314050954.GE15832@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 14, 2018 6:09:54 AM CET Viresh Kumar wrote:
> On 13-03-18, 12:45, Arnd Bergmann wrote:
> > A built-in scpi cpufreq driver cannot link against a modular
> > thermal framework:
> > 
> > drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_ready':
> > scpi-cpufreq.c:(.text+0x4c): undefined reference to `of_cpufreq_cooling_register'
> > drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_exit':
> > scpi-cpufreq.c:(.text+0x9c): undefined reference to `cpufreq_cooling_unregister'
> > 
> > This adds a Kconfig dependency that makes sure this configuration
> > is not possible, while allowing all configurations that can work.
> > Note that disabling CPU_THERMAL means we don't care about the
> > THERMAL dependency.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/cpufreq/Kconfig.arm | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 9bbb5b39d18a..d9457d1e535c 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -45,6 +45,7 @@ config ARM_DT_BL_CPUFREQ
> >  config ARM_SCPI_CPUFREQ
> >  	tristate "SCPI based CPUfreq driver"
> >  	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
> > +	depends on !CPU_THERMAL || THERMAL
> >  	help
> >  	  This adds the CPUfreq driver support for ARM platforms using SCPI
> >  	  protocol for CPU power management.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
