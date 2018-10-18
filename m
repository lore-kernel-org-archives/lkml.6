Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F4AC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4496220866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wTLC7jK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4496220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJSGlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:41:14 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:51049 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbeJSGlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:41:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 13C12C61;
        Thu, 18 Oct 2018 18:38:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 18 Oct 2018 18:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=SD3ThzvZe3sjq9LElJk+QtNx0eIw74f5QmE321O5RSc=; b=wTLC7jK1
        b2aubAk4h5qBQZCVCWvL3kIX0atB8+vfTwoCaamu8anDisrGmGsIfJytCaE6emCp
        J1hA8jhqwKRXXfzrq1FRouenaLTyfvhCm5X1mo3lW9AcwZKm4yCcCRRcE2P76MdU
        jazyaiDH3xp3jknQjv+2OnohL6cANh3Ng4A2aav8OeC1B8xXbZ2s27ZR2V93P763
        y4lDWh8rM2uLTBfaGHfFYsIYAkbuaEXGvka+ceOCB+Jl86jOkZCMnvzX6EiHIsnb
        WtWqmE+yDbq3vX+KZOuXGDEL9og5j3cpXJVPHydB4K4DM2MnH+BjmUamaCV8euog
        1IR5atBAthQIJg==
X-ME-Sender: <xms:TAvJWwH7TG6pTNGgNui7LnSefSlooL_OosU8JUoGz5U-TUWjOP0zsg>
X-ME-Proxy: <xmx:TAvJW1ehO8HRjZKOxuqE0cnC9LDCglfjH3rDAH7ClTbYaq84XNMC4A>
    <xmx:TAvJW9uDR7L7k6IPVw0-I1rpx512xM-9hG6m8Gr4er0jI5ynvJmwRA>
    <xmx:TAvJW7eD8-YZmp2rLmpdtOiy7k6DjAN5Li910CeMPRkSLF6huW80_A>
    <xmx:TAvJWxpGJliCkD4Ldpr4XbfzBCY6uKBVAersrqIgtT519Hv_vuMY1g>
    <xmx:TAvJW594_eswkaEP6zziggIYYhzkMUy-uiMDQojvRAkqTjVRYkzFwA>
    <xmx:TAvJW9UNJxy3vPAU6HNAqrr4D-vGZNORqFWDG3qu_F6HNXt0z9r-6Q>
Received: from localhost (124-169-31-211.dyn.iinet.net.au [124.169.31.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 47BA5102DE;
        Thu, 18 Oct 2018 18:38:03 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] drivers: tty: Fix kernel-docs comments
Date:   Fri, 19 Oct 2018 09:37:00 +1100
Message-Id: <20181018223707.9891-1-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v2 with the author amended to use the correct _new_ email address
(thanks Geert and Greg) so that the SoB is correct.

Applies on top of tty-next tree.

From v1:

My first patch set using kernel.org email address.  I've been so careful
with this one I'm expecting some epic fail :)

This set is an attempt to clean up the kernel docs comments under
drivers/tty/.  I do not know what time in the kernel dev cycle would be
best for this set.  If now is not the time please do not hesitate to say
so and stop reading here.

I included a couple of whitespace patches to kick off with, in hindsight
these might be nothing more than code churn (if so I can remove them).

I had a real hard time breaking these changes up into separate patches.
This was mainly because I was super conscious that this set is
borderline trivial yet large enough to be a P in the A to review.  I
have reviewed these patches a bunch of times myself and am happy with
the result being as easy to review as I know how.  If there was anything
more I could have done please say.  Patch 3 and 7 are the two that are
most arduous to review.

Apart from the first two whitespace patches only comments are touched by
this set.  The set builds cleanly but does _not_ checkpatch cleanly -
there is a limit to the code churn I was willing to risk posting :)

Extra thanks to anyone who reviews this.  This set is super non-critical
so please only review at your leisure.

thanks,
Tobin.


