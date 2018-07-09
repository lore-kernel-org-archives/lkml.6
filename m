Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D64AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F7B20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ib398XKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F7B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754459AbeGILmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:42:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38085 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754433AbeGILmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:42:02 -0400
Received: by mail-it0-f66.google.com with SMTP id v71-v6so15402184itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wI6mVWj2mrQ/dk/3FtvKjStv1U7rv/wnr8OIRsJrntI=;
        b=ib398XKRx1DHzcwe8tDUPRYO4+ECwvJYP4gDUSBMEhT5CbP99NJv4QOa84J9ooJmgl
         hmYWt2dxMoAUS1kv/m4z4AB4UVj8/j9fwLQa0qnIZRykmTAUgQ7vVTesT0NGKolq3d8y
         txE9K2W5Wy17bHGPS30kUBAQh+nMiior5UJRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wI6mVWj2mrQ/dk/3FtvKjStv1U7rv/wnr8OIRsJrntI=;
        b=eUtz3EQXgw7mx02r40won59GrxeTxhhfVOUWPDZrWJJLtq/jN5TgDtR3oNy/zUB1pi
         rkCijMc1bH4PqgZMTg5bsc4QV6mtrM3EOE+N9fhu4DkZm7f39G1qm7jGbH0J2y92nZSc
         fWrT0wyjdrflik5ELAVVlzPX8qmUv0diLe8drNGb0jx0j9dw+ujuvVTo1XW7/cvph5y4
         1nx/YID7Bl4i2eBIZ/qBXdz2+m/JgXQJ2mr11Vp32wvR3alBQYn4Wl9VTSbmMkgVf2PW
         fuB0cWOp6p6S+TC5bV/qQZLbkhQ35kYnHHL7ml39o/z1vDeYK3OdRRXxodUWVmwnTHXQ
         HDdw==
X-Gm-Message-State: APt69E3mdQhHzujRqV/2NqTOfhNTWX+hZubVXhvcqtOqdtt5yMRY/Kds
        so/WySca4bnSeG7Hs4ggXOtUJ1Q6bcGFKZTb1gaUcA==
X-Google-Smtp-Source: AAOMgpc4APKaQQeT78sn0v4vEN2YLXezgfdExKMn009m5kvS3PuBV0IucOVwUp/YxzBumebp+3JnTSC7eQf4NlgOV8o=
X-Received: by 2002:a24:1c09:: with SMTP id c9-v6mr16304881itc.38.1531136521970;
 Mon, 09 Jul 2018 04:42:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 04:42:01 -0700 (PDT)
In-Reply-To: <CAJZ5v0hcBiYPMh8V50yq0jQud32Ey8V-ukiavJkP4PU4zAiFyg@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <CAPDyKFpy8rpjRTBsHUFa_L0M_C=vH+6qjq=Kxdn+0j+T5NNSMQ@mail.gmail.com> <CAJZ5v0hcBiYPMh8V50yq0jQud32Ey8V-ukiavJkP4PU4zAiFyg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Jul 2018 13:42:01 +0200
Message-ID: <CAPDyKFr2EbW=Gb5fgew81JQ4gpp8S-jcEH6eRJ+uaX=4hN27cQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/26] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On 3 July 2018 at 09:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jul 3, 2018 at 7:44 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Rafael,
>>
>> On 20 June 2018 at 19:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Changes in v8:
>>>  - Added some tags for reviews and acks.
>>>  - Cleanup timer patch (patch6) according to comments from Rafael.
>>>  - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
>>>  - While adopting patch 5 to new genpd changes, I took the opportunity to
>>>    improve the new function description a bit.
>>>  - Corrected malformed SPDX-License-Identifier in patch20.
>>
>> There have only been a minor comment from you at patch3 (about
>> squashing it with patch21), with that fixed and assuming there are no
>> further comments - would you like me to collect the changes and send
>> it to you as a pull request?
>
> I have not looked at them in detail yet, sorry.
>
> I any case, I'll apply the patches by hand.

Okay. If there is anything I can help to make the review easier, please tell!

Kind regards
Uffe
