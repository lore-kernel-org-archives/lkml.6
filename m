Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC83C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDD120645
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMQYVCw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDD120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeJKWdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:33:23 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55608 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeJKWdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:33:23 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so13944522itd.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q5EYi3sEo+VMLfN3sb7sUtd8lA98dKNZ3KXGrSXNCd0=;
        b=EMQYVCw5h+veM9/Ddghv0ijNN9BOIElm/LXq0OJ13Kl2Ar7pfyee6unfaznBB4b+WV
         qFkKbzfSnoN+yhqrCSW1PiN0coxdSmTTGR+8Bb4g6gIh+OB01yPY7gbpsnvzLySGdDfH
         +SlMRaCLIqDEIn+OW6gVec9hKneeVt+2PRdZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q5EYi3sEo+VMLfN3sb7sUtd8lA98dKNZ3KXGrSXNCd0=;
        b=rWbfnjFBBtjXpILiVNSY01DdnvxNCPTe2uWeXNEyGJxCplhN1emqjgJBZVhV+R1WB0
         lJEJQXjvoMzwprDd+vEVLKrWFgp8HkJF1giVrSxIhw1ccGyet4ILE6BfuQyF+hcZB9sX
         1ITSLc/GMara49eskzvjx3EBudGlHBa8BS1KjGvalHbPvAVKpmpe17xJPQ2h/rJNcKX6
         17/QVlysrq7ZauhOFpbtIyfFeHFcU8ZTgrmCRTWGwu0JBQ4yTBgD6Hvvw2TD4B3lpuS8
         U6hXmodcTYFedCdYIt6D7ttQiiDfuuGWL9RL9wipaiHCtvTjoQdrJLtVlvyAvDdRNGRf
         bGFQ==
X-Gm-Message-State: ABuFfogRBSVb5C+p0rmb2bPJlPgdQOa2fsbPfKlVYybKFyISou6y2DdW
        yaMnkEa03Oti03xOp7o3ERS2X4HP6fKn3OdK2vLzsA==
X-Google-Smtp-Source: ACcGV62k75YASUf4d5LzfLSjXlUdEFbBif3OmzzXZ3uM1NbsIW7rBJaSpp0aL03nyiBjMoDZFWl/Ngaq588GT9SZlUo=
X-Received: by 2002:a02:c909:: with SMTP id t9-v6mr1607929jao.95.1539270348261;
 Thu, 11 Oct 2018 08:05:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 08:05:07
 -0700 (PDT)
In-Reply-To: <20181010150331.GB4844@e107155-lin>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-6-ulf.hansson@linaro.org> <20181010150331.GB4844@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Oct 2018 17:05:07 +0200
Message-ID: <CAPDyKFq7bNJM5Y4y78tnOEvg7ntmYFtJoDvFH8uR2yUUK9o4HA@mail.gmail.com>
Subject: Re: [PATCH v9 05/11] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 October 2018 at 17:03, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Wed, Oct 03, 2018 at 04:38:18PM +0200, Ulf Hansson wrote:
>> The CPU's idle state nodes are currently parsed at the common cpuidle DT
>> library, but also when initializing back-end data for the arch specific CPU
>> operations, as in the PSCI driver case.
>>
>> To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
>> the device node for the CPU and the index to the requested idle state node,
>> as in-parameters. In case a corresponding idle state node is found, it
>> returns the node with the refcount incremented for it, else it returns
>> NULL.
>>
>> Moreover, for ARM, there are two generic methods, to describe the CPU's
>> idle states, either via the flattened description through the
>> "cpu-idle-states" binding [1] or via the hierarchical layout, using the
>> "power-domains" and the "domain-idle-states" bindings [2]. Hence, let's
>> take both options into account.
>>
>> [1]
>> Documentation/devicetree/bindings/arm/idle-states.txt
>> [2]
>> Documentation/devicetree/bindings/arm/psci.txt
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
>>  include/linux/of.h |  8 ++++++++
>>  2 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 74eaedd5b860..bf1d5fa34899 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -424,6 +424,41 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
>>  }
>>  EXPORT_SYMBOL(of_cpu_node_to_id);
>>
>> +/**
>> + * of_get_cpu_state_node - Get CPU's idle state node at the given index
>> + *
>> + * @cpu_node: The device node for the CPU
>> + * @index: The index in the list of the idle states
>> + *
>> + * Two generic methods can be used to describe a CPU's idle states, either via
>> + * a flattened description through the "cpu-idle-states" binding or via the
>> + * hierarchical layout, using the "power-domains" and the "domain-idle-states"
>> + * bindings. This function check for both and returns the idle state node for
>> + * the requested index.
>> + *
>> + * In case and idle state node is found at index, the refcount incremented for
>> + * it, so call of_node_put() on it when done. Returns NULL if not found.
>> + */
>> +struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
>
> No strong opinion but I am wondering if it makes sense to get cpu
> logical index and fetch the cpu of_node here to contain the refcount on
> it within this function while we are trying to consolidate. I do see
> that may not be so useful in psci.c but keeping refcount for cpu of_node
> here keeps the user free from that.

I see your point.

However, I am hesitating doing that change, as it would be a waste for
the psci case, but I also think that it may becomes a bit less
straight forward to use this helper function.

Although, no strong opinions from my side either, but since Rob is
happy with this, there is no need to change it, I think.

>
> I am fine as it is if there are reasons not to do that.
>

Right.

Kind regards
Uffe
