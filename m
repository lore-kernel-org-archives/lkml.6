Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2999314-1524573733-2-14404800664906385468
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524573732; b=w8quGdIc3Bx+NI19aeDGoQynJBq7XRyv/Gc3tMoQnlTmsDoth+
    zyaibGEBx9U1tIGrFTiwYfiDdYwxP5RFd4UFaWGISaiMFVhOTIQynmAX62iB1fin
    KjbUcMiYZJ6525M109nUnJOzVkc3zxoYfqBLBXaMcn+MH8NvDApZ5i+OFW4BHTF0
    WB95qBTCT8cBm9KCA9POCjZgejPcdjGrWDvhXBBmzahYgQmEvD7tR0eObh3CSEm+
    ws4+IV5ZE22qNa/lvu1rLOQGqOT0D5iltR396yx6sPlEJhb4+sDQ3mfVRhVNZfbI
    q8PI9BaB6G7dU7Nu6zDuIwG0WrgGiEFkHxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524573732; bh=i6fndYT3RrzflJOgbVd8xmJHiqJAGt
    vDTEb9Hvczpjo=; b=ZdsjGlsU0mtJrEjsIVnTn5ABWNWaULKLIEG9Nv4hLSM0NG
    wxVLQ8sbfRlk8LsdYZFPTC2ounljaHmkz7ytV5nwQk7EqRTkUS3Z1alYicQtdnDp
    Awp5atlk5NZ4dACuSAiLpjaNO1ax7u1tNRZqHPtToCoTH4N6kwkKMwh2zVAAQn1c
    Ds7oykd0eex8j8Suf++1qLLmfn9uDw93w3lU1RWNf6uFy5cHCjfp3AaIz2F+TOfH
    1pwy9Pb3wJyHS0BXAsnjCYIngtwtFZoszNrEr5aWRNEqbQJN3LQIS0Ruf6nRe9V8
    dFOeLLK7hQ7ofygYGxMw9m6g/oZiIlUYpggHDMOw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHJr5zosOIWB54ycaBeK4O45RBKLfNfPA3wi/MQb3ggxjhD7m/wFmgHY9LfaT+Gtd0WYjcZWKGj1fMVFEQX99x2thwwEkK3q5qoor631/3AiHRNJUOAa
    r/QPNUni8t2I4yONFQIS5Y8rDCsH89+7Zb3nUALwWIYLvGIszhZazUzinWWYRD2mMf0FS96h//2cIfGfBgOHwahbPNohRYMsgIG/zD4uRplQJ6VAdp74bxOH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=HFBJ73aA71HzFdpGqooA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757609AbeDXMmI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 08:42:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:31862 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752673AbeDXMmF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 08:42:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,322,1520924400";
   d="scan'208";a="49490431"
Date: Tue, 24 Apr 2018 15:42:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v8 3/6] power: supply: Add error checking of psy desc
 during registration
Message-ID: <20180424124200.GE25723@kuha.fi.intel.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <627b8dcdee758c2598c6cf68b0ce536d3e557ca4.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627b8dcdee758c2598c6cf68b0ce536d3e557ca4.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 03:10:58PM +0100, Adam Thomson wrote:
> Currently there's no error checking of this parameter in the
> registration function and it's blindly added to psy class and
> subsequently used as is. For example if this is NULL the call
> to psy_register_thermal() will try to dereference the pointer
> thus causing a kernel dump.
> 
> This commit updates the registration code to add some basic
> checks on the desc pointer validity, name, and presence of
> properties.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/power/supply/power_supply_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index feac7b0..a7984af 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -849,6 +849,9 @@ static void psy_unregister_cooler(struct power_supply *psy)
>  		pr_warn("%s: Expected proper parent device for '%s'\n",
>  			__func__, desc->name);
>  
> +	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
> +		return ERR_PTR(-EINVAL);
> +
>  	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
>  	if (!psy)
>  		return ERR_PTR(-ENOMEM);

-- 
heikki
