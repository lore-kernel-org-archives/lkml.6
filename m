Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3711793-1527058130-2-504393011780240576
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
    1527058129; b=Mu7r9DzVU6jRvbeGrhJ6k7x6ZXyLAc+NS+Qm94eoee1LYb5nun
    X2LSFkBrFiCg82rVBYVL1zDaWAv8ExTJ2E1JOeNLUtjxkJITNgqNTkHNplDA7s1q
    lEpLJpZsYPcSekwllHYTxgK4Ax4Y2Rd4TBXHXyVaGvEZJubsVIl8NvVCDBHo8/2e
    D8XImPSoAp+Y716FtAjZiPifW3RTe7S8vEBVu8S/a560HKWrpMf/Ae/36ENQAKrk
    M2nO17fAIxSaNzhWe3tBf/PYT8vxTdGLao3TPX0l4cGUeMOL6heIu9d2C5MGku3k
    c9Lwx7r1xJNv2ooXmge+edG6VyB1Xb9we2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527058129; bh=KoIKz0r3Kwe7KyKkwduDbj3igIbdn5
    +CTijPUHPT1YA=; b=B4ZsRBv5Js4cZOl6Zeq0w59TtpIsFKn9E+yepzB+C5a80F
    siVr0gP8rUtD2+ZzS5scRFKEeLH1jnn9bd6ABj1WGOXe6hGph4A+S7Y9lySLOvZ+
    5xPQdGn913oimL07nIPkaGExPsQuIiKCgtxmJ/tNpowqYpQbpfEOEmGY0tN9yvWd
    n7TZpLRHqjEeEiQaOeT9/zZzAc3DAGdsj79r5OFE7rSGMa/CDV0ZShyhnt9qCrq+
    b3wf2VmiXtibLPFnoCHoW6N4vwRdprPulz5wO7goB6HOKk4MS0fDhba2Je8GSemx
    3fX2JzVlkZT5vZrX8iFuOxDW7vVh98DSLLLlkDjg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCH6FdaGjjf6pJrbsYeBQQ14SMMBjzhFiqvRBTd+K2LYC57jgo8GlMjOpSS4DhUmCptQqIll69L7iGky8WZoNfiDOcgA3fJnLdqJ3Pl9swoYRQFZucz3
    5mzq72ooAVRZT9C/9buR3t3+z60hu+oiNCpgZFlUqie5FpA/oR24Eoed3xOGftD1F2bUZwK5VvfMoIwVe2rKLd7Ncrw58z5w5l7AGRRGqWolQk422xRlsgWX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=UHFruWed2s98n1uijYYA:9
    a=egyAVZCdU4KJx0o8:21 a=H4a-nIxa51InSJ6I:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeEWGsd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 02:48:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:2491 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754207AbeEWGsU (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 23 May 2018 02:48:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,432,1520924400";
   d="scan'208";a="57704635"
Date: Wed, 23 May 2018 09:48:15 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH 1/2] power: supply: Add fwnode pointer to
 power_supply_config struct
Message-ID: <20180523064815.GA5289@kuha.fi.intel.com>
References: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
 <c398d1fcc81017b9cc694a00d2c1f655874dfeac.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c398d1fcc81017b9cc694a00d2c1f655874dfeac.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 04:16:23PM +0100, Adam Thomson wrote:
> To allow users of the power supply framework to be hw description
> agnostic, this commit adds the ability to pass a fwnode pointer,
> via the power_supply_config structure, to the initialisation code
> of the core, instead of explicitly specifying of_ndoe. If that
> fwnode pointer is provided then it will automatically resolve down
> to of_node on platforms which support it, otherwise it will be NULL.
> 
> In the future, when ACPI support is added, this can be modified to
> accommodate ACPI without the need to change calling code which
> already provides the fwnode handle in this manner.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks Adam! FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/power/supply/power_supply_core.c | 4 +++-
>  include/linux/power_supply.h             | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index ecd68c2..f57ab0a 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/power_supply.h>
> +#include <linux/property.h>
>  #include <linux/thermal.h>
>  #include "power_supply.h"
>  
> @@ -874,7 +875,8 @@ static void psy_unregister_cooler(struct power_supply *psy)
>  	psy->desc = desc;
>  	if (cfg) {
>  		psy->drv_data = cfg->drv_data;
> -		psy->of_node = cfg->of_node;
> +		psy->of_node =
> +			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
>  		psy->supplied_to = cfg->supplied_to;
>  		psy->num_supplicants = cfg->num_supplicants;
>  	}
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 0c9a572..b21c4bd9 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -199,6 +199,8 @@ enum power_supply_notifier_events {
>  /* Run-time specific power supply configuration */
>  struct power_supply_config {
>  	struct device_node *of_node;
> +	struct fwnode_handle *fwnode;
> +
>  	/* Driver private data */
>  	void *drv_data;

Thanks,

-- 
heikki
