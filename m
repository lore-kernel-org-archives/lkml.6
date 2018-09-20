Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3138AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BA521529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BA521529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbeITSna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:43:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbeITSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:43:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 831D4EC6;
        Thu, 20 Sep 2018 13:00:05 +0000 (UTC)
Date:   Thu, 20 Sep 2018 15:00:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [QUEUED v20180920 15/16] lib: Add memcat_p(): paste 2 pointer
 arrays together
Message-ID: <20180920130000.GB17692@kroah.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
 <20180920124553.56978-16-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920124553.56978-16-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 03:45:52PM +0300, Alexander Shishkin wrote:
> This adds a helper to paste 2 pointer arrays together, useful for merging
> various types of attribute arrays. There are a few places in the kernel
> tree where this is open coded, and I just added one more in the STM class.
> 
> The naming is inspired by memset_p() and memcat(), and partial credit for
> it goes to Andy Shevchenko.
> 
> This patch adds the function wrapped in a type-enforcing macro and a test
> module.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It would be good to get someone else to review/ack a core function like
this, to verify nothing is incorrect.  Especially given the fun of
off-by-one issues in C we have had over the years...

thanks,

greg k-h
