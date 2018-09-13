Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9418C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B23920881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mk4VSGv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B23920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeIMM4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:56:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39374 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeIMM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:56:53 -0400
Received: by mail-it0-f68.google.com with SMTP id h1-v6so6558323itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 00:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VirJn8KVk0kYx/O9YrzA3qVGDRx5P3AsFNJ6bZ/ZfXA=;
        b=Mk4VSGv7NdGNVmHIqoD0DiAZC57qXEcOWvMbMTMxLgxhSGOOA9UIzS65oqCMUltptR
         la5npJuQOnhhKqKS5tdTckgwD1Mf/nlwxtnmq8V7Lq0VNJia/9LoNPfW264uRQtwMTvH
         AnjrLYpJuVcPKgPe+xuxI/90qYx1Mlu4x7/H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VirJn8KVk0kYx/O9YrzA3qVGDRx5P3AsFNJ6bZ/ZfXA=;
        b=ATCYfDn1j5BuOVwOGe4bg8edtYLFvK1nZJF34tqlqlrcBBw3i5f6alGzN97OOn+ue3
         xMRqYNA/+XhjzcvP+CRlMqdNRTRuwv+bZ5xYtKZQmizTbS0LCyFBg6v5P4SGzRuLNV7n
         pn+Tw7llGTlk2ppkGaFtKlGGskpEfwKbecNNnTvG4hz1Zfcag0mvlvArnKDny+RVsek+
         hCLZhclsRdFYh+5jywoQMLjca0+7n2NSzvow+VQQmF7RNoDH/V716rqwSdaGOljZ4fkK
         2bbKSJOE+hZjMZ7IBQ5NesgKjOu3JRVtur/lasPki7Vqm9YbmfqDLxEQlUVaputfJ9f9
         JwrA==
X-Gm-Message-State: APzg51AKiTZsZO5rhyKbQKxIkaj9vhXPlOXlO7MW7rD6cDdVbX4n7IS0
        8THwC9YFP5plFu1MU6SwXDeoeKw/zG/ko6pE8kZ55g==
X-Google-Smtp-Source: ANB0Vda6QA8a5jou/Dg1nrVdabo19x3y79nQzLT3gmFMRERuM39xPrvSAz8eLT705SHynqMBd0FgsXlyhrq6OP4/ou8=
X-Received: by 2002:a02:9b81:: with SMTP id p1-v6mr5510872jak.125.1536824915405;
 Thu, 13 Sep 2018 00:48:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:9823:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 00:48:34
 -0700 (PDT)
In-Reply-To: <20180912135537.GA9985@centauri.ideon.se>
References: <cover.1536736872.git.viresh.kumar@linaro.org> <20180912135537.GA9985@centauri.ideon.se>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 13 Sep 2018 13:18:34 +0530
Message-ID: <CAKohpomVR_U9cA2yFLWjQ0pLdjp_d8=s2C7cvbauacha0Uv8xw@mail.gmail.com>
Subject: Re: [PATCH 00/11] OPP: Don't create multiple OPP tables for devices
 sharing OPP table
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "4.18" <stable@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 September 2018 at 19:25, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> On Wed, Sep 12, 2018 at 01:58:39PM +0530, Viresh Kumar wrote:
>> Hello,
>>
>> Niklas Cassle recently reported some regressions with his Qcom cpufreq
>> driver where he was getting some errors while creating the OPPs tables.
>>
>> After looking into it I realized that the OPP core incorrectly creates
>> multiple OPP tables for the devices even if they are sharing the OPP
>> table in DT. This happens when the request comes using different CPU
>> devices. For example, dev_pm_opp_set_supported_hw() getting called using
>> CPU0 and dev_pm_opp_of_add_table() getting called using CPU1.
>>
>> This series redesigns the internals of the OPP core to fix that. The
>> redesign has simplified the core itself though.
>>
>> @Niklas: Can you please confirm that this series fixes the issues you
>> have reported ? I have already tested it on Hikey960.
>
> Hello Viresh,
>
> This fixes the OPP error messages that I previously reported.
>
> However, I also tested to add a duplicate OPP to the opp-table.
>
> Before this series, I got the first two error prints.
> After this series, I get the first two error prints + the use after free splat.

This looks to be an old bug. Can you please try this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/qcom-fix

?
