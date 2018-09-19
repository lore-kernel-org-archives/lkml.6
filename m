Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D889C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6F021521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6F021521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbeITE0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:26:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40529 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeITE0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:26:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id v10-v6so7469405otk.7;
        Wed, 19 Sep 2018 15:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qWAdNLM2KCvUag5SdpHGR3Ere2OADjaodWkxsdODSs=;
        b=ZxIYmKt32lWso2NUVfLTIRnw+5X/X50TCdWQGg/0bv4nIKyONkiakXUyBvbGm5N0Yy
         1w0jQn74WNSV6LMV2K3LdbGw3BJFU8Ssc6JqTiMIyKdB0k3HMkyvXa5+yZ8I2q9uxYn0
         17ePelKpKHhskoYg4mhgzebrPQ0Pt73WgyK4PAE9HkknWo/8Jkz7GI6pnyYbjejuBRHC
         ZwBQW0nxgriH1ssxwBqI+fJuw2NWbDHHqUetcuestpHonXsvrm/p2tVpMAI1sAZFpfYt
         jP/8FpQbhietw8qm6qa40Sa/OT+I5uin6QB4aUPPoqewiqXVu/a4vwotzu6X1plQrf93
         KxCw==
X-Gm-Message-State: APzg51DsZR0NjKX2bm4kjKkdy0HgspJp1AcYhdYRZq8vbK5JSsupKHIE
        xqlPvbbIkpUp4TTSsVk2b8mOP6a7y6VPJ9jh5no=
X-Google-Smtp-Source: ANB0VdaZ1okf6HoiFWnj3UnmsNdYsMOp/MqXN5G6Q4xN2zYfjKE9KdtJ8kMnsnFUoSn3C+PQW5No/lVBtTo4LrKqfqI=
X-Received: by 2002:a9d:19e8:: with SMTP id k95-v6mr21365347otk.248.1537397166773;
 Wed, 19 Sep 2018 15:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
 <20180919215039.mb7prmmfs5jek3aj@vireshk-mac-ubuntu> <20180919215418.y2jsrsj73vy3dudd@vireshk-mac-ubuntu>
In-Reply-To: <20180919215418.y2jsrsj73vy3dudd@vireshk-mac-ubuntu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Sep 2018 00:45:55 +0200
Message-ID: <CAJZ5v0ipkaudrv7W5VP1_e9LERF6DLZuw+HtTf2Si4p=pbv9bw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ndesaulniers@google.com, natechancellor@gmail.com,
        ilia.lin@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:54 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-09-18, 14:50, Viresh Kumar wrote:
> > On 19-09-18, 14:45, Nick Desaulniers wrote:
> > > On Wed, Sep 19, 2018 at 11:22 AM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> > > > the function qcom_cpufreq_kryo_probe() to the function
> > > > .init.text:qcom_cpufreq_kryo_get_msm_id()
> > > > The function qcom_cpufreq_kryo_probe() references
> > > > the function __init qcom_cpufreq_kryo_get_msm_id().
> > > > This is often because qcom_cpufreq_kryo_probe lacks a __init
> > > > annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> > > >
> > > > Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
> > > > no more mismatch warning.
> > >
> > > I wonder why this driver has an exit function marked __init rather
> > > than __exit?
> >
> > I think it was just a mistake.
> >
> > > Does that mean it gets cleaned up after kernel init, and
> > > so on unloading of the driver, the kernel jumps to unmapped memory?
> >
> > The __init/exit sections are only useful when the driver is builtin
> > and so there is no unloading. Yeah, if you would have tried to call
> > shutdown for the kernel, it may have crashed or something. I don't
> > know.
> >
> > > Does this patch now produce a warning for `qcom_cpufreq_kryo_driver`
> > > referencing `qcom_cpufreq_kryo_probe`?
> >
> > Why should it ? It doesn't though.
>
> I thought you replied to my commit where I marked the exit routine
> with __exit and realised just now that it wasn't the case. I haven't
> build-tested this thing, but the question still stands. Why should it
> ?

Because __init things go away at one point and calling them from the
other sections is a bad idea.  OTOH, __exit things are simply not
needed in built-in drivers and they are never there if the driver is
built-in, so calling them from the other sections is a bad idea too.

Can you guys, please, prepare *one* patch fixing all of the
__init/__exit annotations in this driver and post it?

Thanks,
Rafael
