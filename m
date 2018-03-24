Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2522873-1521851139-2-14000736628251308910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521851138; b=bc/WtA0BG2cTPXTMEcPKAYcXd8n91TWjNPclhkiASspW26Q
    xgKYmFzOC4QpDCGnLWPqgKYq6u6HdXhzA6Fum9CMEQpKpVQhbBRK1Lhd6euhd4um
    ENJYXKyVWijK36aCw/fqAQCGq98/eWZWWmynjwnfEp9NLnHut2snk4JmJx5t6y25
    FOGG/0/mDm3ePaMUgr6lyOo0uyJpVdWC/0BhUWRTAcxh36kdpiI1s1a1+I0VcCYe
    GBZfeph1PzvgN2xPX+FNPRFmy9srx6eIbpdvXaV6ASbDnKflIGMIyBf0oOQWWqut
    g37Ltx8+FxdBr76dN8ZPTHXyve2qJWuiEVuGxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521851138; bh=Qphnwky3KI2zuuCRKoMGiWcOx7
    eZp1XbfZK9HrR3Fis=; b=cgzxMKcbKoINMVozRH7V6CVVhxxq8uUgdj0d3YyByp
    BP9mEEJvia93iPXIQYfN5dFGKcsjeWPjl5aQh18W15kWuvZjaGSMRPotV4d2Z5Fr
    1xW6OB9Ph1L9vAwdEzYtsJna/EQfwtOqAV8VpKZRttuRdWGMPZGc4kD64hQJlZh3
    2ofytu0PUsfBeezntQfSSFs6bN7Msfb6tQiNV94zGuosMBoSZ1WoNOcjOEJNl5rl
    j6s135ITNn/3cP0xF5m9WIQwbXqp4dMd7YxdeUJjLlHj8vNiZQ4i5LSUiQOh950i
    wGS3PCX08fvjouNJaXJP5+Br3DlTrhkxwrRcpZ8uMnXQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeCXAZZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 20:25:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:23562 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbeCXAZY (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 23 Mar 2018 20:25:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,352,1517904000";
   d="scan'208";a="214381021"
Date: Sat, 24 Mar 2018 08:24:57 +0800
From: kbuild test robot <lkp@intel.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc2: dwc2_vbus_supply_init: fix error check
Message-ID: <201803240827.nmiIDaqS%fengguang.wu@intel.com>
References: <20180322131451.12631-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322131451.12631-1-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tomeu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on balbi-usb/next]
[also build test WARNING on next-20180323]
[cannot apply to v4.16-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tomeu-Vizoso/usb-dwc2-dwc2_vbus_supply_init-fix-error-check/20180324-063752
base:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/usb/dwc2/hcd.c:367:9-16: ERROR: PTR_ERR applied after initialization to constant on line 366

vim +367 drivers/usb/dwc2/hcd.c

   358	
   359	static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
   360	{
   361		hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
   362		if (PTR_ERR(hsotg->vbus_supply) == -ENODEV) {
   363			hsotg->vbus_supply = NULL;
   364			return 0;
   365		} else if (IS_ERR(hsotg->vbus_supply)) {
 > 366			hsotg->vbus_supply = NULL;
 > 367			return PTR_ERR(hsotg->vbus_supply);
   368		}
   369	
   370		return regulator_enable(hsotg->vbus_supply);
   371	}
   372	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
