Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeCWM1S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:27:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51805 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeCWM1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:27:15 -0400
X-Google-Smtp-Source: AG47ELuzJaz08jHqarZ7PVuWLZDzxtElGW/Ysv39lkbfCizPNPpvcnWUtqgRkIRiUPg0v5dksBG7Nw==
From: Paolo Pisati <p.pisati@gmail.com>
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 v8] Lattice MachXO2 Slave SPI FPGA Manager support
Date: Fri, 23 Mar 2018 13:27:10 +0100
Message-Id: <1521808032-29645-1-git-send-email-p.pisati@gmail.com>
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

Changes since v7:
* misc style fixes, among which:
  * static const u8 cmd[]
  * #ifdef DEBUG ... #endif reorder
  * introduction of get_err_string()
  * direct returns to reduce line count
  * indentation


Paolo Pisati (2):
  dt: bindings: fpga: add lattice machxo2 slave spi binding description
  fpga: lattice machxo2: Add Lattice MachXO2 support

 .../bindings/fpga/lattice-machxo2-spi.txt          |  29 ++
 drivers/fpga/Kconfig                               |   8 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/machxo2-spi.c                         | 388 +++++++++++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 drivers/fpga/machxo2-spi.c

-- 
2.7.4
