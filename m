Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323AFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4A02075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eTROMYFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4A02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeKSHph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:45:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44511 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeKSHpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:45:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id j17-v6so29919772wrq.11;
        Sun, 18 Nov 2018 13:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9klZ8isTv81ubFhK6yKYWbH2hgQVv1AZordoOIelDY=;
        b=eTROMYFsabZYrcne2ofIJz4wz0Keb6OItr2le61G49An9Pu1DzzAMWQpgaawVN23K/
         xyIvQ6RSjwEK3KY+qYF9wXNoSUkfws91v+8MnsDqymCzVvLghQWHhmCPE7cmw3a5G3Bw
         h6qZSIXKBhzNpQOPQJJWlxlSxd9xAMREsE1cmTj9wbR6Drz62XAMixtlDvV/w3c+zhCh
         lbycduCBYYcjUGwD9aRWD3mEsdZ5rPDWjU9lbWkvNwL7ShCTBuxd3hgP6Z52RrjPnQEV
         HagggPCJhQ+adfNpjJJUnFpaH/gqhivO9dxd2RLgxpIpDSllDRqu7zR4qBnI3Hju14sU
         W8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9klZ8isTv81ubFhK6yKYWbH2hgQVv1AZordoOIelDY=;
        b=MGqpf89LgGymT2dSuYV5EMsNprqwK3xqrFaWMSIjyqSJdvq1dk5vp6ot/Te7jqL0tw
         0dXzk3k1QPGzvmpKaz58+QYWFglLmi2gULtG2pCMf8WZC87m60Dkl823OQs8zFkPXeba
         Xz1WNIkkSg5ydefdUAhvsK7QgfJ9+yHgZzLwi7JQOAn0uOJS5xBTXrVMi7185X1E0T1H
         mbbW1Yb7BTwNe95xxLFIl0ZHJ+CQf7KX9gmYlYI8DD5Y/IEstuVklZEB2eAcC8Ue11i0
         mfR71P3veImbXHlKID0Y+WLT11nsb3h4OPXZDbCu7ir5K8ezLm79EnkQercEOG8J/F3W
         Jqvw==
X-Gm-Message-State: AA+aEWYIQZcyzVa/YyYXaUEadpC1zm9+Z5ElnfcpDU3QDYL204TLqu7e
        dC/KJLlqJWbJW+5lHf9mpGMkOD5gwlg=
X-Google-Smtp-Source: AFSGD/WkfnQ7Ve7CU8uhoPLUDvigBnxNXWUUFunDh9PI59GFvhojtfESdZe9tEFnXLejrmoWbIKpHQ==
X-Received: by 2002:adf:d112:: with SMTP id a18mr3164784wri.17.1542576251882;
        Sun, 18 Nov 2018 13:24:11 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A10029D7537EB9A16C22.dip0.t-ipconnect.de. [2003:dc:d717:a100:29d7:537e:b9a1:6c22])
        by smtp.googlemail.com with ESMTPSA id d4sm31835649wrp.89.2018.11.18.13.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:24:10 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/7] IP101GR: devicetree based configuration of SEL_INTR32
Date:   Sun, 18 Nov 2018 22:23:52 +0100
Message-Id: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP101GR is a 32-pin QFN package variant of the IP101G/IP101GA
Ethernet PHY. Due to it's limited amount of pins the RXER (receive
error) and INTR32 (interrupt) functions share pin 21.

The goal of this series is:
- some small cleanups in patches 3, 4 and 5
- allowing the kernel to detect IRQ floods on boards where the IP101GR
  is configured in RXER mode but the RXER line is configured on the
  host SoC as interrupt line (patch 6)
- configuration of the SEL_INTR32 register so we can use the interrupt
  function on boards where the RXER/INTR32 pin (pin 21) is routed to
  one of the host SoC's interrupt inputs (patches 1, 2, 7)

A use-case where this is needed is the Endless Mini (EC-100). I have
tested my changes on that board. This also confirms that Heiner
Kallweit's recent icplus.c PHY driver changes are working (at least on
my setup).

This series is based on net-next commit 7c460cf9cd1a ("net: aquantia:
fix spelling mistake "specfield" -> "specified"")


Changes since v1 at [0]:
- collected Andrew's Reviewed-by's (thank you!)
- updated description of patch #2 to explain why two properties were
  added instead of adding an "this is a IP101GR" property
- validate that there's no conflicting configuration in patch #7
- rebased on top of latest net-next


[0] https://patchwork.ozlabs.org/cover/999371/


Martin Blumenstingl (7):
  dt-bindings: vendor-prefix: add prefix for IC Plus Corp.
  dt-bindings: net: phy: add bindings for the IC Plus Corp. IP101A/G
    PHYs
  net: phy: icplus: keep all ip101a_g functions together
  net: phy: icplus: use the BIT macro where possible
  net: phy: icplus: rename IP101A_G_NO_IRQ to IP101A_G_IRQ_ALL_MASK
  net: phy: icplus: implement .did_interrupt for IP101A/G
  net: phy: icplus: allow configuring the interrupt function on IP101GR

 .../bindings/net/icplus-ip101ag.txt           |  19 +++
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 drivers/net/phy/icplus.c                      | 135 +++++++++++++++---
 3 files changed, 135 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/icplus-ip101ag.txt

-- 
2.19.1

