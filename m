Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20759C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60C7208D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60C7208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeHVRra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:47:30 -0400
Received: from muru.com ([72.249.23.125]:54458 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbeHVRr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:47:29 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 876D08047;
        Wed, 22 Aug 2018 14:26:09 +0000 (UTC)
Date:   Wed, 22 Aug 2018 07:22:20 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "J, KEERTHY" <j-keerthy@ti.com>
Cc:     Johan Hovold <johan@kernel.org>, d-gerlach@ti.com,
        linux-kernel@vger.kernel.org, t-kristo@ti.com, ssantosh@kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which
 it is functional
Message-ID: <20180822142220.GG7523@atomide.com>
References: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
 <20180822073409.GK14967@localhost>
 <20180822073719.GL14967@localhost>
 <ae71d45f-9260-3547-5ff2-355c084fcf8e@ti.com>
 <20180822084318.GN14967@localhost>
 <335b4efe-ab18-df83-35f2-ee232c09f2e3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335b4efe-ab18-df83-35f2-ee232c09f2e3@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* J, KEERTHY <j-keerthy@ti.com> [180822 11:11]:
> On 8/22/2018 2:13 PM, Johan Hovold wrote:
> > Yes, and a blacklist would make much more sense for something like this
> > if where talking about specific boards.
>
> Black list is easier here?

After thinking about this a bit more I think the boards supporting
deep sleep should add a PM related dts property to enable deep sleep.

The board maintainers need to test and verify deep sleep for each
board, it's not something that just works for the SoC in general.
Some boards may use different powering for things like DDR where
it's power might be controlled by a GPIO regulator. And in some
cases deeper idle states may depend also on the PMIC being used.

Maybe we already have some dts property we can use to describe
the idle states the board hardware supports?

Regards,

Tony

