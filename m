Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC0FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB05121471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjG33ni0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB05121471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJQHOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:14:35 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60263 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbeJQHOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:14:35 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C864221F75;
        Tue, 16 Oct 2018 19:21:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Oct 2018 19:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=wl/5ywfNokEmpgnJ3EEPPtO5jpP/e1MpJLRWp/LUYk8=; b=hjG33ni0
        juWGjRQmg102rml1zRx017m0Pvb+ceRbiRGwpZr+oXSeAtUrBEkQNxxrLCgdLYta
        Sd+TR+IFCwhGH7rH1Cqpvg/vW+4HP8LhL1YLTdDfyuyHG1ihoId9CBFQFSZy/Bxe
        HX0AMw/1kV0P0GC2MZZ6ktq8czWZu8nfZk9/IFObjt6sXEctzGbwuvmIT0becqOk
        nIMrEkCG5qWeJomt3MWEBnBldYD2FVeocnIW105g0Sv21Sf+MqHueqj/QSr+/qN+
        8pTpuhJp6+skValeJAWEEroBpi+rAn9tJ30HiHy5a6P1QEPwwIg4wI3yulLig1Tw
        qza5ydwUsOgb+w==
X-ME-Sender: <xms:jnLGW0gYjI-CSSTdgxAmjSmqo5xvAuqvz_DcHgLt4I98v_Sf6jObrQ>
X-ME-Proxy: <xmx:jnLGWwgKDOyF0RjtQLATLlvl7T2yw6GbTWc1x-eA4KPo--0wz5nTxA>
    <xmx:jnLGW78LEV-7xC3VX4D4F-hY8q1vEErY5nNJT5g9fLooGTb8WkkmWQ>
    <xmx:jnLGW8Rl5VgdcEJD90VEgNXi9h_2TLtIP6vgDYE6cSXk_XRvMK9F5g>
    <xmx:jnLGW-fvets3ds4IiVWM9FE5qqhkFQeGIvtpYWnVBIWkL9yi8TTtMA>
    <xmx:jnLGW6EXxMTe5sgferjBPyLuWRIpIPPEP4v5G_Nf788vK_FtZLaksw>
    <xmx:jnLGW__5rtooB6ZPdJeUKMYUnNRgcrr9y9IqsYWw0vbtMas3_pQsNQ>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id BFA4EE4071;
        Tue, 16 Oct 2018 19:21:49 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] drivers: tty: Fix kernel-docs comments
Date:   Wed, 17 Oct 2018 10:21:23 +1100
Message-Id: <20181016232130.728-1-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
 drivers/tty/tty_ioctl.c                     |  224 ++--
 drivers/tty/tty_jobctrl.c                   |  141 ++-
 drivers/tty/tty_ldisc.c                     |  290 +++---
 drivers/tty/tty_port.c                      |  124 ++-
 drivers/tty/vt/consolemap.c                 |   84 +-
 drivers/tty/vt/keyboard.c                   |  165 +--
 drivers/tty/vt/selection.c                  |   40 +-
 drivers/tty/vt/vt.c                         |  138 ++-
 drivers/tty/vt/vt_ioctl.c                   |   70 +-
 72 files changed, 3454 insertions(+), 3657 deletions(-)

-- 
2.17.1

