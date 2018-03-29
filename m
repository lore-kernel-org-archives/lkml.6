Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522338175; cv=none;
        d=google.com; s=arc-20160816;
        b=Vp48epymqfhNFKgG2GOxMuEA6VBqdscwjx7JYODR0By8cQ3bxUtKTML31MHEsKfM32
         QDFvp2yYlBBZBNLSy+OEag+HvINThTBi9OmcwQpuOQUjf0J4FsWJNBuQYQGHEI5Z3xtP
         dCdCTldcUw0/owoxFB4T1EelU4V1fW33qoYWgws+/Gpy/FKCsLxOD1mbx7gMHDMIus00
         EzDMWtjS/RAWsdF8wg8CsMGARjcpktOe9tV9pnhhBQtALN1EjolO44o/74nMktXNflrj
         u67VsIYX9rjR8C2m671dBwk4oe4a/w9S6AE/qpxCgMref0j8JN83Uul2DfmH0kK+uQNe
         tpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=DYuzwaUm0hGRFFwPjeo7EcMuqvEl5bxUMZF3K300kyw=;
        b=ZqlUKEetkjLgBuMr5E8OvsPlOS3316z53Pvjq3l/N0jgPaJFLqngT66g7yloDefoq1
         UlrlUYm40m1xI3Rqw2HvACHDUCwvbix+X7hPv8EILHri/qQ1UbACx05tjbyrxYp8QOqH
         Ss0uzoPuyUhY17Dr4nqRttnjTe9MYA0zQ5EApvi1nsrtnCcv0nYYO8Up9T13bCEDib9x
         J5Gj7TQi7eze6i7l0h6ys8/gQt4pBcB2IXNWSguc6XTUOWOU20He5KijwzNSs+qUmJlp
         LWFBiL8ZH4LnQ0/jvVpzzCDZPcaqAhFND/jiJHbNcMO7CWSBpbBXyCTBCJYW8hGkpqoY
         lX9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx4/LzbmgOF2OZX3jce32Hc0DELehSrJUkle2LJj2Dsoct/0mw/32CNkLWvrmTJFy5V2PrDlHeg==
From: Moritz Fischer <mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/6] FPGA Manager Patches for 4.17
Date: Thu, 29 Mar 2018 08:36:52 -0700
Message-Id: <20180329153658.11614-1-mdf@kernel.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287274725977231?=
X-GMAIL-MSGID: =?utf-8?q?1596287274725977231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

can you please take the following patches for 4.17.

Alan's changes are mostly refactoring in preparation for non-dt based
FPGA regions.

Anatolij's changes fix a small issue with altera-ps-spi FPGAs,
where the FPGA is being reset unnessesarily on driver load.

All patches have been reviewed on the list.

I'm sending the patches this time instead of Alan so I can get more
familiar with the process.

If you prefer to pull instead there's also a signed tag:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux.git tags/fpga-for-greg-4.17

Thanks,

Moritz

Alan Tull (5):
  fpga: region: don't use drvdata in common fpga code
  fpga: manager: don't use drvdata in common fpga code
  fpga: bridge: don't use drvdata in common fpga code
  fpga: region: change fpga_region_register to have one param
  fpga: fpga-region: comment on fpga_region_program_fpga locking

Anatolij Gustschin (1):
  fpga-manager: altera-ps-spi: preserve nCONFIG state

 Documentation/fpga/fpga-mgr.txt     | 24 +++++++++++++++------
 Documentation/fpga/fpga-region.txt  |  3 +--
 drivers/fpga/altera-cvp.c           | 18 ++++++++++++----
 drivers/fpga/altera-fpga2sdram.c    | 20 +++++++++++++----
 drivers/fpga/altera-freeze-bridge.c | 18 +++++++++++++---
 drivers/fpga/altera-hps2fpga.c      | 16 +++++++++++---
 drivers/fpga/altera-pr-ip-core.c    | 17 +++++++++++++--
 drivers/fpga/altera-ps-spi.c        | 20 +++++++++++++----
 drivers/fpga/fpga-bridge.c          | 43 ++++++++++++++-----------------------
 drivers/fpga/fpga-mgr.c             | 39 ++++++++++++---------------------
 drivers/fpga/fpga-region.c          | 14 ++++++++++--
 drivers/fpga/ice40-spi.c            | 20 +++++++++++++----
 drivers/fpga/of-fpga-region.c       |  4 +++-
 drivers/fpga/socfpga-a10.c          | 16 +++++++++++---
 drivers/fpga/socfpga.c              | 18 +++++++++++++---
 drivers/fpga/ts73xx-fpga.c          | 18 +++++++++++++---
 drivers/fpga/xilinx-pr-decoupler.c  | 15 ++++++++++---
 drivers/fpga/xilinx-spi.c           | 18 +++++++++++++---
 drivers/fpga/zynq-fpga.c            | 16 +++++++++++---
 include/linux/fpga/fpga-bridge.h    |  7 +++---
 include/linux/fpga/fpga-mgr.h       |  8 +++----
 include/linux/fpga/fpga-region.h    |  4 +++-
 22 files changed, 262 insertions(+), 114 deletions(-)

-- 
2.16.2
