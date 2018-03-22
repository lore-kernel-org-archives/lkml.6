Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELuFB9oA+5w2VPIs91Vmpk3PDGxsF672nlF91CKpynrEXhJTvXmVn4xuOjX9ccpWeFkom6e8
ARC-Seal: i=1; a=rsa-sha256; t=1521739034; cv=none;
        d=google.com; s=arc-20160816;
        b=jDkdV32Tqq5Vcm03yX1mmXzGmHrNGRs9AmBPN78feyeoePoyB44mlCmS11OjUwH/LO
         t4a1WEwDRzUL4ww61ZwZXVQQEzkiD6sCYrvFFy/NgNd6lHnAMehbYCwFwodWXw3d59qr
         6PQ9eaPBC16X8KnZUbrEPN/fTUgCG7A1cxAhx7ELBje91i38lSoT2oXGEBqxMp05Dnq5
         THb0D3YBWcITh1wqc7DY6/uZ1d6dLmoqEeSXvtbs9ZvUUp1ZeyfVTP2oqlVcXR7Pbmgw
         YV5HOLOOn25SkrZ67ZPOu9/Kzo/MafXDup+0AjVm+Mn4/gt832lDyAcsq5/3YnDX8I5I
         wpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:message-id:date:cc
         :to:from:arc-authentication-results;
        bh=QbkxJ96zZrNMFiaNmVDfnmBMb0mPoQd0w+GvhdO69Uw=;
        b=v4FIWEEZFe/Cj7cNC73SEif+QhRevL/ao7NrM3aSVne/O5HMbNCMJgYqpJFAuQv870
         m9IwsjzaqKBEPV/Ad5nfZOF4Y9nFTPHBzJmmy9ku9hJsO/i0BCxA2Y7SIiFzcLOK87V3
         yxZfgPD9OifNLewlgAtpoeILitTSqauj15AA4uRqsE3ROXjBsaSJbx8B4YRBh3qVJdWR
         PzlUY0RCH4fPfLwZP39CL7O2GzanHLJGtsvaP0UDTxLObrqLQiGfhM3dE0oJrN0f4qfJ
         1Ajw2gBZ7u76nbrtodWi15vh5/BqT5woansDz6U5Np/rQ2z3oGxnS4nUpMyMMP6aydpm
         i1yA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 22 Mar 2018 11:16:53 -0600
Message-Id: <20180322171703.4300-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v14 00/10] Add io{read|write}64 to io-64-atomic headers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595659028453474554?=
X-GMAIL-MSGID: =?utf-8?q?1595659028453474554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is v14 of my cleanup series to push a number of instances of people
defining their own io{read|write}64 functions into common headers seing
they don't exist in non-64bit systems. This series adds inline functions to the
io-64-nonatomic headers and then cleans up the drivers that defined their
own copies.

This cleanup was originally requested by Greg after he reviewed my
Switchtec NTB code. And I hope someone can pick it up or at least give
feedback on it soon as it's been around relatively unchanged for a few
cycles now and I'm getting a bit tired of resubmitting it with little to
no interest.

Thanks,

Logan

--

Changes since v13:
- Changed the subject of patch 0001 to correct a nit pointed out by Luc

Changes since v12:
- Rebased onto v4.16-rc6
- Split patch 0001 into two and reworked the commit log as requested
  by Luc Van Oostenryck

Changes since v11:
- Rebased onto v4.16-rc5
- Added a patch (0001) to fix some old and new sparse warnings
  that the kbuild robot warned about this cycle. The latest version
  of sparse was required to reproduce these.
- Added a patch (0002) to add io{read|write}64 to parisc which the kbuild
  robot also found errors for this cycle

Changes since v10:
- Rebased onto v4.16-rc4, this droped the drm/tilcdc patch which was
  picked up by that tree and is already in 4.16.

Changes since v9:
- Rebased onto v4.15-rc6
- Fixed a couple of issues in the new version of the CAAM patch as
  pointed out by Horia

Changes since v8:
- Rebased onto v4.15-rc2, as a result rewrote patch 7 seeing someone did
  some similar cleanup in that area.
- Added a patch to clean up the Switchtec NTB driver which landed in
  v4.15-rc1

Changes since v7:
- Fix minor nits from Andy Shevchenko
- Rebased onto v4.14-rc1

Changes since v6:
 ** none **

Changes since v5:
- Added a fix to the tilcdc driver to ensure it doesn't use the
  non-atomic operation. (This includes adding io{read|write}64[be]_is_nonatomic
  defines).

Changes since v4:
- Add functions so the powerpc implementation of iomap.c compiles. (As
  noticed by Horia)

Changes since v3:

- I noticed powerpc didn't use the appropriate functions seeing
  readq/writeq were not defined when iomap.h was included. Thus I've
  included a patch to adjust this
- Fixed some mistakes with a couple of the defines in io-64-nonatomic*
  headers
- Fixed a typo noticed by Horia.

(earlier versions were drastically different)

--

Logan Gunthorpe (10):
  iomap: Use correct endian conversion function in mmio_writeXXbe
  iomap: Add big endian sparse annotations to mmio_{read|write}XXbe()
  parisc: iomap: introduce io{read|write}64
  powerpc: io.h: move iomap.h include so that it can use readq/writeq
    defs
  powerpc: iomap.c: introduce io{read|write}64_{lo_hi|hi_lo}
  iomap: introduce io{read|write}64_{lo_hi|hi_lo}
  io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
  ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
  crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
  ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common
    header

 arch/parisc/include/asm/io.h           |   9 +++
 arch/parisc/lib/iomap.c                |  64 +++++++++++++++
 arch/powerpc/include/asm/io.h          |   6 +-
 arch/powerpc/kernel/iomap.c            |  40 ++++++++++
 drivers/crypto/caam/regs.h             |  30 +------
 drivers/ntb/hw/intel/ntb_hw_intel.c    |  30 +------
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  36 +--------
 include/asm-generic/iomap.h            |  26 ++++--
 include/linux/io-64-nonatomic-hi-lo.h  |  64 +++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h  |  64 +++++++++++++++
 lib/iomap.c                            | 140 ++++++++++++++++++++++++++++++++-
 11 files changed, 409 insertions(+), 100 deletions(-)

--
2.11.0
