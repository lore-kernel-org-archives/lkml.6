Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3245871-1525183702-2-3053827712865988177
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525183701; b=QQsYJVfPrNva914uWxUeJNjNDb+AQmErGCCbtroPEuAO+JzMY/
    TExLmYUsipWN/w8TKmhM9UVwcAh+dqaIYDPfyo4mMk45th4Tn1Z7eokvD2WhRIvb
    NFOcBHHxMAK0pDzJJgNM/zVmBtsxihvFIHkBru/dAxgEsc4sUEZtUjsJAi0aDBeS
    8Cyxyxljep6DIAFo8el/ztth+axr3K7I/F0lluUgS/avQ+unewJqkMIcPTWFd5K6
    mCnnQnpv6/tPAVHdJYbc5L2LD/TzGIrhzsPo+0+ta1oudt7E0z3QZsteTWFW9jJZ
    PD1iThZ9AI1jF8au1+5875oEe1Zv8vak5Axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525183701; bh=FIPoOpEyIY8sXAlRndYbMQy+YoazW1
    bh4/sW6o+e5Jo=; b=mo7C0aVz9y2SPQF0hWzQPBJjJOpZcs/UpbKb8Y3VH8ITSq
    SJHNANF6dxYpE1dDCl4+IIfsgcS2BqbNWidTO2ZiL3ko2FXEZesp7mNjAvJs1I5U
    DlYIBXYFS1qkEJMc7TYYDYS8gW+hbpnwktMMKU9MfRYzc7iMPV+9qBCeri+gHIvj
    I0hBb8ICKtP2omanQeiqmyYiIhT1ht4eeEsu0Q71nHToeIqNV/yOpHvLjEj+fyJX
    fCGz0ZlZHVAJip+5hfI7mwCsFq2SzsAEZeGU05Cs/3BaQixw6136Yj6yaB5zHvRn
    hRBI515i3W+qjsCX4F6vqHXKGUiA9t79IEq34p6g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Nw8qiTZe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Nw8qiTZe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFZcs+TCFdqbrr0f7ubhuxGhCNDh1BveLCDgS0U2wz3aPa7gFWfEeucSICv41pLkO9zUyScfrDtJgVOhfsIZ4D0R31M3Ey5houqjfoh2DEI2XeVseXzf
    ebOmyPNetj8qZtZep+uHzlNsSRP1Up0tkmSP52TXkNyJtU58/GIJmbFqErhMmoVOoU305JBDECNmgNBETUGHDzzQj4PECX4cQvYk0FJmyGqiwJO+2wU91Blk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=bFUnhJpB9Z3-8uSK8OwA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755876AbeEAOII (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 10:08:08 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39962 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755199AbeEAOID (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 10:08:03 -0400
X-Google-Smtp-Source: AB8JxZq2DQQ4HNwCQNjoMEwbPpo2dXi58yTnphfHNvL3LE9+zeBSDMDxMk4VzCvU5EKHFxi3DwJbsw==
Date: Tue, 1 May 2018 09:08:01 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 02/10] ata: ahci-platform: Remove support for Exynos5440
Message-ID: <20180501140801.GA27080@rob-hp-laptop>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:32:31PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 -
>  drivers/ata/ahci_platform.c                             | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