v2:
 - Check author of each patch, run when required:
    `git commit --amend --author="Tobin C. Harding <tobin@kernel.org>"
 - Fix introduced 'space before tab warnings' in patch 3 and 7.
 

Tobin C. Harding (7):
  tty: Fix whitespace before tab warnings
  tty: Remove trailing whitespace
  tty: Partially fix kernel-docs layout
  tty: Fix kernel-doc variable typos
  tty: Fix spacing between kernel-doc sections
  tty: Remove newline after function kernel-doc
  tty: Fix section format

 drivers/tty/amiserial.c                     |   62 +-
 drivers/tty/cyclades.c                      |    2 +-
 drivers/tty/ehv_bytechan.c                  |    2 +-
 drivers/tty/hvc/hvc_console.c               |    8 +-
 drivers/tty/hvc/hvc_iucv.c                  |   14 +-
 drivers/tty/hvc/hvc_xen.c                   |    2 +-
 drivers/tty/hvc/hvcs.c                      |    4 +-
 drivers/tty/ipwireless/tty.c                |    2 +-
 drivers/tty/isicom.c                        |    4 +-
 drivers/tty/mips_ejtag_fdc.c                |    4 +-
 drivers/tty/moxa.c                          |   38 +-
 drivers/tty/mxser.c                         |   14 +-
 drivers/tty/n_gsm.c                         |  754 +++++++-------
 drivers/tty/n_hdlc.c                        |  208 ++--
 drivers/tty/n_r3964.c                       |    6 +-
 drivers/tty/n_tracerouter.c                 |   18 +-
 drivers/tty/n_tracesink.c                   |   24 +-
 drivers/tty/n_tty.c                         |  688 ++++++-------
 drivers/tty/pty.c                           |  126 ++-
 drivers/tty/rocket.c                        |   78 +-
 drivers/tty/serdev/core.c                   |    2 +-
 drivers/tty/serial/21285.c                  |    2 +-
 drivers/tty/serial/8250/8250_core.c         |   72 +-
 drivers/tty/serial/8250/8250_dw.c           |    4 +-
 drivers/tty/serial/8250/8250_port.c         |   42 +-
 drivers/tty/serial/amba-pl010.c             |    2 +-
 drivers/tty/serial/amba-pl011.c             |   34 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    8 +-
 drivers/tty/serial/earlycon.c               |   26 +-
 drivers/tty/serial/icom.c                   |    5 +-
 drivers/tty/serial/ifx6x60.c                |  387 ++++---
 drivers/tty/serial/ioc3_serial.c            |   73 +-
 drivers/tty/serial/ioc4_serial.c            |   85 +-
 drivers/tty/serial/ip22zilog.c              |    2 +-
 drivers/tty/serial/jsm/jsm_neo.c            |    2 +-
 drivers/tty/serial/kgdb_nmi.c               |    2 +-
 drivers/tty/serial/max3100.c                |    2 +-
 drivers/tty/serial/max310x.c                |    2 +-
 drivers/tty/serial/men_z135_uart.c          |    5 +-
 drivers/tty/serial/mux.c                    |   62 +-
 drivers/tty/serial/mxs-auart.c              |    2 +-
 drivers/tty/serial/pmac_zilog.c             |   62 +-
 drivers/tty/serial/pxa.c                    |   20 +-
 drivers/tty/serial/sa1100.c                 |    2 +-
 drivers/tty/serial/serial-tegra.c           |    4 +-
 drivers/tty/serial/serial_core.c            |  198 ++--
 drivers/tty/serial/serial_txx9.c            |   23 +-
 drivers/tty/serial/sn_console.c             |  105 +-
 drivers/tty/serial/sunsab.c                 |   16 +-
 drivers/tty/serial/sunsu.c                  |    8 +-
 drivers/tty/serial/sunzilog.c               |   10 +-
 drivers/tty/serial/uartlite.c               |   15 +-
 drivers/tty/serial/ucc_uart.c               |  134 +--
 drivers/tty/serial/vr41xx_siu.c             |    2 +-
 drivers/tty/serial/xilinx_uartps.c          |   71 +-
 drivers/tty/serial/zs.c                     |   12 +-
 drivers/tty/synclink.c                      | 1016 +++++++++----------
 drivers/tty/synclinkmp.c                    |   16 +-
 drivers/tty/sysrq.c                         |   34 +-
 drivers/tty/tty_audit.c                     |   39 +-
 drivers/tty/tty_baudrate.c                  |   77 +-
 drivers/tty/tty_buffer.c                    |  245 +++--
 drivers/tty/tty_io.c                        |  847 ++++++++--------
 drivers/tty/tty_ioctl.c                     |  222 ++--
 drivers/tty/tty_jobctrl.c                   |  140 ++-
 drivers/tty/tty_ldisc.c                     |  290 +++---
 drivers/tty/tty_port.c                      |  124 ++-
 drivers/tty/vt/consolemap.c                 |   84 +-
 drivers/tty/vt/keyboard.c                   |  165 +--
 drivers/tty/vt/selection.c                  |   40 +-
 drivers/tty/vt/vt.c                         |  138 ++-
 drivers/tty/vt/vt_ioctl.c                   |   70 +-
 72 files changed, 3452 insertions(+), 3656 deletions(-)

-- 
2.17.1

