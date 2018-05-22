Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2741439-1527005305-2-6137202390720754908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527005304; b=HmMnjG8xA1KSxYnAosPCOriKvbZLvUb1nvSlfgfL6EbM1pu+XP
    a8bChQeOmkaHRYIF2ZUml25YkOtmTl7lcNpdQsz6xwdP4a9lysiLquGj30164ot7
    6sgY/8ZvX5Ybixgpll8tU62rBJxhGmFWCb8PLSW0xka2OsQCwijRUEThybnBCYcL
    SZv2AeoOL5I46U4bT4b28qBx+vTuGQebK9Bh6VQp2mqCCySh8utMW8FB8r7jdteE
    Fhy25B+NjQCJNZZ/Zw+zXGcuwFKvaMJSpfhY++6G5yoyQ+wq4cwsh67px8N0Cyd2
    g53u4HhKXQfiIdlZAZ6tlfUW6cKmXjp80P6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527005304; bh=aAD0G0yb/sr7dfENrUJDvt6fecYjd1
    iiyEL9YPmrW4o=; b=XZ60qHPvgXroBZyyjUYhiTb8yPkNNtnfk7SY2P3Bl+S+rC
    G6NWsQZlSKRa4k8ZeIj5T/lOkJCB+YoJukTJX5gv0jI2NDv5CIj2aO41t/Z6JZE0
    WMrvX3fwCLyp4tjIw+VCq63lDBcwb2t19U7dqueMcKUY211QW3vMLbipzgH9zXqG
    ZT28wnREHLafKOTQvc2NxHZaqCwORLZx9LZB3QJFEvO7Gop7aXrP3294aGF77tHX
    2TWRoHj5iiJMR+IpNRZDFWMXUVcY+4KNsLZKtBakiyIGkKB36T79mIg7P11BqCsw
    o+30CamnJd9erSS5Twm82r1j3RCtwbtbSnQETf9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=kBaDs4J4
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=kBaDs4J4
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDFO4/+O79r9oo7EhH+5sLSm6XR/S7UldIzBX4Ib8/k5BzBvI4DNacr+XAkGMzRpilJ1+6M+wpY8o4FXPNgznYwpzbOX07KidK9REwSi/hL4cSAxFyby
    0LyqhxmTICvZAYyqlhctG+bpgFZBbN2dG9QDCD1A4bRr8IqlEMRhkZUkqfGD25Tm4HHi1rVK4DdRe5uaF2e3qTlbJh/i0B99nsLsH11AQpxSeOAQUnPna6Cn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10 a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8
    a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=GDVnyHEbltg1h7Ly3tgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22 a=nlm17XC03S6CtCLSeiRr:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeEVQIU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:08:20 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51195 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeEVQIS (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 12:08:18 -0400
Date: Tue, 22 May 2018 09:08:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH 2/2] typec: tcpm: Provide fwnode pointer as part of
 psy_cfg
Message-ID: <20180522160815.GA22182@roeck-us.net>
References: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
 <449707040719c8845cf9fa6bc779bae25fca54a5.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449707040719c8845cf9fa6bc779bae25fca54a5.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 04:16:24PM +0100, Adam Thomson wrote:
> For supply registration, provide fwnode pointer of the port device,
> via the power_supply_config structure, to allow other psy drivers
> to add us as a supplier. At present this only applies to DT
> based platforms using the 'power-supplies' DT property, but in the
> future should also work for ACPI platforms when the relevant support
> is added to the power_supply core.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 72996cc..0ccd2ce 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -14,6 +14,7 @@
>  #include <linux/mutex.h>
>  #include <linux/power_supply.h>
>  #include <linux/proc_fs.h>
> +#include <linux/property.h>
>  #include <linux/sched/clock.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> @@ -4500,6 +4501,7 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
>  	char *psy_name;
>  
>  	psy_cfg.drv_data = port;
> +	psy_cfg.fwnode = dev_fwnode(port->dev);
>  	psy_name = devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
>  	if (!psy_name)
>  		return -ENOMEM;
> -- 
> 1.9.1
> 
