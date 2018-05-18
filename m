Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3777917-1526640421-3-6096106549356368051
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526640420; b=g17Bi6Qqrwre2h8Za7376zp4oCNpShibXjeB0nW633NCnqZzDu
    o/YZL31lTQEqidSs8Ut+74F6raC9tM7TNSdEqufbhw7QQbReYdjyUyXXASa+SCUv
    /NSgWXTP0xm6Duz2N7ieeMEsD8dlcbJzKfP5UEC3ft9Wok95DD64e1AK0M4RrvBi
    R0i/xEhhID/hCG4JFzMRXc1iUCBaJ8buK5HsoQPjkwv8/iTkjwuf/qQJJpPIOMoE
    EipF6J4BPL4/kMTrc0nbkmEGgT7bVwZfzdHKj9byTqSY7QaF8/RhPHo8cfTBHCzK
    9rF4bE4K1XKu/3IJagZzxLS7mtkhl8dGlAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526640420; bh=SYPXGWiciqk3u8pt7e6EaYMmyRvMYE
    lvogWcvk6Tz3I=; b=ODbjQ10ghtB+k3yPJGnGBR/KM+K2WSS3dgWimppEUrOnUX
    8KlH1+pnvn9pIQlstDAuu8m7nMh4X5b+6JuXyv50fh7Dd6nj+YUm0DlHrd/TZ/la
    IYEaOjhDZwIyzqXx40MYSjXvhnOD7uDvoVfiu2jjXJL4MLWfpJ6+jYd7er35kjf+
    rVBTUKeCVv0N6g8uxcnUTeeCKx16M/H5Pb2luOxK3ULXggiDmTXcf/S7aabdB6rV
    ywVfwhHNZWXNjxCSc5YAHdBE4mdBt/uIQxWPuDFqf3o2obFRbBzxr4pTQGJ8LusH
    hPqa434avtKRSPuEcJBnKMp5YidmXtFma+B5qBeQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
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
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfCpPEcza6VrgmJaC3J7oHOuaLwa8rNHogExBeU/Yehgqe7cq04ZMqhdZVSS67kMa09QbroxATPEumoI+R172kgv2trKWkLwu6Caf4hMZdFBIayWWJQjP
    W0nl/6sZ/j4Du5VJ8htV1h98zNPzl/n6ZtG78pegmuJoaQxFFTCN/IMquhq//aScxHJk3US5hWoPGUWKB7iOP3oB7vCzxxZDCFOH1ScvNLPgMJGAY/M8SJJz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=EqdPLkY1AAAA:8 a=QyXUC8HyAAAA:8 a=DsIyA7KjvPr0w1rW4UUA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=dfeKg4RqpEhWThG6bP4-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeERKqp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 06:46:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:23957 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751304AbeERKqn (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 06:46:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="scan'208";a="41999892"
Date: Fri, 18 May 2018 13:46:38 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input
 clock
Message-ID: <20180518104638.GF15419@lahna.fi.intel.com>
References: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 11:38:27AM +0300, Jarkko Nikula wrote:
> Intel Cannon Lake PCH has much higher 216 MHz input clock to LPSS I2C
> than Sunrisepoint which uses 120 MHz. Preliminary information was that
> both share the same clock rate but actual silicon implements elevated
> rate for better support for 3.4 MHz high-speed I2C.
> 
> This incorrect input clock rate results too high I2C bus clock in case
> ACPI doesn't provide tuned I2C timing parameters since I2C host
> controller driver calculates them from input clock rate.
> 
> Fix this by using the correct rate. We still share the same 230 ns SDA
> hold time value than Sunrisepoint.
> 
> Cc: stable@vger.kernel.org
> Fixes: b418bbff36dd ("mfd: intel-lpss: Add Intel Cannonlake PCI IDs")
> Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Reported-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
