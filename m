Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2477ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AD520665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOaCqJPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AD520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeJZTxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40476 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeJZTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so894257wre.7;
        Fri, 26 Oct 2018 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bv2YS9N2LMSq+eP7/rHzcd3tzw14G3HT9MLQqCkcqxs=;
        b=aOaCqJPCGVp6biml68UFwxuyvI+vV5FOZZ9YvLneAXLD3cTpEqsIcXR9oXWV09YiTj
         vqF5fWYtDj0ojyED8oXpHLVixOmfOvk/gi9tQuG+GDEV60La2Nni/v7PbchhQB5rN4Rw
         XxkE/4B5xYpNUJEDyOEJUoWp3zEg+QluuJKcJ1HlchHCgIz/vX7dDhl+6w/+90fBYmPf
         YmE/sUqgf69e42T/0z+XBrhv8p+Viijx69obABzCOamCUGa010l8XcS6xA9hLfSrjKEw
         AdzSd8CVp+UC9o1XtiM2QYQVi+/S7wlFG0iBRl0WkxRb/i4JfcM3m2foKWIDR9tLKHE9
         fj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bv2YS9N2LMSq+eP7/rHzcd3tzw14G3HT9MLQqCkcqxs=;
        b=Tx/vuaoUSPZArVz7bG2kqrp/wWnGxSxpZ8vv9W7lb2MdXtyk/T2xAhRPK3G+7977NR
         zljvpEwP+j7LmP24lDhIO80JoTsZohCpXdhzL1QdBGlgSiHGvzAXKNDafdI6R8WwUSWf
         auq8Q4e+AL7bc7CGfbGLEbooo66z9iejEvaontGVdeL56sO7jzGm4eW/tUZyT8+wOoYk
         N9TJPWwIb6TKi1RaVGfc3LGaKmJfSRD3CKFfqr7Ii6oJQvYv1t5hFDBSlCPLcZ5pDtik
         j7FwpE0o2Q62NHZeGnfFPfgyFlLy3LACNvLelx4UdWWglNEK4kJuzwWrP04HLQ0dAElr
         5PSA==
X-Gm-Message-State: AGRZ1gKARgJdppFNTLEpZ+b5F3eezs7q8z/rD4GdiCbrjY2tH4HGkKz3
        VDuq7pvBk6jDs2ac8ak2Ogk=
X-Google-Smtp-Source: AJdET5fj5JDtKFHfOlvsvu+3Rg/yxA+sIh6V70YGAkJL0z8XAfMtJolktKTlXJMi+Z1rigNBv+vaGQ==
X-Received: by 2002:a5d:434c:: with SMTP id u12-v6mr5191375wrr.306.1540552611767;
        Fri, 26 Oct 2018 04:16:51 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id q77-v6sm5757398wmd.33.2018.10.26.04.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:51 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] dt-bindings: serial: Add bindings for nvidia,tegra194-tcu
Date:   Fri, 26 Oct 2018 13:16:35 +0200
Message-Id: <20181026111638.10759-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Add bindings for the Tegra Combined UART device used to talk to the
UART console on Tegra194 systems.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/serial/nvidia,tegra194-tcu.txt   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
new file mode 100644
index 000000000000..a8becf6efd2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
@@ -0,0 +1,35 @@
+NVIDIA Tegra Combined UART (TCU)
+
+The TCU is a system for sharing a hardware UART instance among multiple
+systems within the Tegra SoC. It is implemented through a mailbox-
+based protocol where each "virtual UART" has a pair of mailboxes, one
+for transmitting and one for receiving, that is used to communicate
+with the hardware implementing the TCU.
+
+Required properties:
+- name : Should be tcu
+- compatible
+    Array of strings
+    One of:
+    - "nvidia,tegra194-tcu"
+- mbox-names:
+    "rx" - Mailbox for receiving data from hardware UART
+    "tx" - Mailbox for transmitting data to hardware UART
+- mboxes: Mailboxes corresponding to the mbox-names. 
+
+This node is a mailbox consumer. See the following files for details of
+the mailbox subsystem, and the specifiers implemented by the relevant
+provider(s):
+
+- .../mailbox/mailbox.txt
+- .../mailbox/nvidia,tegra186-hsp.txt
+
+Example bindings:
+-----------------
+
+tcu: tcu {
+	compatible = "nvidia,tegra194-tcu";
+	mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
+	         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
+	mbox-names = "rx", "tx";
+};
-- 
2.19.1

