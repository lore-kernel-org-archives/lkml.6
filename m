Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C76EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EB7218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfAYOcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:32:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:6218 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfAYOcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:32:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 06:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="121286644"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2019 06:32:06 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gn2Wb-0002XH-Ds; Fri, 25 Jan 2019 16:32:05 +0200
Date:   Fri, 25 Jan 2019 16:32:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] device property: Fix the length used in
 PROPERTY_ENTRY_STRING
Message-ID: <20190125143205.GP9224@smile.fi.intel.com>
References: <20190123144416.51859-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123144416.51859-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:44:16PM +0300, Heikki Krogerus wrote:
> With string type property entries we need to use
> sizeof(const char *) instead of the number of characters as
> the length of the entry.
> 
> If the string was shorter then sizeof(const char *),
> attempts to read it would have failed with -EOVERFLOW. The
> problem has been hidden because all build-in string
> properties have had a string longer then 8 characters until
> now.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: a85f42047533 ("device property: helper macros for property entry creation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  include/linux/property.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 3789ec755fb6..65d3420dd5d1 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -258,7 +258,7 @@ struct property_entry {
>  #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
>  (struct property_entry) {				\
>  	.name = _name_,					\
> -	.length = sizeof(_val_),			\
> +	.length = sizeof(const char *),			\
>  	.type = DEV_PROP_STRING,			\
>  	{ .value = { .str = _val_ } },			\
>  }
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


