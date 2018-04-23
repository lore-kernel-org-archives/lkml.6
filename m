Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AIpwx48j+Ab+v9lbdeK7Y4vx9C2WFlt8QDylK5qO3TXIKZnl2deHe/zfL8B2ZL4LjDKkph3o9IYE
ARC-Seal: i=1; a=rsa-sha256; t=1524526292; cv=none;
        d=google.com; s=arc-20160816;
        b=aVJQC3QSCMbgQFrdll9+Xbq5TjvPRrza/nEiDEuV7bFdV5hVMs6G1ocU4SyXXaSul7
         vte0VaBxa4Q2skIJbrCHUSlvxel7Gq81H0Z5nqfDwb1k3zJORo4p5IlXkkd8ewqGU4eg
         93D/6McgjwqJh+JrPBprR1z58jhN2Bn+F3bB18o26Y7ourQhEVRMjvA84OPUx89IKkSK
         le7P1fMDgbHiKkAtITLm1HibcBzC7UT/4qXMfBt3Io5WKqEURqv0h/8RcqUnGEk6wZZ1
         lMu3KOZYIVE3oNvVCpQOrPohyI2sZhUGnPotMQOxNRbTFghlY3sH23gsfzBzUqHzIKMe
         36yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=dzoMoVzubGcPt3XBQ4TFiVF3uEXkZerGX2bozUb8uYI=;
        b=NwhMlYFwZeuvIkB6XwQOJ8px+XfsVT/CZp6vmvZK/Z4ekPzoBBuGEV1DGTpqQqr9Aq
         cJ3kG4Vog55BaYoeCJQzlnmsb4YAD9KM+y+OpRfUyrnnhW9p4nPT8yjdQC0go/CDqfWO
         /Cd1liviBNYKOOhoGLkKxkoBsMmueE8rx+hjE+tZqhfRDqWyPnZujeWzDBNC3d1P4aJ9
         BebzQEiTX3DDTKCzl9RKjEKwyqUQnJozomzgTGtolMvA8KMWvpdZ1xJWBYB6PH4Gbbw5
         9bKJ3qtQwhAcKVMn0MlLgo/5bdgIO/HfcWOPlF6uMgAvgFRz7NUFvs7ttwIPAnf7jqDM
         +zdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Sagar Dharia <sdharia@codeaurora.org>
Date: Mon, 23 Apr 2018 17:30:37 -0600
Message-Id: <20180423233046.21476-6-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423233046.21476-1-logang@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org, sbates@raithlin.com, hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, bhelgaas@google.com, jgg@mellanox.com, maxg@mellanox.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, logang@deltatee.com, corbet@lwn.net, mchehab@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, treding@nvidia.com, keith.busch@intel.com, dan.j.williams@intel.com, vinod.koul@intel.com, sanyog.r.kale@intel.com, sdharia@codeaurora.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 05/14] docs-rst: Add a new directory for PCI documentation
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598581681635177245?=
X-GMAIL-MSGID: =?utf-8?q?1598581681635177245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a new directory in the driver API guide for PCI specific
documentation.

This is in preparation for adding a new PCI P2P DMA driver writers
guide which will go in this directory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: Sagar Dharia <sdharia@codeaurora.org>
---
 Documentation/driver-api/index.rst         |  2 +-
 Documentation/driver-api/pci/index.rst     | 19 +++++++++++++++++++
 Documentation/driver-api/{ => pci}/pci.rst |  0
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/pci/index.rst
 rename Documentation/driver-api/{ => pci}/pci.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6d8352c0f354..9e4cd4e91a49 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -27,7 +27,7 @@ available subsections can be seen below.
    iio/index
    input
    usb/index
-   pci
+   pci/index
    spi
    i2c
    hsi
diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
new file mode 100644
index 000000000000..03b57cbf8cc2
--- /dev/null
+++ b/Documentation/driver-api/pci/index.rst
@@ -0,0 +1,19 @@
+============================================
+The Linux PCI driver implementer's API guide
+============================================
+
+.. class:: toc-title
+
+	   Table of contents
+
+.. toctree::
+   :maxdepth: 2
+
+   pci
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/pci.rst b/Documentation/driver-api/pci/pci.rst
similarity index 100%
rename from Documentation/driver-api/pci.rst
rename to Documentation/driver-api/pci/pci.rst
-- 
2.11.0
