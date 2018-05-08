Return-Path: <mperttunen@nvidia.com>
X-Google-Smtp-Source: AB8JxZr0ILG71sWbRiHK3eqZbEwi9eKQ7bYbJWKnBZH/RFYhxzaPYdio3Sp+B2BLjnnZMByheVoP
ARC-Seal: i=1; a=rsa-sha256; t=1525780168; cv=none;
        d=google.com; s=arc-20160816;
        b=AB7RqJeYmmADfqQpLwVlEB3prGEFNF0ja/OkyD9BeGFl0jR887TaVEHcfNAHohcYs7
         SQEopumfeQPIkDh1kb2p9FjGbSVf2qzC1vxEx2EDtduROl6pZpyYLL8zyjOscie20FBh
         U7ICtP1LsnmEeh1UcmlchmnPitUYOb94Kd3CKNmz+1V4GOUtcKhFZiCxmvXl6sWT2gO5
         fFS+9Op7182UE8LXt3KKv4njBRJRBxVZuDAP7OXYhXAFIlDZ7u8shTHE8Hm1nwsaV4Dp
         Op/egZYUkam75UX0xbQV6jjKqPs5/5XNj2GDZ2FtCbR83tpWSBUTX3N9mcB+5jNW9hfS
         TsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=nGXRqOEffJ8T3a9alLr5f27b0+NrC093f000SR8cfIk=;
        b=nsq83qGEYsfCj7ZJbHP9tLVaCpAWm7C9guddBhXZhnL89zNPnIxuE2M3yiNhSibB3/
         8xqTNXfVkWnl/sQuABmXpl9AuK3JI+yVQSq3ilRzpkd0yNyapU0YfyHLncX2tZGstUJP
         MSZdsJjsbybiYKs87BYUuSa2Sx4WuWM/P/0e79j81Eq5mqwXVAUIEOuVkj9p81wJ2Anq
         7WwoJUxujYrNgl1jbUBtW/bigAKiEi31of2IrxcGjVnPqU8JWK+32uUImN/D36UZb806
         4quFN478EexH1X9UJrIuEB5YcETqsWf2/NLuc71zM7bHJnaNsZM7MkhdUmwmMdgHTFFo
         bZ4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 08 May 2018 04:49:27 -0700
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
	<gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Mikko
 Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 2/8] dt-bindings: serial: Add bindings for nvidia,tegra194-tcu
Date: Tue, 8 May 2018 14:43:57 +0300
Message-ID: <20180508114403.14499-3-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896465891432368?=
X-GMAIL-MSGID: =?utf-8?q?1599896465891432368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add bindings for the Tegra Combined UART device used to talk to the
UART console on Tegra194 systems.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
new file mode 100644
index 000000000000..86763bc5d74f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
@@ -0,0 +1,35 @@
+NVIDIA Tegra Combined UART (TCU)
+
+The TCU is a system for sharing a hardware UART instance among multiple
+systems withing the Tegra SoC. It is implemented through a mailbox-
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
2.16.1
