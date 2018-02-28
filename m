Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AG47ELuNe82gAJtH2zYUb9CvANi76sDqfYrfeMs8EcsOiczWAUA9ekzYY6pQi8QF5F+eQuzhy8oR
ARC-Seal: i=1; a=rsa-sha256; t=1519807466; cv=none;
        d=google.com; s=arc-20160816;
        b=syYWBVRHqcgRiAZz13d+14l3H6V5Y5nFikrlyXjZG8Wvavn2OcTI2lLDO3rHSHBCpZ
         fqnQ0lmubfBnGcsEZmBJfHdicV6MFwvPWcruK18qlqmUijrl8NR4RX2m6/61yW+VZFYY
         FGyDf1VlNYMklv5m/0sero1tCmewN3LjR2Qz1+P8xfuhMJ1iGSb7IeJugM6pFZsrQwqA
         vxH4Oww/e2wjdXy0x3StgtJa6ffwDckT+U33S/RBvjHoAyAK26k1ccRwT6g5zg9DMeQ7
         /rCSrhwNgxENehgP/nMoQatqkS3nDXGhpbJfCLItb6vIJRagx5H8qlzH6sHKd91msloT
         8xIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=8Kn3AA0mn+DBJJ02uCzApCNUxjQm2gpp8QHmqh7aF+0=;
        b=AK3O9MSMvsUbR9dKP9rjZhiV2UhNKJP0utROGtUoILSVHZGz69eFerspuXAVcL1tJU
         OR6cJxfZyIywMog/hQ/rx8U9A8u+Fy0O8nadjBjNLAYKQ5Vw2tghy3AragA44aTmNI2G
         lvRDQ6DXGViM61IbI0fE8azk7I+kJsTVFQciuE0ADcFFB6Be7Gc0VTmP+PGDwjbw19nN
         TIaWxN6qleyEdRz33mcu8hNWjkwEDqWRFwqHIsrTCJ9TimG90sYSLM9Ou9ntspErgkkH
         E5iNpV32mqLeg9VnnrrYPZPm5jxTuYuW/Hbj1UgDdhXOeCMbqvlo4ihjMIYnPLvcxcaF
         B2ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-pci@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 0/2] MCB Update for v4.17 
Date: Wed, 28 Feb 2018 09:44:16 +0100
Message-Id: <20180228084418.7566-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593633633623715262?=
X-GMAIL-MSGID: =?utf-8?q?1593633633623715262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg or Bjorn,

here's a small mcb update for the 4.17 window. The first patch makes
the PCI Vendor ID of Altera generally available in pci_ids.h and
removes it from the two private implementations before I would have to
add a 3rd one.

The 2nd patch adds the Altera's PCI vendor ID to the mcb pci driver
which enables at least one carrier board. This was reported and tested
by Ben Turner.

Bjorn asked me to Cc linux-pci@ in his response, so I'm not sure if he want's
to merge these two patches. I'm fine either way.

Thanks,
	Johannes

Changes to v1:
* Removed redundant pci_ids.h include

Johannes Thumshirn (2):
  PCI: add vendor id for Altera
  mcb: add Altera PCI ID to mcb-pci

 drivers/char/xillybus/xillybus_pcie.c | 1 -
 drivers/fpga/altera-cvp.c             | 2 --
 drivers/mcb/mcb-pci.c                 | 1 +
 include/linux/pci_ids.h               | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.13.6
