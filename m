Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8EC20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8EC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbeLJOce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:32:34 -0500
Received: from muru.com ([72.249.23.125]:57068 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJOcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:32:33 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8CF3980F0;
        Mon, 10 Dec 2018 14:32:35 +0000 (UTC)
Date:   Mon, 10 Dec 2018 06:32:29 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Illia Smyrnov <illia.smyrnov@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] Input: omap-keypad: Fix keyboard debounce
 configuration
Message-ID: <20181210143229.GY6707@atomide.com>
References: <20181203012933.6647-1-tony@atomide.com>
 <20181209115648.GA23309@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209115648.GA23309@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181209 11:56]:
> So, if I press key "." quickly on console in
> 4.18.0-rc4-88970-gf075a2c-dirty it starts repeating. I could reproduce
> it 3 times from tree tries. Then I decided to test your patch, and so
> I booted 4.20-rc5+ using kexec. Turns out, I can't reproduce that
> repeat there... I tried more than 10 times. But that's before your
> patch.
> 
> So -- bad news for you -- seems like someone -- maybe you -- already
> fixed this. (But that does not mean the patch is bad idea).

Hmm OK thanks for testing. For me it recently started happening before
this fix, often when logging in as root on the console using the keypad
where I'd start seeing roooooooot instead of root.

Regards,

Tony
