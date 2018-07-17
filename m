Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B211ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DCD20877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUaB+EB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DCD20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeGQQCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:02:32 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35987 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbeGQQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:02:32 -0400
Received: by mail-oi0-f41.google.com with SMTP id r16-v6so2802588oie.3;
        Tue, 17 Jul 2018 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6rj5FrBFGCJsvw7z2wi2yo8eEuPmSDqQIi3CBDf4+dk=;
        b=mUaB+EB2GKACKrhesUYiFNDxQoxD84Y1yfnxDPoBhpbijk1/SOxEwMUVOFHbeHyTgu
         2/QWSjLDP+sIX0F0yrOK9tD5OEKUOiNrwm5ZkNOIuMGiQGg6PtdazREser4C+hSU2941
         fSi+i68nZIdBV/24WBLxHxFM/+usMQI7TEyx8R8Z9nbKfTTB+6oycl2rBQFwafES+Fit
         4pX4BI+GJ5pFLmSVWLLCeGyHS/wYHMEmvAxXCoHXqjgpYuRcgKo+m+ab+jlWZ/dZWWVd
         asobvXS+uygP6ebMs58XQj6TA2oB+Zv+GfV6D4sl9hbNZ/FRKXrVXOylhyZLurDZFpV+
         nQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6rj5FrBFGCJsvw7z2wi2yo8eEuPmSDqQIi3CBDf4+dk=;
        b=P9MzPfffLMt1aVAt4ErXBm2F6idlv9qYCvfpW36xCmpDMcZQPU94qOEkYkm5to3m4y
         kODwIkmovN75vGJ6JVY+iZsv2fAC/6O9yQxN+PZQd4k3UBUldfCS+L18eGRN+E6o0JT5
         afbtxVJY1OOQjP+lJR5nLK88RelfMcGJOLNWRsofORL0wayc0D3kItppfywGvaj13+nk
         z9XZdyUTn6EfOuS+lCXCYRYNROlz0ixgbvCichMvALAwjUhSHool8Mol+rDWxoWVCjkC
         PQUPnL3lRkDgnEdNclU5/0YpsjvI6UHadgDTCtbqaHV6pf1eV9QPu+FEZ4/1vv7oEb4r
         Q50w==
X-Gm-Message-State: AOUpUlEd7WC7KVmwsMNwJ5NQ6SMDsUN5FB7k6Qe7I6py0F0ZrG3hWgM9
        Dc+ax9nXRNQjK7tFy2FICoT4q+/B8Cg5+JeXlK0=
X-Google-Smtp-Source: AAOMgpejvwK0bMnOf1Jqad26tlqbrFKOw34d/u1jsxu4LlAVzKvKIketQdK0apmZlZfHALFe7cuy1DFq+vXobCFQbHM=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr2319103oih.227.1531841361811;
 Tue, 17 Jul 2018 08:29:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 08:29:21
 -0700 (PDT)
In-Reply-To: <20180717140336.ayovaz4ksdlak6bb@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <20180717092721.onkaf3qsu7te6syi@suselix>
 <20180717093620.ym6phfmr3rfvsxyo@suselix> <3724084.DyflrVPzDS@aspire.rjw.lan>
 <20180717102136.snayvzmv2h3dcwiq@suselix> <20180717140336.ayovaz4ksdlak6bb@suselix>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 17:29:21 +0200
X-Google-Sender-Auth: MCVymb2HzTJ9oaIPvqbsZBosHi8
Message-ID: <CAJZ5v0ipaaCYwsxdi7Mw6nPzw_76cKQ50M=aM+kJrY+FhdV4pg@mail.gmail.com>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:03 PM, Andreas Herrmann <aherrmann@suse.com> wrote:
> On Tue, Jul 17, 2018 at 12:21:36PM +0200, Andreas Herrmann wrote:
>> On Tue, Jul 17, 2018 at 12:09:21PM +0200, Rafael J. Wysocki wrote:
>
>   ---8<---
>
>> > OK, the patch is below.
>> >
>> > First, I hope that if "Collaborative Power Control" is disabled, it will
>> > simply hide the PCCH object and so intel_pstate will still not load then.
>>
>> PCCH is hidden in that case.
>>
>> > The main question basically is what the OS is expected to do if
>> > "Dynamic Power Savings Mode" is set.  If we are *expected* to use
>> > the PCC interface then, intel_pstate may not work in that case, but
>> > I suspect that the PCC interface allows extra energy to be saved
>> > over what is possible without it.
>>
>> I'll test it and see what happens.
>
> I've tested it on top of v4.18-rc5-36-g30b06abfb92b. intel_pstate now
> loads instead of pcc-cpufreq and system looks stable.
>
> When disabling "Collaborative Power Control" no cpufreq driver is loaded
> (as expected).
>
> Performance (with kernbench) is as expected (always better than any
> brew of pcc-cpufreq + misc modifications to this driver + partial
> rollback of commit 554c8aa8ecad).
>
> If you like you can add either Tested-by or
> Reviewed-by: Andreas Herrmann <aherrmann@suse.com>
>
> I think this patch should be tagged for 4.17-stable.

OK, thank you for testing!
