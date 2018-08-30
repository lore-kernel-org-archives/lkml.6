Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D81C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A09420837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1thpxXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A09420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeHaB5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbeHaB5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:57:24 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B6120835;
        Thu, 30 Aug 2018 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535665989;
        bh=HD9Y+6tKegMkb6G6onWhZOdxT29qfHX6JotSd5Qk8e4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=S1thpxXJjSKxbbSFiQycOLzyqQMIE8N0wxHITWLXBohERq4DJaUTuAeCfqw+zEjV3
         3FQoUyRTAokqHou2N9emhe/C6zDRDXoqN4/7HV2wn/Ce83kM8ekDqJMCDaB/VQ9eFX
         gCw6aGajpOm+hstiMCqDxkmoFx75pHXALAxZwPAU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180828093332.20674-5-brgl@bgdev.pl>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
References: <20180828093332.20674-1-brgl@bgdev.pl> <20180828093332.20674-5-brgl@bgdev.pl>
Message-ID: <153566598892.129321.11102576282589539273@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 4/4] clk: pmc-atom: use devm_kstrdup_const()
Date:   Thu, 30 Aug 2018 14:53:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bartosz Golaszewski (2018-08-28 02:33:32)
> Use devm_kstrdup_const() in the pmc-atom driver. This mostly serves as
> an example of how to use this new routine to shrink driver code.
> =

> While we're at it: replace a call to kcalloc() with devm_kcalloc().
> =

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

If you want this example to be merged through the clk tree please resend
after the other patches merge.

