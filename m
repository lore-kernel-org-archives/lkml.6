Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9D0C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B1921A0F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B1921A0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeHFOT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:19:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:1716 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731081AbeHFOT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:19:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 05:11:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="78878633"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 06 Aug 2018 05:11:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 06 Aug 2018 15:11:03 +0300
Date:   Mon, 6 Aug 2018 15:11:03 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][usb-next] USB: typec: fsusb302: remove unused variables
 snk_pdo and toggling_mode_name
Message-ID: <20180806121103.GC1634@kuha.fi.intel.com>
References: <20180806111414.9436-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806111414.9436-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 12:14:14PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables snk_pdo and toggling_mode_name are defined but are not used and
> hence can be removed.
> 
> Cleans up clang warnings:
> warning: 'snk_pdo' defined but not used [-Wunused-const-variable=]
> warning: 'toggling_mode_name' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/fusb302/fusb302.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
> index 82bed9810be6..ad7cfed1cea7 100644
> --- a/drivers/usb/typec/fusb302/fusb302.c
> +++ b/drivers/usb/typec/fusb302/fusb302.c
> @@ -48,13 +48,6 @@ enum toggling_mode {
>  	TOGGLING_MODE_SRC,
>  };
>  
> -static const char * const toggling_mode_name[] = {
> -	[TOGGLINE_MODE_OFF]	= "toggling_OFF",
> -	[TOGGLING_MODE_DRP]	= "toggling_DRP",
> -	[TOGGLING_MODE_SNK]	= "toggling_SNK",
> -	[TOGGLING_MODE_SRC]	= "toggling_SRC",
> -};
> -
>  enum src_current_status {
>  	SRC_CURRENT_DEFAULT,
>  	SRC_CURRENT_MEDIUM,
> @@ -1178,10 +1171,6 @@ static const u32 src_pdo[] = {
>  	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
>  };
>  
> -static const u32 snk_pdo[] = {
> -	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
> -};
> -
>  static const struct tcpc_config fusb302_tcpc_config = {
>  	.src_pdo = src_pdo,
>  	.nr_src_pdo = ARRAY_SIZE(src_pdo),

Thanks,

-- 
heikki
