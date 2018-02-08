Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBHGrh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbeBHGrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:47:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B44220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 8 Feb 2018 14:47:10 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] soc: imx: gpcv2: Do not pass static memory as
 platform data
Message-ID: <20180208064709.GB31910@dragon>
References: <20180122150748.1742-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122150748.1742-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2018 at 07:07:47AM -0800, Andrey Smirnov wrote:
> Platform device core assumes the ownership of dev.platform_data as
> well as that it is dynamically allocated and it will try to kfree it
> as a part of platform_device_release(). Change the code to pass
> kzalloc'ed chunk of memory instead of a pointer to a static memory to
> avoid causing a BUG() when calling platform_device_put().
> 
> The problem can be reproduced by artificially enabling the error path
> of platform_device_add() call (around line 357).
> 
> Note that this change also allows us to constify imx7_pgc_domains,
> since we no longer need to be able to modify it.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied both, thanks.
