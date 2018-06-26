Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3FFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B282492B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B282492B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeFZGt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:49:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:54710 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751181AbeFZGtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:49:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 23:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,273,1526367600"; 
   d="scan'208";a="67301400"
Received: from cblaim-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.34.55])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2018 23:49:22 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 9763E21E18; Tue, 26 Jun 2018 09:49:20 +0300 (EEST)
Date:   Tue, 26 Jun 2018 09:49:20 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     alanx.chiang@intel.com
Cc:     linux-i2c@vger.kernel.org, andy.yeh@intel.com,
        andriy.shevchenko@intel.com, rajmohan.mani@intel.com,
        andy.shevchenko@gmail.com, brgl@bgdev.pl, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: at24: Add address-width property
Message-ID: <20180626064920.65atfoengymu5yjg@kekkonen.localdomain>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
 <1529994128-26770-2-git-send-email-alanx.chiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529994128-26770-2-git-send-email-alanx.chiang@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, Jun 26, 2018 at 02:22:07PM +0800, alanx.chiang@intel.com wrote:
> From: "alanx.chiang" <alanx.chiang@intel.com>
> 
> The AT24 series chips use 8-bit address by default. If some
> chips would like to support more than 8 bits, should add the compatible
> field for specfic chips in the driver.
> 
> Provide a flexible way to determine the addressing bits through
> address-width in this patch.
> 
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> 
> ---
> since v1:
> -- Remove the address-width field in the example.
> 
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 61d833a..9467482 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -72,6 +72,8 @@ Optional properties:
>  
>    - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
>  
> +  - address-width : number of address bits (one of 8, 16).

Please remove the space before the colon; that way it looks the same as the
rest.

> +
>  Example:
>  
>  eeprom@52 {

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
