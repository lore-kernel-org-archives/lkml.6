Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806809-2-3388349617208375768
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
    t=1521806809; b=rkaAOTG0YI5K04bS0ozBtj8ua26CwZ4ANFw+WjtUFZW/Tmc
    DCZ+TXuOufAKBSfK7W59S29bSvTicjvbqbF63F9M+lXR8dOxeVVyVFuNa97Yw1sO
    B8iEFTJF6aibQaoSh2ZkzkBJxo1EOKQul9QbBwPfQbbez3wjs9Ca+oI9Er0yzR4e
    R+BxwDTXWA86vy4hrlztMqj3SLy6MNf0D2yGbaxZfbvy2EuTRYThv8mdK8WoToIh
    hL1esZ8yGf7czXER6k1HJs7uCEQARIBMTso/2XxSLuFEPnp6ekOwEM63V1VBD/WF
    n8k3KzJvx70crovJsmxIpGAIsoe2btb8Nbxm2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806809; bh=aWrx5zDBoS4cssS6OvM/UhFEOa
    QO31kP/iD+nlM8vrY=; b=WSZuH5EvCpqq3taa0gCDEv9HbjZxUMiF/zEjRYk+GH
    g/C4GQ6/QTNUQUplnXSMjnqAc+KDhjgdtEiYAwka3/C3zpEXv+sG/f7YFL2D6Ty+
    4cUQ+SQEuXw4mQ/OanuqZ5AzyRu63bcw2y/z6tk81C6x3ijit3bnwoCuNqHJZHgU
    pGDzVC/t6KzabGcLaoHCVx51fwrgkNkieBwV0w0VC/KDjTJSXQ7Ok1NVrzpxZ4Oz
    +nSCZ04BmQOiCc8GIh7ILueIMKe0tdaWeVWsLtE8SaB8SBk4f0uytpjIW/1EcgzT
    jhlbSimrbpE6l5xRM8bym92d5H4a74O14nixxEypH5dQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeCWJ66 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:58:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeCWJ64 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 55/84] clk: check ops pointer on clock register
Date: Fri, 23 Mar 2018 10:54:09 +0100
Message-Id: <20180323095420.275785299@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>


[ Upstream commit 29fd2a34ef8d863e48183bd473ba57c8d7839e25 ]

Nothing really prevents a provider from (trying to) register a clock
without providing the clock ops structure.

We do check the individual fields before using them, but not the
structure pointer itself. This may have the usual nasty consequences when
the pointer is dereferenced, most likely when checking one the field
during the initialization.

This is fixed by returning an error on clock register if the ops pointer
is NULL.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Link: lkml.kernel.org/r/20171219083329.24746-1-jbrunet@baylibre.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2684,7 +2684,13 @@ struct clk *clk_register(struct device *
 		ret = -ENOMEM;
 		goto fail_name;
 	}
+
+	if (WARN_ON(!hw->init->ops)) {
+		ret = -EINVAL;
+		goto fail_ops;
+	}
 	core->ops = hw->init->ops;
+
 	if (dev && pm_runtime_enabled(dev))
 		core->dev = dev;
 	if (dev && dev->driver)
@@ -2746,6 +2752,7 @@ fail_parent_names_copy:
 		kfree_const(core->parent_names[i]);
 	kfree(core->parent_names);
 fail_parent_names:
+fail_ops:
 	kfree_const(core->name);
 fail_name:
 	kfree(core);
