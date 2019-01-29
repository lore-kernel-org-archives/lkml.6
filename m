Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B57C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6342084C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8FU5aDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfA2UUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:20:35 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44153 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfA2UUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:20:35 -0500
Received: by mail-ua1-f67.google.com with SMTP id d19so7295723uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilHjXEI1KzvjdP9zzP42JvJaplYBYotZ66b5QTZL1Bc=;
        b=N8FU5aDZJHTzVXJlRIgvC7uoZvuURuzLWl0hw+dJw3aIad4JdXBcmTUn5CV7cXDw1H
         /kitQH4t8F+dMQdALsiQB5fEXmt+UxLLLTG/Tg3KjnJtdB/fueBYqN5mqPbJzCdBDkZw
         M7uuBqHGAe6K8RMG6zZk3dxKqhnZmP3EQ5df4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilHjXEI1KzvjdP9zzP42JvJaplYBYotZ66b5QTZL1Bc=;
        b=Xv55UficRSnL47Vi1DzgI4DbMUzgnRMDFG8aqdYsiqh52X0Qq155kmbhifh+qWJrX4
         eomj47ZwtYHKdzFanI9Y+XaJOkg0C+rME6rr5YtSczfkGR5PhoaOt46oUUmrKK/1gTvs
         XDR0omH5XOY0a+tn/xZKaYbSABVJtPpLFt5UBE2BLnIz3i1BueJLS9NILqdiyZGT8EQF
         4o3dPORVc4a/sGH6P5XH0EZ5AOosNbl1Efot+SEV8zjGGnnimNfzFaog3o+87jZtLO5H
         hpSog/i0qi58K7RgaCL7NqBM2oPEgFTtLfb28r+VU7uNOxF72Ivm5rzA61aT/fAk5VvP
         Jidg==
X-Gm-Message-State: AJcUuke4IxYeKwAiM65e/S+JjNLz78G3Xl3lpWuRjcx99zItSYbHGejk
        +0E7vWOhBbdAWo0qLhj8l6WsW/ylvLHa7B3lRkfUjw==
X-Google-Smtp-Source: ALg8bN4F6v2thNh+uz9FjyxVvJUaN1hmrHfB37XX4gzMAJbwTLg3mX+1RuGcmScFgiFBSON9cPxkpMqNNvsmEr+I+YA=
X-Received: by 2002:ab0:6446:: with SMTP id j6mr11410854uap.2.1548793233719;
 Tue, 29 Jan 2019 12:20:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
 <20190129053618.laa6nscfvlmhhkb5@vireshk-i7> <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
 <CAJZ5v0hs2Af9DJoxiyMmFt7R5nYbGOCqgG5cvPOL8yrQXN-ZUw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hs2Af9DJoxiyMmFt7R5nYbGOCqgG5cvPOL8yrQXN-ZUw@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 30 Jan 2019 01:50:22 +0530
Message-ID: <CAHLCerN-+57hH8r5e0ZyNY6+w102tHHhWORXk2admf1EU_=jjA@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000871c4e05809e86f4"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000871c4e05809e86f4
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 29, 2019 at 2:43 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 29, 2019 at 6:46 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > On Tue, Jan 29, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 29-01-19, 10:25, Amit Kucheria wrote:
> > > > All cpufreq drivers do similar things to register as a cooling device.
> > > > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > > > to register the cooling device on their behalf. This allows us to get
> > > > rid of duplicated code in the drivers.
> > > >
> > > > In order to allow this, we add a struct thermal_cooling_device pointer
> > > > to struct cpufreq_policy so that drivers don't need to store it in a
> > > > private data structure.
> > > >
> > > > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > > > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
> > > >  include/linux/cpufreq.h   |  9 +++++++++
> > > >  2 files changed, 22 insertions(+)
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index e35a886e00bc..0f9b50d3ee91 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -19,6 +19,7 @@
> > > >
> > > >  #include <linux/cpu.h>
> > > >  #include <linux/cpufreq.h>
> > > > +#include <linux/cpu_cooling.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/init.h>
> > > > @@ -1318,6 +1319,11 @@ static int cpufreq_online(unsigned int cpu)
> > > >       if (cpufreq_driver->ready)
> > > >               cpufreq_driver->ready(policy);
> > > >
> > > > +#if IS_ENABLED(CONFIG_CPU_THERMAL)
> > > > +     if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> > > > +             policy->cdev = of_cpufreq_cooling_register(policy);
> > > > +#endif
> > >
> > > I am not sure if Rafael wanted it this way but maybe something like this:
> > >
> > >         if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
> > >             cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV))
> > >                 policy->cdev = of_cpufreq_cooling_register(policy);
> > >
> > > We never wanted ifdef hackery to be in there :)
> >
> > OK, that makes more sense. Should I just send out a fixup patch or the
> > entire series?
>
> Just a fixup patch, please.

