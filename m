Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1794019-1519876050-2-3732669799804805934
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519876050; b=wNi+j8zF3h+xFNGDriPVqP2frKZMKl6gtir7s2K481vyKFc
    X6Ni8azW7i/Xk6B86WT48eHLeYDqFJRP73F1rfbSD+5v+oRmEVGcg5d56ZqzUJ5Z
    0mD2WXJbSxswIOTfTAFC6nSQefL6pgr5hILJ/kruQ9AWMhgi/DSqEHGyAnQi5QOk
    8yNt4LNsabh4EGMFIXJLAsFZ51IS420bjycgiZu5Mvs3aA/e5lfjFerD1e3f9Wfm
    N4gJqv5WowiFH0A4sA6gEzP9nLITq4QLwUyvFTPHIIhPm69nBtyhenbZrFqGo/aj
    js/GoSKNZIWTbALQ3mpz5M/1t8VAnGSX4RKAebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519876050; bh=beVNTUlAxRv1jwSMfJGxUZgtX7
    pu5PrihJRZLG0ZcaA=; b=hOIgl8rQCqT4YdbktCBIs7OCXvHzhsDN/3X2n93zq+
    Sh92HyxjvLG6EHgWw2NVWtDgBXqMKlmhhaq4Kj48QhYArz+YI/sRmjg7xXmMI7VP
    BDNa7KYNKoFGg7bN7rVEb2e7vF85JzFuyV6PveI4Gd5wDqhLwr3GWMt3BcB6U2ug
    E98wrTWRLczheujBU2kspJkixCv1td8gFmFytW08dxw3/dV+DxkD8TncYmzaXpTr
    cUTT0mf3pPdPenXIP6kFd/x5Gd9tts7ibRReqjus2qp/BWfJ8P1jngxjik6a2TNW
    b4UTCpxmBnKIL5aeOb5uF8+hjLty9kG4qKrJWBICUA3A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965765AbeCADrR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 22:47:17 -0500
Received: from muru.com ([72.249.23.125]:58942 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965759AbeCADrQ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 28 Feb 2018 22:47:16 -0500
Date: Wed, 28 Feb 2018 19:47:13 -0800
From: Tony Lindgren <tony@atomide.com>
To: kbuild test robot <lkp@intel.com>
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
Message-ID: <20180301034713.GD62820@atomide.com>
References: <20180217210723.7013-1-tony@atomide.com>
 <201802191503.yJma6SYG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201802191503.yJma6SYG%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* kbuild test robot <lkp@intel.com> [180219 07:47]:
>  > 354		if (reset_gpio >= 0)
>    355			gpiod_set_value_cansleep(reset_gpio, 1);

Thanks this test can be just dropped. Will send out an updated
version shortly.

Regards,

Tony
