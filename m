Return-Path: <rajatja@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527028094; cv=none;
        d=google.com; s=arc-20160816;
        b=G7Kf30t8paIuOLGfYiFIeaAhaMTeR/cHfgWtLvbvfM3y7iw4uxUOZZnY9T/V5tkEUZ
         bjW1+zLoelZmPdzDCtfwx0wOtV+PXFlGKuxLFdRr4RMMpd6lnANRrqVSl5tyESth/cTJ
         Y9E+ILCzZuO5JYIAkaEG9mmAgWtP5rBYt22pwh3TQA7r3d09WE7+0HZS1B7G+d6dn7qW
         H7aETy0SW/6c0xyquPVxFNqo5+fljgKhrlNvMunajsVS2eWGzVOSQCMLtwPCB3xL5FlX
         xg4uMf5MceQLuILK/eIC1Xt8mDYzOi/CeIpP31o8XbCuFNZ5tmUeojSV1eJgNvxsILxF
         WC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=027o/2OeYAs8ktRMQ23ZKyEtA1fOF6X7CAFwP/wwUdk=;
        b=TZvfPGiwR9KvOfKmSAFkh8qplY6pIbYY8HX5uheFg8HpCcUgEmixI+FY0qNtPiNiAV
         uDc7T7ceB3pSgZlf5Dz7rLdDG4C17huE1b0lY74tuSQk9gZmGhpKC7fwMA3EnY2v0QGa
         etU1IGMhGRN5cfoAO1JHn1Wr7tgA8SB1cgONWYgXgOAS9C1uWg481ksw3u39HhwqP9iH
         AJJ+ui5SDXQjyye6583rK/Uc5IGEoKEg2rrJDn8DyM+oua0PiBVHOuzvxYSO8OGfsrC9
         /MelXUPGHBhfozlMvAAS87SOpPwj+m8tsTBK3Y4roLB40ngDyCWqXaW7u0PL9WwY1DKt
         UBWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Ph1bkmZ8;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Ph1bkmZ8;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZpmDDDauYpupl3mGmsjehKAbr9iHRtuGYnTUQ/6Vbp/DhiRPDAafLSSqi3pOFK+XJgzZzn7JA==
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajat Jain <rajatja@google.com>,
	Frederick Lawler <fred@fredlawl.com>,
	Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jes Sorensen <jsorensen@fb.com>,
	Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
Subject: [PATCH 0/5] Expose PCIe AER stats via sysfs
Date: Tue, 22 May 2018 15:28:00 -0700
Message-Id: <20180522222805.80314-1-rajatja@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205011130411711?=
X-GMAIL-MSGID: =?utf-8?q?1601205011130411711?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset exposes the AER stats via the sysfs attributes.

Rajat Jain (5):
  PCI/AER: Define and allocate aer_stats structure for AER capable
    devices
  PCI/AER: Add sysfs stats for AER capable devices
  PCP/AER: Add sysfs attributes to provide breakdown of AERs
  PCI/AER: Add sysfs attributes for rootport cumulative stats
  Documentation/PCI: Add details of PCI AER statistics

 Documentation/PCI/pcieaer-howto.txt    |  35 +++++
 drivers/pci/pci-sysfs.c                |   3 +
 drivers/pci/pci.h                      |   4 +-
 drivers/pci/pcie/aer/Makefile          |   2 +-
 drivers/pci/pcie/aer/aerdrv.h          |  15 ++
 drivers/pci/pcie/aer/aerdrv_core.c     |  11 ++
 drivers/pci/pcie/aer/aerdrv_errprint.c |   7 +-
 drivers/pci/pcie/aer/aerdrv_stats.c    | 192 +++++++++++++++++++++++++
 drivers/pci/probe.c                    |   1 +
 include/linux/pci.h                    |   3 +
 10 files changed, 269 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/pcie/aer/aerdrv_stats.c

-- 
2.17.0.441.gb46fe60e1d-goog
