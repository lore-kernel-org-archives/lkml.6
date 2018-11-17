Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969EBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CCB20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Fz623GT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CCB20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeKREhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:37:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41488 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKREhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:37:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id v18-v6so27981769wrt.8;
        Sat, 17 Nov 2018 10:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2CVIxXeXtEkDx1tthYixA2APpRSK9i7VNiCgQVjMrs=;
        b=Fz623GT18t7uPITYf5MyGP3vYaLQpG750VhDdFf06o7LXjAXg12tLfhYLRih1AzJvc
         GpP3U2LJvKmf9D0tuamtF7JX0JykNcG52KVNRFwHR3a+HTLE50ZVR//PirbbvdtL3iSW
         a9PiMCtMikiGqwEtw8fUkXpNbSoxzplbzWIZl7v3iz6autbgC8rH3boM4EjiRuT141Pp
         viajp0tDbiwQDhL4fJcO17RZR58YwgNbJeCncQJN1iPkw8mBvPIO/F1vBWW1f71gf4Kw
         au+qBTIQbs1Z5bE23nkMjGrT5/rZ4F/bjALiePIzd7mH2OmzDp+qQXZSH9whCWDAflyr
         eO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2CVIxXeXtEkDx1tthYixA2APpRSK9i7VNiCgQVjMrs=;
        b=bljaj9Jh0jXLyYBDx4dw76wC43GZLmXGrbpF9PpofRnTEXwFfzAHxJsZFMxS+zNyjp
         sQo4DAJEOs8g1FB7L/6X7hWtuPqW1d78BpS/6MSpZWXOoP1k5N1J0pWGHcqkwy8e35q8
         p6TQhO3B/Dox/1MEDCYBQmyxok8eZeCSuJqfU7s7HmKOGtVRj+Pn4hXwBnFqRFYYYY33
         ismiOZYW9Wg9wXBxhC3XffJPfr2Y1MQenJde7w6Y9KrzGFH5YyC7Ocurc3GIDeu5KP8q
         ujoEhVw5+pdSZwlDNkArcC5vcGQAPI6HFLCReNTYrsnWsKrnBT5ci26V6UyvJFjnliWE
         0hgA==
X-Gm-Message-State: AGRZ1gKd2IBkIWn5+bbSNML6gr3QU754jAjZ62LfpRbU6QdNeqUOC5Dt
        9PCNSI95qHsL1ff5bdENuK3m0YCbm8A=
X-Google-Smtp-Source: AJdET5eCKU/Zz181ds7H9Xx9FyyuXLLOHadq9ZHrCOoEtzgzSfdTVVMXpgc1oJCeNH9OFFZoP0WHTw==
X-Received: by 2002:adf:afdc:: with SMTP id y28-v6mr12747216wrd.176.1542478819931;
        Sat, 17 Nov 2018 10:20:19 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100C991D5C7C405D3EC.dip0.t-ipconnect.de. [2003:dc:d717:a100:c991:d5c7:c405:d3ec])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm63631232wmf.22.2018.11.17.10.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:20:18 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/7] IP101GR: devicetree based configuration of SEL_INTR32
Date:   Sat, 17 Nov 2018 19:20:00 +0100
Message-Id: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
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

This series is based on net-next commit 9c549a6b057386d ("selftests:
add explicit test for multiple concurrent GRO sockets")


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
 drivers/net/phy/icplus.c                      | 125 +++++++++++++++---
 3 files changed, 125 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/icplus-ip101ag.txt

-- 
2.19.1

