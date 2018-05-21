Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-732810-1526908828-2-11211495261085866429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526908827; b=gFSXgf88W9wo32Nc1HzBGT3+00/0YMYp8OESJZ8kIXr1bGwR72
    cxQQzyUFMu6NkKjisWXx/JWr+IuT8uRuvqDiDy8EBaiReMqTktTWzWo6/pjgfO47
    J3OzVt7eC7SB1ufA/ducm9qR65xT1cO7VJrrTm2kf6Ldj6gRtCpRxn7MFOYsWTTZ
    EUwy1GBYD9Jm6vFNuSrdbe2erWKd4xGsVBPPlYj6q1w3WKcrsJEKPLOIN6pOz9Jm
    8/sbLFuVniYV6Sts1hGyOufr57uhihOAcM6GHKzH7rWap0I59ieSw+YS05P5IY6M
    fw0wQIZSXtV5TKN4XcnSjQxP4kYDqB211FWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526908827; bh=lHhR9vDbqPj5/GY3cODBgWGiUF6I6g
    2QuDV4O+3bTlw=; b=VZIk8wOt4Dvj23M5kfhA73QiQ9h6reHQ0s6M8k1mdaZChy
    2+yEwpy0pRjAm4ALS5pDsiA1LUZvCXzxXRT5nQwLOmZOTZVQ8X7MJNtuCesZGAEJ
    WsEFtIinpDFIQpAxrUExr6WYfoR8431Wn5Ocn4ebj0qj6+yVj7nXWy+QYaVwJ8tX
    pToP5qyxFMTHXOP3pKnbnBodlqUWG1PDs8QNtahMGQy33AIwmbjJAG6BG3To2hDN
    VfrQHKGQLpVN9cpheCU2+CYuSU72PfrBMErCYKgAamEsUbQ7azldC+ZAc8rbiwgU
    HTKgeHRDOIXPAPawSpi/Suk5OSPmL3YNv5YcF/aQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNmoKQ3B1UrsSW3nWly36LbVHDK9Z0QZaON7VenOOjiwRs5RC5ZcpEdqnArDTe+UAGOSHCddDu6wko10GUAwYddlq27g1qxxeMdnhnekKL2xYgsSdhau
    ey+dRsobJBPzshTHHDHt0mqH6ui8s/R4Sfxbkfo3DdWJixZWvsowuJAS/XFw89uqRNUGOgnYXR04d/mbCAkxT+H2PjwA718jdorbZpq+WHeKMyO1kBVWiN8W
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=X3a0BiUdAAAA:8 a=VwQbUJbxAAAA:8 a=3yo7uQTKm1gGI-3Av5MA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEUNUV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 09:20:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:17852 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeEUNUU (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 21 May 2018 09:20:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="57082402"
Date: Mon, 21 May 2018 16:20:16 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH] typec: tcpm: Provide of_node pointer as part of psy_cfg
Message-ID: <20180521132016.GC10677@kuha.fi.intel.com>
References: <20180516160046.18FCF3FAD3@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516160046.18FCF3FAD3@swsrvapps-01.diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Adam,

On Wed, May 16, 2018 at 05:00:46PM +0100, Adam Thomson wrote:
> For supply registration, provide of_node pointer of the port device,
> via the power_supply_config structure, to allow other psy drivers
> to add us as a supplier using the 'power-supplies' DT property.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  drivers/usb/typec/tcpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 72996cc..e7c0b95 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -4500,6 +4500,7 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
>  	char *psy_name;
>  
>  	psy_cfg.drv_data = port;
> +	psy_cfg.of_node = port->dev->of_node;
>  	psy_name = devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
>  	if (!psy_name)
>  		return -ENOMEM;

Would it be possible to use fwnode here instead? It would mean that
you add a member for it to the struct power_supply_config, and handle
it separately in power_supply_core.c. You could just convert it to
of_node there for now.

That is just a request, I'm fine with this, but it would prepare this
driver for all types of platforms, so less patching would be needed
once we add ACPI support to the power_supply_core.c.


Thanks,

-- 
heikki
