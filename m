Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42991C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7F720B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfAaKGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:06:37 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43828 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbfAaKGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:06:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so2046941eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SU79ejPGwFnEun6aFh2CYhWUo6nQS9OYkeS3fXTHHAU=;
        b=dQVVGOGv9/u8hnLAsdz8YazTtslrYwGAsggZqCgg1yc5RWfah50zHIiw9iNHW+Jv+q
         g9aESxMNnuversgx+UVTlnIIeK+2tG7ERJVfkn7L7P7YT5CXa4hw/rOxD/AchgQY7/Aa
         nZ3n5JOnE5BthQVyibsX1pY6/ow5RoHbswP84GKT34+r9ILke9oo3H6BguqfM+voekaf
         +SsKG2XcDzoZWRi2brhsXu3d6Tx9J+1WsLmUl8N7sCUTCDozXruRY5z6v2oGbQbsc6+Z
         gWiM8UN2Z6mD/H9VxxeDtoKshROj634xSIUIZ6a64ZSot5MBRzSsp/MtsgaS6AUKQUtd
         X0gg==
X-Gm-Message-State: AJcUukdeEGXb1h07v+X5JkbLTMAe5dg4GTxt4N4se5P+IICmlPkWjgj8
        9jAp1iA8pc9Zn6SOOy4YaEh2GBrC4NA=
X-Google-Smtp-Source: ALg8bN45h0ErWKCmzKqoK/DBx38CgIUhuEnuuIj5x/F83jcXvCOvTU1LgaO2Pf5M+PEh6LYbnWrAdw==
X-Received: by 2002:a17:906:a48f:: with SMTP id m15mr10925649ejz.234.1548929190727;
        Thu, 31 Jan 2019 02:06:30 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h8sm1146596edb.95.2019.01.31.02.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 02:06:30 -0800 (PST)
Subject: Re: [PATCH v2 0/9] device connection: Add support for device graphs
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <07262cf3-c512-d3dd-f383-3795f035a2d5@redhat.com>
Date:   Thu, 31 Jan 2019 11:06:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-01-19 17:02, Heikki Krogerus wrote:
> Hi,
> 
> This is the second version of this series. On top the two code style
> improvements requested by Andy, I also renamed the connection
> identifiers used with the USB Type-C muxes for something that I felt
> are better, especially after we start using them to name reference
> device properties in fwnodes. That's why the first patch is now split
> in two, 1/9 and 3/9.
> 
> Hans! Please note that there is no functional change. The alt mode
> device is still getting a handle to the mux, just like before.

Ack.

I've reviewed the entire series and it looks good to me.

Patches 1-3 are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I'm slightly less familiar with the material in patches 4-9, so they
are:

Acked-by: Hans de Goede <hdegoede@redhat.com>

I will also add this series to my personal git tree for testing.

Regards,

Hans




> That was actually happening also in the first version of the series.
> 
> The commit message from v1:
> 
> This series adds support for OF and ACPI device graph parsing to the
> device connection API.
> 
> Handling the graph is straightforward, but because I'm adding that
> fwnode member to struct device_connection, I had to make sure all the
> existing users consider it.
> 
> The plan is to only support matching with fwnode in the future, so no
> more device name matching. The software fwnodes that we now have in
> kernel should make that possible, once we add support for references
> to them.
> 
> The original RFC:
> https://lkml.org/lkml/2018/10/24/619
> 
> thanks,
> 
> Heikki Krogerus (9):
>    platform/x86: intel_cht_int33fe: Prepare for better mux naming scheme
>    usb: typec: Rationalize the API for the muxes
>    platform/x86: intel_cht_int33fe: Remove old style mux connections
>    device connection: Add fwnode member to struct device_connection
>    usb: typec: mux: Find the muxes by also matching against the device
>      node
>    usb: roles: Find the muxes by also matching against the device node
>    usb: typec: Find the ports by also matching against the device node
>    device connection: Prepare support for firmware described connections
>    device connection: Find device connections also from device graphs
> 
>   drivers/base/devcon.c                    | 62 ++++++++++++++-
>   drivers/platform/x86/intel_cht_int33fe.c | 15 ++--
>   drivers/usb/roles/class.c                | 21 +++++-
>   drivers/usb/typec/class.c                | 31 ++++++--
>   drivers/usb/typec/mux.c                  | 96 ++++++++++++++++++++----
>   include/linux/device.h                   |  6 ++
>   include/linux/usb/role.h                 |  1 +
>   include/linux/usb/typec_mux.h            |  3 +-
>   8 files changed, 195 insertions(+), 40 deletions(-)
> 
