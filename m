Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-348652-1524840092-3-284524675557861379
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840091; b=Yw1VpGX+xf6epHDG/BsLqpvslGCclRYBsn77spSMGNCtxCk1Vg
    NKBQYpjftn8iID4vaty8vZzbJqumCi7I5gQ0UKo8zAqGYOQxRVYrb7DQmSfVNiQA
    73jx09PbbKUe696mGQSBobp/TupCIwyHWEJ98ZVPv1/o6maBhpGgXUodp/7ho0++
    kCEQazFdx3thRgj5PMYVv1ESZxeTR5vPX+lwHZ2QXbO82Ou+kaGSor7hXhdfirrg
    MVbTTm/mWwnDKElIz2+aijOOm3fMxttle1ySQkC92C/GMo2hDXZNnPJ1tHyvp/01
    zOb9qmJF31XCFuJuj5AvKSE7y8n/u0r73t0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524840091;
    bh=w4IkuPEKq2fJJ7k1OQl2DHFLacF+O6KkYXGvmZnpUAc=; b=grzlX8Z4KVyJ
    qn2YLMsVxrJ29GfU1wR9kDTAs9rEoZgp/99c1Fo2dIDwDJ0p8zzc3rWqo11NfXER
    4B20e57WoF/92jKiukqmKOPMEqUMM27eW5aR4LYuoxlTIeyPVhjG9IT1q6pmrhJM
    CyfudVCp2f9IK9H+0ia6DcM/Z9/OtEqit72twrZa+J54HqxFNMDsuAKcYPHcO1TM
    OVBCpFCgQ7Z9phYZpOgB220bFV7oKmQ9UIBqjIFSjuJMJQVe9YwVYjKx6P5esAMl
    ezGhA47Sq57/qmwn2tpp0trdqZuNgJh9YXKH4KBle/1b3P0Ay44yzUwSqfB3exwo
    ixYmAMlgzg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEl+Q57XDC3SWFRPLGYXHcYant7Ay+rPhKfVKvNCJ4vL0rqs9vKGl12T+i4pHQIH6i8m9IQehyrylDjJSHLCGrgjuuSO3aqYDQ8ngu2C0f3E3QH80J2L
    ik87K8JjckmxxRcdilJzFIdoeCTV2wy/CD5RPlSRHk6cl3dIdMSiaN0mVoD97GHL0huGkkR+MZPjyZnyc6RdXcW6ccEaJq+GP9sMMUyP963HSxpGshHbEgBP
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=CzvQiGJaEjxHkL6M5h8A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934612AbeD0OlR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934597AbeD0OlQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Apr 2018 10:41:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C2D218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 16:41:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 4.17-rc3
Message-ID: <20180427144104.GA9231@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.17-rc3

for you to fetch changes up to bcdd0ca8cb8730573afebcaae4138f8f4c8eaa20:

  tty: Use __GFP_NOFAIL for tty_ldisc_get() (2018-04-25 15:03:44 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 4.17-rc3

Here are some tty and serial driver fixes for reported issues for
4.17-rc3.

Nothing major, but a number of small things:
	- device tree fixes/updates for serial ports
	- earlycon fixes
	- n_gsm fixes
	- tty core change reverted to help resolve syszkaller reports
	- other serial driver small fixes

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Biju Das (1):
      serial: sh-sci: Document r8a77470 bindings

Daniel Kurtz (1):
      earlycon: Use a pointer table to fix __earlycon_table stride

Geert Uytterhoeven (2):
      dt-bindings: meson-uart: DT fix s/clocks-names/clock-names/
      dt-bindings: mvebu-uart: DT fix s/interrupts-names/interrupt-names/

Karthikeyan Ramasubramanian (1):
      tty: serial: qcom_geni_serial: Use signed variable to get IRQ

Marc Zyngier (1):
      serial: mvebu-uart: Fix local flags handling on termios update

Michal Simek (1):
      tty: serial: xuartps: Setup early console when uartclk is also passed

Stefan Agner (2):
      serial: imx: warn user when using unsupported configuration
      serial: imx: fix cached UCR2 read on software reset

Tetsuo Handa (3):
      tty: Avoid possible error pointer dereference at tty_ldisc_restore().
      tty: Don't call panic() at tty_ldisc_init()
      tty: Use __GFP_NOFAIL for tty_ldisc_get()

Tony Lindgren (2):
      tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
      tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

 .../bindings/serial/amlogic,meson-uart.txt         |  2 +-
 .../devicetree/bindings/serial/mvebu-uart.txt      |  2 +-
 .../bindings/serial/renesas,sci-serial.txt         |  2 ++
 drivers/of/fdt.c                                   |  7 ++++--
 drivers/tty/n_gsm.c                                | 23 ++++++++++++++++-
 drivers/tty/serial/earlycon.c                      |  6 +++--
 drivers/tty/serial/imx.c                           | 19 +++++++++++++-
 drivers/tty/serial/mvebu-uart.c                    |  1 -
 drivers/tty/serial/qcom_geni_serial.c              | 10 +++++---
 drivers/tty/serial/xilinx_uartps.c                 |  2 +-
 drivers/tty/tty_io.c                               |  5 +++-
 drivers/tty/tty_ldisc.c                            | 29 ++++++++++------------
 include/asm-generic/vmlinux.lds.h                  |  2 +-
 include/linux/serial_core.h                        | 21 ++++++++++------
 include/linux/tty.h                                |  2 +-
 15 files changed, 93 insertions(+), 40 deletions(-)
