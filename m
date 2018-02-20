Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2549902-1519120676-2-7206696191109469355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='be',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519120676; b=rV8J2kkSnCUBdNrFUfh1+HNj1idylBiocmxASzpG83lBKTA
    SNeg8b+xnQaP7Y2Ggl+gidqMQXwb82gyTif2h8VjQhhUGiwQejbAgApcH8AanAVa
    CmIR7b1XIRDuVxzqFJHsS8DHv9lJzDWnKcpmRqbYNngbRgkOcc8GJ5IwF9KcIL1P
    gUWXZSirVrjMh9LVPRIL5uzhk4nNlQb+/lLvQ2aHBMtqQYJ+FprB8zSdxZN3q2Vz
    iw6IlDOFL4P3jwtj4xYrrRFpJjHNfXw7unkkwQUunn6b3sq6aeQ04fjlacuIjewe
    vBV5gpO9KRD4C4wo1vB+dqBXzkBoWfK062Nms3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519120676; bh=UHJxlMkY0M6RdXwKCEpYXzoSHE
    OYb5CYmlR/EQsSdxk=; b=pxqx+SzHUNkMNcq7BRn4MEtADiGxKTEnt4ZO47ijKT
    dUSP0b/1z7d6utzd+b2G9wMoiPVkfoZj+qWMXHHucWsDliORH9mla1xJdQWsBD4F
    fNhIgLHt3Qr5OQhBlB13R+UlGN/Qo4xMu6+niCIY7m7tVTYcZYv3x1TfYR9RFYZI
    yZJttHipg5nFLmhUM00mUhI+KiI3/IqwcWmES3t+aCgFN0OFtAI8K+m0vD5x9h14
    ZqpB1hPTT3j4M0eVCPEx9TiMBp9MiwWsvjODVtiGtoVVdAyg53TDdG0ZSseS6kgM
    IIKdh3MM2EQZLeElc/32FZKZBsXJHjy4SIsOJUukGMfQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeBTJ5a (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 04:57:30 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:60170 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBTJ5Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 04:57:25 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Barry Song <baohua@kernel.org>, Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/9] serial: Fix out-of-bounds accesses through DT aliases
Date: Tue, 20 Feb 2018 10:40:15 +0100
Message-Id: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

	Hi all,

Serial drivers used on DT platforms use the "serialN" alias in DT to
obtain the serial port index for a specific port.  Drivers typically use
a fixed-size array for keeping track of all available serial ports.
However, several drivers do not perform any validation on the index
obtained from DT, which may lead to out-of-bounds accesses of these
fixed-size arrays.

While the DTB passed to the kernel might be considered trusted, some of
these out-of-bounds accesses can be triggered by a legitimate DTB:
  - In some drivers the size of the array is defined by a Kconfig
    symbol, so a user who doesn't need all serial ports may lower this
    value rightfully,
  - Tomorrow's new SoC may have more serial ports than the fixed-size
    array in today's driver can accommodate, which the user may forget
    to enlarge.

Hence this series fixes that by adding checks for out-of-range aliases,
logging an error message when triggered.

Tested on r8a7791/koelsch (sh-sci), all other drivers were
compile-tested only.

Thanks for your comments!

Geert Uytterhoeven (9):
  serial: arc_uart: Fix out-of-bounds access through DT alias
  serial: fsl_lpuart: Fix out-of-bounds access through DT alias
  serial: imx: Fix out-of-bounds access through DT alias
  serial: mxs-auart: Fix out-of-bounds access through DT alias
  serial: pxa: Fix out-of-bounds access through DT alias
  serial: samsung: Fix out-of-bounds access through DT alias
  serial: sh-sci: Fix out-of-bounds access through DT alias
  serial: sirf: Fix out-of-bounds access through DT alias
  serial: xuartps: Fix out-of-bounds access through DT alias

 drivers/tty/serial/arc_uart.c      | 5 +++++
 drivers/tty/serial/fsl_lpuart.c    | 4 ++++
 drivers/tty/serial/imx.c           | 5 +++++
 drivers/tty/serial/mxs-auart.c     | 4 ++++
 drivers/tty/serial/pxa.c           | 4 ++++
 drivers/tty/serial/samsung.c       | 4 ++++
 drivers/tty/serial/sh-sci.c        | 4 ++++
 drivers/tty/serial/sirfsoc_uart.c  | 5 +++++
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 9 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
