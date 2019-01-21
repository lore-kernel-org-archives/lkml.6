Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E121C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CA420861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfAUIkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:40:11 -0500
Received: from verein.lst.de ([213.95.11.211]:56974 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728751AbfAUIkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:40:10 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0807B6FA7F; Mon, 21 Jan 2019 09:40:09 +0100 (CET)
Date:   Mon, 21 Jan 2019 09:40:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, Even Xu <even.xu@intel.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] HID: intel-ish-hid: Switch to use new generic UUID
 API
Message-ID: <20190121084008.GA18680@lst.de>
References: <20190110154804.89298-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110154804.89298-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:48:04PM +0200, Andy Shevchenko wrote:
> There are new types and helpers that are supposed to be used in new code.
> 
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c |  3 +--
>  drivers/hid/intel-ish-hid/ishtp-hid.h        |  6 +++---
>  drivers/hid/intel-ish-hid/ishtp/bus.c        | 19 ++++++++-----------
>  drivers/hid/intel-ish-hid/ishtp/bus.h        |  4 ++--
>  drivers/hid/intel-ish-hid/ishtp/client.h     |  2 +-
>  drivers/hid/intel-ish-hid/ishtp/hbm.h        |  2 +-
>  6 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index e64243bc9c96..2246697ada1d 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -788,8 +788,7 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
>  	if (!cl_device)
>  		return	-ENODEV;
>  
> -	if (uuid_le_cmp(hid_ishtp_guid,
> -			cl_device->fw_client->props.protocol_name) != 0)
> +	if (!guid_equal(&hid_ishtp_guid, &cl_device->fw_client->props.protocol_name))

This adds an overly long line.

With that fixed:

Reviewed-by: Christoph Hellwig <hch@lst.de>
