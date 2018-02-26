Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2691517-1519645341-3-820783144919839374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519645341; b=hAqMgGl+bWjpleoTCaCjHpUdfRhZZhI/pEHsp9I6aE8IPrZ
    k03u5rmp00cz7+MxeYB+/iq8ULbwywpP2xO4SFl6eNpVaQFpnTuhpISE0y4m0TFa
    6rYgXef0OO9VZ9SggbytoIPvxDmozy0DPVK+4Jl/SWfAWXVA05nyvRPSkeEfOGAw
    HAU9WVgK2RxqDHWGHu1a/Pawqq0UT/PzM7Q2a8jTP0bWaISCX72LQC56Z1Yfmx+3
    uGy4IJH3ko5eI6Iufce/rJFjvFNCGymYrtDrrYKDW82sR3ML7V3Wqd4V/LqxVbCb
    34fuEvFfa0d3t+BR6gQ+7hXLZ9eJkrRQtXpQxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519645341; bh=ojh57t6tJ89Do0vfRL44MnigDz
    hHH0hsA7rQEWLBS6A=; b=w7VIM4C4z2UW3dVLne2C5ajfAj1fuw+CeJoSWSnx5B
    HIWNYN7Q5eAauTjh6pszaa95fdJcSSl6eIkNmWy7dpS0mcpgUtzo3FTFqBrZ3N2I
    CFG6QdRI/xhOtBm5Qv1wpN1bW4O3d8z8D5umdoYqfAPVnuXM9Iuwcfu5m3NIgOwn
    6tv9fVKnhBXqO+CTRPVqZn1ZnDyqJnKC6T0vma4aqA5vnMrT6K1aytFPvtE6ReOu
    267pV8kSxBG72LHMh3nGt/LfxP79OOirgg0aRRoWIYTP+TRFG73rE008r3VJjpLb
    7jF5LhXn1HGWKPyeiL8kBAJUENf4x+P8vqhu06isYb2A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeBZLmR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 06:42:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:23369 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeBZLmP (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 26 Feb 2018 06:42:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="33664723"
Date: Mon, 26 Feb 2018 13:42:11 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 09/12] usb: roles: Add Intel xHCI USB role switch
 driver
Message-ID: <20180226114211.GA25535@kuha.fi.intel.com>
References: <20180226090925.29436-1-hdegoede@redhat.com>
 <20180226090925.29436-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226090925.29436-10-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 10:09:22AM +0100, Hans de Goede wrote:
> Various Intel SoCs (Cherry Trail, Broxton and others) have an internal USB
> role switch for swiching the OTG USB data lines between the xHCI host
> controller and the dwc3 gadget controller.
> 
> Note on some Cherry Trail systems there is ACPI/AML code listening to
> edge interrupts on the id-pin (through an _AIE ACPI method) and switching
> the role between ROLE_HOST and ROLE_NONE based on the id-pin. Note it does
> not set the role to ROLE_DEVICE, because device-mode is usually not used
> under Windows.
> 
> The presence of AML code which modifies the cfg0 reg (on some systems)
> means that our read/write/modify of cfg0 may race with the AML code
> doing the same to avoid this we take the global ACPI lock while doing
> the read/write/modify.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks Hans!

-- 
heikki
