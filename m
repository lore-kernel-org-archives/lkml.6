Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479143-2-6007480146338790373
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479143; b=aLTaKI4wyus0MaQZv4FGfa9q/YaFYSN20ejtpv6f1h4LVsdVR2
    DS31JhoukgQKvi5vZwPCW5eU3Evb0KZMnqaoZ91COBPnU8pAsh7/q8O7V3em1jg0
    eE3V5H+G93j6KLsPiCmc65uRxRmlOZrfHre98U+q9kzWDe0gNaF74ibuV8NyQShN
    if9HXFxh5T4lzEgL0lQtAhGd3fqhLhYL9Ols2dBV8ezRBfsckBVmnlPcORQWcGQI
    LxHysC3z8CGUDQr7J3ERTN4yQ5PEhkbdtM7qskrrckqARYutIb1B2AC+1sthvPZY
    hcUHQph4O8NLLPOANQBz2dAEfcmvmjQoJCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479143; bh=SuxCtDZbRNvcETP/OXAbQmlNMPs4Wc
    0oZVQn/oQVP9E=; b=pYMxKbCwiF3enioqbtew1s+KCNs4WzLHkPI4UOMyzEVyrg
    R02S/ZcbYgMcZ9UFtV0RbHrUeYseK0jD9vqmXAFuZ29o0qYLnYjnH/rsa4zEKRfG
    SfsJWM5jiwThi6JGYYMzpHQ/G2Ko3LEBhRBWQ4wNeoaX5pFFQLcvGwpm0T6LnFH5
    88cFh3oXJV7YenkJG4jpeZ6Ul03Juzfa8Cmt3eIqlVCjx8BcRWv60rp/ueVNwpHf
    Enn8RePw96aSKdvmf5wFNeb/VBCLK5r6d57q4ex0xYLRGqn54FoXY/FI1yQwOw/H
    UBLczyq5V1g0gMApXVUjrK3bkWCqfNvPsCK1Ldxw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNL1W7xiESfAOIye3H4VNY9fZ3TOYgdAR1WoX4NOqKuFA098ErNdrq4LWacWNqwxF/p8fUs9ZGmU8IrD0axIvsYbBX7lzVXS4pDZh3wlbq5IVw/CXV5y
    R4a8IPF8CzUYl86yUzsX+gvZJCwnhNP9LdLYOMCLpdD5CIMlWPmjLGUOorUMYn2kPsZyI0ZKxfJ51K0SOJmTh3T1vtWLqjFw8AE+5fJHNv01xP21SEyLcxFP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=jp4aXL4lJfE8QpMu4FcA:9
    a=QEXdDO2ut3YA:10 a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbeDKUip (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:38:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59588 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932386AbeDKSsM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan ODonoghue <pure.logic@nexus-software.ie>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 108/190] clk: Fix __set_clk_rates error print-string
Date: Wed, 11 Apr 2018 20:35:54 +0200
Message-Id: <20180411183556.983347971@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>


[ Upstream commit ee177c5d6369f8e5d3e4793dce501cf4431313a1 ]

When failing to set a clock the printout emitted is incorrect.
"u32 rate" is formatted as %d and should be %u whereas "unsigned long
clk_set_rate()" is formatted as %ld and should be %lu as per
Documentation/printk-formats.txt.

Fixes: 2885c3b2a3da ("clk: Show correct information when fail to set clock rate")
Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-conf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -106,7 +106,7 @@ static int __set_clk_rates(struct device
 
 			rc = clk_set_rate(clk, rate);
 			if (rc < 0)
-				pr_err("clk: couldn't set %s clk rate to %d (%d), current rate: %ld\n",
+				pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n",
 				       __clk_get_name(clk), rate, rc,
 				       clk_get_rate(clk));
 			clk_put(clk);
