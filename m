Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804906-2-17155143208519286782
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804905; b=M5NeTcrchLdqeGQyT60ti3f8YLBgaYZ/WxiNGQObAVHB7vk
    utvsKUzcj2eBlNMwGFZYd3tqN3cQmxZqgRkaAiGsGDBE9vNjLRJOYAg0fOix347u
    fchsO4VmcCwob9sFvQCWPazOtmfZUmqOn6VXD0KGycZrN5fps+Yz3TAncDbNhX7M
    +gtj9M/Z142Fe56Tc18CBU30OOUud3CC1vKEjCh9Qq5/Pr98b5AQsXzLNnbbcRiJ
    KpGudd8V1aRJIydpGROnP/cRtW+spwEW5gN4yWQs8fNc2ZbYmIeffpbZpAFucywf
    TLWSUGRvCs4n3gVotLZsHcRmK+SzpdxiBFuk9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804905; bh=MQd06Cvuv7BFQMQn3q7iZIiYu5
    6x2ZvypOc94HMKfjM=; b=lAgodsIo3s2z9D4Q3EyHP6haC3M7PNT+dAnMWtOP5K
    Lupdu52Ju5pEjCAGYophFAaMIU6OXZbM7NXD6CzD0kHo+A+WY98HbL/FnLUb2fVj
    tpUWbEhXJGFW75FFMExP5Q70kkc2j3AwRSAcZ9MqWnUVPpJrfs/7Z+vSjp3MQ4WE
    /Nq5DaQqwiffanU6xJ5hWizk7uv1d9vm4QLlDOZjbNcK9MtdGt4UEj8dvO32TzVC
    rtq64rb53EVKzlascriRE3D7OTrDuP89kxZUc9G8k6kb+z1Huqn2A6VwcQZWrgLG
    SaUIt5uczhFypv6DwnGrur1v27ewuYl0XPSVwEGzXBBA==
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
        id S1754937AbeCWKFT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39588 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754917AbeCWKFR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 010/177] regulator: anatop: set default voltage selector for pcie
Date: Fri, 23 Mar 2018 10:52:18 +0100
Message-Id: <20180323094205.668662461@linuxfoundation.org>
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

From: Dong Aisheng <aisheng.dong@nxp.com>


[ Upstream commit 9bf944548169f6153c3d3778cf983cb5db251a0e ]

Set the initial voltage selector for vddpcie in case it's disabled
by default.

This fixes the below warning:
20c8000.anatop:regulator-vddpcie: Failed to read a valid default voltage selector.
anatop_regulator: probe of 20c8000.anatop:regulator-vddpcie failed with error -22

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/anatop-regulator.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -296,6 +296,11 @@ static int anatop_regulator_probe(struct
 		if (!sreg->sel && !strcmp(sreg->name, "vddpu"))
 			sreg->sel = 22;
 
+		/* set the default voltage of the pcie phy to be 1.100v */
+		if (!sreg->sel && rdesc->name &&
+		    !strcmp(rdesc->name, "vddpcie"))
+			sreg->sel = 0x10;
+
 		if (!sreg->bypass && !sreg->sel) {
 			dev_err(&pdev->dev, "Failed to read a valid default voltage selector.\n");
 			return -EINVAL;
