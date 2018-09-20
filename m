Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F193C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD113206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD113206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbeITLDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:03:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbeITLDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:03:42 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1C2FCA1;
        Thu, 20 Sep 2018 05:22:07 +0000 (UTC)
Date:   Thu, 20 Sep 2018 07:22:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH] firmware: Always initialize the fw_priv list object
Message-ID: <20180920052204.GA15695@kroah.com>
References: <20180920010938.10315-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920010938.10315-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 06:09:38PM -0700, Bjorn Andersson wrote:
> When freeing the fw_priv the item is taken off the list. This causes an
> oops in the FW_OPT_NOCACHE case as the list object is not initialized.
> 
> Make sure to initialize the list object regardless of this flag.
> 
> Fixes: 422b3db2a503 ("firmware: Fix security issue with request_firmware_into_buf()")
> Cc: stable@vger.kernel.org
> Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/base/firmware_loader/main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Is this being triggered by some hardware somewhere today?  Or is this
just a fix found by code inspection?

thanks,

greg k-h
