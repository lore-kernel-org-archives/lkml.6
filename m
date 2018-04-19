Return-Path: <gregory.clement@bootlin.com>
X-Google-Smtp-Source: AIpwx49p7ZjVMvVTNGn25RAu4OKUwOdX9UnM/nxl3vdYHEnoHglUM13rmWDVO2UI9f948KCyPKbH
ARC-Seal: i=1; a=rsa-sha256; t=1524144671; cv=none;
        d=google.com; s=arc-20160816;
        b=oJUvqPktV3BM9hZagu3i7m0Tte2phlW3r0HEVJwhlFQzOFtNEojptpQYMXc5d5Y6vb
         SesOd3+J+qeLVCvrxIII9K07ocm494iEpzU6f4lcU6FgTrYS+N/SaDN4deqdnIUu2kqv
         cvJMghFiGaAZt2ToOPqrBFVJaw7IMWhB/hSwcU61D77pD0E69Wpd09QXgZrBvZi9DnpF
         95jTnzMpfUaNqZ/JZBxiQSxMr8Oj2LMhFhvxxYrVh6UH6Gv2d5y74d2XnW6kC5EVXcNz
         1ibR3jZJEMpZ3HMtnGEHwKMjMtIt8HFuhB0S+UUt3c87qMFUWuiNILSeNilQHQVL1MJD
         ab5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=ZcaC4oTgG/PlV9poOXJ36kULNC51Co2C0YUm8Meayf0=;
        b=nFbQmjNRLJE8aZ1/2opOO00raPXd9+9Sm/f2M6KL31arf43MAJU6KJLD3T5ziJHpJ3
         g8EszhXiMlYBkZO9IOURYx62onlLMzQdv9JKk6bnnA9PlcwsxIyCuxq3pXfo6zeLOl0x
         MdULCOeRtI7Bjh5857SEXsViaYOQWACkuJnuFBOV5n0guH7lVuqeUaSH7NBj5M4S5TJ8
         kvoxoenESS2+/0u1pDsYEucYmg5SQdrvPSh3fvLtqfzfbZkYKhlLcb6CQaJ015iJMroU
         fWerqNO8n34fId0/cuLUiMKQGvzkzARQaBYD+0swTrguDZBFOY/zRxbgxyHFbvvEUlt4
         uKRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gregory.clement@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=gregory.clement@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gregory.clement@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=gregory.clement@bootlin.com
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Omri Itach <omrii@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Igal Liberman <igall@marvell.com>,
	Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 0/2] Allow xhci-plat using a second clock
Date: Thu, 19 Apr 2018 15:30:51 +0200
Message-Id: <20180419133053.11894-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.16.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598181522898010274?=
X-GMAIL-MSGID: =?utf-8?q?1598181522898010274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

The purpose of this series is to allow xhci-plat using a second
clock. It is needed on the Armada 7K/8K but could be used by other
SoCs.

The first patch is just an other fix found while I was working on this
feature.

Thanks,

Gregory

Changelog:
v1 -> v2:

 - Rebased on v4.17-rc1

Gregory CLEMENT (2):
  usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
  usb: host: xhci-plat: Fix clock resource by adding a register clock

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  5 +++-
 drivers/usb/host/xhci-plat.c                       | 31 ++++++++++++++++------
 drivers/usb/host/xhci.h                            |  3 ++-
 3 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.16.3
