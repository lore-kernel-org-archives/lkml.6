Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805011-2-5187973270819079096
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805010; b=Pk4XlQDJhnLg0Y1zv2ZWzcioSnZQ/q5j+1lTPlyTEVTcx5G
    7ybF0reevKgBlrjxrnW/GjhiuxP6X5pEoGb/NM7XF25JrkvUb6YphtDN7Tg/9Y7F
    4a9pVaR+YQ8E1xtK60VEwSxTuxFUAkeW67YJbVC18F6qoN703ZOz0g8jl+mGrJzc
    Cgi0QYIeaXVzO0VUXhJZClQdiixhmHxRU9/UjTpwcDMzF6eCywblKtmwAfOnuUqB
    gmhHcgamb2qjOJm5QV3qgwD8tMREG7bXYf4j1RSGJIaH0uKtc2TmQ7phzmNtc7sN
    LaeKYbQHk/VPOci9Z+AXkBAsra2ZFWyWi0sya2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805010; bh=tSDVMkVVfPsIm5zBNXMfP1r4G8
    9fdgd16OLNGTgsU/M=; b=hS6Zrz2kf+xFv0dcAXHyocLUxOs782JHNkNy9YjtHX
    zcNp2AVXUFGZ4crBdWyyTJblQGjDsE6cQxnlUY+vqGjxsHaeIuxgsV8zXOn4zcAe
    OVPZlPIQ81Xc2gnBDvEId7GXpi2YGMGcvuUOCSRyTwF5IrwDHEpoAbwlbqT9HyFc
    z1KtvGt2CjtTu8KHGf3D1MXp6lF3963sxoo90ifpdamWuxbqyb7xP/DQADbrK8Q8
    DyZ2Ht8m8oQOW5ks/oYqb2X4iOK1YXI6BvntVa35L2DfaM4RGXcidOoUMdFcB8or
    aLeRL9526P8ydtZcN8ZD0GtEeVGcpHYzzBtfBgSTah0w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeCWLgb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:36:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754876AbeCWKFG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-acpi@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 016/177] ACPI/processor: Fix error handling in __acpi_processor_start()
Date: Fri, 23 Mar 2018 10:52:24 +0100
Message-Id: <20180323094205.916261639@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>


[ Upstream commit a5cbdf693a60d5b86d4d21dfedd90f17754eb273 ]

When acpi_install_notify_handler() fails the cooling device stays
registered and the sysfs files created via acpi_pss_perf_init() are
leaked and the function returns success.

Undo acpi_pss_perf_init() and return a proper error code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-acpi@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/20170412201042.695499645@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/processor_driver.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -251,6 +251,9 @@ static int __acpi_processor_start(struct
 	if (ACPI_SUCCESS(status))
 		return 0;
 
+	result = -ENODEV;
+	acpi_pss_perf_exit(pr, device);
+
 err_power_exit:
 	acpi_processor_power_exit(pr);
 	return result;
