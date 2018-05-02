Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065540-1525280879-2-8412972191464242865
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525280879; b=BEfYp5G+54ugCEoRW4C2AdZtaw6WSVDa9rWyDFXIzRW3mfnFs2
    Q3md42o+Do1kgs4qUL6UCixvUYNxKvNRxnIceJlx2NhnWONYv6KQwSreAykNVhB8
    nYG4Jy+OaHSPc1NuFhYQgMic9kj+ZyRlu8GUamdWhtBzn2dB4UDhH18+VUHE3tNF
    gr9Pozh9wBVWeSfwdzeUMax/pK3t27zQORvfMiSKG8uCjB4q2ZqTQlJcRFMXNsAl
    gKD+0xba6vemTlGQgMx1SZrrQoIaWLKUmhg0H01GzpFbkRYcfd5NvJvoJ7wvQC9C
    ZFkgKVBVJxC4P/Z87NzhrL2AJmfVbhTI4C7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525280879; bh=LnKQcPw0pvKRgXQ53ojSrYxUs7APIL
    TOx44Z+hEyftY=; b=YMMWJemck1u0GXQdpfmig6CQoNtFQ9SRt0JxN/LtQsNb11
    mWn7BRJHC5mV+OYETdTvYldk8/BE/pd1HuDvtOn3F5xmTtY9uZ7+RXLSfxheOSNg
    wpgPJaZ43vqKZ6Rwg1fViw0BUO3YqYBgzOssPBHe3cWiurWHkp3thVB9UkMVQOLQ
    iM3RsLkGw/fJBqva90OqfD4hpDJPTfzGYUQCxH84yz/Jc6eaay2ggOGCtwd2BSJg
    xt3qQe+k97P+SCCVpx9oYfTLOYMZ3UudHGT904NoIyTKMogXYxSQVu625LVoLBvn
    21pKa7LE7Ao56uVl+UCPSv/nkqFwvGDkJ9SIlDyA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=lvcGbJX/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=lvcGbJX/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPVPOuxhTvRSSpSq4PpcCIZxXkFV4AmqxtJYSq14Wq5tDqSkSjKutOlzgpfk1CEgdUqZYmsPl9isU+2cvVRhxCa7Z6lim60yRuNQGwdkOAocfuUY5FVm
    8NzrkfMs9T6r+LM/wT+c8ag6d9V8548gGV9MRIn08ybj1WYDuOTRBS/kbZTzLRCBFqZIAUJIfJnJQ4AbE3LGaQs5P1clBlo75MLV4B1zGdWh2uVuKSyV/PVe
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=bFUnhJpB9Z3-8uSK8OwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeEBRHq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 13:07:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54204 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeEBRHk (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 13:07:40 -0400
X-Google-Smtp-Source: AB8JxZr5MbWec8rXix2DX9ErD9YjHshDXj+oCTo0qAV1y5MIyeRv6JG7YuElPTTQ1H5eeGf3dMy5JA==
Date: Wed, 2 May 2018 19:07:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
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
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 10/10] ARM: exynos: Remove support for Exynos5440
Message-ID: <20180502170734.dghbjq4evn2pzha2@kozik-lap>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-11-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-11-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:32:39PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/mach-exynos/Kconfig  | 12 ------------
>  arch/arm/mach-exynos/common.h |  8 --------
>  arch/arm/mach-exynos/exynos.c | 15 ++-------------
>  3 files changed, 2 insertions(+), 33 deletions(-)
> 

Applied.

Best regards,
Krzysztof

