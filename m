Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A43208DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A43208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeGOMh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:37:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbeGOMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:37:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22896BC6;
        Sun, 15 Jul 2018 12:15:09 +0000 (UTC)
Date:   Sun, 15 Jul 2018 14:15:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        mturquette@baylibre.com, khilman@baylibre.com,
        abailon@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org, mka@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 3/8] interconnect: Add debugfs support
Message-ID: <20180715121507.GA17794@kroah.com>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-4-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709155104.25528-4-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 06:50:59PM +0300, Georgi Djakov wrote:
> +static int __init icc_debugfs_init(void)
> +{
> +	struct dentry *file;
> +
> +	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
> +	if (!icc_debugfs_dir) {
> +		pr_err("interconnect: error creating debugfs directory\n");
> +		return -ENODEV;
> +	}

You should never care about the return value of a debugfs call.  Just
ignore it and move on.

> +	file = debugfs_create_file("interconnect_summary", 0444,
> +				   icc_debugfs_dir, NULL, &icc_summary_fops);
> +	if (!file)
> +		return -ENODEV;

Again, do not check this.

Where do you remove this directory and file from the system when the
code shuts down?

thanks,

greg k-h
