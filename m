Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeEMIty (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:49:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50191 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeEMItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:49:53 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix speedstep_detect_processor()'s return type
Date: Sun, 13 May 2018 10:49:23 +0200
Message-ID: <2465997.b7pp1xXBfD@aspire.rjw.lan>
In-Reply-To: <20180425024647.woeugwev6qchwert@vireshk-i7>
References: <20180424131414.1653-1-luc.vanoostenryck@gmail.com> <20180425024647.woeugwev6qchwert@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 25, 2018 4:46:47 AM CEST Viresh Kumar wrote:
> On 24-04-18, 15:14, Luc Van Oostenryck wrote:
> > speedstep_detect_processor() is declared as returing an
> > 'enum speedstep_processor' but use an 'int' in its definition.
> > 
> > Fix this by using 'enum speedstep_processor' in its definition too.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  drivers/cpufreq/speedstep-lib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
> > index e3a9962ee..cabb6f48e 100644
> > --- a/drivers/cpufreq/speedstep-lib.c
> > +++ b/drivers/cpufreq/speedstep-lib.c
> > @@ -252,7 +252,7 @@ EXPORT_SYMBOL_GPL(speedstep_get_frequency);
> >   *********************************************************************/
> >  
> >  /* Keep in sync with the x86_cpu_id tables in the different modules */
> > -unsigned int speedstep_detect_processor(void)
> > +enum speedstep_processor speedstep_detect_processor(void)
> >  {
> >  	struct cpuinfo_x86 *c = &cpu_data(0);
> >  	u32 ebx, msr_lo, msr_hi;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applied, thanks!
