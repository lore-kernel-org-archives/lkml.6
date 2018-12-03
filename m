Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B5A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B5A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeLCQ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:29:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41394 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeLCQ3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:29:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9DB71682;
        Mon,  3 Dec 2018 08:29:00 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08F943F59C;
        Mon,  3 Dec 2018 08:28:58 -0800 (PST)
Date:   Mon, 3 Dec 2018 16:28:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] misc: vexpress: Off by one in vexpress_syscfg_exec()
Message-ID: <20181203162808.GA14028@e107155-lin>
References: <20181203145219.brmtuv26dj3vnc5y@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203145219.brmtuv26dj3vnc5y@kili.mountain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 05:52:19PM +0300, Dan Carpenter wrote:
> The > comparison should be >= to prevent reading beyond the end of the
> func->template[] array.
> 
> (The func->template array is allocated in vexpress_syscfg_regmap_init()
> and it has func->num_templates elements.)
> 
> Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch, thanks for identifying and fixing this.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

I assume Greg will pick this up, if not I will add this when I send
pull request next time(not sure when yet as I don't have anything for
v4.21)

--
Regards,
Sudeep
