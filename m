Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D9EC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB882075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="THij8r3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB882075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeJLXQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:16:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39660 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeJLXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:16:19 -0400
Received: by mail-io1-f67.google.com with SMTP id z16-v6so9547425iol.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3d6PFUd/o4/ZHnNf/AOMsx/oqE420l4gczfX2C9zDQ4=;
        b=THij8r3hgrcTvOFxCRwqJKHOsJcPrUsFhW+TfDa6+xRPCeva/uVTbHx9C9DN6DHPDq
         IZ7XrIBi23bkFuM8i23lWGAs7vtATJIZbE3qtOWn9lxsH2GJ+3Q6g30OGhgghTmMpTGP
         CemaahrjGAtIfVztgbEtXA4BvjhDaGoKBZ/wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3d6PFUd/o4/ZHnNf/AOMsx/oqE420l4gczfX2C9zDQ4=;
        b=pa5JkHw2IlRGx5lucPFv06aVAzBLTHIsPuNyCTfZeb6bWd86/9bWr69qMtM4NtN/rV
         0kT8zbEWitpBCmzeOrMJ16tBk+nWnqV29lJy/q2mBfpvMEpMY3ZUSXSMOh/79IHghvBx
         rCjicpFc7E4B5j4hNQmFfCT3zWbCBkFTNC/C/ly98xkyHGX6RVNpvPMyf2Qw7pvanUpu
         vc0KVQKuwGhT79UvUGVhVfa5WvSn53pWCvvS8M7UtfQUui1D3c4LZYRqr3dRf7XK6oB5
         QNt8xGlviVXnOkHGsJgKMxVlcKgJkMIdlbq+fMVIBPdaQyjTMyVas2e4Zy3tqIHlwc74
         Akvg==
X-Gm-Message-State: ABuFfohsM01Z28khuf0z3DLVxGRNYt/bUkvDuhwvaQY6pGPVZyrnwFPi
        v+5M9Hn8Mbm7eyLvQF0TB2ebKJ3RAWHC6m1SovjMHA==
X-Google-Smtp-Source: ACcGV63JFvcn7PK7RacJw0xhtvUrYjyjVNhe3rSoadPEzWro2hnFhSS3WMcDtvn2ncidZN1lSyQ3lkXphwoa3Doaaw4=
X-Received: by 2002:a6b:c586:: with SMTP id v128-v6mr4477027iof.7.1539358995726;
 Fri, 12 Oct 2018 08:43:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5f97:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 08:43:15
 -0700 (PDT)
In-Reply-To: <CAPDyKFojOdmGbAzDMrO8EVJYrEYwYi6PT8YG55J9svGT61a1Cg@mail.gmail.com>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <110c9e13d8d44dfb59577256b1309dddf2ceda12.1539341929.git.viresh.kumar@linaro.org>
 <CAPDyKFojOdmGbAzDMrO8EVJYrEYwYi6PT8YG55J9svGT61a1Cg@mail.gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri, 12 Oct 2018 21:13:15 +0530
Message-ID: <CAKohpont9Jn0QiZ3yG++xR87ttUAbAL4CAwAmvVL+jMOqVRGdg@mail.gmail.com>
Subject: Re: [PATCH V2 6/9] OPP: Add dev_pm_opp_{set|put}_genpd_device() helper
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 20:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Multiple generic power domains for a consumer device are supported with
>> the help of virtual devices, which are created for each consumer device
>> - genpd pair. These are the device structures which are attached to the
>> power domain and are required by the OPP core to set the performance
>> state of the genpd.
>>
>> The helpers added by this commit are required to be called once for each
>> of these virtual devices. These are required only if multiple domains
>> are available for a device, otherwise the actual device structure will
>> be used instead by the OPP core.
>>
>> The new helpers also support the complex cases where the consumer device
>> wouldn't always require all the domains. For example, a camera may
>> require only one power domain during normal operations but two during
>> high resolution operations. The consumer driver can call
>> dev_pm_opp_put_genpd_device(high_resolution_genpd_dev) if it is
>> currently operating in the normal mode and doesn't have any performance
>> requirements from the genpd which manages high resolution power
>> requirements. The consumer driver can later call
>> dev_pm_opp_set_genpd_device(high_resolution_genpd_dev) once it switches
>> back to the high resolution mode.
>>
>> The new helpers differ from other OPP set/put helpers as the new ones
>> can be called with OPPs initialized for the table as we may need to call
>> them on the fly because of the complex case explained above. For this
>> reason it is possible that the genpd_device structure may be used in
>
> This is a bit unclear. What is really the genpd_device structure?
> Could you please clarify that here?

It is the virtual device structures created by genpd.

>> parallel while the new helpers are running and a new mutex is added to
>> protect against that. We didn't use the existing opp_table->lock mutex
>> as that is widely used in the OPP core and we will need a lock in the
>> hotpath now, i.e.  while changing OPP and we need to make sure there is
>> not much contention while doing that.
>
> I not sure this needs to be considered as hotpath. I would be
> surprised if changing genpd virtual devices for OPP, is something that
> is going to be done frequently. Rather, this is more depending on the
> use case, like the camera case you describe above.
>
> In other words, do you really need a new lock?

My bad. I didn't explain it well. If you see a later patch where we started
configuring the required OPPs, we use genpd_dev or virt-dev within
opp_set_rate() which also needs this lock. And that is the hot path.

--
viresh
