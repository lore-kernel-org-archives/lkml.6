Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1923654-1525743635-2-5141426862758753984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525743634; b=QTUEknmDxaql3suEkbtqFAPK1fhUWmx+UUkE9nIchK0UQSkKGe
    JfWu1GWX9yJ3UnRVtNxRf+moyw9kjbAm89tFdqIeM9qZ1ep6d6Z2ao4HnCLRtvUI
    m25yhP8AymSD4TvG4JXDs9ts7yiTxoLpVTeVkXAMQWUPmxOIgvDHpko8MuctQPnB
    AU3qu3WWsI6HVhqzfbEkfoGAUu8JGIE6JtFvaI++wbYiV3ZHMx8JWwrO6avfBq6K
    4j+WAB4wtkar2xgOIC32xCDIfe5QJrosuiqXt93lHhe0KBTCyXAMAS6dHkqNjTTE
    3ODwY/3RzzXeACoCe83pN2tx26sqbAS7fjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525743634; bh=s1W8Y+6vGJQ
    C9I2SmQQM9z77wW2t0N7/xZ5dSyUNyLU=; b=P/WLhGlE4UidLT0kdIy0UcE5Yau
    zx7N6AbPFK9/M2+Hbntx2HDI8gPcewIsEx4l7/NODxiLAHGMVNvUVqR7Eh3iM15u
    mltw1uC/t8q5MRMhXjj/ovjyU1xLIlv5kMoHdmAYqTC7cWWK9rvuxVKK7zt1wxV3
    wB+Xd2tBx0aRwqlCSvuYd0ioR69dVneZBJ+KuFpQA11RS82s2NAyrDCx/6pRtbFw
    2+TcynlaDBz0XQ2vGU0X4l/a4DFQ4TYOIin0bmx4OV+bJWQXw2816wjfA188t9EI
    rXxx+0/05AyUGrvI8raHDXKijKMerPjbO+lsqDVZnKKjPdY3vZ3CH+RvtDQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=LEITvzZv x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=PXVvjs48;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=LEITvzZv x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=PXVvjs48;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfyrkaUlLsYWR+Upezy8swaTrlNBZv5/TdEWHJnek9N2TVvSE4l+pyKuC0DLd6KX50OgGN5tNY3kiLGgrLw0Xgk6iNZ8MNW3FUgsPcCxViSPN+lI9Q6
    WymGarOVoUu2Z3iZx4UYLDUPhy3hqujAuFU89gCXXXtmL5HWnSL5EyjyysvcK2dPd9gtmo9oXq1uefkBT36NfRBDEighUPON5pJksYsTSrbCfevf7LbsXiHK
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=IpJZQVW2AAAA:8 a=KKAkSRfTAAAA:8 a=3j4BkbkPAAAA:8 a=JqEG_dyiAAAA:8
    a=VwQbUJbxAAAA:8 a=vtUdqKPz224mM0aF0qsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=IawgGOuG5U0WyFbmm1f5:22 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeEHBkb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 21:40:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33202 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeEHBka (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 21:40:30 -0400
X-Google-Smtp-Source: AB8JxZr+yRK/ESW6k+omCu0iSlC77JM/VYn23Oijdu+u7krl1HlTRQvHfGWn02EIPrr5kgOTkLH/6Q==
Date: Tue, 8 May 2018 03:40:24 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 1/3] clocksource: timer-ti-dm: remove the early
 platform driver registration
Message-ID: <20180508014024.GE19313@mai>
References: <20180504132731.14574-1-brgl@bgdev.pl>
 <20180504132731.14574-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180504132731.14574-2-brgl@bgdev.pl>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 03:27:29PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This driver is no longer used as an early platform driver. Remove the
> registration macro.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
