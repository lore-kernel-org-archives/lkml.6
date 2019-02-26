Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F9DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B142173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfBZPkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:40:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:5594 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfBZPkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:40:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 07:40:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,416,1544515200"; 
   d="scan'208";a="125357559"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.135.8]) ([10.249.135.8])
  by fmsmga007.fm.intel.com with ESMTP; 26 Feb 2019 07:40:41 -0800
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <e8bee9db-bd73-6352-9e0f-f3471b9584ae@intel.com>
Date:   Tue, 26 Feb 2019 16:40:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190226144108.25891-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/2019 3:41 PM, Greg Kroah-Hartman wrote:
> The dev_links_info structure has 4 bytes of padding at the end of it
> when embedded in struct device (which is the only place it lives).  To
> help reduce the size of struct device pack this structure so we can take
> advantage of the hole with later structure reorganizations.
>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>   include/linux/device.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6cb4640b6160..b63165276a09 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -884,7 +884,7 @@ struct dev_links_info {
>   	struct list_head suppliers;
>   	struct list_head consumers;
>   	enum dl_dev_state status;
> -};
> +} __packed;
>   
>   /**
>    * struct device - The basic device structure


