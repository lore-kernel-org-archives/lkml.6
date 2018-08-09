Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31ECC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9EC217AC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9EC217AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeHILjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:39:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50774 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbeHILjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:39:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D19C218A;
        Thu,  9 Aug 2018 02:15:47 -0700 (PDT)
Received: from e107155-lin (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A66C3F5D4;
        Thu,  9 Aug 2018 02:15:46 -0700 (PDT)
Date:   Thu, 9 Aug 2018 10:15:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/2] firmware: coreboot: Let OF core populate platform
 device
Message-ID: <20180809091540.GA1324@e107155-lin>
References: <20180808172414.29983-1-swboyd@chromium.org>
 <20180808172414.29983-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808172414.29983-2-swboyd@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 10:24:13AM -0700, Stephen Boyd wrote:
> Now that the /firmware/coreboot node in DT is populated by the core DT
> platform code with commit 3aa0582fdb82 ("of: platform: populate
> /firmware/ node from of_platform_default_populate_init()") we should and
> can remove the platform device creation here. Otherwise, the
> of_platform_device_create() call will fail, the coreboot of driver won't
> be registered, and this driver will never bind. At the same time, we
> should move this driver to use MODULE_DEVICE_TABLE so that module
> auto-load works properly when the coreboot device is auto-populated and
> we should drop the of_node handling that was presumably placed here to
> hold a reference to the DT node created during module init that no
> longer happens.
>
> Cc: Wei-Ning Huang <wnhuang@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Sudeep Holla <Sudeep.Holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
