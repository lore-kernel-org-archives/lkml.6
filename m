Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3C3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E218020831
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E218020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeKUWSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:18:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45258 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKUWSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:18:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so5323961wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 03:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=In3+Un/UnGOxZik1Xw6eX4R2q+wEwqkSI6o/dhQxc9U=;
        b=XJnWeg+G0lTHc8wEnR9HCDEn+L+QGSa804BROIaQe4PK8GeO98EMQR9cSqTV/f/Im+
         Jqdu+LSCxaDwwzO8AwxH3cerFDXc+g0PzJvWIyDmvOUqYJmjVnyq7augQi0UTclmLDJA
         7Dujl+JpC6uqHGjD3N1cqOLC2qzR5AOmF1qeVENCNVOXt5HrVgfGhGlgvZUHf5yxqNGh
         +9hQ8FAiXc++ScZd2yTp19PP8/hyIy6Mj4AxDnA0sVBZB7EvSp/p6oSCCctNwMZFeZb9
         fG9gKQ31rWHMQhcdJ9pvJEim0n/YYwd7jCdcEWb/XNn7PXePXWgr6A+Z/YuQ7JO6aEGg
         zjTQ==
X-Gm-Message-State: AA+aEWbT0tvWAmhH7dpCrKKieqHjXw8f3Jrlw18gjvS8NJGF5ZmJNpll
        nRwvpUfz4wFxOCTMAwvQaQlDVU5Wvr0=
X-Google-Smtp-Source: AFSGD/UpmcMTgE5OQhcWUanBNv5RKJKMMaMoQhAKQ+hsvpEqxVVNC6zXlR5M7zzBBzfDCt0pJP2IDA==
X-Received: by 2002:adf:b190:: with SMTP id q16mr5468336wra.95.1542800668881;
        Wed, 21 Nov 2018 03:44:28 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a1sm24835768wrw.76.2018.11.21.03.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:44:28 -0800 (PST)
Subject: Re: [PATCH v1 06/15] i2c: acpi: Assign fwnode for devices created via
 i2c_acpi_new_device()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-7-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c2ad13ad-cf27-2700-a051-4dda56755ebd@redhat.com>
Date:   Wed, 21 Nov 2018 12:44:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120155924.10773-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-11-18 16:59, Andy Shevchenko wrote:
> i2c_acpi_new_device() doesn't assign fwnode like it's done, for example,
> in i2c_acpi_register_devices() path.
> 
> Assign fwnode in i2c_acpi_new_device() as it's done elsewhere.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As already mentioned in my reply to the cover letter, a NACK from me for
this one.

The problem is that this causes the fwnode to be shared by all the
"struct device"-s (embedded in the i2c-clients created).

This in itself is not necessarily a problem, but it does become a
problem when combined with using device_add_properties as
intel_cht_int33fe.c does.

Since the info in the ACPI tables for devices which use this
driver is pretty terrible, we add a bunch of properties to notify
the drivers about how the different parts which make up the Type-C
functionality are tied together.

device_add_properties creates a new fwnode and then calls
set_secondary_fwnode. For devices which already have a fwnode
assigned (which the i2c-clients will have after this patch)
set_secondary_fwnode sets dev->fwnode->secondary to the fwnode
which has been newly created to hold the added properties.

Since all i2c-clients instantiated now share dev->fwnode,
the result of this is that all i2c-clients created now will
have the properties of the last i2c-client instantiated for
an acpi-node which describes multiple clients in a single
node.

Also the fwnodes created  for the properties of earlier
instantiated i2c-clients will be leaked.

I see 2 possible solutions here:

1) Changing this patch so that i2c_acpi_new_device() does:

         /*
          * The fwnode can not be shared between instantiated clients when
          * adding device-properties to the instantiated client.
          */
	if (!info->properties)
		info->fwnode = acpi_fwnode_handle(adev);

2) Leave whether info->fwnode should be set or not up to the
caller of i2c_acpi_new_device() (info is already passed in as
a param). E.g. i2c-multi-instantiate.c could do this (for now,
maybe in the future we will also want to add properties for
some HIDs).

I think that 1. is the best solution and this is all kernel internal,
so we can always revisit this if necessary.

Regards,

Hans



> ---
>   drivers/i2c/i2c-core-acpi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index af4b5bd5d973..478862abb82a 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -420,6 +420,7 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
>   	if (!adapter)
>   		return NULL;
>   
> +	info->fwnode = acpi_fwnode_handle(adev);
>   	return i2c_new_device(adapter, info);
>   }
>   EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
> 
