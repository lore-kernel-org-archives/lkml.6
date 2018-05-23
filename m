Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3751275-1527058359-2-4049031947455201340
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
    1527058358; b=P6KFpzuO1IFV2i1MnriFpfEsPRO0OaFPMMsYGzxb0O8oNZpUVe
    03nfxashzVei6vGC8pWnLiX/HP0n+XuGmWWHM60eOEpWL2Wgn6Cd65tr7B8Yz7kW
    ORjMolCd2b4IYpBr9NnhZfix6qDORQmc6Uqd+aFwKTP15oJFx64Q3S16Y53ijGd+
    UybA1KOMIb8cDCykk2U14PSzZ5mOHtuPs8w09G5b6U+/MfOa6lSX+NgZ3PD8glHc
    HcxP63BySnu5sSuXDRyy9ZH+Fxt1HdbzYy3nDixwoxZ6coqeJgPC01nrgXt13N1S
    HhzpjupnrjXWGkJCytlvC+aI+l/TWMWWRDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527058358; bh=waQcndqOEej9yXdxbllMweYBiRVlM5
    4pJSsj2Ek+lEQ=; b=NSgg7WaFy/nZSWVOyvJTxMyO8tknEAw2e1CRcwdkapygwQ
    O0RMZvB9SJI2IwaKuP/S/gaV04/0XnOAY5idaqgc1XVQv0cJbPcxohOu2WAwAWIU
    t3swQs6u8FrJxTuQL3rXK/5/lRYrlJiPMS1EGZ4nftezprX5HBQfl+kjjWVj/789
    tUDF7Qj8pxqb2Y78yEyBOtfoDGkyivFYM+gS1YJLTeDjI/Zh6IUVJHe14zTcZJuh
    Ljl2tNnKhD2nWY8mm5Os6Q7u79YC445aDLGTXVUzoTUo1N/Ef+cAAJ+HOAfg8kwI
    KKJ12jxgAWoijtBhxTzO8H6kM7TYFc9EWZqHBLmw==
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
X-CM-Envelope: MS4wfJwaSRNuHgwyb3cnjImnC3dRF3bnilWm8X/rkTae4Sp5XcGOoMGY+Gc0UlgDVuOeT9VxCSEYeHyqADR15T6AU8Cu5gkiQImtD+oCjhz8ZsMh0F6ydfAv
    RxewBRzt+vO0AT5gTZiiCJDoXBI8LxSfPmh1kbMvoCojU4mhoSZWAaqVTHo0uXAAN9AE02h7ov1MCx0Cw6NnnVRqshhmgxHl9b5/kIFKKGlFnCx/DHxPrga0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=GDVnyHEbltg1h7Ly3tgA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754100AbeEWGwe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 02:52:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:9211 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753985AbeEWGwd (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 23 May 2018 02:52:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,432,1520924400";
   d="scan'208";a="57705331"
Date: Wed, 23 May 2018 09:52:27 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH 2/2] typec: tcpm: Provide fwnode pointer as part of
 psy_cfg
Message-ID: <20180523065227.GB5289@kuha.fi.intel.com>
References: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
 <449707040719c8845cf9fa6bc779bae25fca54a5.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449707040719c8845cf9fa6bc779bae25fca54a5.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

Thanks,

-- 
heikki
