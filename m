Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AIpwx4+GGtVXRRkZ/bvFzkqpHZEbNhd1rm4mNmpyLkYS1yPz7hGpxLtpCo70LSorB1Q2a146Tu3V
ARC-Seal: i=1; a=rsa-sha256; t=1524545259; cv=none;
        d=google.com; s=arc-20160816;
        b=avcB0GQhDqI0huPSk22rSjElVdDcOt80Jud4g4tYw3DKDwXQk5i2ExvE/A6Y2JQYeE
         qKiwoMCxYK/G092ySBejcir5oOh4Mwa9zOPwIFk2aRa9EX1HdfAtx9wiQpTobddMvs8l
         tFoh/qT0BEpJXyTCyIL0Cb1KQcuICJTNWi8wlRLTWHylJyZlD6IoYF1pN7z/XEbeBkZV
         R+0F5MD6GN36NiTwNdPWmES3AbJSsuX+IZvolFUpDOvbJNlouwUVF/EoVMRE63YiBf4+
         5Vt/OgkPmQP2/Q1KbkL7ceFN3dgVM2p49XrGvRsADln9RwR/CUvzx+X0EDpCErLemy9D
         3GzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Uf7PjHK/bTGWEq2Mz1N8lSkUht+dyJHh8rVXMgcDoy0=;
        b=VEDRl427+/Ita5z+5eKsPH8vcUkEYb55bQso+G4QmmVAQrFgg8Dr5h7DJ2YazZwamv
         bJQ0fNb33q8jJKOhC9GdE2ibqFgsSSA16GocfEFUzOuTcNj3cm6q9g8XdIpFtT5udNbb
         cE/dj5NHcbCUWMm2XFYFAEhsvo9Hngo6nLM3cdTNqWEh2NNHAEhv2X+smJuUBd8+Fafq
         j/AlPPEK7CzIKKzVQ35ujZUPbJ2D2X8eT4IzPCpPHNrLADdtRKFQfHpiS/2ALWLq99VJ
         h6j+969I+R2P9hRrvpot9V1lidO+84IflAVufnqafiW/Yb9hgG3ogokctF2voVP7sGvO
         kCGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,321,1520924400";
   d="scan'208";a="34148038"
Date: Tue, 24 Apr 2018 12:47:34 +0800
From: kbuild test robot <lkp@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>,
	Oza Pawandeep <poza@codeaurora.org>
Subject: [RFC PATCH] PCI/AER/DPC: pcie_do_fatal_recovery() can be static
Message-ID: <20180424044734.GA16123@lkp-ne02>
References: <1524496993-29799-9-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524496993-29799-9-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598601570570303792?=
X-GMAIL-MSGID: =?utf-8?q?1598601570570303792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Fixes: 3d7db543cb99 ("PCI/AER/DPC: Align FATAL error handling for AER and DPC")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 err.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 99d52a0..9d8d7ef 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -273,7 +273,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	return result_data.result;
 }
 
-pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev, int severity)
+static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev, int severity)
 {
 	struct pci_dev *udev;
 	struct pci_bus *parent;
