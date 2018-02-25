Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604962-1519584511-2-17629494178874637123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519584510; b=kjO+VSM11zUbM+PbgW0reYF2JxTk0M6VTtOr/5uc+yVg4/T
    gJ+z3D1htc2nn2vUm1w+bpV7wisvBX/Px4P4QWOnqpfHat3Z0lWoLX9h1i5CdXrj
    d1u3ilLi4TQarD562iNZxYX2KTGsTgn42HvbY/6Ri6vnnS1qj7kGsGXgFJ4Q6pqd
    Iji3vZyk78ROuxIOVuHeZTBnjqSB9C8cp+kNVrKYSjUk0VCg9oZp3k07NTwDsyWN
    btozeDWh4XxFqtNjKmYVBHIOTPazJCSI6us7N+O493kgI6CJH7YiJd7OckgSOsKD
    fIbkwkQVVl5RbBoFj49A4dN6NPL25lAmwAM/vtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519584510; bh=z+Glp3GqPY/BnYZ2dod8QBhSvWzjbqNVyRoMAsbm3Sw=; b=l
    MXfP/ySgvW9+ab0ll6A6yOPQG+djhmQ6gy0et63m2zNEBXG6D6GPsKzPc/P2/Tnk
    scYQUVXH1UxpV8NYGaOgtjsPgSnv6JGmVnu/Tqu+xvlYTN/ZlxexBO1eoEXBA/9h
    sMUFxl7zh3M7hfp+DyiuerAdLbsNJNde6Cxfpep2w2r7VY8o/WCSRbx28gX7QbIt
    zF1Q5aU83xJoJoK373B33GZHSe4wAH5c1OnsPeVwQtmCNhufQv24jpQ4+k07cOfc
    9g3g2IXt3oQqa5Pfyt90nv19UxsDbfGU46lGCAXGJHfj2HUj9wX/v6bGVu6AhpwV
    XRFe76HKh9lZDVHn4EtmA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sU3NyHB5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sU3NyHB5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeBYSsO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 13:48:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBYSsN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 13:48:13 -0500
Subject: Re: [PATCH v2 09/12] usb: roles: Add Intel xHCI USB role switch
 driver
To: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180225152510.10159-1-hdegoede@redhat.com>
 <20180225152510.10159-10-hdegoede@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <48962e5e-d948-46f9-b1ed-339f96ca3edc@infradead.org>
Date: Sun, 25 Feb 2018 10:48:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225152510.10159-10-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/25/2018 07:25 AM, Hans de Goede wrote:

> diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig
> new file mode 100644
> index 000000000000..f5a5e6f79f1b
> --- /dev/null
> +++ b/drivers/usb/roles/Kconfig
> @@ -0,0 +1,14 @@
> +if USB_ROLE_SWITCH
> +
> +config USB_ROLES_INTEL_XHCI
> +	tristate "Intel XHCI USB Role Switch"
> +	depends on ACPI && X86
> +	help
> +	  Driver for the internal USB role switch for switching the USB data
> +	  lines between the xHCI host controller and the dwc3 gadget controller
> +	  found on various Intel SoCs.
> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called intel-xhci-usb-role-switch.

Wow. I hope that I never have to load that driver by hand. :)


-- 
~Randy
