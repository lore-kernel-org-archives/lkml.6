Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2126129-1523980830-2-4021086450420316076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523980828; b=UsecQ7SrD/d1B17Gkw0LJRAqT3Yotyn8JXxP5IkXq+tbUUQW/4
    C2wVkLbUFg4l2BRFRJCjoxNTzd7O5DOEbIJ/EvIahj7bp+adjTFFMVOiKjt3Kyxb
    joDpBsU2pU6QiCnekRE7MVGnHPaQ4slppB4P757jyrUGQF0u8Q60eyTh6FaTfIcH
    zFdLLA7EuGAT/1qtty4cXqCiPsRkCKVh1evdmjirKXpI327oaYJORUTr7a4DGLsi
    1NiEiGZW14Z3Z2lG72xDahn8DisLgDOeyQZYJHX/2JK5Xt2SGDKgAunfXt6pVc4+
    oOhe8vxO8YpfD8n/YnP4rnIZ5CumaVumYabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523980828; bh=VAeNIQImamcwSSxQwUl6zdvkvxYBys
    r8zg3hf4I4elk=; b=EDhXFwH17owFvQEy3DteNh5ekslYBKAc2yWLzg1jCguoeV
    VQnxpHaa/ajNJlhwvw4HOINCRX/qegaYkCuGTbQxLOPzPjECeEFEYpjsBXzeokZl
    nE8fyLf+ZGkV37qm1GD6UYv5pStK5TsnZ4i6tS5fmjbZy1OBktTlIyH/hCaT6X/n
    S+dJZyK1LMO3Kb1/ruREbuGQXCyLwNuxzIQdgokx5TUzmAoKvWGYyMA4byY/24vo
    xDnOraB8mNCGrBRCcHW6Ae9f1YubyD2d33uOClEMLsRoFuKT9MMAiIhcx+tA1QtW
    u6P0S6pD8j3JuiIdTvi9k7PXGq5ROwy4R363SqKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfONnE8ZXeL3XuasSq5wT8Rrb+PV0h94EUKMtSne1Xt2Zdnoyq3sWB+/VYw+5770SH0SpVGKCLdWhHlsi+BELYNCOuhSKjXJ1tECA7E4HYP8lTillYaNM
    3MIfKmmj1R2jmvg6WtjABYij3Jt/HcY2/33ZW75Mop3xZngkIus+e98EcEuKqLu2WKDsVZA9XAiTacOL6Wx4yjFmRxdTnoKoq8bfIbqdtDMT2y/KFl0HEBpC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=u2zLLAFrw9WH8eSvI3wA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeDQQAY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:00:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbeDQQAV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:00:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.16 17/68] iwlwifi: add a bunch of new 9000 PCI IDs
Date: Tue, 17 Apr 2018 17:57:30 +0200
Message-Id: <20180417155750.035083803@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Coelho <luciano.coelho@intel.com>

commit 9e5053ad9d590e095829a8bb07adbbdbd893f0f9 upstream.

A lot of new PCI IDs were added for the 9000 series.  Add them to the
list of supported PCI IDs.

Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  157 +++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -8,6 +8,7 @@
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
+ * Copyright(c) 2018        Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -36,6 +37,7 @@
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * All rights reserved.
  * Copyright(c) 2017 Intel Deutschland GmbH
+ * Copyright(c) 2018        Intel Corporation
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions
@@ -517,9 +519,9 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8265_2ac_cfg)},
 
 /* 9000 Series */
-	{IWL_PCI_DEVICE(0x2526, 0x0000, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0014, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x0018, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0030, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0034, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0038, iwl9560_2ac_cfg)},
@@ -544,11 +546,15 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x2526, 0x1410, iwl9270_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x1420, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x1610, iwl9270_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x4010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4030, iwl9560_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x4034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x40A4, iwl9460_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0xA014, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x4234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0xA014, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0010, iwl9160_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0014, iwl9160_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0210, iwl9160_2ac_cfg)},
@@ -569,16 +575,42 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x2720, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x02A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2720, 0x1010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2720, 0x1030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2720, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2720, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2720, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x4030, iwl9560_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2720, 0x4034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2720, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2720, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0038, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x003C, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x0060, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x00A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x00A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0230, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0238, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x023C, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x0260, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x02A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x30DC, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x2034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x4030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x4034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x42A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x31DC, 0x0030, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x0034, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x0038, iwl9560_2ac_cfg_shared_clk)},
@@ -595,12 +627,94 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x31DC, 0x0264, iwl9461_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x02A0, iwl9462_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x02A4, iwl9462_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x1010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x31DC, 0x1030, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x31DC, 0x2030, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x2034, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x4030, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x4034, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x40A4, iwl9462_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x4234, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x42A4, iwl9462_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0038, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x003C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0060, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0064, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x00A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x00A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0230, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0238, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x023C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0260, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0264, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x02A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x34F0, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x1010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x34F0, 0x1030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x34F0, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x2034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x4030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x4034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0038, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x003C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0060, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0064, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x00A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x00A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0230, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0238, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x023C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0260, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0264, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x02A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x1010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x1030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x2034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x4030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x4034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0038, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x003C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0060, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0064, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x00A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x00A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0230, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0238, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x023C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0260, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0264, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x02A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x1010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x43F0, 0x1030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x43F0, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x2034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x4030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x4034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x42A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0000, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0010, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0030, iwl9560_2ac_cfg_soc)},
@@ -626,11 +740,44 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x9DF0, 0x0610, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0710, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0A10, iwl9460_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x1010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x1030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x1210, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x2010, iwl9460_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x2A10, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x4030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x4034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0038, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x003C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0060, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0064, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x00A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x00A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0230, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0238, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x023C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0260, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0264, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x02A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x1010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x1030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x2034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x4030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x4034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x42A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x0030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x0034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x0038, iwl9560_2ac_cfg_soc)},
@@ -647,10 +794,16 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0xA370, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x02A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA370, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0xA370, 0x1030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA370, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0xA370, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA370, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x4030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x4034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA370, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA370, 0x42A4, iwl9462_2ac_cfg_soc)},
 
 /* 22000 Series */
 	{IWL_PCI_DEVICE(0x2720, 0x0A10, iwl22000_2ac_cfg_hr_cdb)},
