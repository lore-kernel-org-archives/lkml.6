Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F829C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AD820666
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AD820666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeI0NG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:06:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:60416 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeI0NG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:06:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 23:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,309,1534834800"; 
   d="scan'208";a="95202105"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2018 23:50:03 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id ECCD9209BC; Thu, 27 Sep 2018 09:50:02 +0300 (EEST)
Date:   Thu, 27 Sep 2018 09:50:02 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
Message-ID: <20180927065002.3yzxg6xquapldaqz@paasikivi.fi.intel.com>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927004810.124185-2-mka@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:48:09PM -0700, Matthias Kaehlcke wrote:
> Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> address (BD_ADDR) for a device. If the firmware node of the device
> has a property 'local-bd-address' the BD address is read from this
> property.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Changes in v4:
> - move code from driver/base/property.c to net/bluetooth/lib.c
> - undo move of bdaddr_t declaration
> - merge fwnode_get_bd_address() into device_get_bd_address(). as of now
>   the function is not needed, it can be created later if necessary
> - minor improvements suggested by Sakari
> - updated commit message
> - added 'Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>' tag
> 
> Changes in v3:
> - move definition of bdaddr_t to types.h to avoid include of
>   bluetooth.h from property.h
> - add stubs for the new functions
> 
> Changes in v2:
> - use bdaddr_t instead of byte pointer + len
> - use EXPORT_SYMBOL_GPL for the new functions instead of EXPORT_SYMBOL
> - put new functions inside #if IS_ENABLED(CONFIG_BT)
> - some new line juggling in property.h
> - added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag
> ---
>  include/net/bluetooth/bluetooth.h |  2 ++
>  net/bluetooth/lib.c               | 34 +++++++++++++++++++++++++++++++

Yeah, this seems like a better place for this stuff indeed.

Thanks!

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
