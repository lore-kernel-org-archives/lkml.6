Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E6C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E951320866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E951320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeILTFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:05:45 -0400
Received: from muru.com ([72.249.23.125]:56268 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbeILTFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:05:44 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 788D5807E;
        Wed, 12 Sep 2018 14:05:12 +0000 (UTC)
Date:   Wed, 12 Sep 2018 07:01:02 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Keerthy <j-keerthy@ti.com>, mark.rutland@arm.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        t-kristo@ti.com
Subject: Re: [PATCH] dt-bindings: power: Introduce suspend states supported
 properties
Message-ID: <20180912140102.GJ5662@atomide.com>
References: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
 <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
 <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
 <2c08c85f-a3e0-c1ce-3f87-0866868bd7e4@arm.com>
 <20180912133228.GI5662@atomide.com>
 <19ae9d20-46aa-25d7-87aa-ea4270f0162b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ae9d20-46aa-25d7-87aa-ea4270f0162b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sudeep Holla <sudeep.holla@arm.com> [180912 13:47]:
> 
> 
> On 12/09/18 14:32, Tony Lindgren wrote:
> > * Sudeep Holla <sudeep.holla@arm.com> [180912 11:41]:
> >> On 12/09/18 12:19, Keerthy wrote:
> >>> suspend to mem and suspend to disk are pretty generic states and i agree
> >>> implementation is platform dependent so why not have properties that
> >>> convey if they are supported?
> >>>
> >>
> >> We already have power domains and idle states for that. If you need to
> >> restrict few states on some platform for whatever reasons, just disable
> >> those states. I don't see the need to add any more bindings for the same.
> > 
> > Oh do you mean the "domain-idle-states" property as mentioned in the
> > Documentation/devicetree/bindings/power/power_domain.txt?
> > 
> 
> Yes, exactly that.

OK

> > Yeah that should do and the DOMAIN_PWR_DN and DOMAIN_RET can be SoC
> > specific and then the board can select which ones to use depending on
> > how things are wired for GPIOs, memory, PMIC and so on.
> >
> 
> All the idle-states are platform specific. DOMAIN_RET and DOMAIN_PWR_DN
> are just examples used in the bindings.
> 
> > Hmm I don't see any users for this binding though?
> > 
> 
> It was added specifically to deal with such SoC idles states or
> hierarchical CPU power domains states, no users in upstream yet. But IMO
> it fits what $subject is trying to address.

OK great thanks for confirming that.

Regards,

Tony
