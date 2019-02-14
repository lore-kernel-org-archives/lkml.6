Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DEFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E5A2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392989AbfBNK37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:29:59 -0500
Received: from foss.arm.com ([217.140.101.70]:40530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389571AbfBNK37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:29:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DE68EBD;
        Thu, 14 Feb 2019 02:29:58 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D95A3F575;
        Thu, 14 Feb 2019 02:29:56 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:29:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] drivers: base: add support to skip power management
 in device/driver model
Message-ID: <20190214102953.GB28361@e107155-lin>
References: <20190213120137.23354-1-sudeep.holla@arm.com>
 <20190213223849.GA26335@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213223849.GA26335@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:38:49PM +0100, Eugeniu Rosca wrote:
> Hello Sudeep,
>
> I appreciate your efforts. Currently, this patch generates below
> warnings during s2ram on R-Car H3-Salvator-X:
>
> [ 46.874214] PM: suspend entry (deep)
> [ 46.878211] PM: Syncing filesystems ... done.
> [ 46.989148] Freezing user space processes ... (elapsed 0.004 seconds) done.
> [ 47.000428] OOM killer disabled.
> [ 47.003895] Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
> [ 47.226363] PM: suspend devices took 0.210 seconds
> [ 47.280553] Disabling non-boot CPUs ...
> [ 47.289157] ------------[ cut here ]------------
> [ 47.294524] sysfs group 'power' not found for kobject 'index0'
> [ 47.300622] WARNING: CPU: 1 PID: 14 at fs/sysfs/group.c:256 sysfs_remove_group+0x78/0xc4
> ---snip---
> [ 47.550425] sysfs group 'power' not found for kobject 'index1'
> ---snip---
> [ 47.807005] sysfs group 'power' not found for kobject 'index2'
> ---snip---
> [ 48.063703] sysfs group 'power' not found for kobject 'cache'
> ---snip---
>

Thanks for the report, looks like I am not able to reproduce this, will
check if I am missing something while testing.

> Complete log and .config are shared in
> https://gist.github.com/erosca/da9ea551033a503121de61049d77b834
>

Thanks again, much appreciated for providing full log.

--
Regards,
Sudeep
