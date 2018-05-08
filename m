Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525780168-2-4906901569561573686
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525780168; b=VG7FUVA5lT95Ohy08tHeO4y1gUPk2EY7q0eUPBPonxS4O9S+1x
    i4vNhBhJmybqwvsj4fBfs3KNgYA773AqLdE6YCc14wIRFsPcS7Js1wQFyzJ+hxiU
    V+vBJ2Arj4r1sjJ/HScjFiW00yyxzMKAhp2eVsz88gBHJF5ortwsk4L8UGVv6stI
    3Mejio4MpjL/R0xzzXLqMjsbVwGdIVP7fSM5HH05LqyGxc7EIt5YnvpbTyt/DkGe
    VsCsjau/1lt4kY8s6jToabGnIuBpZjre+FLLJwKdp9QDPkLce58dK91suy2V3pVu
    iPmQw4Y/WE6wNyfi0dkXlIQHgMCtfV9FFO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525780168;
    bh=y1uFWLjKNAzbVsIuA2bZ18pJRRLp2kjaySSDpnSUBfM=; b=GL3XLeLR2Ihp
    S0L1w5r8Pcdip+HuqjtudK10uIN2kZq1gt3XMhN6cyUe5CTNk4QbEz4wE9c0JsKb
    ld9sG2MvzRE8JF3qz12/8BRTy3GDjzw2y3+0hhQR/dO8s6SJuh2b3kDFuryFGavt
    Eoy00iEbCvsLAKm1cKLh+vbFobkCLcFJOYYzu5Iz2L/6UBgX8S4G93Axv9ooGwae
    jpO2bU2tKogqcy0nJdyfHnpmFbo4WOeElcLox586nsx0/qZuoPaY/fKe6COWf3k7
    NGwxqCxB+NxVIssCP6ia2yI0aVLGYu9ZpX1Qbbx8e80L10MV+jBup+3O6V8Fzxa+
    UsZ0FH8Zpw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOA2hTcz09nV29JH7glM9Jrf6dTcBu2HSVkHqiJfY4PWg4nCOYGtOPiSHMZXHFw6wXt4tn0X9KAVTAEkp8CHOMjo9W0v3DNJDQht11A0jP5kSpHxdoVN
    kbjsVGuJyPnFJkkDOF8eVHEu/lk6ITPcJ5t4C0EOG7fSv0vHoMN5sXLwRR3K5QuCm3gRwbYA7pOxJLnShUuPBwJeAWPLY5S8OAyEFsH4zjCwhch5C4REgW7n
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=REBUZm6ri2YXEs3N1ggA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbeEHLtX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 07:49:23 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11226 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbeEHLtV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 07:49:21 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 May 2018 04:49:21 -0700
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 0/8] Tegra Combined UART driver
Date: Tue, 8 May 2018 14:43:55 +0300
Message-ID: <20180508114403.14499-1-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

on Tegra194, the primary console UART is the "Tegra Combined UART",
or TCU. This is a "virtual UART", where each consumer communicates
with a central implementation over mailboxes. The central
implementation then multiplexes the streams and arbitrates use of
a hardware serial port. This driver implements the consumer portion
to allow using the primary console.

The series is split into the following parts:
* patches 1 and 2 add the device tree bindings for mailbox and tcu
  itself.
* patch 3 adds a blocking transmission option to the mailbox
  framework.
* patches 4 and 5 add support for the "shared mailbox" primitive
  to the Tegra HSP driver.
* patch 6 adds the TCU driver itself
* patches 7 and 8 do the necessary device tree changes.

The series has been tested on the Tegra194 P2972 board.

Thanks,
Mikko

Mikko Perttunen (8):
  dt-bindings: tegra186-hsp: Add shared interrupts
  dt-bindings: serial: Add bindings for nvidia,tegra194-tcu
  mailbox: Add transmit done by blocking option
  mailbox: tegra-hsp: Refactor in preparation of mailboxes
  mailbox: tegra-hsp: Add support for shared mailboxes
  serial: Add Tegra Combined UART driver
  arm64: tegra: Add nodes for tcu on Tegra194
  arm64: tegra: Mark tcu as primary serial port on Tegra194 P2888

 .../bindings/mailbox/nvidia,tegra186-hsp.txt       |   2 +
 .../bindings/serial/nvidia,tegra194-tcu.txt        |  35 +++
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  34 ++-
 drivers/mailbox/mailbox.c                          |  30 +-
 drivers/mailbox/mailbox.h                          |   1 +
 drivers/mailbox/tegra-hsp.c                        | 320 +++++++++++++++++----
 drivers/tty/serial/Kconfig                         |   9 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/tegra-tcu.c                     | 302 +++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 11 files changed, 671 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
 create mode 100644 drivers/tty/serial/tegra-tcu.c

-- 
2.16.1