Please find attached a fixup patch suitable to add to the top of the
series and use git rebase --autosquash on.

The entire series with this patch squashed in and rebased on top of
today's linux-next is available for your convenience if needed[1]

Thanks,
Amit

[1] https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=up/cpufreq/auto-register-cooling-dev-v5

--000000000000871c4e05809e86f4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fixup-cpufreq-Auto-register-the-driver-as-a-thermal-.patch"
Content-Disposition: attachment; 
	filename="0001-fixup-cpufreq-Auto-register-the-driver-as-a-thermal-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jri73hss0>
X-Attachment-Id: f_jri73hss0

RnJvbSBjYjVhYTUwMDFlODZmNDYzNWIzOWZhMWUzOTU1YTUzMGY4YTBjZWQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8Y2I1YWE1MDAxZTg2ZjQ2MzViMzlmYTFlMzk1NWE1
MzBmOGEwY2VkOC4xNTQ4NzkyNDg1LmdpdC5hbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+CkZyb206
IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAbGluYXJvLm9yZz4KRGF0ZTogV2VkLCAzMCBK
YW4gMjAxOSAwMTozNzo0MCArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIGZpeHVwISBjcHVmcmVxOiBB
dXRvLXJlZ2lzdGVyIHRoZSBkcml2ZXIgYXMgYSB0aGVybWFsIGNvb2xpbmcKIGRldmljZSBpZiBh
c2tlZAoKLS0tCiBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jIHwgMTAgKysrKy0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYwpp
bmRleCAwZjliNTBkM2VlOTEuLmNkNTc0ZjAzMTMxOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jcHVm
cmVxL2NwdWZyZXEuYworKysgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jCkBAIC0xMzE5LDEw
ICsxMzE5LDkgQEAgc3RhdGljIGludCBjcHVmcmVxX29ubGluZSh1bnNpZ25lZCBpbnQgY3B1KQog
CWlmIChjcHVmcmVxX2RyaXZlci0+cmVhZHkpCiAJCWNwdWZyZXFfZHJpdmVyLT5yZWFkeShwb2xp
Y3kpOwogCi0jaWYgSVNfRU5BQkxFRChDT05GSUdfQ1BVX1RIRVJNQUwpCi0JaWYgKGNwdWZyZXFf
ZHJpdmVyLT5mbGFncyAmIENQVUZSRVFfSVNfQ09PTElOR19ERVYpCisJaWYgKElTX0VOQUJMRUQo
Q09ORklHX0NQVV9USEVSTUFMKSAmJgorCSAgICBjcHVmcmVxX2RyaXZlci0+ZmxhZ3MgJiBDUFVG
UkVRX0lTX0NPT0xJTkdfREVWKQogCQlwb2xpY3ktPmNkZXYgPSBvZl9jcHVmcmVxX2Nvb2xpbmdf
cmVnaXN0ZXIocG9saWN5KTsKLSNlbmRpZgogCiAJcHJfZGVidWcoImluaXRpYWxpemF0aW9uIGNv
bXBsZXRlXG4iKTsKIApAQCAtMTQxMSwxMiArMTQxMCwxMSBAQCBzdGF0aWMgaW50IGNwdWZyZXFf
b2ZmbGluZSh1bnNpZ25lZCBpbnQgY3B1KQogCQlnb3RvIHVubG9jazsKIAl9CiAKLSNpZiBJU19F
TkFCTEVEKENPTkZJR19DUFVfVEhFUk1BTCkKLQlpZiAoY3B1ZnJlcV9kcml2ZXItPmZsYWdzICYg
Q1BVRlJFUV9JU19DT09MSU5HX0RFVikgeworCWlmIChJU19FTkFCTEVEKENPTkZJR19DUFVfVEhF
Uk1BTCkgJiYKKwkgICAgY3B1ZnJlcV9kcml2ZXItPmZsYWdzICYgQ1BVRlJFUV9JU19DT09MSU5H
X0RFVikgewogCQljcHVmcmVxX2Nvb2xpbmdfdW5yZWdpc3Rlcihwb2xpY3ktPmNkZXYpOwogCQlw
b2xpY3ktPmNkZXYgPSBOVUxMOwogCX0KLSNlbmRpZgogCiAJaWYgKGNwdWZyZXFfZHJpdmVyLT5z
dG9wX2NwdSkKIAkJY3B1ZnJlcV9kcml2ZXItPnN0b3BfY3B1KHBvbGljeSk7Ci0tIAoyLjE3LjEK
Cg==
--000000000000871c4e05809e86f4--
