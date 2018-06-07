Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zGsqFb2qGVs9KgAAmS7hNA
	; Thu, 07 Jun 2018 22:00:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BDE1F6074D; Thu,  7 Jun 2018 22:00:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRG1H2W5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1DB31605A2;
	Thu,  7 Jun 2018 22:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DB31605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeFGV76 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:59:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35560 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeFGV74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:59:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so22190064wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WWY8aKhutNswxelsBbeNWOwg1CwPIYATsE2fDCPNTC0=;
        b=QRG1H2W5iQg8R6ZMrY4y/uAy6T56r7fO/OToJIawbjxrKcru1eh/jalQ3C9Fuyh3jY
         gvtZtXv1orEQifq/ad9Q8qBUu1+x5b8ocvCEtjmC7k15gEGsU4Wui3LjWuUZrFKbaq6E
         sRoOnJVC7P+Zt1+fO/65J5V+jwvKznlAGRnQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WWY8aKhutNswxelsBbeNWOwg1CwPIYATsE2fDCPNTC0=;
        b=lTcLNFOyDl/+u/+Aw+gffBdGRgeAipTviqZDc/VovXoHpYK1RxVdJu4PfK8FL+bri8
         xvt+0hZeDfx19b72dBIrmYBIf3874g76NWxlZsjhhn+Krtmqa35zMGw53oWdBHx8hMdf
         r0t3VIjj6MMrtaOXUPaiSANvdKlaMMj+7v/B8jsjGqUIYFxH7wUO9inEnhG7YBzDvHdl
         q7Af0edfEdxPS1NRcD41liY0iZ7rfMfI9pptOUlwXcc89FXNaxx0tCKHFlu+HqsmqxGg
         jOrbfUZs8Ck8lEl4YCx/5NT19/3cepqbfcS09MZaXUfiM218pLFF73tLegKbxVx6IKEJ
         5B5g==
X-Gm-Message-State: APt69E0Nf36Y5h1nYrS71VbqWG6rL6nU+ly6Cx40uRiIST0x3E9OHAJr
        y7lITKaamqRgkA2NPmYMpobIC7Rc6QXIyoUFZ2JQ4g==
X-Google-Smtp-Source: ADUXVKKR1njubbVEZX/dyAsb4ok3wr6qx8KMLJXtoPVBLMHH+5fkOfLEedYmJJcQk21E1t+D827Lj/sgTB8aD2dOXxU=
X-Received: by 2002:a50:b52a:: with SMTP id y39-v6mr4239624edd.195.1528408795303;
 Thu, 07 Jun 2018 14:59:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a48a:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 14:59:54 -0700 (PDT)
In-Reply-To: <20180607164747.7e4bb30f69a1fb4c160b6ef1@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com> <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com> <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com> <20180607083401.GE16651@kroah.com>
 <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com> <20180607091353.GA20438@kroah.com>
 <2f8d233e-8847-ce3d-3a5b-06b175e3944b@arm.com> <20180607095322.GA26174@kroah.com>
 <adbabdb0-df2c-be74-3cde-cda4f6bce579@arm.com> <20180607121304.017d1d6804466050dd5c0af2@arm.com>
 <39d1089f-585d-bc19-2ecd-c9c9c812f85f@arm.com> <20180607164747.7e4bb30f69a1fb4c160b6ef1@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 7 Jun 2018 15:59:54 -0600
Message-ID: <CANLsYkyk=RoZge3d2iEnKwQ7vQ_tsJMwVD_eJVQHJJ1iQji+XQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] coresight: get/put module in coresight_build/release_path
To: Kim Phillips <kim.phillips@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 June 2018 at 15:47, Kim Phillips <kim.phillips@arm.com> wrote:
> On Thu, 7 Jun 2018 22:10:07 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>> On 06/07/2018 06:13 PM, Kim Phillips wrote:
>> > I'm going to assume the series is still valid after this discussion,
>> > since technically just this patch can get dropped, and the user is able
>> > to shoot themselves in the foot.
>>
>> That doesn't mean the kernel can panic() if the user decided to unload
>> the module while the trace session is in progress. It only means that
>> the trace session could be stopped in between in the worst case. But
>> nothing more harmful to the system.
>
> FWIW, I didn't see the kernel panic in my basic tests; just some bad
> accesses: the new remove functions take care of cleaning up most items,
> and most drivers still depend on the links and sinks (funnel,
> replicator) drivers, so they can't be upset too bad.
>
>> >  This series is for development  purposes, after all.
>>
>> Do you mean that this series is for internal development purposes and
>> not upstream ? Making the drivers modular are always helpful, especially
>
> no, I'm posting them for upstream review because I'd like them upstream.
>
>> for something related to tracing, that allows the module to be unloaded
>> after use. So, it would be good to have this series in, but in a manner
>> which is usable and doesn't cause harm to the overall system usage.
>>
>> I think the summary of the discussion is that we need more robust code
>> to handle the situation, which also allows unloading the modules without
>> any trouble.
>
> Trouble's relative.  My point was since the series is going to be used
> mainly by developers testing their code, they already prepare for, and
> expect badness to occur anyway.  Greg's point isn't lost here, and in
> my interpretation, his review of this patch was that it was in the
> wrong direction of safety: it made things unnecessarily too safe, up
> front, and that items relative to the perf core should strive to adhere
> to the higher standards set in place by the networking subsystem.  So,
> this patch doesn't get his ack.

Greg's point was that it's OK to let users harm themselves (which I
totally support), but if you're going to prevent it, make sure to do
it right.

>
> I compiled a new v5 series that omits this patch, and overwrote the v4
> series here:
>
> git://linux-arm.org/linux-kp.git, coresight-modules branch
>
> but I'll hold of submitting a v5 for now.
>
> I don't know how the perf core handles AUXTRACE drivers hanging up on
> it.  I see intel-pt record support can't be built as a module.  I'm
> guessing more testing for actual panics when using perf or sysfs is
> what's being sought here?

There are two ways to approach the problem:

1) Kill active trace sessions (either sysFS or perf) if a driver that
is being used is removed.
2) Deal with the removal in the coresight core, making sure we don't
access operations provided by removed drivers.

The end result in both cases will be the same: failure to properly
terminate the trace session because of user action.

I'm personally in favour of the second option, simply because it keeps
problems resolution with the CS subsystem.

>
> Kim
