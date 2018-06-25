Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACDFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A84B25548
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCEA80Vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A84B25548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeFYHry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:47:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35064 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeFYHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:47:52 -0400
Received: by mail-pf0-f195.google.com with SMTP id c22-v6so6079352pfi.2;
        Mon, 25 Jun 2018 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f4hcntd6PgzM0ED4wp0pnKQjnH1BulT92YS8BqUhI00=;
        b=sCEA80VzrHO9qVYaIAKyF3qVPb5asDYvu2QUZ87La0NNC7Fdcplj4IOChNVg3Sypg1
         lqaXvjHTbxy3wZpXlZFFN8o5rw5FPc4SrPDSKz9MVtQ/IL+ElnhhvVeejBuYnT3iQIws
         sRCynsWvpSFhJpXq0WBzw/bZJuVX+y9Crob9w7zyVPbrD7y3RcuYwxeQYXTHF+YpMu9q
         DDonCZblI4GbfVxth/+KaRWUFrHBW2saaHc7FpiwHlCKb7WFJqjXTJycjgSw3tBZvy22
         NpHHyA+gdf8PXlomwSI44SN14krO4v7A3UsVsqtR93OVaWQ/WDnCV+udfoOJLd7DwVWg
         F3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f4hcntd6PgzM0ED4wp0pnKQjnH1BulT92YS8BqUhI00=;
        b=BR06xIrG/UEC6m28wX7Kew+yPwDutGJ/GCLG7dO1cnn85diaQ6boEVNX+AL4/YpxNj
         iH2RlcUkVH2PP7vmnkbjhbFvAO0FDq5lMsfOxWPicA5rLKTQ6U8/jfkP6ScQRNAlUD/v
         Cu/bAqMf1rFJtbO1mjryyApCY36pGIZL1M5ymz9BcphMn6XNrZPNDDPxaC0A6IsRQd62
         +Nkg9hdXi7dc0snoCDl2p0sA6I7XFr/bjnOvyQVs463j8twSPqsCwkDV5kqqsvZuz3Xj
         x681oFVPqlFTFKmgh6WtChYkeB15+koEotJbolj7zY/co8hZhYu4MXw8XxAHR1Ar7Blz
         AZxA==
X-Gm-Message-State: APt69E0A6AGwXF2CIhUbjcOPNn/HO7KVfLJpkQGCor/rv+v5N6saBAvm
        OC7JhwDv+DRIpi/AC5l9JIBk
X-Google-Smtp-Source: ADUXVKKOXOnCcuNXOHfZYzESLjGs/I3vGi0FxOxeF42124VpyxVmQOyZojpE5Iab+/hPV1dSGcLpuQ==
X-Received: by 2002:a62:4653:: with SMTP id t80-v6mr11728833pfa.58.1529912872117;
        Mon, 25 Jun 2018 00:47:52 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p12-v6sm27350460pfi.175.2018.06.25.00.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 00:47:51 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 0/2] drivers/base: bugfix for supplier<-consumer ordering in device_kset
Date:   Mon, 25 Jun 2018 15:47:37 +0800
Message-Id: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
places an assumption of supplier<-consumer order on the process of probe.
But it turns out to break down the parent <- child order in some scene.
E.g in pci, a bridge is enabled by pci core, and behind it, the devices
have been probed. Then comes the bridge's module, which enables extra
feature(such as hotplug) on this bridge.
This will break the parent<-children order and cause failure when
"kexec -e" in some scenario.

I tried to fix this issue in pci subsystem, and it turns out to be wrong.
Thanks to Christoph Hellwig, he enlightens me that it should be a bug in
driver core.

note: This series has some lock issue, should be fixed in next version

v1 -> v2:
  refragment

Pingfan Liu (2):
  drivers/base: only reordering consumer device when probing
  drivers/base: reorder consumer and its children behind suppliers

 drivers/base/base.h |   1 +
 drivers/base/core.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c   |   9 +---
 3 files changed, 138 insertions(+), 7 deletions(-)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
-- 
2.7.4

