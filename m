Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeCURfd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:35:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33185 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeCURf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:35:29 -0400
X-Google-Smtp-Source: AG47ELv+EIqLVUMEBBmVDiCwAeK5SPgibLjoCUGRD6DWwYT9nrR6WLdh/53vEA4B1pcVLSZgW7HDjA==
From: Paolo Pisati <p.pisati@gmail.com>
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 v7] Lattice MachXO2 Slave SPI FPGA Manager support
Date: Wed, 21 Mar 2018 18:35:24 +0100
Message-Id: <1521653726-24625-1-git-send-email-p.pisati@gmail.com>
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

Changes since v6:
* added the SPDX boilerplate
* switched to pr_debug() and renamed MACHXO2_DEBUG to DEBUG


Paolo Pisati (2):
  dt: bindings: fpga: add lattice machxo2 slave spi binding description
  fpga: lattice machxo2: Add Lattice MachXO2 support

 .../bindings/fpga/lattice-machxo2-spi.txt          |  29 ++
 drivers/fpga/Kconfig                               |   8 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/machxo2-spi.c                         | 405 +++++++++++++++++++++
 4 files changed, 443 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 drivers/fpga/machxo2-spi.c

-- 
2.7.4
