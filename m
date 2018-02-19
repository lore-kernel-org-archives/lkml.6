Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AH8x2248FK4p6vj56sWCQJkZ+gPf8SQIHTsno8BX3mS2wL2srOrxa+WCaSQasMVyIoV3B3rpMWHy
ARC-Seal: i=1; a=rsa-sha256; t=1519082035; cv=none;
        d=google.com; s=arc-20160816;
        b=VV2T1RXrRFYQsyiD8ZFPdfh0exPlzuVC25qagW/DoiMGTfjnGToP6X/ZYagm9kQDX8
         l+Wov6fHjWl0S9BQDA9cHQbPHOCyXWAg5Bnw4WPaMDwZ7E3OHV5tMLCZhn+kAkbRu3CU
         4+wBonjTPiMQFR93fXRDgcpY3hboB5zXAQltbLCJ2qjqr6vXzKPnsZzkDDufQQc0TGk8
         DWjE71pZq2UNwbDmaP5gk5eGmVBdOrZV1JsNW1Xlik973N6NyQ3NBPNE0omF1bAS4z5G
         gpr6PYD33nHS/bn0umt5RjVSPEcJnXvYh27HuuyDg2OcwbvdVWeFZVa95BouY/KI07ZB
         fxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:dmarc-filter:arc-authentication-results;
        bh=zEfHI6X1iPsWpGf8ZGnjNNhvvsUCnlgMXXX8bSU9VJM=;
        b=QLvpL0JDpEZFDcvKmdiiUXgDCb8vQbYUEVr+x/+gwlcKP8jqoN82Gy2YTG0dzo06qs
         DUIjqhi8VQ6Ap37Bm9N6MEcs3rbPWVgsFEXGgWB0tHFf29zWgDaeuyu1toRkPC8dhTcj
         lVG+Tf9PYPwgyW2v3iHHUiG3KJEn6ntvMep7k59H1FRvz/znTysGjs6t+BLXK9D2Ss2J
         Jd6K83q6AL2x7emRtqcxSzYlVF5XWc/+tXj+7YLwmF7fHsPXW6e7aoXke0rAbNnPTwCi
         EOsz2Vx7WMwg3qltEJaUTwnhHgWWEtE13HH/l4fUAyr0Fq2Lgk9TvJNy5OGZ6mYvr52d
         eNzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE8121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH v1 0/2] PCI/PM: Add comments,
 allow PM of conventional & hotplug bridges
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-pm@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Peter Wu <peter@lekensteyn.nl>,
 Qipeng Zha <qipeng.zha@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andreas Noever <andreas.noever@gmail.com>, Dave Airlie <airlied@gmail.com>,
 Qi Zheng <qi.zheng@intel.com>
Date: Mon, 19 Feb 2018 17:13:53 -0600
Message-ID: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872963859410883?=
X-GMAIL-MSGID: =?utf-8?q?1592872963859410883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add comments to help explain why the code in pci_bridge_d3_possible()
doesn't match the spec (we disallow D3 for conventional PCI bridges and for
hotplug bridges, and the spec seems to suggest that D3 could work in both
of those situations).

Make "pcie_port_pm=force" and "pcie_port_pm=off" apply to all PCI bridges
including conventional PCI bridges and hotplug bridges.  This is a little
speculative.  Those parameters are risky to begin with (otherwise
"pcie_port_pm=force" would be the default); this would make them more
general-purpose but obviously also even more risky.

---

Bjorn Helgaas (2):
      PCI: Add PCIe port runtime suspend details
      PCI: Allow user to request power management of conventional and hotplug bridges


 Documentation/admin-guide/kernel-parameters.txt |    8 ++---
 drivers/pci/pci.c                               |   40 +++++++++++++++++------
 2 files changed, 34 insertions(+), 14 deletions(-)
