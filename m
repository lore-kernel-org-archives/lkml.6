Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C15FC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FF52152D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE8I6/5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FF52152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeHHIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:06:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38995 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHHIGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:06:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so573992pff.6;
        Tue, 07 Aug 2018 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=mqmsKdmpmH18HuQQqA8F7CXlaVTzN1hPGjeY3SioQmM=;
        b=CE8I6/5keVToP3ihAdX1qTJhtYT8BXwGJUxZpSQ7JwuREm3uNL4+f4A+qqUhRQEtvq
         MGiIByWqX/ujwOeNBZGO9QJtmFXyLToZ6/eepm9NBRwob4uv7E07XmsMjuezxYSti7p9
         uGLiPX7HE4o3AciEmmV5rPu/GB93gMagvjLh4waQwODf8eP/k0khFQAscKuWOlJycpXY
         Ahe/xw0pGuQE+hXrHvWdsYAPPtwpv1ufHhI78iKc4xac9Z7ro2DCCkoNG/OSaJ5eDmUL
         cJeUuKp5iQGHQmBcRZ0WXxxEXF9fjnjfNCW5VNIfyCxleZaz6rga+ZJNVo3FLMi5zLiM
         mpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=mqmsKdmpmH18HuQQqA8F7CXlaVTzN1hPGjeY3SioQmM=;
        b=OyW5nlZXeCm1cY9wgg02hfiLVAW6DypDXwVYWLbD7FOngROHSeVRzjCYZrFyez7YXZ
         m3/TwGQuRdT4iy4LK1H226U/3Lc4u5mIlapQ3SzG2ybcCAs1yrO6neumVIuPeTS8RSpc
         ruk+DZPQRuXEH7r9EMS6qgXcN2o4RzdO0MGuVNWTm/2lCIJeG0VaI6sekGVKKJC5p14s
         a0UTuOr9cdDIK5HKWIe0tfjhls4LIVRRu1vSZzLgDIayXYgNlQkQWlRBcRHBqDgJ64Ag
         h69SyCUfKB8c5WrGDUbHTLGpvaf8KrMRyfhjHeghG6kV22dVcF38Ribqqs5M2UEAdnIp
         zf2Q==
X-Gm-Message-State: AOUpUlFCSy/T9KzxKMCsI3GgAGseX9msouSWjysE/pdDLAy/AnfD/QAs
        0uQlF1YWwajs8A+E6JT++GM=
X-Google-Smtp-Source: AA+uWPzdUfxIxjvr359k7ZMeMhJ7F4ouhkfuKr8NFPglU+P+xL113awcwflDJXSbvQ5zS0UR5N8i6g==
X-Received: by 2002:a63:f919:: with SMTP id h25-v6mr1102333pgi.401.1533707320892;
        Tue, 07 Aug 2018 22:48:40 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id k125-v6sm3587600pgk.41.2018.08.07.22.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 22:48:39 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Fix calculation of bridge window's size
Date:   Wed,  8 Aug 2018 13:48:37 +0800
Message-Id: <20180808054837.19717-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some 0 resource size pci devices, and it leads to the
accumulator fails to maintain the correct value.
It results in a strange issue on my machine that xhci_hcd failed to init.
   [    2.437278] xhci_hcd 0000:05:00.0: init 0000:05:00.0 fail, -16
   [    2.437300] xhci_hcd: probe of 0000:05:00.0 failed with error -16

To fix this, check if the resource size equals to 0, doesn't increase size.

Fixes: c9c75143a596 ("PCI: Fix calculation of bridge window's size and alignment")
CC: stable@vger.kernel.org # 4.14+

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/pci/setup-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1824e83b4..ae05dde8c6e3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1061,7 +1061,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				r->flags = 0;
 				continue;
 			}
-			size += max(r_size, align);
+			if (r_size != 0)
+				size += max(r_size, align);
 			/* Exclude ranges with size > align from
 			   calculation of the alignment. */
 			if (r_size <= align)
-- 
2.17.1

