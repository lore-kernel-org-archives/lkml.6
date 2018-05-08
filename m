Return-Path: <mperttunen@nvidia.com>
X-Google-Smtp-Source: AB8JxZrhKcseNgcUzymyZ+wMFMj8wi4fFyBBVhKTxXr+EJneU2h1eTwbV1znP8fNg+7e5D1qhdQD
ARC-Seal: i=1; a=rsa-sha256; t=1525780165; cv=none;
        d=google.com; s=arc-20160816;
        b=oChgQxI1qw5+/QkF2ZtFxcMhKANJK01fkM5pVIG1sdJaWUwu3v8QH4WjbhKKj6G9f0
         8TdCdNs8qREekayNqC/RX3fHLomdlneJU2nG/PkVFIwtp025ziNLlXOw/qX2RuCF40P5
         PKGzlQ19v0jKXwwDIcDPEetJ7y3/ZKFCKaLXvXXo9navpTCKMCrRNRZj6B49fEm/hyR3
         cdpNIgNDeZTlsdTN4Nwc/aN9IkLWZDkgVFNOpkD+JX6JKVoLK54I3SQnflIvv+sQf8yX
         xqstqVgMb42Y7nj31AmMXs26h2wpf4zA+nBHIQgcbppOg/GIB1i1XmrDccd7XiajwLKa
         KpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=szzvb6TAiV+hWBH1iYHgS2NMvDGn7j2Wb8+6MDf/7J8=;
        b=pGEMZv6d2hJAt06IcLdHdfSx4XenHtEUYbp0A64tenfAzf8XoblsndwkSKCd6/SiV+
         c0hFJdi75NJnIbv/XUX1MWrpU3ka7XIVabV/d64UsAExViUvToT+Pqmuku2m0YXCUcAv
         DXfM3XR7DYDhOkT+3d90EPCk/hWSnfQoLNBi/6sWJj7SXArQA0K9CtwjdQXPty2XdwrO
         drDBnocQMq4tn7T7Uv2aljDEvd9uOl2BzADc94zmlAB0Y/20uoQlfAiR33VbpnADITI8
         42Mhw8661FYFf+k958V3A1qmx3B/MBqJlpWCa0KnxsLLiSClICx4QZ2Rk3Sdy0VrC1kp
         +VSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Tue, 08 May 2018 04:49:18 -0700
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
	<gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Mikko
 Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Date: Tue, 8 May 2018 14:43:56 +0300
Message-ID: <20180508114403.14499-2-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896462722853640?=
X-GMAIL-MSGID: =?utf-8?q?1599896462722853640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Non-doorbell interrupts are routed through "shared interrupts". These
interrupts can be mapped to various internal interrupt lines. Add
interrupt properties for shared interrupts to the tegra186-hsp device
tree bindings.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
index b99d25fc2f26..9edcdf82d719 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
@@ -21,6 +21,8 @@ Required properties:
     Contains a list of names for the interrupts described by the interrupt
     property. May contain the following entries, in any order:
     - "doorbell"
+    - "sharedN", where 'N' is a number from zero up to the number of
+      external interrupts supported by the HSP instance minus one.
     Users of this binding MUST look up entries in the interrupt property
     by name, using this interrupt-names property to do so.
 - interrupts
-- 
2.16.1
