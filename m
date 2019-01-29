Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCBFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EA42083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfA2QsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:48:17 -0500
Received: from muru.com ([72.249.23.125]:36590 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfA2QsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:48:17 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id ECC05804F;
        Tue, 29 Jan 2019 16:48:24 +0000 (UTC)
Date:   Tue, 29 Jan 2019 08:48:13 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129164813.GA5720@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like commit 5451781dadf8 ("regulator: core: Only count load for
enabled consumers") started showing new warnings with v5.0-rc cycle:

regulator-dummy: Underflow of regulator enable count

I'm seeing this at least with my pwm-vibra test case:

# rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
input: pwm-vibrator as /devices/platform/vibrator/input/input4
regulator-dummy: Underflow of regulator enable count
Upload rumble effect... id=0
regulator-dummy: Underflow of regulator enable count

Are these bogus warnings for dummy regulator or do we have
real unpaired regulator calls or somewhere?

Regards,

Tony
