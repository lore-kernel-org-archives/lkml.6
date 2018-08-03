Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F04C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFD82173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYzzhvNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFD82173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbeHCNkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:40:09 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50597 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHCNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:40:06 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so6179413ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=byNl4k1fXCCyiuXFGYmnPHf0o5+0YMzTptwVVa/XV2M=;
        b=jYzzhvNYoqJwpAPS1knAXX8xC+DkR6kUl/Rmym1ob4aVcpjIB47hj+fucZcJgXaN1x
         lbm/EI/J8wuAGoPoplOFJOt9OUEfMX6xdDzIyudBRWcGXgCCUXMMTkIa/3A/YTfGb93I
         PpDSKeHc0eWUY60qi+uQvPZpRFvJykT8uKVFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=byNl4k1fXCCyiuXFGYmnPHf0o5+0YMzTptwVVa/XV2M=;
        b=Jb4Tnm3nC+kNbojXl6xsj/nrdk+QVgEtAKqUTiNX3dw7QbfL23OBNmgMhKCYhADH70
         nNPUBEXb6B3p+sC+EpwE2DZ8qUfSq1n6VhZ7Z/fnYnrQJG1KdU5ScXj9jlBVPEdhddRK
         5vneBSoOfGKSGYRO21xCZoTGYdI5W+zte9axt4M6Q8e9/sey8AFm8LI4SR7eKx3zxQHy
         6n7XqvFpWXYKIaCgMQorTMqKR325Vi182r7OQSnU5Eznq4y40DCBRW95VieFeyAlUC+d
         4TU9CyuC/tc7aU80Lci2tdyjoOzKK4ITlXFD9P4r0o1IpV7ZFlBEZJbABpOtn2DMx5id
         6Hgw==
X-Gm-Message-State: AOUpUlHIGGDnKJHy9pkXJ37mkm1dTbVAPzgJi/eRGpsQacHCnjw83Wuw
        R/Cm+OJjCLbqln8OODAnSoqwyKvz9nHLW70kuEJO/Q==
X-Google-Smtp-Source: AAOMgpe7fqnGxeG7EmKQ64CEs0Ui82EjsCSPu22CiM7IKi9ZKEwXfqH8m9ENf+Zl7C/yNmrM3jPiF75qa4WcqHB646M=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr3009930jad.107.1533296648958;
 Fri, 03 Aug 2018 04:44:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 04:44:08 -0700 (PDT)
In-Reply-To: <3889041.sTGkQNs1Ck@aspire.rjw.lan>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-6-ulf.hansson@linaro.org> <3889041.sTGkQNs1Ck@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Aug 2018 13:44:08 +0200
Message-ID: <CAPDyKFrteziAy==C+-mEiV-404--qwBu8JLoSAHYJjb8p1a+Ag@mail.gmail.com>
Subject: Re: [PATCH v8 05/26] PM / Domains: Add helper functions to
 attach/detach CPUs to/from genpd
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 July 2018 at 12:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 20, 2018 7:22:05 PM CEST Ulf Hansson wrote:
>> Introduce two new genpd helper functions, of_genpd_attach|detach_cpu(),
>> which takes the CPU-number as an in-parameter.
>>
>> To attach a CPU to a genpd, of_genpd_attach_cpu() starts by fetching the
>> struct device belonging to the CPU. Then it calls genpd_dev_pm_attach(),
>> which via DT tries to hook up the CPU device to its corresponding PM
>> domain. If it succeeds, of_genpd_attach_cpu() continues to prepare/enable
>> runtime PM of the device.
>>
>> To detach a CPU from its PM domain, of_genpd_attach_cpu() reverse the
>> operations made from of_genpd_attach_cpu(). However, first it checks that
>> the CPU device has a valid PM domain pointer assigned, as to make sure it
>> belongs to genpd.
>>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 69 +++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |  9 +++++
>>  2 files changed, 78 insertions(+)

[...]

> I'd combine this with patch [04/26].  The split here is somewhat artificial IMO.

I wanted to keep one change per patch, hence the split.

$subject patch introduces helpers to add CPU devices to genpd and
isn't really part of making genpd to cope with CPU devices. So
$subject patch is about avoiding open coding.

Are you still sure you want me to squash the changes?

Kind regards
Uffe
