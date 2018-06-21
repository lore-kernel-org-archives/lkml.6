Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27212C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E285A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E285A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeFUJju (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:39:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:11164 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932620AbeFUJjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:39:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 02:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,251,1526367600"; 
   d="scan'208";a="66018408"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 21 Jun 2018 02:39:44 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Jun 2018 12:39:43 +0300
Date:   Thu, 21 Jun 2018 12:39:43 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild test robot <lkp@intel.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Guenter Roeck <linux@roeck-us.net>, kbuild-all@01.org
Subject: Re: [PATCH] staging/typec: fix tcpci_rt1711h build errors
Message-ID: <20180621093943.GE2847@kuha.fi.intel.com>
References: <f344e5f3-4e92-1fd0-ef4d-7b96065466b8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f344e5f3-4e92-1fd0-ef4d-7b96065466b8@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 05:05:42PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix Kconfig warning and build errors in staging/typec/rt1711h.c.
> The driver uses I2C interfaces so it should depend on I2C.
> 
> WARNING: unmet direct dependencies detected for TYPEC_TCPCI
>   Depends on [m]: STAGING [=y] && TYPEC_TCPM [=y] && I2C [=m]
>   Selected by [y]:
>   - TYPEC_RT1711H [=y] && STAGING [=y] && TYPEC_TCPM [=y]
> 
> and then:
> drivers/staging/typec/tcpci.o: In function `tcpci_probe':
> ../drivers/staging/typec/tcpci.c:536: undefined reference to `__devm_regmap_init_i2c'
> drivers/staging/typec/tcpci.o: In function `tcpci_i2c_driver_init':
> ../drivers/staging/typec/tcpci.c:593: undefined reference to `i2c_register_driver'
> drivers/staging/typec/tcpci.o: In function `tcpci_i2c_driver_exit':
> ../drivers/staging/typec/tcpci.c:593: undefined reference to `i2c_del_driver'
> drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_check_revision':
> ../drivers/staging/typec/tcpci_rt1711h.c:218: undefined reference to `i2c_smbus_read_word_data'
> ../drivers/staging/typec/tcpci_rt1711h.c:225: undefined reference to `i2c_smbus_read_word_data'
> drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_probe':
> ../drivers/staging/typec/tcpci_rt1711h.c:251: undefined reference to `__devm_regmap_init_i2c'
> drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_i2c_driver_init':
> ../drivers/staging/typec/tcpci_rt1711h.c:308: undefined reference to `i2c_register_driver'
> drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_i2c_driver_exit':
> ../drivers/staging/typec/tcpci_rt1711h.c:308: undefined reference to `i2c_del_driver'
> 
> Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: kbuild-all@01.org

Revieved-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/staging/typec/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lnx-418-rc1.orig/drivers/staging/typec/Kconfig
> +++ lnx-418-rc1/drivers/staging/typec/Kconfig
> @@ -11,6 +11,7 @@ config TYPEC_TCPCI
>  
>  config TYPEC_RT1711H
>  	tristate "Richtek RT1711H Type-C chip driver"
> +	depends on I2C
>  	select TYPEC_TCPCI
>  	help
>  	  Richtek RT1711H Type-C chip driver that works with
> 

Thanks,

-- 
heikki
