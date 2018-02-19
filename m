Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3657171-1519026417-2-11101085136674678982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519026417; b=PWf0F4ZKvY/QQlhXQehHI1b5FgWvUXtD7qFXU6HEDNXKdFs
    DCosocZdAu6OeYn0AnuTsFKnyG7X6vQ1vxNQjL3oGshmt0TBG1Ae6kcALEENI9yg
    VZ/wC+PFy5zg2GUBdW8mT1uhVawNw+SXIGrs81xCnNNPgHKhVZuwrDC1sBpQgLAR
    unk1+1lr9fethVN8EpqM69oPY0Mi6FcAUyxnca7v0Y+b2kfPIUNyTfDuiyuGtjMN
    XJ+h8aTAT+FlJx1kUTh+Fmy9k+DlSpbiRFCBsPWcIafD4TTrmFqJJniGgDmnLuaD
    TFI8Rg8qNmlzZAwSgJ/6nWnZ9/Hg5tCrYFMBm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519026417; bh=QHqm0VXWki5unvFpWp+Tx5vxl5
    DYU+Ec3IIXxHIqaRM=; b=wUxGJZ19NN6aqA44nd2q4BA10nPjUx9ch1iJGoK2mQ
    z0xqTM7w2x30XQs6tdRN0HctABXMCMCJUTYL63f6iIhTwkly46/bAgNL16sp0AO0
    4AZBbeDmIWJTajqv5fnWekqYdnmaso/uHSXjPY5l0vOGB138+mDSYsZeIoQD9/N4
    +PJNS1GaVipgw+yS9Oe/iXXfUrRyJM8cY2B2i5R+Xbvf0PS2T2LxeHiHKNsI8nnG
    1n7zQpt5FVJg2lCXvBPOCki5Nshg151mlcJmt2QAbj3wGRxIqDlPGKwCbi5sNGdY
    ZwcC83RpDpfMiKsfIsEh169sMfb3nM6854EuWO+BBGFA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeBSHqn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 02:46:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:53159 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbeBSHqm (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 19 Feb 2018 02:46:42 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="35784453"
Date: Mon, 19 Feb 2018 15:45:38 +0800
From: kbuild test robot <lkp@intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: kbuild-all@01.org, Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on
 Droid 4
Message-ID: <201802191503.yJma6SYG%fengguang.wu@intel.com>
References: <20180217210723.7013-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217210723.7013-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tony,

I love your patch! Perhaps something to improve:

[auto build test WARNING on phy/next]
[also build test WARNING on v4.16-rc2 next-20180216]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tony-Lindgren/phy-mapphone-mdm6600-Add-USB-PHY-driver-for-MDM6600-on-Droid-4/20180219-131127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/phy/motorola/phy-mapphone-mdm6600.c:354:24: sparse: incompatible types for operation (>=)
   drivers/phy/motorola/phy-mapphone-mdm6600.c:354:24: left side has type struct gpio_desc
   drivers/phy/motorola/phy-mapphone-mdm6600.c:354:24: right side has type int
>> drivers/phy/motorola/phy-mapphone-mdm6600.c:354:24: sparse: incorrect type in conditional
   drivers/phy/motorola/phy-mapphone-mdm6600.c:354:24: got bad type

vim +354 drivers/phy/motorola/phy-mapphone-mdm6600.c

   340	
   341	/**
   342	 * phy_mdm6600_device_power_off() - power off mdm6600 device
   343	 * @ddata: device driver data
   344	 */
   345	static void phy_mdm6600_device_power_off(struct phy_mdm6600 *ddata)
   346	{
   347		struct gpio_desc *reset_gpio =
   348			ddata->gpio[PHY_MDM6600_RESET];
   349	
   350		ddata->enabled = false;
   351		phy_mdm6600_cmd(ddata, AP_STATUS_BP_SHUTDOWN_REQ);
   352		msleep(100);
   353	
 > 354		if (reset_gpio >= 0)
   355			gpiod_set_value_cansleep(reset_gpio, 1);
   356	
   357		dev_info(ddata->dev, "Waiting for power down request to complete.. ");
   358		if (wait_for_completion_timeout(&ddata->ack,
   359						msecs_to_jiffies(5000))) {
   360			dev_info(ddata->dev, "Powered down OK\n");
   361		} else {
   362			dev_err(ddata->dev, "Timed out powering down\n");
   363		}
   364	}
   365	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
