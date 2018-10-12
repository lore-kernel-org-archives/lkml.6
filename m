Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAD3C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AB320868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UnrpZntS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LB7juICt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AB320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbeJLWxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:53:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeJLWxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:53:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 516BC6031A; Fri, 12 Oct 2018 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539357622;
        bh=58AkvfzkjzHqpHYyqte5HT+X6XxbqL2cnbSzSKbVZ5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UnrpZntSqtP21OjkbA4TLOHWcz8gL0CW07REqMDs7M6+yjFG9haRMDHyVt/tuEnhv
         dTZZcoeoSzra3kxURHEI7hTO/6TcKTHjCeN2irTJ5mCP/IWcXNlZaHCXQIPJjCLc4t
         DXA72u5w3PFZyiBr0F9rZykEoZVzZqkiEGwV9Z88=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AA156014B;
        Fri, 12 Oct 2018 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539357620;
        bh=58AkvfzkjzHqpHYyqte5HT+X6XxbqL2cnbSzSKbVZ5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LB7juICtnd84FnyiLvVzXOYVcet0m2ILMLMQegto2OuAGgFa8RauTC0cTLIqZ62bJ
         d+8t8NJ0MZ7sibrdGyl9eWlD2A0HAbQKDSIOkSIzEj86uTeXx/4kS6Y1q9O5bVsPV3
         bKe4u+Cj+5CjsOH563EUKUCWaaa1GYWuDmUkCUfk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AA156014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 12 Oct 2018 09:20:19 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, rplsssn@codeaurora.org,
        Andy Gross <andy.gross@linaro.org>, david.brown@linaro.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, evgreen@chromium.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH RFC v1 2/8] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
Message-ID: <20181012152019.GF2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
 <8161939.SRDo8Qx48D@aspire.rjw.lan>
 <20181011220842.GE2371@codeaurora.org>
 <CAJZ5v0hXM9krdacL09kJSn30AL_5kN+4U3d02rZX7-V2DWg_VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hXM9krdacL09kJSn30AL_5kN+4U3d02rZX7-V2DWg_VQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12 2018 at 01:43 -0600, Rafael J. Wysocki wrote:
>On Fri, Oct 12, 2018 at 12:08 AM Lina Iyer <ilina@codeaurora.org> wrote:
>> On Thu, Oct 11 2018 at 14:56 -0600, Rafael J. Wysocki wrote:
>> >On Wednesday, October 10, 2018 11:20:49 PM CEST Raju P.L.S.S.S.N wrote:
>> >> From: Ulf Hansson <ulf.hansson@linaro.org>

>> The cluster states should account for that additional latency.
>
>But even then, you need to be sure that the idle governor selected
>"cluster" states for all of the CPUs in the cluster.  It might select
>WFI for one of them for reasons unrelated to the distance to the next
>timer (so to speak), for example.
>
Well, if cpuidle chooses WFI, cpu_pm_enter() will not be called. So for
that case we are okay with this approach.

>> Just the CPU's power down states need not care about that.
>
>The meaning of this sentence isn't particularly clear to me. :-)
>
What I meant to say is that if cpuidle chooses a CPU only power down
state, then, atleast in ARM architecture, we would not choose to power
down the cluster in the firmware. To power down the cluster in the
firmware, all CPUs need to choose a cluster state, which would account
the additional latency of powering off and on the domain.

How I ever thought that I could convey this point in that line is beyond
me now. Sorry!

>> But, it would be nice if the PM domain governor could be cognizant of
>> the idle state chosen for each CPU, that way we dont configure the
>> domain to be powered off when the CPUs have just chosen to power down
>> (not chosen a cluster state). I think that is a whole different topic to
>> discuss.
>
>This needs to be sorted out before the approach becomes viable, though.
>
We embarked on that discussion a few years ago, but realized that there
is a lot more complexity involved in specifying that especially with DT.
I believe ACPI has a way to specify this. But DT and driver code
currently don't have a nice way to propagate this requirement to the
domain governor. So we shelved it for the future.

>Basically, the domain governor needs to track what the idle governor
>did for all of the CPUs in the domain and only let the domain go off
>if the latency matches all of the states selected by the idle
>governor.  Otherwise the idle governor's assumptions would be violated
>and it would become essentially useless overhead.
>
Well, we kinda do that in the CPU PM domain governor. By looking at the
next wakeup and the latency/QoS requirement of each CPU in the domain,
we determine if the domain can be powered off. But, if we were to do
this by correlating domain idle states to that of the required CPU idle
state, then a lot needs to plumbed in to the cpuidle and driver model.
The current approach is rather simple while meeting most of the
requirement.

Thanks,
Lina
