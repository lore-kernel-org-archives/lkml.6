Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481873-2-18298491756101955028
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481872; b=tMt0CHVsYuhA/MQhQP5YT2XZd5JVV2p3ov8TshPichjvhvWCWC
    nbpMusGHhD4Ll+ZUOOe0zemlyp8H1xjw5eidjZFp1ElTkY2AmsBWTge06Zu6dS7V
    NWsR5HfZGHxyjqbnG9KOxeXW6R/SuA9mkVNl8RhHQEuGpyyKksMmtDmoDth04W/H
    ahvo+grdqWji6jFs0+Aow3kH8MsqIjkGgp/dUDKKVm5qYtJ5FfgaRV3luAxdrfUG
    AI5MfsTXVrPbXoi08Rs2J34QZVlZeg7dsU5ktPcOg/0MsLnjYRdgjwCY5s/wuHqf
    DMgsKh76F2RfXwBYE3ONNMTUUZwSEDnzZoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481872; bh=iNa3zdYIRiFzmaY1d6ldTaGFv6AZOd
    mqJx5DatEmutE=; b=Wli1tlom9q5Bj24Vd98MeQyB9Inl1aJHJzLbXtTSQ7stv9
    lh7TpmHevDoxHwdN4HV4f4J5vYFmpb2SaMQHCHCxeiTaU/2xH2Q1PWDYrHLLP/Rn
    Kb/FqNKV3pPNTJwP3UPvxDF11MRk5nsP8sKdBhuab6gIWsi5+jpMBP/jtimlBMrX
    VNxDDvI1QXmDGKZHR41OfdMEnw9H7wkE2pOqLwhD8FF4HXKK6SrodgDUyIJQ+txA
    c0XQxXQxgy5ALJX1zXuQr/C0TuTOIbqVX+eYwJkihfS2kE6AkLWOjn/YM84G7d/e
    yPX8xiAsZmTtqwn4r/1HXrs0Jq/kkKYWW4NtCH/w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCgXbs7V0nBhOraoLYV2a7AWTe5yHnqTcusSYC2qBgcFawGzg2+xbMLnS8nybGE8gl8uI13EJYd9rZeM7jwmpEq3o1t6fPEWZGFgiBWg/ub15vfjKcJG
    beijKkwXwQ34d1mAvbVDl9sUw4+ZayPEK0zrSeeP4O8FDhmpiQqG4uAEu1nc41P59siCSTLzI3sbM9SyLg3sOOH4K2y18KCa5HkuQ6GRknm2VAxtPAdob++2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Byx-y9mGAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=MK96HyGrqPNBv2a_Q8EA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeDKSik (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:38:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754050AbeDKSii (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 024/121] usb: dwc3: keystone: check return value
Date: Wed, 11 Apr 2018 20:35:27 +0200
Message-Id: <20180411183457.598105588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 018047a1dba7636e1f7fdae2cc290a528991d648 ]

Function devm_clk_get() returns an ERR_PTR when it fails. However, in
function kdwc3_probe(), its return value is not checked, which may
result in a bad memory access bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-keystone.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -117,6 +117,10 @@ static int kdwc3_probe(struct platform_d
 	dev->dma_mask = &kdwc3_dma_mask;
 
 	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
+	if (IS_ERR(kdwc->clk)) {
+		dev_err(kdwc->dev, "unable to get usb clock\n");
+		return PTR_ERR(kdwc->clk);
+	}
 
 	error = clk_prepare_enable(kdwc->clk);
 	if (error < 0) {
