Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23472213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoL3oMtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23472213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJDPvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:51:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47096 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeJDPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:51:50 -0400
Received: by mail-io1-f67.google.com with SMTP id t7-v6so7255101ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r4VNbATbQ5kZn2OxeCNaB7p0jOKYvrX1PmER4NvD2pQ=;
        b=hoL3oMtmt00fWNWthGEbW4rXHuj8yh8oX0b5ipvFLeg0gAwA7YzLCg0gz1/kVdYPZp
         hs2R3p/rJFqLjIhBCxjV6OWk9DHjVOid/H0G/fAveB2urXsVifLOyVSfyUJOGt6vhvmA
         MbpmitPqBJRJ7uoXDszp5w6rl+5svQXncYdlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r4VNbATbQ5kZn2OxeCNaB7p0jOKYvrX1PmER4NvD2pQ=;
        b=VOdEqFPRZR16KaVbFQQdJsE3o+DlyX03S9aT6J068Y9dJkHfB1ziji303+FycfcRjZ
         VkjxASamLETDqwmxyeaG83CWdqxABBj5hCEXG20f8MJdM5Xq0QlXhMS10sU7QxyLV7ls
         ZDbcI0O5JlRpbJejO5OUKKlOyNkHkPm7tbgiVvuk5JMkd7IyHTH3rGFBM7hGv7ERMjN8
         Fl8CAYn1efxY1ZV4KYJCm8J4aIt8ejUahgVEfqNLnkTvA9nB1xZGWslhX/b8k8e/BkPq
         By9ElxqXef/PKzk2Tcq6F69RKw0WX7oiTP8NGzeVz0TtmM0guu/V7ST5rVf7/z2lyUCp
         +3bQ==
X-Gm-Message-State: ABuFfoiuLOLUQ5yds495zYu/JHAHGRsq+2cB2UmlTMmzKn45mrfQHo9a
        DK7iQft5Rai0iQbyt8m+Sc+AatDNxxm42VC4Mmxweg==
X-Google-Smtp-Source: ACcGV62mfmF8iRWtBoMrGMu6CySjffU9GMc+gmPVrmDU9XvWAfqcYMWdUfcVKJi2Ss3kmPcu1thukgC2Osk6fCKV/Zw=
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr3648801ioc.131.1538643574106;
 Thu, 04 Oct 2018 01:59:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 01:58:53 -0700 (PDT)
In-Reply-To: <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org> <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 10:58:53 +0200
Message-ID: <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 October 2018 at 10:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Oct 3, 2018 at 4:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> I have digested the review comments so far, including a recent offlist chat
>> with with Lorenzo Pieralisi around the debatable PSCI changes. More or less I
>> have a plan for how to move forward.
>>
>> However, to avoid re-posting non-changed patches over and over again, I decided
>> to withhold the more debatable part from this v9, hence this is not the complete
>> series to make things play. In v9, I have just included the trivial changes,
>> which are either already acked/reviewed or hopefully can be rather soon/easily.
>>
>> My hope is to get this queued for v4.20, to move things forward. I know it's
>> late, but there are more or less nothing new here since v8.
>
> I have no problems with the first three patches in this series, so I
> can apply them right away.  Do you want me to do that?

Yes, please.

>
> As for the rest, the cpuidle driver patch looks OK to me, but the
> PSCI-related ones need ACKs.

For some yes, but I think you can go ahead with a few more.

Patch 4, 5 is already acked/reviewed.

Patch 6 should be fine (if you are okay with it else wait for an ack
from Daniel)

Patch 7 and 8 should be fine. They were suggested by Mark.

Patch 9 and 10 needs acks.

Patch 11 has been acked, but depends on the other PSCI changes.

Kind regards
Uffe
