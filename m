Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-999974-1521800282-2-15979848199458881553
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
    t=1521800281; b=PyDYy7peydIsU4CGEDBsovQhpzaBIM7Xe7DpSUNNVXLiw7u
    qpglbklahY16xZVE6UiDUuJE+7MhLsmitG8l+1KZHfrEVTe+80mRCAQfpd6xD4mV
    TazkaiCQTdIhbM/rU4lXcf+fwHBXtaVB4nf05n5uBq5zJyfvbXIigB0N5TLB/QHa
    ewhn0qB3BHdIj+HLZtFHxutWyCPGQtLtCP4WYmiMX3AAC2EV6PYN1ivKL5IdlVc5
    wY3O4EuVyN+k5obk57nAgq7L/U+wKSRd3LCOB973DwGwd/oNTMnNJVnOuoqFPllv
    LOH2Zk7tz8PsXXtFnjtczsqqvwi81x0stGqPMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521800281; bh=nd2QZsQl0hsGW9UNMHcC73EYoN
    90dIT4F4wd+3stby8=; b=u5OC9iSC+4EjIqr82RcVk0EP/pjEZuyByTwP6NLWkg
    P0KPQw20sXLO9e6CTpAzntHOs8nJkdd71HhgkdToLTsn9hvdcF7DyTL+6zYz4KOq
    lQqqU1fJh7EUWVsxHTcLU+GMJckUEeYQ+G8HHp50uk1+QZLlnEWK2k1YXeMXeeN2
    0fSfNVDXso/H5EE7srhWjshzYqnF9ejWkAHzDuB/LpoAZPoPDfcfRHvpx+VxN8GP
    S7OY6wZyliwVH2lHhG4ek485Zlumne+cSaad3XORWnwMKi+3UfwsHP83BXGgKv+N
    ND8qefUd6H9UfZBF4lykRzRmZwgwrXhFURaGauJQe5rQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S933614AbeCWKR5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:17:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933864AbeCWKRz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:17:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 03/47] Input: ar1021_i2c - fix too long name in drivers device table
Date: Fri, 23 Mar 2018 10:54:54 +0100
Message-Id: <20180323094248.263728113@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>


[ Upstream commit 95123fc43560d6f4a60e74f72836e63cd8848f76 ]

The name field in structure i2c_device_id is 20 characters, and we expect
it to be NULL-terminated, however we are trying to stuff it with 21 bytes
and thus NULL-terminator is lost. This causes issues when one creates
device with name "MICROCHIP_AR1021_I2C" as i2c core cuts off the last "C",
and automatic module loading by alias does not work as result.

The -I2C suffix in the device name is superfluous, we know what bus we are
dealing with, so let's drop it. Also, no other driver uses capitals, and
the manufacturer name is normally not included, except in very rare cases
of incompatible name collisions.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116211
Fixes: dd4cae8bf166 ("Input: Add Microchip AR1021 i2c touchscreen")
Reviewed-By: Christian Gmeiner <christian.gmeiner@gmail.com>
Tested-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/ar1021_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -152,7 +152,7 @@ static int __maybe_unused ar1021_i2c_res
 static SIMPLE_DEV_PM_OPS(ar1021_i2c_pm, ar1021_i2c_suspend, ar1021_i2c_resume);
 
 static const struct i2c_device_id ar1021_i2c_id[] = {
-	{ "MICROCHIP_AR1021_I2C", 0 },
+	{ "ar1021", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);
