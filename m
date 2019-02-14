Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6D5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C01218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437355AbfBNUJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:09:52 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:51949 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390902AbfBNUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:09:52 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id BDA8C3C00B7;
        Thu, 14 Feb 2019 21:09:49 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rl9DF3eYkIYq; Thu, 14 Feb 2019 21:09:43 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 095293C00B6;
        Thu, 14 Feb 2019 21:09:43 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Thu, 14 Feb
 2019 21:09:42 +0100
Date:   Thu, 14 Feb 2019 21:09:37 +0100
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
Subject: Re: [PATCH v3] drivers: base: add support to skip power management
 in device/driver model
Message-ID: <20190214200937.GA21536@vmlxhi-102.adit-jv.com>
Illegal-Object: Syntax error in Reply-To: address found on vger.kernel.org:
        Reply-To:       =?ISO-8859-1?Q?=20=22=1B=1B=1B=22@smtp1.de.a?==?ISO-8859-1?Q?dit-jv.com?=
                                                                      ^-missing end of address
References: <20190214182910.20600-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190214182910.20600-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudeep,

On Thu, Feb 14, 2019 at 06:29:10PM +0000, Sudeep Holla wrote:
[..]
> 
> Lets add no_pm_required flags to indicate that the device doesn't

s/no_pm_required/no_pm/ ?

> require any sort of pm activities and all of them can be completely
> skipped. We can use the same flag to also avoid adding not used *power*
> sysfs entries for these devices. For now, lets use this for cpu cache
> devices.
[..]

Running suspend/resume ~500 times on H3-Salvator-X with this patch
didn't reveal any regressions. The annoying warnings are gone.
Console log and .config are available at:
https://gist.github.com/erosca/1af11aa62e16903e1b6964be6a9eea77

Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Thanks!
Eugeniu.
