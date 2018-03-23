Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802620-2-16021390385367106708
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
    t=1521802619; b=p7+/2rHAFu/8kcH6S/SK8KBWA9+0do9s2QjvpszZXhQf882
    iB5kDdXWALnFomShFFCdqLsJlFeZWDvEiIU2DNRNiQbeSRL9znQopjqUfpQ7eAA9
    gUQPjGq44SafHf6kaoVB8/XFgyPYr9pyu21VDB7KHm0gAbSpurT/MPn/LbeoPALu
    RAlsKJWSxYiCm1y/OvV/iA+fdjLhTa9pWmz8KAmo2lNE10HoXqETzxS9Be2VXMYf
    Y7U8ciZiM4UMip5CvB+E8riNDiMq/wb0qyMrLHDbzCHq1iXwIyoIcDc3Lzv6LYbk
    obIctq8Jm8nK6e0WN/89UXrdz7XcvHbO6z2AkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802619; bh=5NGcNHgqoV/i8T5wGi98Lx90fr
    RJe0AMBbwfw8QQ8T0=; b=pvoS4Ef3kV7gpXXqX/UyBHB63MY8MxUAMThR7QcxBL
    YnoSUzUonoiEI9H4WXPV0j/nBZOPjdFE4hhNvzgdDRIPNFAV4MR8vSUGDzs22wlO
    TJLVL4L6T5NJJlAZltLwlO6BTVCDYntIs8Y/6Wi8msl9J8rZVB0F0U/ipsgB/K+r
    n8V8wwaSuYR7ywxIneQVWMChxe52rzCnZSVoQ/hl7F/i6+FkyETmc2ZXAoSuVkzl
    7bPPTlm4RdzeaGJcQOlEmAu9bn4dPDlIBMd4upDlROH+68DLsO5mt/1ZPyzlds5p
    keS+0bMclN4xCLcFZng6of/KBBlpOzQHcHEhcC5dRQNg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1752580AbeCWKND (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:13:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeCWKNB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 10/97] Input: ar1021_i2c - fix too long name in drivers device table
Date: Fri, 23 Mar 2018 10:53:57 +0100
Message-Id: <20180323094158.078104191@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
