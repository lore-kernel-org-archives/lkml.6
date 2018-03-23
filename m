Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802462-2-6095473477213289697
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
    t=1521802462; b=bMPuynu4FPy1XC7wG70vraP+VXLDBCqe3qTl0kciZxV2vX6
    ekLJJxw/009PoSvwFyeRWEBVFYdoB5W3EJFA6LC9c6kqwJZtFcGo4JodnaKHdmxh
    o0Qu8CddfsdKRGC8j8SVJk6L8Pw7I5i46dv0ig0/B0if0e4OMm2mlBVVeLW/B8f4
    hVHztj3ya7FSlnQDsmyYRLuFE1FYyynLBCKxh6iNK49DJog23wMlanpU1xemifMV
    BnuUPNQ/CJZCoGKYyTisbgqHTHoUJhmjJ/9NzeFccfRF4GnZlcQM9TSxHxJY/rCf
    7SCQcX1LJtHGCLTe6lafMNWZJUf4hB21iz9VCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802462; bh=jGyU++Z9lsLgAadIDx3GTThrYN
    lW1Yo9gRV6uhdFzJ4=; b=thv5wtAzEuiy6jPNHglOfa2pTM23NGLdAXVj5siSIJ
    faCitQHIxfkWluU+laGD8zjuJhuyb+0mSxbl0PgGyc9RYkRqX4oAfpEpHzzNIbeX
    /QfbuiyE8pj90eWuG5Hyn2FcdvhHQM84qisFDW/zVSEfMJykLUvZyIuX1Q+dTAK8
    uqq6VlQ0B6dDMVeMu0vtjz7Qb2THHgJhu02W+sIjksZOF6IS3secGTdB/StOm1iw
    xzl4KY6spoQ08s0yCaYP7e7KjC1DUXkCQU9iC0NreSbGpStMIlArwPmVFHxRvXLy
    0MNx5KMQ19DD7negdLMWyBeT8jl96Sy27E+XoW7rJrjg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1755890AbeCWKNf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:13:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755860AbeCWKNd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:33 -0400
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
Subject: [PATCH 4.4 07/97] regulator: anatop: set default voltage selector for pcie
Date: Fri, 23 Mar 2018 10:53:54 +0100
Message-Id: <20180323094157.939739673@linuxfoundation.org>
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
