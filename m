Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1071218-1526314927-5-16570096529249094506
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526314927; b=Levpxn6uihGiLbMWWRUrWZdwk5g3a3OPHGAh/89jcfezsL00IQ
    aPajLmgrPIvXFK3HN30t2IFguVa1mQaovJfnx1jV4aeo6NGX0HFJkrJ1curbQOEF
    bXn+zitE/LccOmkfYGAUptIdOvDLMgpoxyiwiJWqVcS3S3q2vjAOcZMBRFz7LtJA
    QmWwZ4moC17CLzthLqZNfbM7IYlwTKP4sgoc6q0Pg9u7YRZfPyKujFuXLYS1SR61
    VKpO0chFgLkCtFKACKAL3BkkLNIBVHnqcQvzlc/197NraZA+D+LzaVB/K31fDtxs
    k3xOgu0sedx/VWzTb3j8Co2Ci33AyMr7ry3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526314927; bh=
    h3ZN4AD5Cn8DD7877fqJcjc6eZ+uAihh6ypQHLEwLSs=; b=A1eeg+VMtgQpOfUv
    WUje0FhlMpXCUTFLUC+qwMuX2vq/Jn4MOJQCZBvuSYQk3YR+BqehVl0WUL9k40lr
    lGnGJL21xhmofkIn0Ed4Ik13lQvLhmVNZyDrprjDkTUyM4VA6yX5X9QabvpQgz25
    dAuQPysQCe7TvvR8FlYg4q3T1+HR953x+33EKEDNHixsMPXyz05SwWItYU6uGZZE
    2Y//ecMDzDaEu+KeSYrzpVOTsi4WP/tcSFI4Jx7CEztdsDDvwmpwYBlyCvqrHPcd
    dfSinFfBvwgTKtROyfNTQyD1ZYCdLVP2B+OJ1fzERvucUiXLo0b4MR8L2mJZfv5V
    4ujpUw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mellanox.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mellanox.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI82Gqw/aVyvI+7APKsbhE6t9yeqzz6NALGbYZF63HBPjgjvHv+mNMdtqktS6NiBhTQpXFI5mmKYsKdyQJax6ID+lNShhQ1s/3kulBOI+xwoUrgBEgjN
    Rdc7pZ/mLPSdzwku80wlz+kdq52itW7CzAY6hqUJeW4FBeeLxh0nydT5Eb+v3H0mBne1WBHh5/S7nAwhHeq0DZzmSL1eqRcl30xzcyZnWb8QfMpC5Vszu+5m
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=CbDCq_QkAAAA:8
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ONpdaqaGwc1WCYbRhBcA:9
    a=OtarCkJxcMnUxKr5:21 a=wWi9hfW9m_WXMi2b:21 a=x8gzFH9gYPwA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754883AbeENQU6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:20:58 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39827 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754877AbeENQUL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 12:20:11 -0400
From: Oleksandr Shamray <oleksandrs@mellanox.com>
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch,
        linux-serial@vger.kernel.org, vadimp@mellanox.com,
        system-sw-low-level@mellanox.com, robh+dt@kernel.org,
        openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, davem@davemloft.net, mchehab@kernel.org,
        Oleksandr Shamray <oleksandrs@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Subject: [patch v20 3/4] Documentation: jtag: Add bindings for Aspeed SoC 24xx and 25xx families JTAG master driver
Date: Mon, 14 May 2018 19:20:02 +0300
Message-Id: <1526314803-3532-4-git-send-email-oleksandrs@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1526314803-3532-1-git-send-email-oleksandrs@mellanox.com>
References: <1526314803-3532-1-git-send-email-oleksandrs@mellanox.com>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It has been tested on Mellanox system with BMC equipped with
Aspeed 2520 SoC for programming CPLD devices.

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v19->v20
v18->v19
v17->v18
v16->v17
v15->v16
Comments pointed by Joel Stanley <joel.stan@gmail.com>
- change clocks = <&clk_apb> to proper clocks = <&syscon ASPEED_CLK_APB>
- add reset descriptions in bndings file

v14->v15
v13->v14
v12->v13
v11->v12
v10->v11
v9->v10
v8->v9
v7->v8
Comments pointed by pointed by Joel Stanley <joel.stan@gmail.com>
- Change compatible string to ast2400 and ast2000

V6->v7
Comments pointed by Tobias Klauser <tklauser@distanz.ch>
 - Fix spell "Doccumentation" -> "Documentation"

v5->v6
Comments pointed by Tobias Klauser <tklauser@distanz.ch>
- Small nit: s/documentation/Documentation/

v4->v5

V3->v4
Comments pointed by Rob Herring <robh@kernel.org>
- delete unnecessary "status" and "reg-shift" descriptions in
  bndings file

v2->v3
Comments pointed by Rob Herring <robh@kernel.org>
- split Aspeed jtag driver and binding to sepatrate patches
- delete unnecessary "status" and "reg-shift" descriptions in
  bndings file
---
 .../devicetree/bindings/jtag/aspeed-jtag.txt       |   22 ++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.txt

diff --git a/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
new file mode 100644
index 0000000..7c36eb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
@@ -0,0 +1,22 @@
+Aspeed JTAG driver for ast2400 and ast2500 SoC
+
+Required properties:
+- compatible:		Should be one of
+      - "aspeed,ast2400-jtag"
+      - "aspeed,ast2500-jtag"
+- reg			contains the offset and length of the JTAG memory
+			region
+- clocks		root clock of bus, should reference the APB
+			clock in the second cell
+- resets		phandle to reset controller with the reset number in
+			the second cell
+- interrupts		should contain JTAG controller interrupt
+
+Example:
+jtag: jtag@1e6e4000 {
+	compatible = "aspeed,ast2500-jtag";
+	reg = <0x1e6e4000 0x1c>;
+	clocks = <&syscon ASPEED_CLK_APB>;
+	resets = <&syscon ASPEED_RESET_JTAG_MASTER>;
+	interrupts = <43>;
+};
-- 
1.7.1

