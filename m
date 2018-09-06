Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4FFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0081820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0081820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeIFKhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:37:12 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:7525 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeIFKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:37:11 -0400
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 33ADF1A3;
        Thu,  6 Sep 2018 06:03:23 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 3B14881;
        Thu,  6 Sep 2018 06:03:22 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.6])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id E9F8B3F;
        Thu,  6 Sep 2018 06:03:21 +0000 (UTC)
Date:   Thu, 6 Sep 2018 00:03:21 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] watchdog: hpwdt: Bug Fixes/Enhancement
Message-ID: <20180906060321.GA14264@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 01:13:22PM -0600, Jerry Hoemann wrote:
> Changes for v2
> 
> 1) Patch 0001: Simplify initialization of pretimeout removing #ifdef.
> 2) Patch 0002: Loosen check on mynmi to accommodate potential FW issue.
> 3) Patch 0003: Split dev_info into mulitple calls as output was getting long.
> 4) Patch 0004: New: Add alias to module parameter soft_margin.
> 

Wim,

I would like to get our Distro partners to back port these changes,
but they must first be upstream.  :)

Do you know when you will include these in a pull request so that I can
pass on to them when to schedule the work?

Thanks

The patch e-mails are at:
	https://lkml.org/lkml/2018/8/8/769

Jerry

> 
> -----------------------------
> 
> Two defect fixes and one enhancement.  
> 
> 0001: Initialize pretimeout from module parameter.
> 
> Bug Fix.
> 
> Pretimeout was getting programmed correctly in the hardware,
> but this issue caused it to not be displayed correctly
> in sysfs.
> 
> 
> 
> 0002: Claim NMI from iLO
> 
> Bug Fix.
> 
> Default configuration worked, but if user were to disable the
> pretimeout for the watchdog, then an explicit request to NMI
> the system from the iLO virutal button would fail.
> 
> 
> 0003: Display module parameters
> 
> Enhancement.
> 
> Display all the module parameters when loading the driver.
> Makes it easier to diagnose problems.
> 
> 
> Jerry
> 
> 
> Jerry Hoemann (5):
>   watchdog: hpwdt: Initialize pretimeout from module parameter.
>   watchdog: hpwdt: Claim NMI from iLO
>   watchdog: hpwdt: Display module parameters.
>   watchdog: hpwdt: Module paramerter alias.
>   watchdog: hpwdt: Update version number.
> 
>  drivers/watchdog/hpwdt.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> -- 
> 1.8.3.1

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
