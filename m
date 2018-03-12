Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AG47ELt9oDqoMJdAz3gPvGX7euTXK7XUBQSnYD5IvrI4HQXUC5M5mJD0natewxgbSwiN44I/fX+C
ARC-Seal: i=1; a=rsa-sha256; t=1520847687; cv=none;
        d=google.com; s=arc-20160816;
        b=TojLIjZU0JOQjpw0MgFFsXtkVgeSwP3J7m6I+uDDrQTI+BIYKJanPsqxuCXYg9LsN5
         AC0J3fybJu6oYTTtD9Y/dlTwxQta/1qbgveeAwkk77E1oGkg4BH70JQh94V8EgAbrLy9
         oyr5kwgM208NtQ3ZTzy12vSd/zMAwRVR1SRZ5ukk9ocQYRDUVApOMIdHrFCVyLwN273N
         +mlDc9pmjGAxhNPp0YFTljSufp2XGSUwci81VUlPeGx+ycjZqitaygAugRD1I5w5mrsY
         deImLyJq8ORNkR4GT4O1H8a0hFZg4CHREQzj6udUreY+G80UoOX3o4THxPw6YbtBRQ55
         hpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=ET7Wg5Sxf2bV2sj5OAK0GtPks7QjTV70YHkJOZ6Y/Sc=;
        b=PFQfTShgG4bD+b69tDg7lXNE5/6n0dQm1f2ypSOEn9BmwuvuR++GInFEX/UnnidFX9
         ISErS95lEOC/yf1yIsrV9/AXN2O1GE/hqztYnraDtSSPAx3b7Ys3X0ey+lHxpYZZYcqG
         l/+GbmjuFTGyxHeqdj9V68VO0avdovnkR0DLFHItwTz56NaYg18J0DtSSfMSLfvGV0h+
         qVUaTVooAslhZmeEWKgAfnYh1sQtigTWEzfFdYIpQBGDqq0Tpt486Td23rYc13oe8st2
         M6SCSOBNG/dzvhrcDHwy2rnOkg0XWx6m6WiHO23gKsjIpVgLuXsIOXCa3QsTd4ciGfVZ
         vF+w==
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
Subject: [PATCH v3 0/2] MCB Update for v4.17
Date: Mon, 12 Mar 2018 10:41:17 +0100
Message-Id: <20180312094119.5298-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594724385482004141?=
X-GMAIL-MSGID: =?utf-8?q?1594724385482004141?=
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

Changes to v2:
* Collected ACKs
* Reworded Subject of 1/2 according to Bjorn

Changes to v1:
* Removed redundant pci_ids.h include


Johannes Thumshirn (2):
  PCI: Add Altera vendor ID
  mcb: add Altera PCI ID to mcb-pci

 drivers/char/xillybus/xillybus_pcie.c | 1 -
 drivers/fpga/altera-cvp.c             | 2 --
 drivers/mcb/mcb-pci.c                 | 1 +
 include/linux/pci_ids.h               | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.13.6
