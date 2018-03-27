Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-601012-1522188131-2-17265993359941720132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='comi', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522188131; b=Jxo0NVL3L+OCwFIKnxdMMr5os/TNnhiIf+VrKFqF3Z1rMqQ
    t/PkcRSL7pSnrCH1DTDZ+dg/HJHmUFkXo/hU2ECmYOqcYWERmrSxS3QKdjuZ1OTw
    LOYZ1NDKVkPD3igqob9owKUtMUyQrcGQQK2KFqrI+scigKEdl2qdQd2lQ8pBk1Q9
    i9iNmRaX6XDA2+RiPEH9q8etsOBKes7uVrO8HK1+uXI8e6WVzw/+KDoLqdFIK9Ca
    zjeruutvI4vU+n7blgMuflVuTwzZIWGiXBH6MwZJWCZeCDJxco1ztps6enic10vk
    wiSUIzgvjb12EXbuyuGsQ4/dDeso+fo2qGAhTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=arctest; t=
    1522188131; bh=wJDP5a0aY7Dw5MoFKJeDtXf3PlpXbjjcjD+u0hPaMlk=; b=g
    sTU8gQnabHrbJA9ZhTykiOj5wSgevQKeJ+/rV+yXVabJrhOdnH0/0SmVlZsOTUAf
    /CPV2r9YMcnv0P0Go4+6bLucNOm8TQq0W5AbjqrfcQO0xrtaRjFE4eOmJYkkABP4
    r6LH1TiUDOw4zmgsPc5Z6tD/33yspN0P/YjNcvn+1XYXue9tFLYapzEg7CSLP0m2
    mtuZfgvO9D4jujNCFhQ6tybuOSt1V5FEupKhEI9/+q4IjTfZZK+JJKQgOuVsTUGv
    DiW2ui0+66+R+KavSi32K9p1h9kXhS35++MZBUufp6YjDfA9e1dwTTSPVcKynFIy
    6DQybF5xtdrWxRBVn8iAw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=permerror (from header invalid) header.from=linuxonhyperv.comi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.comi header.mx.error=NXDOMAIN header.a.error=NXDOMAIN header.aaaa.error=NXDOMAIN header.result=fail header_org.domain=comi header_org.mx.error=NXDOMAIN header_org.a.error=NXDOMAIN header_org.aaaa.error=NXDOMAIN header_org.result=fail header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=permerror (from header invalid) header.from=linuxonhyperv.comi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.comi header.mx.error=NXDOMAIN header.a.error=NXDOMAIN header.aaaa.error=NXDOMAIN header.result=fail header_org.domain=comi header_org.mx.error=NXDOMAIN header_org.a.error=NXDOMAIN header_org.aaaa.error=NXDOMAIN header_org.result=fail header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFITznaYM6Ja+5+sx5jYhWbZebTp5oCvdo8QCaBMMVsuGd85r3m2IZ5JlHk2eGa4lPu+jOC90dkMGSoVd2vtPAPLtj64raRkPCQG8qTfedhe3D8lTQG7
    lgiG19AoMFPnuVsyj3SUaEIBLqe2oL1v2ATJDQhd+9P57q6W9wdml6CQgWDEyCSQ9XrqquvYd3ULpHKFh6nn1xLC+5ei+zdE9FgTueOcDd2MppL2XepGuMof
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=v2DPQv5-lfwA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=GkTYVVm25eQ9X94RZzEA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeC0WCI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 18:02:08 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:51174
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751874AbeC0WCH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 18:02:07 -0400
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.comi
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        leann.ogasawara@canonical.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com
Cc: Dexuan Cui <decui@microsoft.com>, stable@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/4] Drivers: hv: vmbus: do not mark HV_PCIE as perf_device
Date: Tue, 27 Mar 2018 15:01:02 -0700
Message-Id: <20180327220104.19700-2-kys@linuxonhyperv.comi>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180327220104.19700-1-kys@linuxonhyperv.comi>
References: <20180327215859.19624-1-kys@linuxonhyperv.com>
 <20180327220104.19700-1-kys@linuxonhyperv.comi>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfABmXR7Rk+vCv4NXGkmCKpUssJxtEkQ0Yoc7ijs4GTxJUbbd3qbXoBelXaMZqadpCX3eqgtNIDb6XUqZyPpBe3Q3+q78/oMciN8lUi97ij+42Um8MF22
 Xe5k5lWBGpNPmf2a3uul7DbcEBhrOuG2rPNHM/v3f3ZhBVDD7qlkeUIp73J8wJKmqWxV3J5tnlWGu4u63vl3/ybFPf38FdbGALWdrO0+N6Y7Vtk390d/YrNZ
 guWfQ5N9sifwhHpFAYUg32/djc9sAfFocFY0KSP5FR72VB3j7GMm2iVQl5C6QYyLwhQuG3pS8vS/PCCQL/ddB1F6+eLwCy92cjx7NuqHuKhHs4/F3RcUs9wK
 u2I7ihG840mpgH+uNCI8vfvP/PcbQHn7Khd87qfp4TtHIDJ7Sj1MZ5yI/IyCKHtkKdsnVueYc5FpoBb1z+AMPdzbqceOCRNdN6LHlZAGOq8MOBw/X9HFEsHn
 2AY+VKerxELzRuZmBcGdKmm18XY9BluGjDnEGzvOq0/zDzxrG82f35wqu2aw7WtVrx63HwK9IknXXeYjEQpK2OqNZ2q6abkQ5JI6cmWCcq1qvg1q8aWkvzYP
 4BfpYcANdz6GE6s7KRCUmgqRmRcU8JY3GGA8HnDptT+qVA==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dexuan Cui <decui@microsoft.com>

The pci-hyperv driver's channel callback hv_pci_onchannelcallback() is not
really a hot path, so we don't need to mark it as a perf_device, meaning
with this patch all HV_PCIE channels' target_cpu will be CPU0.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c6d9d19bc04e..ecc2bd275a73 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -71,7 +71,7 @@ static const struct vmbus_device vmbus_devs[] = {
 	/* PCIE */
 	{ .dev_type = HV_PCIE,
 	  HV_PCIE_GUID,
-	  .perf_device = true,
+	  .perf_device = false,
 	},
 
 	/* Synthetic Frame Buffer */
-- 
2.15.1
