Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A59C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C4E20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C4E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeJEQwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:52:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58452 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeJEQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:52:39 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 2909a8fe81f97fc6; Fri, 5 Oct 2018 11:54:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq / CPPC: Mark acpi_ids as used
Date:   Fri, 05 Oct 2018 11:51:34 +0200
Message-ID: <1561369.7cfCgrRCj6@aspire.rjw.lan>
In-Reply-To: <CAKwvOdnbnw-yciWkuuKMye=57qwpXDX4oPaoNUoeYvbpn-Tavw@mail.gmail.com>
References: <20181002223457.7564-1-natechancellor@gmail.com> <CAKwvOdnbnw-yciWkuuKMye=57qwpXDX4oPaoNUoeYvbpn-Tavw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 3, 2018 12:40:19 AM CEST Nick Desaulniers wrote:
> On Tue, Oct 2, 2018 at 3:35 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/cpufreq/cppc_cpufreq.c:431:36: warning: variable 'cppc_acpi_ids'
> > is not needed and will not be emitted [-Wunneeded-internal-declaration]
> > static const struct acpi_device_id cppc_acpi_ids[] = {
> >                                    ^
> > 1 warning generated.
> >
> > Mark the definition as used so that Clang understands we don't want this
> > warning while not inhibiting Clang's dead code elimination from removing
> > the unreferenced internal symbol when moving the data it contains to the
> > globally available symbol via MODULE_DEVICE_TABLE.
> >
> > $ nm -S drivers/cpufreq/cppc_cpufreq.o | grep acpi | tail -1
> > 0000000000000000 0000000000000040 R __mod_acpi__cppc_acpi_ids_device_table
> >
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 30f302149730..fd25c21cee72 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -428,7 +428,7 @@ MODULE_LICENSE("GPL");
> >
> >  late_initcall(cppc_cpufreq_init);
> >
> > -static const struct acpi_device_id cppc_acpi_ids[] = {
> > +static const struct acpi_device_id cppc_acpi_ids[] __used = {
> >         {ACPI_PROCESSOR_DEVICE_HID, },
> >         {}
> >  };
> > --

Patch applied, thanks!

