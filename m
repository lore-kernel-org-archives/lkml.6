Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbeCHXkb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:40:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:38633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbeCHXk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:40:29 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/8] Move most GPIO documentation to driver-api/gpio/ and ReST
Date: Fri,  9 Mar 2018 00:40:16 +0100
Message-Id: <20180308234024.24145-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:aqfnyGP5i1ZzFdE35Atp7nqm99LWtxLihv5rXb7yRd/5hnqJuOG
 D1qIWIBQrpZr+FBKRmhGASRdxzcC1R6Vo2jsW/7nm7ZV6Hk3OlJ9VLUoUuCZZaRkvBXF8oR
 nuuTy0+l6Ny6cz2h/jY+dKMWNGVmG/NfZJTGRbkwaEvRrUzoGlvfIOyhJ8DZxjBnffvbZcE
 PV6ljuJZwG7r6BSOZXdFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dQo375sOpZQ=:19qpG/9QWOELrjuzqpJIR5
 jVs40PAK8qiMVeWVF918XQTQYXhkrdF1dkG9xmCKMOUY7xIFg5luT2Yxx/zoDVOZxR3BCahH7
 Cmnph7i9Djbr/oJ33IoG0yKfyLhbuyZI/0voEOu9EoIDGyseVAzX0Kj9Ws/bmHqHHvhHdK86D
 fVkaVvy8mlQWmasqwE18mO0BIcQM1DK+R3xBhnQZKz9rOXOx18hzK/fjfn4gLe8eRnrXSinHu
 a8nWJkqnJQgFpqI5Q94Toj6t5wGfl0tlwsDLqmDJXk+v9/eZymF4h8WTZM4abSZSs2p7PZmKA
 48nKg5GYuGswJJoDe5jyQChg40Q6Lwx9FUcZV5r0Yq3DTyjZeJufXqh/390SenbSysZY+nmAA
 8Ip+1w2oQWDPZWwMcUCPAg0rr34K7Y5krjL2wavS6e9GxefV4YmTXNRiMRvdLNEuavLXGcjd5
 IvbajsRbjKA7wdkI17ZjLSogZslQqWbZGZF3ZVkC/qMOEX3MtWQcbKfVMpuhilXFCFvrOdrbR
 pCvLqvmrRalT9NgKIt+gp1JBXAjraXeKMDbmeeda5ptSsq3T42bXvyxc45nEbg1qR1c0tnzKN
 FPiAOZisnai/x2K4ZwsYAphEMLwUSQ7Cwh8FTDAAfBGvzVS9XzHJAaJoHHxQXsKLle1KOOyPS
 S0sHIN/C6smfr9jcXnTwafOtwYvucECL08cMrqXBAAhD6wM1D/i6ChFud3l1LzHltZsX/SPOA
 knGK81sqg8Aati0ijffNUKwjOrZaPONxyFrMk/lyyGGPs8ppPi3W14ibPm6SfY/d7voKgThbO
 JBmMlm1aLaXieoOnhiA4wlVNz6IcV8zaN3Ye0aRta+QEfSCVZA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of this patchset is to move the GPIO subsystem's documentation
under Documentation/driver-api/gpio/ such that it is picked up by Sphinx
and compiled into HTML. I moved everything except for sysfs.txt, because
this file describes the legacy sysfs ABI, and doesn't seem to serve much
(non-historical) purpose anymore.

There are still some rough edges:

* I think the API documentation (kernel-doc) should be moved out of
  index.rst into more appropriate files.
* The headings are arguably wrong, because driver.rst, consumer.rst,
  etc. use the "document title" style, even though they are part of the
  GPIO chapter. But the resulting TOC tree is consistent, and I did not
  want to change almost all headings.
* Some of the files could use more :c:func:`...` references and general
  ReST polish.

But I don't want to make this patchset too large.

Jonathan Neuschäfer (8):
  MAINTAINERS: GPIO: Add Documentation/driver-api/gpio/
  Documentation: driver-api: Move gpio.rst to gpio/index.rst
  Documentation: gpio: Move introduction to driver-api
  Documentation: gpio: Move driver documentation to driver-api
  Documentation: gpio: Move legacy documentation to driver-api
  Documentation: gpio: Move gpiod_* consumer documentation to driver-api
  Documentation: gpio: Move GPIO mapping documentation to driver-api
  Documentation: gpio: Move drivers-on-gpio.txt to driver-api

 .../{gpio/board.txt => driver-api/gpio/board.rst}  | 39 +++++-----
 .../consumer.txt => driver-api/gpio/consumer.rst}  | 85 +++++++++++-----------
 .../driver.txt => driver-api/gpio/driver.rst}      | 80 ++++++++++----------
 .../gpio/drivers-on-gpio.rst}                      |  1 +
 .../driver-api/{gpio.rst => gpio/index.rst}        | 21 +++---
 .../{gpio/gpio.txt => driver-api/gpio/intro.rst}   |  9 ++-
 .../gpio-legacy.txt => driver-api/gpio/legacy.rst} | 68 ++++++++++-------
 Documentation/driver-api/index.rst                 |  2 +-
 Documentation/gpio/00-INDEX                        | 13 ----
 Documentation/gpio/sysfs.txt                       |  5 +-
 MAINTAINERS                                        |  1 +
 11 files changed, 169 insertions(+), 155 deletions(-)
 rename Documentation/{gpio/board.txt => driver-api/gpio/board.rst} (88%)
 rename Documentation/{gpio/consumer.txt => driver-api/gpio/consumer.rst} (89%)
 rename Documentation/{gpio/driver.txt => driver-api/gpio/driver.rst} (93%)
 rename Documentation/{gpio/drivers-on-gpio.txt => driver-api/gpio/drivers-on-gpio.rst} (99%)
 rename Documentation/driver-api/{gpio.rst => gpio/index.rst} (74%)
 rename Documentation/{gpio/gpio.txt => driver-api/gpio/intro.rst} (96%)
 rename Documentation/{gpio/gpio-legacy.txt => driver-api/gpio/legacy.rst} (96%)

-- 
2.16.1
