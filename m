Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965405AbeCPPyg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:54:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35765 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeCPPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:54:32 -0400
X-Google-Smtp-Source: AG47ELv1e9tTZ1MPn0ydcKwryCi0k9gZ89LlVtDj9Iiyz7w5rGj7A3o37rsrPsCGCoznz2eBrrGYIA==
From: Paolo Pisati <p.pisati@gmail.com>
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 v6] Lattice MachXO2 Slave SPI FPGA Manager support
Date: Fri, 16 Mar 2018 16:54:27 +0100
Message-Id: <1521215669-23874-1-git-send-email-p.pisati@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
this series adds support for the Lattice MachXO2 FPGA chip, programmed
over Slave SPI.

Tested on a raspberry pi3, beaglebone black (little endian mode) and imx6
hummingboard (big endian mode) + bugblat's pif2 fpga hat (machxo2 7000HC) or
tinyfpga A1/A2 (machxo2 256HC / 1200HC), in SPI slave mode with varying bus
speed.

Changes since v5:
* fixed all the endianess issues
* introduced a cleanup() path invoked in case of flash failure
* moved back machxo2_write() to use a spi_sync() transaction per line write
  (in v5 i queued all the spi_write()s and executed a single spi_sync() at the
  end, but that, sometimes, resulted in the REFRESH command to fail with a
  CMD_ERR, depending on the SPI bus speed)


Paolo Pisati (2):
  dt: bindings: fpga: add lattice machxo2 slave spi binding description
  fpga: lattice machxo2: Add Lattice MachXO2 support

 .../bindings/fpga/lattice-machxo2-spi.txt          |  29 ++
 drivers/fpga/Kconfig                               |   8 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/machxo2-spi.c                         | 410 +++++++++++++++++++++
 4 files changed, 448 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 drivers/fpga/machxo2-spi.c

-- 
2.7.4
