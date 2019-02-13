Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6DE2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbfBMWsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:48:12 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:44077 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfBMWsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:48:12 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 17:48:10 EST
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id BF4033C005D;
        Wed, 13 Feb 2019 23:39:00 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nwnB-wPvfI8U; Wed, 13 Feb 2019 23:38:53 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 8046D3C003A;
        Wed, 13 Feb 2019 23:38:53 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 13 Feb
 2019 23:38:52 +0100
Date:   Wed, 13 Feb 2019 23:38:49 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] drivers: base: add support to skip power management
 in device/driver model
Message-ID: <20190213223849.GA26335@vmlxhi-102.adit-jv.com>
References: <20190213120137.23354-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190213120137.23354-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudeep,

I appreciate your efforts. Currently, this patch generates below
warnings during s2ram on R-Car H3-Salvator-X:

[ 46.874214] PM: suspend entry (deep)
[ 46.878211] PM: Syncing filesystems ... done.
[ 46.989148] Freezing user space processes ... (elapsed 0.004 seconds) done.
[ 47.000428] OOM killer disabled.
[ 47.003895] Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
[ 47.226363] PM: suspend devices took 0.210 seconds
[ 47.280553] Disabling non-boot CPUs ...
[ 47.289157] ------------[ cut here ]------------
[ 47.294524] sysfs group 'power' not found for kobject 'index0'
[ 47.300622] WARNING: CPU: 1 PID: 14 at fs/sysfs/group.c:256 sysfs_remove_group+0x78/0xc4
---snip---
[ 47.550425] sysfs group 'power' not found for kobject 'index1'
---snip---
[ 47.807005] sysfs group 'power' not found for kobject 'index2'
---snip---
[ 48.063703] sysfs group 'power' not found for kobject 'cache'
---snip---

Complete log and .config are shared in
https://gist.github.com/erosca/da9ea551033a503121de61049d77b834

Thank you,
Eugeniu.
