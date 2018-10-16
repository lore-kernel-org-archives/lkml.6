Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBACC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FB521471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cJAUR+qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FB521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeJQHPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:15:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36235 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbeJQHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:15:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C62FC22118;
        Tue, 16 Oct 2018 19:22:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 16 Oct 2018 19:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=/7hhyRNAYfxlgggNnVvSLlmAUb/Lj
        BdbCIbRkuoI604=; b=cJAUR+qfDvuZB5ogiFYZo3VDu3OE3ebYv1Hir1yxQUxlR
        9NI1N+SpEmw0uEFVHa0I09Tjz6/r31LYMgeSZP+Se5zMPGe313iHBKIyBT5AOuu5
        kQvopnzOlOaxCFV6wnzQvRGrp1jHVDRgz/ADZk1HbXJniiQhYLewDHyOvSFjPGDC
        /O7X7g81xL+P18j/XdDjt3OItseuUJp3vqiF62F5P0Ap5rvled5GJovMx0T1vipo
        ch7n7vAeFbBYtmPAdcMpGbDwN7TtZY06D+jQJSDTc3IqlwDr6TcAhJm5UgM5+g4H
        7kIXiMrEBDiybf4W1i5EdskzrJmJQbpP+93uA+A/g==
X-ME-Sender: <xms:nXLGW546Wt7SzD61T6OKRVcWAXdolST0kqWNnHULNXqqoZcTISCzIw>
X-ME-Proxy: <xmx:nXLGW1rqpkPRtmaB_aoRoyPrlDIb1XBhzbdk_uQAEmAjQ8Otl0GcDQ>
    <xmx:nXLGW_GHug5vwiexTux9lquq__qe-2SNfGivOYVgSfkArzaKRwZxQw>
    <xmx:nXLGW7JzgX2q3JakAspDUk-CMJYd6XzyeqoYFIA4BMNsS9h7dPDeXA>
    <xmx:nXLGW72pGy9ioaVNUjzfoRKzgGg7hxyaj8J9DNF1toZ87gpFSq_HZA>
    <xmx:nXLGW0KG3UiBvKlztoJuqxA73nYIVDsZ3zmVIL5EWutG2Ypcbe800g>
    <xmx:nXLGW2OEmeGxUJ84r26CrMAQpxdotwNwYVnd2uU3RHij23QrnfQ99A>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id BADFB102D7;
        Tue, 16 Oct 2018 19:22:02 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        linux-kernel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH 3/7] tty: Partially fix kernel-docs layout
Date:   Wed, 17 Oct 2018 10:21:26 +1100
Message-Id: <20181016232130.728-4-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016232130.728-1-tobin@kernel.org>
References: <20181016232130.728-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <me@tobin.cc>

Currently a bunch of the kernel-docs function comments contain custom
layout.  We should use the standard kernel-docs function comment layout
as per Documentation/doc-guide/kerenl-doc.rst

Fix layout in kernel-docs to be kernel standard.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 drivers/tty/ehv_bytechan.c          |   2 +-
 drivers/tty/n_gsm.c                 | 699 ++++++++++++------------
 drivers/tty/n_hdlc.c                |  28 +-
 drivers/tty/n_tracerouter.c         |   4 +-
 drivers/tty/n_tracesink.c           |   4 +-
 drivers/tty/n_tty.c                 | 660 +++++++++++------------
 drivers/tty/pty.c                   | 116 ++--
 drivers/tty/serial/8250/8250_core.c |  64 +--
 drivers/tty/serial/8250/8250_port.c |  42 +-
 drivers/tty/serial/amba-pl011.c     |  26 +-
 drivers/tty/serial/earlycon.c       |  26 +-
 drivers/tty/serial/ifx6x60.c        | 382 ++++++-------
 drivers/tty/serial/ioc3_serial.c    |  68 +--
 drivers/tty/serial/ioc4_serial.c    |  82 +--
 drivers/tty/serial/kgdb_nmi.c       |   2 +-
 drivers/tty/serial/mux.c            |  44 +-
 drivers/tty/serial/serial-tegra.c   |   2 +-
 drivers/tty/serial/serial_core.c    | 198 +++----
 drivers/tty/serial/serial_txx9.c    |  20 +-
 drivers/tty/serial/sn_console.c     |  66 +--
 drivers/tty/serial/uartlite.c       |  10 +-
 drivers/tty/serial/xilinx_uartps.c  |  54 +-
 drivers/tty/tty_audit.c             |  38 +-
 drivers/tty/tty_baudrate.c          |  70 +--
 drivers/tty/tty_buffer.c            | 226 ++++----
 drivers/tty/tty_io.c                | 798 ++++++++++++++--------------
 drivers/tty/tty_ioctl.c             | 208 ++++----
 drivers/tty/tty_jobctrl.c           | 132 ++---
 drivers/tty/tty_ldisc.c             | 272 +++++-----
 drivers/tty/tty_port.c              | 118 ++--
 drivers/tty/vt/consolemap.c         |  30 +-
 drivers/tty/vt/keyboard.c           | 132 ++---
 drivers/tty/vt/selection.c          |  26 +-
 drivers/tty/vt/vt.c                 |  66 +--
 drivers/tty/vt/vt_ioctl.c           |  37 +-
 35 files changed, 2373 insertions(+), 2379 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 769e0a5d1dfc..9e8d0439d802 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -730,7 +730,7 @@ static struct platform_driver ehv_bc_tty_driver = {
 };
 
 /**
- * ehv_bc_init - ePAPR hypervisor byte channel driver initialization
+ * ehv_bc_init() - ePAPR hypervisor byte channel driver initialization
  *
  * This function is called when this driver is loaded.
  */
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 86b7e20ffd7f..e25944ee2766 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -75,10 +75,10 @@ module_param(debug, int, 0600);
 #define	GSM_NET_TX_TIMEOUT (HZ*10)
 
 /**
- *	struct gsm_mux_net	-	network interface
- *	@struct gsm_dlci* dlci
+ * struct gsm_mux_net - network interface
+ * @struct gsm_dlci* dlci
  *
- *	Created when net interface is initialized.
+ * Created when net interface is initialized.
  **/
 struct gsm_mux_net {
 	struct kref ref;
@@ -359,12 +359,12 @@ static const u8 gsm_fcs8[256] = {
 #define GOOD_FCS	0xCF
 
 /**
- *	gsm_fcs_add	-	update FCS
- *	@fcs: Current FCS
- *	@c: Next data
+ * gsm_fcs_add() - update FCS
+ * @fcs: Current FCS
+ * @c: Next data
  *
- *	Update the FCS to include c. Uses the algorithm in the specification
- *	notes.
+ * Update the FCS to include c. Uses the algorithm in the specification
+ * notes.
  */
 
 static inline u8 gsm_fcs_add(u8 fcs, u8 c)
@@ -373,13 +373,13 @@ static inline u8 gsm_fcs_add(u8 fcs, u8 c)
 }
 
 /**
- *	gsm_fcs_add_block	-	update FCS for a block
- *	@fcs: Current FCS
- *	@c: buffer of data
- *	@len: length of buffer
+ * gsm_fcs_add_block() - update FCS for a block
+ * @fcs: Current FCS
+ * @c: buffer of data
+ * @len: length of buffer
  *
- *	Update the FCS to include c. Uses the algorithm in the specification
- *	notes.
+ * Update the FCS to include c. Uses the algorithm in the specification
+ * notes.
  */
 
 static inline u8 gsm_fcs_add_block(u8 fcs, u8 *c, int len)
@@ -390,12 +390,12 @@ static inline u8 gsm_fcs_add_block(u8 fcs, u8 *c, int len)
 }
 
 /**
- *	gsm_read_ea		-	read a byte into an EA
- *	@val: variable holding value
- *	c: byte going into the EA
+ * gsm_read_ea() - read a byte into an EA
+ * @val: variable holding value
+ * @c: byte going into the EA
  *
- *	Processes one byte of an EA. Updates the passed variable
- *	and returns 1 if the EA is now completely read
+ * Processes one byte of an EA. Updates the passed variable
+ * and returns 1 if the EA is now completely read
  */
 
 static int gsm_read_ea(unsigned int *val, u8 c)
@@ -408,11 +408,11 @@ static int gsm_read_ea(unsigned int *val, u8 c)
 }
 
 /**
- *	gsm_encode_modem	-	encode modem data bits
- *	@dlci: DLCI to encode from
+ * gsm_encode_modem() - encode modem data bits
+ * @dlci: DLCI to encode from
  *
- *	Returns the correct GSM encoded modem status bits (6 bit field) for
- *	the current status of the DLCI and attached tty object
+ * Returns the correct GSM encoded modem status bits (6 bit field) for
+ * the current status of the DLCI and attached tty object
  */
 
 static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
@@ -433,16 +433,16 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 }
 
 /**
- *	gsm_print_packet	-	display a frame for debug
- *	@hdr: header to print before decode
- *	@addr: address EA from the frame
- *	@cr: C/R bit from the frame
- *	@control: control including PF bit
- *	@data: following data bytes
- *	@dlen: length of data
+ * gsm_print_packet() - display a frame for debug
+ * @hdr: header to print before decode
+ * @addr: address EA from the frame
+ * @cr: C/R bit from the frame
+ * @control: control including PF bit
+ * @data: following data bytes
+ * @dlen: length of data
  *
- *	Displays a packet in human readable format for debugging purposes. The
- *	style is based on amateur radio LAP-B dump display.
+ * Displays a packet in human readable format for debugging purposes. The
+ * style is based on amateur radio LAP-B dump display.
  */
 
 static void gsm_print_packet(const char *hdr, int addr, int cr,
@@ -516,14 +516,14 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
  */
 
 /**
- *	gsm_stuff_packet	-	bytestuff a packet
- *	@ibuf: input
- *	@obuf: output
- *	@len: length of input
+ * gsm_stuff_packet() - bytestuff a packet
+ * @ibuf: input
+ * @obuf: output
+ * @len: length of input
  *
- *	Expand a buffer by bytestuffing it. The worst case size change
- *	is doubling and the caller is responsible for handing out
- *	suitable sized buffers.
+ * Expand a buffer by bytestuffing it. The worst case size change
+ * is doubling and the caller is responsible for handing out
+ * suitable sized buffers.
  */
 
 static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
@@ -543,17 +543,17 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
 }
 
 /**
- *	gsm_send	-	send a control frame
- *	@gsm: our GSM mux
- *	@addr: address for control frame
- *	@cr: command/response bit
- *	@control:  control byte including PF bit
+ * gsm_send() - send a control frame
+ * @gsm: our GSM mux
+ * @addr: address for control frame
+ * @cr: command/response bit
+ * @control: control byte including PF bit
  *
- *	Format up and transmit a control frame. These do not go via the
- *	queueing logic as they should be transmitted ahead of data when
- *	they are needed.
+ * Format up and transmit a control frame. These do not go via the
+ * queueing logic as they should be transmitted ahead of data when
+ * they are needed.
  *
- *	FIXME: Lock versus data TX path
+ * FIXME: Lock versus data TX path
  */
 
 static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
@@ -595,12 +595,12 @@ static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 }
 
 /**
- *	gsm_response	-	send a control response
- *	@gsm: our GSM mux
- *	@addr: address for control frame
- *	@control:  control byte including PF bit
+ * gsm_response() - send a control response
+ * @gsm: our GSM mux
+ * @addr: address for control frame
+ * @control: control byte including PF bit
  *
- *	Format up and transmit a link level response frame.
+ * Format up and transmit a link level response frame.
  */
 
 static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
@@ -609,12 +609,12 @@ static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
 }
 
 /**
- *	gsm_command	-	send a control command
- *	@gsm: our GSM mux
- *	@addr: address for control frame
- *	@control:  control byte including PF bit
+ * gsm_command() - send a control command
+ * @gsm: our GSM mux
+ * @addr: address for control frame
+ * @control: control byte including PF bit
  *
- *	Format up and transmit a link level command frame.
+ * Format up and transmit a link level command frame.
  */
 
 static inline void gsm_command(struct gsm_mux *gsm, int addr, int control)
@@ -627,15 +627,15 @@ static inline void gsm_command(struct gsm_mux *gsm, int addr, int control)
 #define HDR_LEN		6	/* ADDR CTRL [LEN.2] DATA FCS */
 
 /**
- *	gsm_data_alloc		-	allocate data frame
- *	@gsm: GSM mux
- *	@addr: DLCI address
- *	@len: length excluding header and FCS
- *	@ctrl: control byte
+ * gsm_data_alloc() - allocate data frame
+ * @gsm: GSM mux
+ * @addr: DLCI address
+ * @len: length excluding header and FCS
+ * @ctrl: control byte
  *
- *	Allocate a new data buffer for sending frames with data. Space is left
- *	at the front for header bytes but that is treated as an implementation
- *	detail and not for the high level code to use
+ * Allocate a new data buffer for sending frames with data. Space is left
+ * at the front for header bytes but that is treated as an implementation
+ * detail and not for the high level code to use
  */
 
 static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
@@ -654,15 +654,15 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 }
 
 /**
- *	gsm_data_kick		-	poke the queue
- *	@gsm: GSM Mux
+ * gsm_data_kick() - poke the queue
+ * @gsm: GSM Mux
  *
- *	The tty device has called us to indicate that room has appeared in
- *	the transmit queue. Ram more data into the pipe if we have any
- *	If we have been flow-stopped by a CMD_FCOFF, then we can only
- *	send messages on DLCI0 until CMD_FCON
+ * The tty device has called us to indicate that room has appeared in
+ * the transmit queue. Ram more data into the pipe if we have any
+ * If we have been flow-stopped by a CMD_FCOFF, then we can only
+ * send messages on DLCI0 until CMD_FCON
  *
- *	FIXME: lock against link layer control transmissions
+ * FIXME: lock against link layer control transmissions
  */
 
 static void gsm_data_kick(struct gsm_mux *gsm)
@@ -707,13 +707,13 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 }
 
 /**
- *	__gsm_data_queue		-	queue a UI or UIH frame
- *	@dlci: DLCI sending the data
- *	@msg: message queued
+ * __gsm_data_queue() - queue a UI or UIH frame
+ * @dlci: DLCI sending the data
+ * @msg: message queued
  *
- *	Add data to the transmit queue and try and get stuff moving
- *	out of the mux tty if not already doing so. The Caller must hold
- *	the gsm tx lock.
+ * Add data to the transmit queue and try and get stuff moving
+ * out of the mux tty if not already doing so. The Caller must hold
+ * the gsm tx lock.
  */
 
 static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
@@ -758,13 +758,13 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 }
 
 /**
- *	gsm_data_queue		-	queue a UI or UIH frame
- *	@dlci: DLCI sending the data
- *	@msg: message queued
+ * gsm_data_queue() - queue a UI or UIH frame
+ * @dlci: DLCI sending the data
+ * @msg: message queued
  *
- *	Add data to the transmit queue and try and get stuff moving
- *	out of the mux tty if not already doing so. Take the
- *	the gsm tx lock and dlci lock.
+ * Add data to the transmit queue and try and get stuff moving
+ * out of the mux tty if not already doing so. Take the
+ * the gsm tx lock and dlci lock.
  */
 
 static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
@@ -776,15 +776,15 @@ static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 }
 
 /**
- *	gsm_dlci_data_output	-	try and push data out of a DLCI
- *	@gsm: mux
- *	@dlci: the DLCI to pull data from
+ * gsm_dlci_data_output() - try and push data out of a DLCI
+ * @gsm: mux
+ * @dlci: the DLCI to pull data from
  *
- *	Pull data from a DLCI and send it into the transmit queue if there
- *	is data. Keep to the MRU of the mux. This path handles the usual tty
- *	interface which is a byte stream with optional modem data.
+ * Pull data from a DLCI and send it into the transmit queue if there
+ * is data. Keep to the MRU of the mux. This path handles the usual tty
+ * interface which is a byte stream with optional modem data.
  *
- *	Caller must hold the tx_lock of the mux.
+ * Caller must hold the tx_lock of the mux.
  */
 
 static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
@@ -829,15 +829,15 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 }
 
 /**
- *	gsm_dlci_data_output_framed  -	try and push data out of a DLCI
- *	@gsm: mux
- *	@dlci: the DLCI to pull data from
+ * gsm_dlci_data_output_framed() - try and push data out of a DLCI
+ * @gsm: mux
+ * @dlci: the DLCI to pull data from
  *
- *	Pull data from a DLCI and send it into the transmit queue if there
- *	is data. Keep to the MRU of the mux. This path handles framed data
- *	queued as skbuffs to the DLCI.
+ * Pull data from a DLCI and send it into the transmit queue if there
+ * is data. Keep to the MRU of the mux. This path handles framed data
+ * queued as skbuffs to the DLCI.
  *
- *	Caller must hold the tx_lock of the mux.
+ * Caller must hold the tx_lock of the mux.
  */
 
 static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
@@ -902,16 +902,16 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 }
 
 /**
- *	gsm_dlci_data_sweep		-	look for data to send
- *	@gsm: the GSM mux
+ * gsm_dlci_data_sweep() - look for data to send
+ * @gsm: the GSM mux
  *
- *	Sweep the GSM mux channels in priority order looking for ones with
- *	data to send. We could do with optimising this scan a bit. We aim
- *	to fill the queue totally or up to TX_THRESH_HI bytes. Once we hit
- *	TX_THRESH_LO we get called again
+ * Sweep the GSM mux channels in priority order looking for ones with
+ * data to send. We could do with optimising this scan a bit. We aim
+ * to fill the queue totally or up to TX_THRESH_HI bytes. Once we hit
+ * TX_THRESH_LO we get called again
  *
- *	FIXME: We should round robin between groups and in theory you can
- *	renegotiate DLCI priorities with optional stuff. Needs optimising.
+ * FIXME: We should round robin between groups and in theory you can
+ * renegotiate DLCI priorities with optional stuff. Needs optimising.
  */
 
 static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
@@ -943,12 +943,12 @@ static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
 }
 
 /**
- *	gsm_dlci_data_kick	-	transmit if possible
- *	@dlci: DLCI to kick
+ * gsm_dlci_data_kick() - transmit if possible
+ * @dlci: DLCI to kick
  *
- *	Transmit data from this DLCI if the queue is empty. We can't rely on
- *	a tty wakeup except when we filled the pipe so we need to fire off
- *	new data ourselves in other cases.
+ * Transmit data from this DLCI if the queue is empty. We can't rely on
+ * a tty wakeup except when we filled the pipe so we need to fire off
+ * new data ourselves in other cases.
  */
 
 static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
@@ -979,13 +979,13 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
 
 
 /**
- *	gsm_control_reply	-	send a response frame to a control
- *	@gsm: gsm channel
- *	@cmd: the command to use
- *	@data: data to follow encoded info
- *	@dlen: length of data
+ * gsm_control_reply() - send a response frame to a control
+ * @gsm: gsm channel
+ * @cmd: the command to use
+ * @data: data to follow encoded info
+ * @dlen: length of data
  *
- *	Encode up and queue a UI/UIH frame containing our response.
+ * Encode up and queue a UI/UIH frame containing our response.
  */
 
 static void gsm_control_reply(struct gsm_mux *gsm, int cmd, u8 *data,
@@ -1002,13 +1002,13 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, u8 *data,
 }
 
 /**
- *	gsm_process_modem	-	process received modem status
- *	@tty: virtual tty bound to the DLCI
- *	@dlci: DLCI to affect
- *	@modem: modem bits (full EA)
+ * gsm_process_modem() - process received modem status
+ * @tty: virtual tty bound to the DLCI
+ * @dlci: DLCI to affect
+ * @modem: modem bits (full EA)
  *
- *	Used when a modem control message or line state inline in adaption
- *	layer 2 is processed. Sort out the local modem state and throttles
+ * Used when a modem control message or line state inline in adaption
+ * layer 2 is processed. Sort out the local modem state and throttles
  */
 
 static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
@@ -1062,15 +1062,15 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 }
 
 /**
- *	gsm_control_modem	-	modem status received
- *	@gsm: GSM channel
- *	@data: data following command
- *	@clen: command length
+ * gsm_control_modem() - modem status received
+ * @gsm: GSM channel
+ * @data: data following command
+ * @clen: command length
  *
- *	We have received a modem status control message. This is used by
- *	the GSM mux protocol to pass virtual modem line status and optionally
- *	to indicate break signals. Unpack it, convert to Linux representation
- *	and if need be stuff a break message down the tty.
+ * We have received a modem status control message. This is used by
+ * the GSM mux protocol to pass virtual modem line status and optionally
+ * to indicate break signals. Unpack it, convert to Linux representation
+ * and if need be stuff a break message down the tty.
  */
 
 static void gsm_control_modem(struct gsm_mux *gsm, u8 *data, int clen)
@@ -1124,14 +1124,14 @@ static void gsm_control_modem(struct gsm_mux *gsm, u8 *data, int clen)
 }
 
 /**
- *	gsm_control_rls		-	remote line status
- *	@gsm: GSM channel
- *	@data: data bytes
- *	@clen: data length
+ * gsm_control_rls() - remote line status
+ * @gsm: GSM channel
+ * @data: data bytes
+ * @clen: data length
  *
- *	The modem sends us a two byte message on the control channel whenever
- *	it wishes to send us an error state from the virtual link. Stuff
- *	this into the uplink tty if present
+ * The modem sends us a two byte message on the control channel whenever
+ * it wishes to send us an error state from the virtual link. Stuff
+ * this into the uplink tty if present
  */
 
 static void gsm_control_rls(struct gsm_mux *gsm, u8 *data, int clen)
@@ -1177,15 +1177,15 @@ static void gsm_control_rls(struct gsm_mux *gsm, u8 *data, int clen)
 static void gsm_dlci_begin_close(struct gsm_dlci *dlci);
 
 /**
- *	gsm_control_message	-	DLCI 0 control processing
- *	@gsm: our GSM mux
- *	@command:  the command EA
- *	@data: data beyond the command/length EAs
- *	@clen: length
+ * gsm_control_message() - DLCI 0 control processing
+ * @gsm: our GSM mux
+ * @command: the command EA
+ * @data: data beyond the command/length EAs
+ * @clen: length
  *
- *	Input processor for control messages from the other end of the link.
- *	Processes the incoming request and queues a response frame or an
- *	NSC response if not supported
+ * Input processor for control messages from the other end of the link.
+ * Processes the incoming request and queues a response frame or an
+ * NSC response if not supported
  */
 
 static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
@@ -1248,16 +1248,16 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 }
 
 /**
- *	gsm_control_response	-	process a response to our control
- *	@gsm: our GSM mux
- *	@command: the command (response) EA
- *	@data: data beyond the command/length EA
- *	@clen: length
+ * gsm_control_response() - process a response to our control
+ * @gsm: our GSM mux
+ * @command: the command (response) EA
+ * @data: data beyond the command/length EA
+ * @clen: length
  *
- *	Process a response to an outstanding command. We only allow a single
- *	control message in flight so this is fairly easy. All the clean up
- *	is done by the caller, we just update the fields, flag it as done
- *	and return
+ * Process a response to an outstanding command. We only allow a single
+ * control message in flight so this is fairly easy. All the clean up
+ * is done by the caller, we just update the fields, flag it as done
+ * and return
  */
 
 static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
@@ -1285,11 +1285,11 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 }
 
 /**
- *	gsm_control_transmit	-	send control packet
- *	@gsm: gsm mux
- *	@ctrl: frame to send
+ * gsm_control_transmit() - send control packet
+ * @gsm: gsm mux
+ * @ctrl: frame to send
  *
- *	Send out a pending control command (called under control lock)
+ * Send out a pending control command (called under control lock)
  */
 
 static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
@@ -1303,14 +1303,14 @@ static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
 }
 
 /**
- *	gsm_control_retransmit	-	retransmit a control frame
- *	@data: pointer to our gsm object
+ * gsm_control_retransmit() - retransmit a control frame
+ * @data: pointer to our gsm object
  *
- *	Called off the T2 timer expiry in order to retransmit control frames
- *	that have been lost in the system somewhere. The control_lock protects
- *	us from colliding with another sender or a receive completion event.
- *	In that situation the timer may still occur in a small window but
- *	gsm->pending_cmd will be NULL and we just let the timer expire.
+ * Called off the T2 timer expiry in order to retransmit control frames
+ * that have been lost in the system somewhere. The control_lock protects
+ * us from colliding with another sender or a receive completion event.
+ * In that situation the timer may still occur in a small window but
+ * gsm->pending_cmd will be NULL and we just let the timer expire.
  */
 
 static void gsm_control_retransmit(struct timer_list *t)
@@ -1337,15 +1337,15 @@ static void gsm_control_retransmit(struct timer_list *t)
 }
 
 /**
- *	gsm_control_send	-	send a control frame on DLCI 0
- *	@gsm: the GSM channel
- *	@command: command  to send including CR bit
- *	@data: bytes of data (must be kmalloced)
- *	@len: length of the block to send
+ * gsm_control_send() - send a control frame on DLCI 0
+ * @gsm: the GSM channel
+ * @command: command to send including CR bit
+ * @data: bytes of data (must be kmalloced)
+ * @len: length of the block to send
  *
- *	Queue and dispatch a control command. Only one command can be
- *	active at a time. In theory more can be outstanding but the matching
- *	gets really complicated so for now stick to one outstanding.
+ * Queue and dispatch a control command. Only one command can be
+ * active at a time. In theory more can be outstanding but the matching
+ * gets really complicated so for now stick to one outstanding.
  */
 
 static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
@@ -1381,13 +1381,13 @@ static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
 }
 
 /**
- *	gsm_control_wait	-	wait for a control to finish
- *	@gsm: GSM mux
- *	@control: control we are waiting on
+ * gsm_control_wait() - wait for a control to finish
+ * @gsm: GSM mux
+ * @control: control we are waiting on
  *
- *	Waits for the control to complete or time out. Frees any used
- *	resources and returns 0 for success, or an error if the remote
- *	rejected or ignored the request.
+ * Waits for the control to complete or time out. Frees any used
+ * resources and returns 0 for success, or an error if the remote
+ * rejected or ignored the request.
  */
 
 static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
@@ -1409,11 +1409,11 @@ static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
  */
 
 /**
- *	gsm_dlci_close		-	a DLCI has closed
- *	@dlci: DLCI that closed
+ * gsm_dlci_close() - a DLCI has closed
+ * @dlci: DLCI that closed
  *
- *	Perform processing when moving a DLCI into closed state. If there
- *	is an attached tty this is hung up
+ * Perform processing when moving a DLCI into closed state. If there
+ * is an attached tty this is hung up
  */
 
 static void gsm_dlci_close(struct gsm_dlci *dlci)
@@ -1433,10 +1433,10 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 }
 
 /**
- *	gsm_dlci_open		-	a DLCI has opened
- *	@dlci: DLCI that opened
+ * gsm_dlci_open() - a DLCI has opened
+ * @dlci: DLCI that opened
  *
- *	Perform processing when moving a DLCI into open state.
+ * Perform processing when moving a DLCI into open state.
  */
 
 static void gsm_dlci_open(struct gsm_dlci *dlci)
@@ -1452,18 +1452,18 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 }
 
 /**
- *	gsm_dlci_t1		-	T1 timer expiry
- *	@dlci: DLCI that opened
+ * gsm_dlci_t1() - T1 timer expiry
+ * @dlci: DLCI that opened
  *
- *	The T1 timer handles retransmits of control frames (essentially of
- *	SABM and DISC). We resend the command until the retry count runs out
- *	in which case an opening port goes back to closed and a closing port
- *	is simply put into closed state (any further frames from the other
- *	end will get a DM response)
+ * The T1 timer handles retransmits of control frames (essentially of
+ * SABM and DISC). We resend the command until the retry count runs out
+ * in which case an opening port goes back to closed and a closing port
+ * is simply put into closed state (any further frames from the other
+ * end will get a DM response)
  *
- *	Some control dlci can stay in ADM mode with other dlci working just
- *	fine. In that case we can just keep the control dlci open after the
- *	DLCI_OPENING retries time out.
+ * Some control dlci can stay in ADM mode with other dlci working just
+ * fine. In that case we can just keep the control dlci open after the
+ * DLCI_OPENING retries time out.
  */
 
 static void gsm_dlci_t1(struct timer_list *t)
@@ -1500,13 +1500,13 @@ static void gsm_dlci_t1(struct timer_list *t)
 }
 
 /**
- *	gsm_dlci_begin_open	-	start channel open procedure
- *	@dlci: DLCI to open
+ * gsm_dlci_begin_open() - start channel open procedure
+ * @dlci: DLCI to open
  *
- *	Commence opening a DLCI from the Linux side. We issue SABM messages
- *	to the modem which should then reply with a UA or ADM, at which point
- *	we will move into open state. Opening is done asynchronously with retry
- *	running off timers and the responses.
+ * Commence opening a DLCI from the Linux side. We issue SABM messages
+ * to the modem which should then reply with a UA or ADM, at which point
+ * we will move into open state. Opening is done asynchronously with retry
+ * running off timers and the responses.
  */
 
 static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
@@ -1521,14 +1521,14 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 }
 
 /**
- *	gsm_dlci_begin_close	-	start channel open procedure
- *	@dlci: DLCI to open
+ * gsm_dlci_begin_close() - start channel open procedure
+ * @dlci: DLCI to open
  *
- *	Commence closing a DLCI from the Linux side. We issue DISC messages
- *	to the modem which should then reply with a UA, at which point we
- *	will move into closed state. Closing is done asynchronously with retry
- *	off timers. We may also receive a DM reply from the other end which
- *	indicates the channel was already closed.
+ * Commence closing a DLCI from the Linux side. We issue DISC messages
+ * to the modem which should then reply with a UA, at which point we
+ * will move into closed state. Closing is done asynchronously with retry
+ * off timers. We may also receive a DM reply from the other end which
+ * indicates the channel was already closed.
  */
 
 static void gsm_dlci_begin_close(struct gsm_dlci *dlci)
@@ -1543,14 +1543,14 @@ static void gsm_dlci_begin_close(struct gsm_dlci *dlci)
 }
 
 /**
- *	gsm_dlci_data		-	data arrived
- *	@dlci: channel
- *	@data: block of bytes received
- *	@len: length of received block
+ * gsm_dlci_data() - data arrived
+ * @dlci: channel
+ * @data: block of bytes received
+ * @len: length of received block
  *
- *	A UI or UIH frame has arrived which contains data for a channel
- *	other than the control channel. If the relevant virtual tty is
- *	open we shovel the bits down it, if not we drop them.
+ * A UI or UIH frame has arrived which contains data for a channel
+ * other than the control channel. If the relevant virtual tty is
+ * open we shovel the bits down it, if not we drop them.
  */
 
 static void gsm_dlci_data(struct gsm_dlci *dlci, u8 *data, int clen)
@@ -1592,15 +1592,15 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, u8 *data, int clen)
 }
 
 /**
- *	gsm_dlci_control	-	data arrived on control channel
- *	@dlci: channel
- *	@data: block of bytes received
- *	@len: length of received block
+ * gsm_dlci_control() - data arrived on control channel
+ * @dlci: channel
+ * @data: block of bytes received
+ * @len: length of received block
  *
- *	A UI or UIH frame has arrived which contains data for DLCI 0 the
- *	control channel. This should contain a command EA followed by
- *	control data bytes. The command EA contains a command/response bit
- *	and we divide up the work accordingly.
+ * A UI or UIH frame has arrived which contains data for DLCI 0 the
+ * control channel. This should contain a command EA followed by
+ * control data bytes. The command EA contains a command/response bit
+ * and we divide up the work accordingly.
  */
 
 static void gsm_dlci_command(struct gsm_dlci *dlci, u8 *data, int len)
@@ -1632,13 +1632,13 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, u8 *data, int len)
  */
 
 /**
- *	gsm_dlci_alloc		-	allocate a DLCI
- *	@gsm: GSM mux
- *	@addr: address of the DLCI
+ * gsm_dlci_alloc() - allocate a DLCI
+ * @gsm: GSM mux
+ * @addr: address of the DLCI
  *
- *	Allocate and install a new DLCI object into the GSM mux.
+ * Allocate and install a new DLCI object into the GSM mux.
  *
- *	FIXME: review locking races
+ * FIXME: review locking races
  */
 
 static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
@@ -1671,12 +1671,12 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 }
 
 /**
- *	gsm_dlci_free		-	free DLCI
- *	@dlci: DLCI to free
+ * gsm_dlci_free() - free DLCI
+ * @dlci: DLCI to free
  *
- *	Free up a DLCI.
+ * Free up a DLCI.
  *
- *	Can sleep.
+ * Can sleep.
  */
 static void gsm_dlci_free(struct tty_port *port)
 {
@@ -1703,13 +1703,13 @@ static inline void dlci_put(struct gsm_dlci *dlci)
 static void gsm_destroy_network(struct gsm_dlci *dlci);
 
 /**
- *	gsm_dlci_release		-	release DLCI
- *	@dlci: DLCI to destroy
+ * gsm_dlci_release() - release DLCI
+ * @dlci: DLCI to destroy
  *
- *	Release a DLCI. Actual free is deferred until either
- *	mux is closed or tty is closed - whichever is last.
+ * Release a DLCI. Actual free is deferred until either
+ * mux is closed or tty is closed - whichever is last.
  *
- *	Can sleep.
+ * Can sleep.
  */
 static void gsm_dlci_release(struct gsm_dlci *dlci)
 {
@@ -1733,13 +1733,13 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
  */
 
 /**
- *	gsm_queue		-	a GSM frame is ready to process
- *	@gsm: pointer to our gsm mux
+ * gsm_queue() - a GSM frame is ready to process
+ * @gsm: pointer to our gsm mux
  *
- *	At this point in time a frame has arrived and been demangled from
- *	the line encoding. All the differences between the encodings have
- *	been handled below us and the frame is unpacked into the structures.
- *	The fcs holds the header FCS but any data FCS must be added here.
+ * At this point in time a frame has arrived and been demangled from
+ * the line encoding. All the differences between the encodings have
+ * been handled below us and the frame is unpacked into the structures.
+ * The fcs holds the header FCS but any data FCS must be added here.
  */
 
 static void gsm_queue(struct gsm_mux *gsm)
@@ -1848,13 +1848,12 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 
 /**
- *	gsm0_receive	-	perform processing for non-transparency
- *	@gsm: gsm data for this ldisc instance
- *	@c: character
+ * gsm0_receive() - perform processing for non-transparency
+ * @gsm: gsm data for this ldisc instance
+ * @c: character
  *
- *	Receive bytes in gsm mode 0
+ * Receive bytes in gsm mode 0
  */
-
 static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 {
 	unsigned int len;
@@ -1930,13 +1929,12 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 }
 
 /**
- *	gsm1_receive	-	perform processing for non-transparency
- *	@gsm: gsm data for this ldisc instance
- *	@c: character
+ * gsm1_receive() - perform processing for non-transparency
+ * @gsm: gsm data for this ldisc instance
+ * @c: character
  *
- *	Receive bytes in mode 1 (Advanced option)
+ * Receive bytes in mode 1 (Advanced option)
  */
-
 static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 {
 	if (c == GSM1_SOF) {
@@ -2004,15 +2002,15 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 }
 
 /**
- *	gsm_error		-	handle tty error
- *	@gsm: ldisc data
- *	@data: byte received (may be invalid)
- *	@flag: error received
+ * gsm_error() - handle tty error
+ * @gsm: ldisc data
+ * @data: byte received (may be invalid)
+ * @flag: error received
  *
- *	Handle an error in the receipt of data for a frame. Currently we just
- *	go back to hunting for a SOF.
+ * Handle an error in the receipt of data for a frame. Currently we just
+ * go back to hunting for a SOF.
  *
- *	FIXME: better diagnostics ?
+ * FIXME: better diagnostics ?
  */
 
 static void gsm_error(struct gsm_mux *gsm,
@@ -2050,12 +2048,12 @@ static int gsm_disconnect(struct gsm_mux *gsm)
 }
 
 /**
- *	gsm_cleanup_mux		-	generic GSM protocol cleanup
- *	@gsm: our mux
+ * gsm_cleanup_mux() - generic GSM protocol cleanup
+ * @gsm: our mux
  *
- *	Clean up the bits of the mux which are the same for all framing
- *	protocols. Remove the mux from the mux table, stop all the timers
- *	and then shut down each device hanging up the channels as we go.
+ * Clean up the bits of the mux which are the same for all framing
+ * protocols. Remove the mux from the mux table, stop all the timers
+ * and then shut down each device hanging up the channels as we go.
  */
 
 static void gsm_cleanup_mux(struct gsm_mux *gsm)
@@ -2096,12 +2094,12 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
 }
 
 /**
- *	gsm_activate_mux	-	generic GSM setup
- *	@gsm: our mux
+ * gsm_activate_mux() - generic GSM setup
+ * @gsm: our mux
  *
- *	Set up the bits of the mux which are the same for all framing
- *	protocols. Add the mux to the mux table so it can be opened and
- *	finally kick off connecting to DLCI 0 on the modem.
+ * Set up the bits of the mux which are the same for all framing
+ * protocols. Add the mux to the mux table so it can be opened and
+ * finally kick off connecting to DLCI 0 on the modem.
  */
 
 static int gsm_activate_mux(struct gsm_mux *gsm)
@@ -2140,10 +2138,10 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 }
 
 /**
- *	gsm_free_mux		-	free up a mux
- *	@mux: mux to free
+ * gsm_free_mux() - free up a mux
+ * @mux: mux to free
  *
- *	Dispose of allocated resources for a dead mux
+ * Dispose of allocated resources for a dead mux
  */
 static void gsm_free_mux(struct gsm_mux *gsm)
 {
@@ -2153,10 +2151,10 @@ static void gsm_free_mux(struct gsm_mux *gsm)
 }
 
 /**
- *	gsm_free_muxr		-	free up a mux
- *	@mux: mux to free
+ * gsm_free_muxr() - free up a mux
+ * @mux: mux to free
  *
- *	Dispose of allocated resources for a dead mux
+ * Dispose of allocated resources for a dead mux
  */
 static void gsm_free_muxr(struct kref *ref)
 {
@@ -2175,11 +2173,10 @@ static inline void mux_put(struct gsm_mux *gsm)
 }
 
 /**
- *	gsm_alloc_mux		-	allocate a mux
+ * gsm_alloc_mux() - allocate a mux
  *
- *	Creates a new mux ready for activation.
+ * Creates a new mux ready for activation.
  */
-
 static struct gsm_mux *gsm_alloc_mux(void)
 {
 	struct gsm_mux *gsm = kzalloc(sizeof(struct gsm_mux), GFP_KERNEL);
@@ -2215,13 +2212,13 @@ static struct gsm_mux *gsm_alloc_mux(void)
 }
 
 /**
- *	gsmld_output		-	write to link
- *	@gsm: our mux
- *	@data: bytes to output
- *	@len: size
+ * gsmld_output() - write to link
+ * @gsm: our mux
+ * @data: bytes to output
+ * @len: size
  *
- *	Write a block of data from the GSM mux to the data channel. This
- *	will eventually be serialized from above but at the moment isn't.
+ * Write a block of data from the GSM mux to the data channel. This
+ * will eventually be serialized from above but at the moment isn't.
  */
 
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
@@ -2238,13 +2235,13 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 }
 
 /**
- *	gsmld_attach_gsm	-	mode set up
- *	@tty: our tty structure
- *	@gsm: our mux
+ * gsmld_attach_gsm() - mode set up
+ * @tty: our tty structure
+ * @gsm: our mux
  *
- *	Set up the MUX for basic mode and commence connecting to the
- *	modem. Currently called from the line discipline set up but
- *	will need moving to an ioctl path.
+ * Set up the MUX for basic mode and commence connecting to the
+ * modem. Currently called from the line discipline set up but
+ * will need moving to an ioctl path.
  */
 
 static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
@@ -2266,15 +2263,13 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	return ret;
 }
 
-
 /**
- *	gsmld_detach_gsm	-	stop doing 0710 mux
- *	@tty: tty attached to the mux
- *	@gsm: mux
+ * gsmld_detach_gsm() - stop doing 0710 mux
+ * @tty: tty attached to the mux
+ * @gsm: mux
  *
- *	Shutdown and then clean up the resources used by the line discipline
+ * Shutdown and then clean up the resources used by the line discipline
  */
-
 static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
 	int i;
@@ -2325,26 +2320,25 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 }
 
 /**
- *	gsmld_flush_buffer	-	clean input queue
- *	@tty:	terminal device
+ * gsmld_flush_buffer() - clean input queue
+ * @tty: terminal device
  *
- *	Flush the input buffer. Called when the line discipline is
- *	being closed, when the tty layer wants the buffer flushed (eg
- *	at hangup).
+ * Flush the input buffer. Called when the line discipline is
+ * being closed, when the tty layer wants the buffer flushed (eg
+ * at hangup).
  */
-
 static void gsmld_flush_buffer(struct tty_struct *tty)
 {
 }
 
 /**
- *	gsmld_close		-	close the ldisc for this tty
- *	@tty: device
+ * gsmld_close() - close the ldisc for this tty
+ * @tty: device
  *
- *	Called from the terminal layer when this line discipline is
- *	being shut down, either because of a close or becsuse of a
- *	discipline change. The function will not be called while other
- *	ldisc methods are in progress.
+ * Called from the terminal layer when this line discipline is
+ * being shut down, either because of a close or becsuse of a
+ * discipline change. The function will not be called while other
+ * ldisc methods are in progress.
  */
 
 static void gsmld_close(struct tty_struct *tty)
@@ -2359,13 +2353,13 @@ static void gsmld_close(struct tty_struct *tty)
 }
 
 /**
- *	gsmld_open		-	open an ldisc
- *	@tty: terminal to open
+ * gsmld_open() - open an ldisc
+ * @tty: terminal to open
  *
- *	Called when this line discipline is being attached to the
- *	terminal device. Can sleep. Called serialized so that no
- *	other events will occur in parallel. No further open will occur
- *	until a close.
+ * Called when this line discipline is being attached to the
+ * terminal device. Can sleep. Called serialized so that no
+ * other events will occur in parallel. No further open will occur
+ * until a close.
  */
 
 static int gsmld_open(struct tty_struct *tty)
@@ -2396,14 +2390,13 @@ static int gsmld_open(struct tty_struct *tty)
 }
 
 /**
- *	gsmld_write_wakeup	-	asynchronous I/O notifier
- *	@tty: tty device
+ * gsmld_write_wakeup() - asynchronous I/O notifier
+ * @tty: tty device
  *
- *	Required for the ptys, serial driver etc. since processes
- *	that attach themselves to the master and rely on ASYNC
- *	IO must be woken up
+ * Required for the ptys, serial driver etc. since processes
+ * that attach themselves to the master and rely on ASYNC
+ * IO must be woken up
  */
-
 static void gsmld_write_wakeup(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm = tty->disc_data;
@@ -2420,18 +2413,18 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
 }
 
 /**
- *	gsmld_read		-	read function for tty
- *	@tty: tty device
- *	@file: file object
- *	@buf: userspace buffer pointer
- *	@nr: size of I/O
+ * gsmld_read() - read function for tty
+ * @tty: tty device
+ * @file: file object
+ * @buf: userspace buffer pointer
+ * @nr: size of I/O
  *
- *	Perform reads for the line discipline. We are guaranteed that the
- *	line discipline will not be closed under us but we may get multiple
- *	parallel readers and must handle this ourselves. We may also get
- *	a hangup. Always called in user context, may sleep.
+ * Perform reads for the line discipline. We are guaranteed that the
+ * line discipline will not be closed under us but we may get multiple
+ * parallel readers and must handle this ourselves. We may also get
+ * a hangup. Always called in user context, may sleep.
  *
- *	This code must be sure never to sleep through a hangup.
+ * This code must be sure never to sleep through a hangup.
  */
 
 static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
@@ -2441,17 +2434,17 @@ static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
 }
 
 /**
- *	gsmld_write		-	write function for tty
- *	@tty: tty device
- *	@file: file object
- *	@buf: userspace buffer pointer
- *	@nr: size of I/O
+ * gsmld_write() - write function for tty
+ * @tty: tty device
+ * @file: file object
+ * @buf: userspace buffer pointer
+ * @nr: size of I/O
  *
- *	Called when the owner of the device wants to send a frame
- *	itself (or some other control data). The data is transferred
- *	as-is and must be properly framed and checksummed as appropriate
- *	by userspace. Frames are either sent whole or not at all as this
- *	avoids pain user side.
+ * Called when the owner of the device wants to send a frame
+ * itself (or some other control data). The data is transferred
+ * as-is and must be properly framed and checksummed as appropriate
+ * by userspace. Frames are either sent whole or not at all as this
+ * avoids pain user side.
  */
 
 static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
@@ -2465,17 +2458,17 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 }
 
 /**
- *	gsmld_poll		-	poll method for N_GSM0710
- *	@tty: terminal device
- *	@file: file accessing it
- *	@wait: poll table
+ * gsmld_poll() - poll method for N_GSM0710
+ * @tty: terminal device
+ * @file: file accessing it
+ * @wait: poll table
  *
- *	Called when the line discipline is asked to poll() for data or
- *	for special events. This code is not serialized with respect to
- *	other events save open/close.
+ * Called when the line discipline is asked to poll() for data or
+ * for special events. This code is not serialized with respect to
+ * other events save open/close.
  *
- *	This code must be sure never to sleep through a hangup.
- *	Called without the kernel lock held - fine
+ * This code must be sure never to sleep through a hangup.
+ * Called without the kernel lock held - fine
  */
 
 static __poll_t gsmld_poll(struct tty_struct *tty, struct file *file,
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 789251f8a1e2..4b7aaf9ee09c 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -227,7 +227,7 @@ static struct tty_ldisc_ops n_hdlc_ldisc = {
 };
 
 /**
- * n_hdlc_release - release an n_hdlc per device line discipline info structure
+ * n_hdlc_release() - release an n_hdlc per device line discipline info structure
  * @n_hdlc - per device line discipline info structure
  */
 static void n_hdlc_release(struct n_hdlc *n_hdlc)
@@ -279,7 +279,7 @@ static void n_hdlc_release(struct n_hdlc *n_hdlc)
 }	/* end of n_hdlc_release() */
 
 /**
- * n_hdlc_tty_close - line discipline close
+ * n_hdlc_tty_close() - line discipline close
  * @tty - pointer to tty info structure
  *
  * Called when the line discipline is changed to something
@@ -318,7 +318,7 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 }	/* end of n_hdlc_tty_close() */
 
 /**
- * n_hdlc_tty_open - called when line discipline changed to n_hdlc
+ * n_hdlc_tty_open() - called when line discipline changed to n_hdlc
  * @tty - pointer to tty info structure
  *
  * Returns 0 if success, otherwise error code
@@ -364,7 +364,7 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
 }	/* end of n_tty_hdlc_open() */
 
 /**
- * n_hdlc_send_frames - send frames on pending send buffer list
+ * n_hdlc_send_frames() - send frames on pending send buffer list
  * @n_hdlc - pointer to ldisc instance data
  * @tty - pointer to tty instance data
  *
@@ -456,7 +456,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 }	/* end of n_hdlc_send_frames() */
 
 /**
- * n_hdlc_tty_wakeup - Callback for transmit wakeup
+ * n_hdlc_tty_wakeup() - Callback for transmit wakeup
  * @tty	- pointer to associated tty instance data
  *
  * Called when low level device driver can accept more send data.
@@ -481,7 +481,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 }	/* end of n_hdlc_tty_wakeup() */
 
 /**
- * n_hdlc_tty_receive - Called by tty driver when receive data is available
+ * n_hdlc_tty_receive() - Called by tty driver when receive data is available
  * @tty	- pointer to tty instance data
  * @data - pointer to received data
  * @flags - pointer to flags for data
@@ -549,7 +549,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 }	/* end of n_hdlc_tty_receive() */
 
 /**
- * n_hdlc_tty_read - Called to retrieve one frame of data (if available)
+ * n_hdlc_tty_read() - Called to retrieve one frame of data (if available)
  * @tty - pointer to tty instance data
  * @file - pointer to open file object
  * @buf - pointer to returned data buffer
@@ -633,7 +633,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 }	/* end of n_hdlc_tty_read() */
 
 /**
- * n_hdlc_tty_write - write a single frame of data to device
+ * n_hdlc_tty_write() - write a single frame of data to device
  * @tty	- pointer to associated tty device instance data
  * @file - pointer to file object data
  * @data - pointer to transmit data (one frame)
@@ -717,7 +717,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 }	/* end of n_hdlc_tty_write() */
 
 /**
- * n_hdlc_tty_ioctl - process IOCTL system call for the tty device.
+ * n_hdlc_tty_ioctl() - process IOCTL system call for the tty device.
  * @tty - pointer to tty instance data
  * @file - pointer to open file object for device
  * @cmd - IOCTL command code
@@ -787,7 +787,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 }	/* end of n_hdlc_tty_ioctl() */
 
 /**
- * n_hdlc_tty_poll - TTY callback for poll system call
+ * n_hdlc_tty_poll() - TTY callback for poll system call
  * @tty - pointer to tty instance data
  * @filp - pointer to open file object for device
  * @poll_table - wait queue for operations
@@ -827,7 +827,7 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 }	/* end of n_hdlc_tty_poll() */
 
 /**
- * n_hdlc_alloc - allocate an n_hdlc instance data structure
+ * n_hdlc_alloc() - allocate an n_hdlc instance data structure
  *
  * Returns a pointer to newly created structure if success, otherwise %NULL
  */
@@ -877,7 +877,7 @@ static struct n_hdlc *n_hdlc_alloc(void)
 }	/* end of n_hdlc_alloc() */
 
 /**
- * n_hdlc_buf_return - put the HDLC buffer after the head of the specified list
+ * n_hdlc_buf_return() - put the HDLC buffer after the head of the specified list
  * @buf_list - pointer to the buffer list
  * @buf - pointer to the buffer
  */
@@ -895,7 +895,7 @@ static void n_hdlc_buf_return(struct n_hdlc_buf_list *buf_list,
 }
 
 /**
- * n_hdlc_buf_put - add specified HDLC buffer to tail of specified list
+ * n_hdlc_buf_put() - add specified HDLC buffer to tail of specified list
  * @buf_list - pointer to buffer list
  * @buf	- pointer to buffer
  */
@@ -913,7 +913,7 @@ static void n_hdlc_buf_put(struct n_hdlc_buf_list *buf_list,
 }	/* end of n_hdlc_buf_put() */
 
 /**
- * n_hdlc_buf_get - remove and return an HDLC buffer from list
+ * n_hdlc_buf_get() - remove and return an HDLC buffer from list
  * @buf_list - pointer to HDLC buffer list
  *
  * Remove and return an HDLC buffer from the head of the specified HDLC buffer
diff --git a/drivers/tty/n_tracerouter.c b/drivers/tty/n_tracerouter.c
index 4479af4d2fa5..f7a2616145cf 100644
--- a/drivers/tty/n_tracerouter.c
+++ b/drivers/tty/n_tracerouter.c
@@ -184,7 +184,7 @@ static struct tty_ldisc_ops tty_ptirouter_ldisc = {
 };
 
 /**
- * n_tracerouter_init -	module initialisation
+ * n_tracerouter_init() - module initialisation
  *
  * Registers this module as a line discipline driver.
  *
@@ -210,7 +210,7 @@ static int __init n_tracerouter_init(void)
 }
 
 /**
- * n_tracerouter_exit -	module unload
+ * n_tracerouter_exit() - module unload
  *
  * Removes this module as a line discipline driver.
  */
diff --git a/drivers/tty/n_tracesink.c b/drivers/tty/n_tracesink.c
index d96ba82cc356..8feeea7d33b6 100644
--- a/drivers/tty/n_tracesink.c
+++ b/drivers/tty/n_tracesink.c
@@ -188,7 +188,7 @@ static struct tty_ldisc_ops tty_n_tracesink = {
 };
 
 /**
- * n_tracesink_init-	module initialisation
+ * n_tracesink_init() - module initialisation
  *
  * Registers this module as a line discipline driver.
  *
@@ -207,7 +207,7 @@ static int __init n_tracesink_init(void)
 }
 
 /**
- * n_tracesink_exit -	module unload
+ * n_tracesink_exit() - module unload
  *
  * Removes this module as a line discipline driver.
  */
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3ad460219fd6..2f90e0aa57ad 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -188,15 +188,15 @@ static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
 }
 
 /**
- *	n_tty_kick_worker - start input worker (if required)
- *	@tty: terminal
+ * n_tty_kick_worker() - start input worker (if required)
+ * @tty: terminal
  *
- *	Re-schedules the flip buffer work if it may have stopped
+ * Re-schedules the flip buffer work if it may have stopped
  *
- *	Caller holds exclusive termios_rwsem
- *	   or
- *	n_tty_read()/consumer path:
- *		holds non-exclusive termios_rwsem
+ * Caller holds exclusive termios_rwsem
+ *    or
+ * n_tty_read()/consumer path:
+ * 	holds non-exclusive termios_rwsem
  */
 
 static void n_tty_kick_worker(struct tty_struct *tty)
@@ -232,12 +232,12 @@ static ssize_t chars_in_buffer(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_write_wakeup	-	asynchronous I/O notifier
- *	@tty: tty device
+ * n_tty_write_wakeup() - asynchronous I/O notifier
+ * @tty: tty device
  *
- *	Required for the ptys, serial driver etc. since processes
- *	that attach themselves to the master and rely on ASYNC
- *	IO must be woken up
+ * Required for the ptys, serial driver etc. since processes
+ * that attach themselves to the master and rely on ASYNC
+ * IO must be woken up
  */
 
 static void n_tty_write_wakeup(struct tty_struct *tty)
@@ -302,14 +302,14 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
 }
 
 /**
- *	put_tty_queue		-	add character to tty
- *	@c: character
- *	@ldata: n_tty data
+ * put_tty_queue() - add character to tty
+ * @c: character
+ * @ldata: n_tty data
  *
- *	Add a character to the tty read_buf queue.
+ * Add a character to the tty read_buf queue.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
+ * n_tty_receive_buf()/producer path:
+ * 	caller holds non-exclusive termios_rwsem
  */
 
 static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
@@ -319,14 +319,14 @@ static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
 }
 
 /**
- *	reset_buffer_flags	-	reset buffer state
- *	@tty: terminal to reset
+ * reset_buffer_flags() - reset buffer state
+ * @tty: terminal to reset
  *
- *	Reset the read buffer counters and clear the flags.
- *	Called from n_tty_open() and n_tty_flush_buffer().
+ * Reset the read buffer counters and clear the flags.
+ * Called from n_tty_open() and n_tty_flush_buffer().
  *
- *	Locking: caller holds exclusive termios_rwsem
- *		 (or locking is not required)
+ * Locking: caller holds exclusive termios_rwsem
+ *          (or locking is not required)
  */
 
 static void reset_buffer_flags(struct n_tty_data *ldata)
@@ -353,17 +353,17 @@ static void n_tty_packet_mode_flush(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_flush_buffer	-	clean input queue
- *	@tty:	terminal device
+ * n_tty_flush_buffer() - clean input queue
+ * @tty: terminal device
  *
- *	Flush the input buffer. Called when the tty layer wants the
- *	buffer flushed (eg at hangup) or when the N_TTY line discipline
- *	internally has to clean the pending queue (for example some signals).
+ * Flush the input buffer. Called when the tty layer wants the
+ * buffer flushed (eg at hangup) or when the N_TTY line discipline
+ * internally has to clean the pending queue (for example some signals).
  *
- *	Holds termios_rwsem to exclude producer/consumer while
- *	buffer indices are reset.
+ * Holds termios_rwsem to exclude producer/consumer while
+ * buffer indices are reset.
  *
- *	Locking: ctrl_lock, exclusive termios_rwsem
+ * Locking: ctrl_lock, exclusive termios_rwsem
  */
 
 static void n_tty_flush_buffer(struct tty_struct *tty)
@@ -378,12 +378,12 @@ static void n_tty_flush_buffer(struct tty_struct *tty)
 }
 
 /**
- *	is_utf8_continuation	-	utf8 multibyte check
- *	@c: byte to check
+ * is_utf8_continuation() - utf8 multibyte check
+ * @c: byte to check
  *
- *	Returns true if the utf8 character 'c' is a multibyte continuation
- *	character. We use this to correctly compute the on screen size
- *	of the character when printing
+ * Returns true if the utf8 character 'c' is a multibyte continuation
+ * character. We use this to correctly compute the on screen size
+ * of the character when printing
  */
 
 static inline int is_utf8_continuation(unsigned char c)
@@ -392,11 +392,11 @@ static inline int is_utf8_continuation(unsigned char c)
 }
 
 /**
- *	is_continuation		-	multibyte check
- *	@c: byte to check
+ * is_continuation() - multibyte check
+ * @c: byte to check
  *
- *	Returns true if the utf8 character 'c' is a multibyte continuation
- *	character and the terminal is in unicode mode.
+ * Returns true if the utf8 character 'c' is a multibyte continuation
+ * character and the terminal is in unicode mode.
  */
 
 static inline int is_continuation(unsigned char c, struct tty_struct *tty)
@@ -405,25 +405,25 @@ static inline int is_continuation(unsigned char c, struct tty_struct *tty)
 }
 
 /**
- *	do_output_char			-	output one character
- *	@c: character (or partial unicode symbol)
- *	@tty: terminal device
- *	@space: space available in tty driver write buffer
+ * do_output_char() - output one character
+ * @c: character (or partial unicode symbol)
+ * @tty: terminal device
+ * @space: space available in tty driver write buffer
  *
- *	This is a helper function that handles one output character
- *	(including special characters like TAB, CR, LF, etc.),
- *	doing OPOST processing and putting the results in the
- *	tty driver's write buffer.
+ * This is a helper function that handles one output character
+ * (including special characters like TAB, CR, LF, etc.),
+ * doing OPOST processing and putting the results in the
+ * tty driver's write buffer.
  *
- *	Note that Linux currently ignores TABDLY, CRDLY, VTDLY, FFDLY
- *	and NLDLY.  They simply aren't relevant in the world today.
- *	If you ever need them, add them here.
+ * Note that Linux currently ignores TABDLY, CRDLY, VTDLY, FFDLY
+ * and NLDLY.  They simply aren't relevant in the world today.
+ * If you ever need them, add them here.
  *
- *	Returns the number of bytes of buffer space used or -1 if
- *	no space left.
+ * Returns the number of bytes of buffer space used or -1 if
+ * no space left.
  *
- *	Locking: should be called under the output_lock to protect
- *		 the column state and space left in the buffer
+ * Locking: should be called under the output_lock to protect
+ *          the column state and space left in the buffer
  */
 
 static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
@@ -488,17 +488,17 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 }
 
 /**
- *	process_output			-	output post processor
- *	@c: character (or partial unicode symbol)
- *	@tty: terminal device
+ * process_output() - output post processor
+ * @c: character (or partial unicode symbol)
+ * @tty: terminal device
  *
- *	Output one character with OPOST processing.
- *	Returns -1 when the output device is full and the character
- *	must be retried.
+ * Output one character with OPOST processing.
+ * Returns -1 when the output device is full and the character
+ * must be retried.
  *
- *	Locking: output_lock to protect column state and space left
- *		 (also, this is called from n_tty_write under the
- *		  tty layer write lock)
+ * Locking: output_lock to protect column state and space left
+ *          (also, this is called from n_tty_write under the
+ *          tty layer write lock)
  */
 
 static int process_output(unsigned char c, struct tty_struct *tty)
@@ -519,22 +519,22 @@ static int process_output(unsigned char c, struct tty_struct *tty)
 }
 
 /**
- *	process_output_block		-	block post processor
- *	@tty: terminal device
- *	@buf: character buffer
- *	@nr: number of bytes to output
- *
- *	Output a block of characters with OPOST processing.
- *	Returns the number of characters output.
- *
- *	This path is used to speed up block console writes, among other
- *	things when processing blocks of output data. It handles only
- *	the simple cases normally found and helps to generate blocks of
- *	symbols for the console driver and thus improve performance.
- *
- *	Locking: output_lock to protect column state and space left
- *		 (also, this is called from n_tty_write under the
- *		  tty layer write lock)
+ * process_output_block() - block post processor
+ * @tty: terminal device
+ * @buf: character buffer
+ * @nr: number of bytes to output
+ *
+ * Output a block of characters with OPOST processing.
+ * Returns the number of characters output.
+ *
+ * This path is used to speed up block console writes, among other
+ * things when processing blocks of output data. It handles only
+ * the simple cases normally found and helps to generate blocks of
+ * symbols for the console driver and thus improve performance.
+ *
+ * Locking: output_lock to protect column state and space left
+ *          (also, this is called from n_tty_write under the
+ *          tty layer write lock)
  */
 
 static ssize_t process_output_block(struct tty_struct *tty,
@@ -597,28 +597,28 @@ static ssize_t process_output_block(struct tty_struct *tty,
 }
 
 /**
- *	process_echoes	-	write pending echo characters
- *	@tty: terminal device
+ * process_echoes() - write pending echo characters
+ * @tty: terminal device
  *
- *	Write previously buffered echo (and other ldisc-generated)
- *	characters to the tty.
+ * Write previously buffered echo (and other ldisc-generated)
+ * characters to the tty.
  *
- *	Characters generated by the ldisc (including echoes) need to
- *	be buffered because the driver's write buffer can fill during
- *	heavy program output.  Echoing straight to the driver will
- *	often fail under these conditions, causing lost characters and
- *	resulting mismatches of ldisc state information.
+ * Characters generated by the ldisc (including echoes) need to
+ * be buffered because the driver's write buffer can fill during
+ * heavy program output.  Echoing straight to the driver will
+ * often fail under these conditions, causing lost characters and
+ * resulting mismatches of ldisc state information.
  *
- *	Since the ldisc state must represent the characters actually sent
- *	to the driver at the time of the write, operations like certain
- *	changes in column state are also saved in the buffer and executed
- *	here.
+ * Since the ldisc state must represent the characters actually sent
+ * to the driver at the time of the write, operations like certain
+ * changes in column state are also saved in the buffer and executed
+ * here.
  *
- *	A circular fifo buffer is used so that the most recent characters
- *	are prioritized.  Also, when control characters are echoed with a
- *	prefixed "^", the pair is treated atomically and thus not separated.
+ * A circular fifo buffer is used so that the most recent characters
+ * are prioritized.  Also, when control characters are echoed with a
+ * prefixed "^", the pair is treated atomically and thus not separated.
  *
- *	Locking: callers must hold output_lock
+ * Locking: callers must hold output_lock
  */
 
 static size_t __process_echoes(struct tty_struct *tty)
@@ -829,11 +829,11 @@ static void flush_echoes(struct tty_struct *tty)
 }
 
 /**
- *	add_echo_byte	-	add a byte to the echo buffer
- *	@c: unicode byte to echo
- *	@ldata: n_tty data
+ * add_echo_byte() - add a byte to the echo buffer
+ * @c: unicode byte to echo
+ * @ldata: n_tty data
  *
- *	Add a character or operation byte to the echo buffer.
+ * Add a character or operation byte to the echo buffer.
  */
 
 static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
@@ -844,10 +844,10 @@ static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
 }
 
 /**
- *	echo_move_back_col	-	add operation to move back a column
- *	@ldata: n_tty data
+ * echo_move_back_col() - add operation to move back a column
+ * @ldata: n_tty data
  *
- *	Add an operation to the echo buffer to move back one column.
+ * Add an operation to the echo buffer to move back one column.
  */
 
 static void echo_move_back_col(struct n_tty_data *ldata)
@@ -857,11 +857,11 @@ static void echo_move_back_col(struct n_tty_data *ldata)
 }
 
 /**
- *	echo_set_canon_col	-	add operation to set the canon column
- *	@ldata: n_tty data
+ * echo_set_canon_col() - add operation to set the canon column
+ * @ldata: n_tty data
  *
- *	Add an operation to the echo buffer to set the canon column
- *	to the current column.
+ * Add an operation to the echo buffer to set the canon column
+ * to the current column.
  */
 
 static void echo_set_canon_col(struct n_tty_data *ldata)
@@ -871,18 +871,18 @@ static void echo_set_canon_col(struct n_tty_data *ldata)
 }
 
 /**
- *	echo_erase_tab	-	add operation to erase a tab
- *	@num_chars: number of character columns already used
- *	@after_tab: true if num_chars starts after a previous tab
- *	@ldata: n_tty data
- *
- *	Add an operation to the echo buffer to erase a tab.
- *
- *	Called by the eraser function, which knows how many character
- *	columns have been used since either a previous tab or the start
- *	of input.  This information will be used later, along with
- *	canon column (if applicable), to go back the correct number
- *	of columns.
+ * echo_erase_tab() - add operation to erase a tab
+ * @num_chars: number of character columns already used
+ * @after_tab: true if num_chars starts after a previous tab
+ * @ldata: n_tty data
+ *
+ * Add an operation to the echo buffer to erase a tab.
+ *
+ * Called by the eraser function, which knows how many character
+ * columns have been used since either a previous tab or the start
+ * of input.  This information will be used later, along with
+ * canon column (if applicable), to go back the correct number
+ * of columns.
  */
 
 static void echo_erase_tab(unsigned int num_chars, int after_tab,
@@ -902,14 +902,14 @@ static void echo_erase_tab(unsigned int num_chars, int after_tab,
 }
 
 /**
- *	echo_char_raw	-	echo a character raw
- *	@c: unicode byte to echo
- *	@tty: terminal device
+ * echo_char_raw() - echo a character raw
+ * @c: unicode byte to echo
+ * @tty: terminal device
  *
- *	Echo user input back onto the screen. This must be called only when
- *	L_ECHO(tty) is true. Called from the driver receive_buf path.
+ * Echo user input back onto the screen. This must be called only when
+ * L_ECHO(tty) is true. Called from the driver receive_buf path.
  *
- *	This variant does not treat control characters specially.
+ * This variant does not treat control characters specially.
  */
 
 static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
@@ -923,15 +923,15 @@ static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
 }
 
 /**
- *	echo_char	-	echo a character
- *	@c: unicode byte to echo
- *	@tty: terminal device
+ * echo_char() - echo a character
+ * @c: unicode byte to echo
+ * @tty: terminal device
  *
- *	Echo user input back onto the screen. This must be called only when
- *	L_ECHO(tty) is true. Called from the driver receive_buf path.
+ * Echo user input back onto the screen. This must be called only when
+ * L_ECHO(tty) is true. Called from the driver receive_buf path.
  *
- *	This variant tags control characters to be echoed as "^X"
- *	(where X is the letter representing the control char).
+ * This variant tags control characters to be echoed as "^X"
+ * (where X is the letter representing the control char).
  */
 
 static void echo_char(unsigned char c, struct tty_struct *tty)
@@ -949,8 +949,8 @@ static void echo_char(unsigned char c, struct tty_struct *tty)
 }
 
 /**
- *	finish_erasing		-	complete erase
- *	@ldata: n_tty data
+ * finish_erasing() - complete erase
+ * @ldata: n_tty data
  */
 
 static inline void finish_erasing(struct n_tty_data *ldata)
@@ -962,16 +962,16 @@ static inline void finish_erasing(struct n_tty_data *ldata)
 }
 
 /**
- *	eraser		-	handle erase function
- *	@c: character input
- *	@tty: terminal device
+ * eraser() - handle erase function
+ * @c: character input
+ * @tty: terminal device
  *
- *	Perform erase and necessary output when an erase character is
- *	present in the stream from the driver layer. Handles the complexities
- *	of UTF-8 multibyte symbols.
+ * Perform erase and necessary output when an erase character is
+ * present in the stream from the driver layer. Handles the complexities
+ * of UTF-8 multibyte symbols.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
+ * n_tty_receive_buf()/producer path:
+ * 	caller holds non-exclusive termios_rwsem
  */
 
 static void eraser(unsigned char c, struct tty_struct *tty)
@@ -1093,18 +1093,18 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 }
 
 /**
- *	isig		-	handle the ISIG optio
- *	@sig: signal
- *	@tty: terminal
+ * isig() - handle the ISIG optio
+ * @sig: signal
+ * @tty: terminal
  *
- *	Called when a signal is being sent due to terminal input.
- *	Called from the driver receive_buf path so serialized.
+ * Called when a signal is being sent due to terminal input.
+ * Called from the driver receive_buf path so serialized.
  *
- *	Performs input and output flush if !NOFLSH. In this context, the echo
- *	buffer is 'output'. The signal is processed first to alert any current
- *	readers or writers to discontinue and exit their i/o loops.
+ * Performs input and output flush if !NOFLSH. In this context, the echo
+ * buffer is 'output'. The signal is processed first to alert any current
+ * readers or writers to discontinue and exit their i/o loops.
  *
- *	Locking: ctrl_lock
+ * Locking: ctrl_lock
  */
 
 static void __isig(int sig, struct tty_struct *tty)
@@ -1152,16 +1152,16 @@ static void isig(int sig, struct tty_struct *tty)
 }
 
 /**
- *	n_tty_receive_break	-	handle break
- *	@tty: terminal
+ * n_tty_receive_break() - handle break
+ * @tty: terminal
  *
- *	An RS232 break event has been hit in the incoming bitstream. This
- *	can cause a variety of events depending upon the termios settings.
+ * An RS232 break event has been hit in the incoming bitstream. This
+ * can cause a variety of events depending upon the termios settings.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
+ * n_tty_receive_buf()/producer path:
+ * 	caller holds non-exclusive termios_rwsem
  *
- *	Note: may get exclusive termios_rwsem if flushing input buffer
+ * Note: may get exclusive termios_rwsem if flushing input buffer
  */
 
 static void n_tty_receive_break(struct tty_struct *tty)
@@ -1182,16 +1182,16 @@ static void n_tty_receive_break(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_receive_overrun	-	handle overrun reporting
- *	@tty: terminal
+ * n_tty_receive_overrun() - handle overrun reporting
+ * @tty: terminal
  *
- *	Data arrived faster than we could process it. While the tty
- *	driver has flagged this the bits that were missed are gone
- *	forever.
+ * Data arrived faster than we could process it. While the tty
+ * driver has flagged this the bits that were missed are gone
+ * forever.
  *
- *	Called from the receive_buf path so single threaded. Does not
- *	need locking as num_overrun and overrun_time are function
- *	private.
+ * Called from the receive_buf path so single threaded. Does not
+ * need locking as num_overrun and overrun_time are function
+ * private.
  */
 
 static void n_tty_receive_overrun(struct tty_struct *tty)
@@ -1208,15 +1208,15 @@ static void n_tty_receive_overrun(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_receive_parity_error	-	error notifier
- *	@tty: terminal device
- *	@c: character
+ * n_tty_receive_parity_error() - error notifier
+ * @tty: terminal device
+ * @c: character
  *
- *	Process a parity error and queue the right data to indicate
- *	the error case if necessary.
+ * Process a parity error and queue the right data to indicate
+ * the error case if necessary.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
+ * n_tty_receive_buf()/producer path:
+ * 	caller holds non-exclusive termios_rwsem
  */
 static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 {
@@ -1250,19 +1250,19 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 }
 
 /**
- *	n_tty_receive_char	-	perform processing
- *	@tty: terminal device
- *	@c: character
+ * n_tty_receive_char() - perform processing
+ * @tty: terminal device
+ * @c: character
  *
- *	Process an individual character of input received from the driver.
- *	This is serialized with respect to itself by the rules for the
- *	driver above.
+ * Process an individual character of input received from the driver.
+ * This is serialized with respect to itself by the rules for the
+ * driver above.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
- *		publishes canon_head if canonical mode is active
+ * n_tty_receive_buf()/producer path:
+ *      caller holds non-exclusive termios_rwsem
+ *      publishes canon_head if canonical mode is active
  *
- *	Returns 1 if LNEXT was received, else returns 0
+ * Returns 1 if LNEXT was received, else returns 0
  */
 
 static int
@@ -1661,37 +1661,37 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 }
 
 /**
- *	n_tty_receive_buf_common	-	process input
- *	@tty: device to receive input
- *	@cp: input chars
- *	@fp: flags for each char (if NULL, all chars are TTY_NORMAL)
- *	@count: number of input chars in @cp
- *
- *	Called by the terminal driver when a block of characters has
- *	been received. This function must be called from soft contexts
- *	not from interrupt context. The driver is responsible for making
- *	calls one at a time and in order (or using flush_to_ldisc)
- *
- *	Returns the # of input chars from @cp which were processed.
- *
- *	In canonical mode, the maximum line length is 4096 chars (including
- *	the line termination char); lines longer than 4096 chars are
- *	truncated. After 4095 chars, input data is still processed but
- *	not stored. Overflow processing ensures the tty can always
- *	receive more input until at least one line can be read.
- *
- *	In non-canonical mode, the read buffer will only accept 4095 chars;
- *	this provides the necessary space for a newline char if the input
- *	mode is switched to canonical.
- *
- *	Note it is possible for the read buffer to _contain_ 4096 chars
- *	in non-canonical mode: the read buffer could already contain the
- *	maximum canon line of 4096 chars when the mode is switched to
- *	non-canonical.
- *
- *	n_tty_receive_buf()/producer path:
- *		claims non-exclusive termios_rwsem
- *		publishes commit_head or canon_head
+ * n_tty_receive_buf_common() - process input
+ * @tty: device to receive input
+ * @cp: input chars
+ * @fp: flags for each char (if NULL, all chars are TTY_NORMAL)
+ * @count: number of input chars in @cp
+ *
+ * Called by the terminal driver when a block of characters has
+ * been received. This function must be called from soft contexts
+ * not from interrupt context. The driver is responsible for making
+ * calls one at a time and in order (or using flush_to_ldisc)
+ *
+ * Returns the # of input chars from @cp which were processed.
+ *
+ * In canonical mode, the maximum line length is 4096 chars (including
+ * the line termination char); lines longer than 4096 chars are
+ * truncated. After 4095 chars, input data is still processed but
+ * not stored. Overflow processing ensures the tty can always
+ * receive more input until at least one line can be read.
+ *
+ * In non-canonical mode, the read buffer will only accept 4095 chars;
+ * this provides the necessary space for a newline char if the input
+ * mode is switched to canonical.
+ *
+ * Note it is possible for the read buffer to _contain_ 4096 chars
+ * in non-canonical mode: the read buffer could already contain the
+ * maximum canon line of 4096 chars when the mode is switched to
+ * non-canonical.
+ *
+ * n_tty_receive_buf()/producer path:
+ * 	claims non-exclusive termios_rwsem
+ * 	publishes commit_head or canon_head
  */
 static int
 n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
@@ -1776,17 +1776,17 @@ static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
 }
 
 /**
- *	n_tty_set_termios	-	termios data changed
- *	@tty: terminal
- *	@old: previous data
+ * n_tty_set_termios() - termios data changed
+ * @tty: terminal
+ * @old: previous data
  *
- *	Called by the tty layer when the user changes termios flags so
- *	that the line discipline can plan ahead. This function cannot sleep
- *	and is protected from re-entry by the tty layer. The user is
- *	guaranteed that this function will not be re-entered or in progress
- *	when the ldisc is closed.
+ * Called by the tty layer when the user changes termios flags so
+ * that the line discipline can plan ahead. This function cannot sleep
+ * and is protected from re-entry by the tty layer. The user is
+ * guaranteed that this function will not be re-entered or in progress
+ * when the ldisc is closed.
  *
- *	Locking: Caller holds tty->termios_rwsem
+ * Locking: Caller holds tty->termios_rwsem
  */
 
 static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
@@ -1874,13 +1874,13 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 }
 
 /**
- *	n_tty_close		-	close the ldisc for this tty
- *	@tty: device
+ * n_tty_close() - close the ldisc for this tty
+ * @tty: device
  *
- *	Called from the terminal layer when this line discipline is
- *	being shut down, either because of a close or becsuse of a
- *	discipline change. The function will not be called while other
- *	ldisc methods are in progress.
+ * Called from the terminal layer when this line discipline is
+ * being shut down, either because of a close or becsuse of a
+ * discipline change. The function will not be called while other
+ * ldisc methods are in progress.
  */
 
 static void n_tty_close(struct tty_struct *tty)
@@ -1895,13 +1895,13 @@ static void n_tty_close(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_open		-	open an ldisc
- *	@tty: terminal to open
+ * n_tty_open() - open an ldisc
+ * @tty: terminal to open
  *
- *	Called when this line discipline is being attached to the
- *	terminal device. Can sleep. Called serialized so that no
- *	other events will occur in parallel. No further open will occur
- *	until a close.
+ * Called when this line discipline is being attached to the
+ * terminal device. Can sleep. Called serialized so that no
+ * other events will occur in parallel. No further open will occur
+ * until a close.
  */
 
 static int n_tty_open(struct tty_struct *tty)
@@ -1938,23 +1938,23 @@ static inline int input_available_p(struct tty_struct *tty, int poll)
 }
 
 /**
- *	copy_from_read_buf	-	copy read data directly
- *	@tty: terminal device
- *	@b: user data
- *	@nr: size of data
- *
- *	Helper function to speed up n_tty_read.  It is only called when
- *	ICANON is off; it copies characters straight from the tty queue to
- *	user space directly.  It can be profitably called twice; once to
- *	drain the space from the tail pointer to the (physical) end of the
- *	buffer, and once to drain the space from the (physical) beginning of
- *	the buffer to head pointer.
- *
- *	Called under the ldata->atomic_read_lock sem
- *
- *	n_tty_read()/consumer path:
- *		caller holds non-exclusive termios_rwsem
- *		read_tail published
+ * copy_from_read_buf() - copy read data directly
+ * @tty: terminal device
+ * @b: user data
+ * @nr: size of data
+ *
+ * Helper function to speed up n_tty_read.  It is only called when
+ * ICANON is off; it copies characters straight from the tty queue to
+ * user space directly.  It can be profitably called twice; once to
+ * drain the space from the tail pointer to the (physical) end of the
+ * buffer, and once to drain the space from the (physical) beginning of
+ * the buffer to head pointer.
+ *
+ * Called under the ldata->atomic_read_lock sem
+ *
+ * n_tty_read()/consumer path:
+ * 	caller holds non-exclusive termios_rwsem
+ * 	read_tail published
  */
 
 static int copy_from_read_buf(struct tty_struct *tty,
@@ -1991,26 +1991,26 @@ static int copy_from_read_buf(struct tty_struct *tty,
 }
 
 /**
- *	canon_copy_from_read_buf	-	copy read data in canonical mode
- *	@tty: terminal device
- *	@b: user data
- *	@nr: size of data
- *
- *	Helper function for n_tty_read.  It is only called when ICANON is on;
- *	it copies one line of input up to and including the line-delimiting
- *	character into the user-space buffer.
- *
- *	NB: When termios is changed from non-canonical to canonical mode and
- *	the read buffer contains data, n_tty_set_termios() simulates an EOF
- *	push (as if C-d were input) _without_ the DISABLED_CHAR in the buffer.
- *	This causes data already processed as input to be immediately available
- *	as input although a newline has not been received.
- *
- *	Called under the atomic_read_lock mutex
- *
- *	n_tty_read()/consumer path:
- *		caller holds non-exclusive termios_rwsem
- *		read_tail published
+ * canon_copy_from_read_buf() - copy read data in canonical mode
+ * @tty: terminal device
+ * @b: user data
+ * @nr: size of data
+ *
+ * Helper function for n_tty_read.  It is only called when ICANON is on;
+ * it copies one line of input up to and including the line-delimiting
+ * character into the user-space buffer.
+ *
+ * NB: When termios is changed from non-canonical to canonical mode and
+ * the read buffer contains data, n_tty_set_termios() simulates an EOF
+ * push (as if C-d were input) _without_ the DISABLED_CHAR in the buffer.
+ * This causes data already processed as input to be immediately available
+ * as input although a newline has not been received.
+ *
+ * Called under the atomic_read_lock mutex
+ *
+ * n_tty_read()/consumer path:
+ * 	caller holds non-exclusive termios_rwsem
+ * 	read_tail published
  */
 
 static int canon_copy_from_read_buf(struct tty_struct *tty,
@@ -2081,17 +2081,17 @@ extern ssize_t redirected_tty_write(struct file *, const char __user *,
 							size_t, loff_t *);
 
 /**
- *	job_control		-	check job control
- *	@tty: tty
- *	@file: file handle
+ * job_control() - check job control
+ * @tty: tty
+ * @file: file handle
  *
- *	Perform job control management checks on this file/tty descriptor
- *	and if appropriate send any needed signals and return a negative
- *	error code if action should be taken.
+ * Perform job control management checks on this file/tty descriptor
+ * and if appropriate send any needed signals and return a negative
+ * error code if action should be taken.
  *
- *	Locking: redirected write test is safe
- *		 current->signal->tty check is safe
- *		 ctrl_lock to safely reference tty->pgrp
+ * Locking: redirected write test is safe
+ *          current->signal->tty check is safe
+ *          ctrl_lock to safely reference tty->pgrp
  */
 
 static int job_control(struct tty_struct *tty, struct file *file)
@@ -2109,22 +2109,22 @@ static int job_control(struct tty_struct *tty, struct file *file)
 
 
 /**
- *	n_tty_read		-	read function for tty
- *	@tty: tty device
- *	@file: file object
- *	@buf: userspace buffer pointer
- *	@nr: size of I/O
- *
- *	Perform reads for the line discipline. We are guaranteed that the
- *	line discipline will not be closed under us but we may get multiple
- *	parallel readers and must handle this ourselves. We may also get
- *	a hangup. Always called in user context, may sleep.
- *
- *	This code must be sure never to sleep through a hangup.
- *
- *	n_tty_read()/consumer path:
- *		claims non-exclusive termios_rwsem
- *		publishes read_tail
+ * n_tty_read() - read function for tty
+ * @tty: tty device
+ * @file: file object
+ * @buf: userspace buffer pointer
+ * @nr: size of I/O
+ *
+ * Perform reads for the line discipline. We are guaranteed that the
+ * line discipline will not be closed under us but we may get multiple
+ * parallel readers and must handle this ourselves. We may also get
+ * a hangup. Always called in user context, may sleep.
+ *
+ * This code must be sure never to sleep through a hangup.
+ *
+ * n_tty_read()/consumer path:
+ * 	claims non-exclusive termios_rwsem
+ * 	publishes read_tail
  */
 
 static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
@@ -2275,25 +2275,25 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 }
 
 /**
- *	n_tty_write		-	write function for tty
- *	@tty: tty device
- *	@file: file object
- *	@buf: userspace buffer pointer
- *	@nr: size of I/O
- *
- *	Write function of the terminal device.  This is serialized with
- *	respect to other write callers but not to termios changes, reads
- *	and other such events.  Since the receive code will echo characters,
- *	thus calling driver write methods, the output_lock is used in
- *	the output processing functions called here as well as in the
- *	echo processing function to protect the column state and space
- *	left in the buffer.
- *
- *	This code must be sure never to sleep through a hangup.
- *
- *	Locking: output_lock to protect column state and space left
- *		 (note that the process_output*() functions take this
- *		  lock themselves)
+ * n_tty_write() - write function for tty
+ * @tty: tty device
+ * @file: file object
+ * @buf: userspace buffer pointer
+ * @nr: size of I/O
+ *
+ * Write function of the terminal device.  This is serialized with
+ * respect to other write callers but not to termios changes, reads
+ * and other such events.  Since the receive code will echo characters,
+ * thus calling driver write methods, the output_lock is used in
+ * the output processing functions called here as well as in the
+ * echo processing function to protect the column state and space
+ * left in the buffer.
+ *
+ * This code must be sure never to sleep through a hangup.
+ *
+ * Locking: output_lock to protect column state and space left
+ *          (note that the process_output*() functions take this
+ *          lock themselves)
  */
 
 static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
@@ -2384,17 +2384,17 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 }
 
 /**
- *	n_tty_poll		-	poll method for N_TTY
- *	@tty: terminal device
- *	@file: file accessing it
- *	@wait: poll table
+ * n_tty_poll() - poll method for N_TTY
+ * @tty: terminal device
+ * @file: file accessing it
+ * @wait: poll table
  *
- *	Called when the line discipline is asked to poll() for data or
- *	for special events. This code is not serialized with respect to
- *	other events save open/close.
+ * Called when the line discipline is asked to poll() for data or
+ * for special events. This code is not serialized with respect to
+ * other events save open/close.
  *
- *	This code must be sure never to sleep through a hangup.
- *	Called without the kernel lock held - fine
+ * This code must be sure never to sleep through a hangup.
+ * Called without the kernel lock held - fine
  */
 
 static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
@@ -2482,10 +2482,10 @@ static struct tty_ldisc_ops n_tty_ops = {
 };
 
 /**
- *	n_tty_inherit_ops	-	inherit N_TTY methods
- *	@ops: struct tty_ldisc_ops where to save N_TTY methods
+ * n_tty_inherit_ops() - inherit N_TTY methods
+ * @ops: struct tty_ldisc_ops where to save N_TTY methods
  *
- *	Enables a 'subclass' line discipline to 'inherit' N_TTY methods.
+ * Enables a 'subclass' line discipline to 'inherit' N_TTY methods.
  */
 
 void n_tty_inherit_ops(struct tty_ldisc_ops *ops)
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 678406e0948b..a8ec902fd9be 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -96,15 +96,15 @@ static void pty_unthrottle(struct tty_struct *tty)
 }
 
 /**
- *	pty_write		-	write to a pty
- *	@tty: the tty we write from
- *	@buf: kernel buffer of data
- *	@count: bytes to write
+ * pty_write() - write to a pty
+ * @tty: the tty we write from
+ * @buf: kernel buffer of data
+ * @count: bytes to write
  *
- *	Our "hardware" write method. Data is coming from the ldisc which
- *	may be in a non sleeping state. We simply throw this at the other
- *	end of the link as if we were an IRQ handler receiving stuff for
- *	the other side of the pty/tty pair.
+ * Our "hardware" write method. Data is coming from the ldisc which
+ * may be in a non sleeping state. We simply throw this at the other
+ * end of the link as if we were an IRQ handler receiving stuff for
+ * the other side of the pty/tty pair.
  */
 
 static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
@@ -128,11 +128,11 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 }
 
 /**
- *	pty_write_room	-	write space
- *	@tty: tty we are writing from
+ * pty_write_room() - write space
+ * @tty: tty we are writing from
  *
- *	Report how many bytes the ldisc can send into the queue for
- *	the other device.
+ * Report how many bytes the ldisc can send into the queue for
+ * the other device.
  */
 
 static int pty_write_room(struct tty_struct *tty)
@@ -143,11 +143,11 @@ static int pty_write_room(struct tty_struct *tty)
 }
 
 /**
- *	pty_chars_in_buffer	-	characters currently in our tx queue
- *	@tty: our tty
+ * pty_chars_in_buffer() - characters currently in our tx queue
+ * @tty: our tty
  *
- *	Report how much we have in the transmit queue. As everything is
- *	instantly at the other end this is easy to implement.
+ * Report how much we have in the transmit queue. As everything is
+ * instantly at the other end this is easy to implement.
  */
 
 static int pty_chars_in_buffer(struct tty_struct *tty)
@@ -291,12 +291,12 @@ static void pty_set_termios(struct tty_struct *tty,
 }
 
 /**
- *	pty_do_resize		-	resize event
- *	@tty: tty being resized
- *	@ws: window size being set.
+ * pty_do_resize() - resize event
+ * @tty: tty being resized
+ * @ws: window size being set.
  *
- *	Update the termios variables and send the necessary signals to
- *	peform a terminal resize correctly
+ * Update the termios variables and send the necessary signals to
+ * peform a terminal resize correctly
  */
 
 static int pty_resize(struct tty_struct *tty,  struct winsize *ws)
@@ -329,14 +329,14 @@ static int pty_resize(struct tty_struct *tty,  struct winsize *ws)
 }
 
 /**
- *	pty_start - start() handler
- *	pty_stop  - stop() handler
- *	@tty: tty being flow-controlled
+ * pty_start() - start handler
+ * pty_stop() - stop handler
+ * @tty: tty being flow-controlled
  *
- *	Propagates the TIOCPKT status to the master pty.
+ * Propagates the TIOCPKT status to the master pty.
  *
- *	NB: only the master pty can be in packet mode so only the slave
- *	    needs start()/stop() handlers
+ * NB: only the master pty can be in packet mode so only the slave
+ *     needs start()/stop() handlers
  */
 static void pty_start(struct tty_struct *tty)
 {
@@ -365,15 +365,15 @@ static void pty_stop(struct tty_struct *tty)
 }
 
 /**
- *	pty_common_install		-	set up the pty pair
- *	@driver: the pty driver
- *	@tty: the tty being instantiated
- *	@legacy: true if this is BSD style
+ * pty_common_install() - set up the pty pair
+ * @driver: the pty driver
+ * @tty: the tty being instantiated
+ * @legacy: true if this is BSD style
  *
- *	Perform the initial set up for the tty/pty pair. Called from the
- *	tty layer when the port is first opened.
+ * Perform the initial set up for the tty/pty pair. Called from the
+ * tty layer when the port is first opened.
  *
- *	Locking: the caller must hold the tty_mutex
+ * Locking: the caller must hold the tty_mutex
  */
 static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
 		bool legacy)
@@ -606,14 +606,14 @@ static inline void legacy_pty_init(void) { }
 static struct cdev ptmx_cdev;
 
 /**
- *	ptm_open_peer - open the peer of a pty
- *	@master: the open struct file of the ptmx device node
- *	@tty: the master of the pty being opened
- *	@flags: the flags for open
+ * ptm_open_peer() - open the peer of a pty
+ * @master: the open struct file of the ptmx device node
+ * @tty: the master of the pty being opened
+ * @flags: the flags for open
  *
- *	Provide a race free way for userspace to open the slave end of a pty
- *	(where they have the master fd and cannot access or trust the mount
- *	namespace /dev/pts was mounted inside).
+ * Provide a race free way for userspace to open the slave end of a pty
+ * (where they have the master fd and cannot access or trust the mount
+ * namespace /dev/pts was mounted inside).
  */
 int ptm_open_peer(struct file *master, struct tty_struct *tty, int flags)
 {
@@ -687,12 +687,12 @@ static long pty_unix98_compat_ioctl(struct tty_struct *tty,
 }
 
 /**
- *	ptm_unix98_lookup	-	find a pty master
- *	@driver: ptm driver
- *	@idx: tty index
+ * ptm_unix98_lookup() - find a pty master
+ * @driver: ptm driver
+ * @idx: tty index
  *
- *	Look up a pty master device. Called under the tty_mutex for now.
- *	This provides our locking.
+ * Look up a pty master device. Called under the tty_mutex for now.
+ * This provides our locking.
  */
 
 static struct tty_struct *ptm_unix98_lookup(struct tty_driver *driver,
@@ -703,12 +703,12 @@ static struct tty_struct *ptm_unix98_lookup(struct tty_driver *driver,
 }
 
 /**
- *	pts_unix98_lookup	-	find a pty slave
- *	@driver: pts driver
- *	@idx: tty index
+ * pts_unix98_lookup() - find a pty slave
+ * @driver: pts driver
+ * @idx: tty index
  *
- *	Look up a pty master device. Called under the tty_mutex for now.
- *	This provides our locking for the tty pointer.
+ * Look up a pty master device. Called under the tty_mutex for now.
+ * This provides our locking for the tty pointer.
  */
 
 static struct tty_struct *pts_unix98_lookup(struct tty_driver *driver,
@@ -787,15 +787,15 @@ static const struct tty_operations pty_unix98_ops = {
 };
 
 /**
- *	ptmx_open		-	open a unix 98 pty master
- *	@inode: inode of device file
- *	@filp: file pointer to tty
+ * ptmx_open() - open a unix 98 pty master
+ * @inode: inode of device file
+ * @filp: file pointer to tty
  *
- *	Allocate a unix98 pty master device from the ptmx driver.
+ * Allocate a unix98 pty master device from the ptmx driver.
  *
- *	Locking: tty_mutex protects the init_dev work. tty->count should
- *		protect the rest.
- *		allocated_ptys_lock handles the list of free pty numbers
+ * Locking: tty_mutex protects the init_dev work. tty->count should
+ *          protect the rest.
+ *          allocated_ptys_lock handles the list of free pty numbers
  */
 
 static int ptmx_open(struct inode *inode, struct file *filp)
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94f3e1c64490..63d7537a1db1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -397,7 +397,7 @@ static const struct uart_8250_ops univ8250_driver_ops = {
 static struct uart_8250_port serial8250_ports[UART_NR];
 
 /**
- * serial8250_get_port - retrieve struct uart_8250_port
+ * serial8250_get_port() - retrieve struct uart_8250_port
  * @line: serial line number
  *
  * This function retrieves struct uart_8250_port for the specific line.
@@ -609,22 +609,22 @@ static int univ8250_console_setup(struct console *co, char *options)
 }
 
 /**
- *	univ8250_console_match - non-standard console matching
- *	@co:	  registering console
- *	@name:	  name from console command line
- *	@idx:	  index from console command line
- *	@options: ptr to option string from console command line
+ * univ8250_console_match() - non-standard console matching
+ * @co: registering console
+ * @name: name from console command line
+ * @idx: index from console command line
+ * @options: ptr to option string from console command line
  *
- *	Only attempts to match console command lines of the form:
- *	    console=uart[8250],io|mmio|mmio16|mmio32,<addr>[,<options>]
- *	    console=uart[8250],0x<addr>[,<options>]
- *	This form is used to register an initial earlycon boot console and
- *	replace it with the serial8250_console at 8250 driver init.
+ * Only attempts to match console command lines of the form:
+ *     console=uart[8250],io|mmio|mmio16|mmio32,<addr>[,<options>]
+ *     console=uart[8250],0x<addr>[,<options>]
+ * This form is used to register an initial earlycon boot console and
+ * replace it with the serial8250_console at 8250 driver init.
  *
- *	Performs console setup for a match (as required by interface)
- *	If no <options> are specified, then assume the h/w is already setup.
+ * Performs console setup for a match (as required by interface)
+ * If no <options> are specified, then assume the h/w is already setup.
  *
- *	Returns 0 if console matches; otherwise non-zero to use default matching
+ * Returns 0 if console matches; otherwise non-zero to use default matching
  */
 static int univ8250_console_match(struct console *co, char *name, int idx,
 				  char *options)
@@ -740,10 +740,10 @@ int __init early_serial_setup(struct uart_port *port)
 }
 
 /**
- *	serial8250_suspend_port - suspend one serial port
- *	@line:  serial line number
+ * serial8250_suspend_port() - suspend one serial port
+ * @line: serial line number
  *
- *	Suspend one serial port.
+ * Suspend one serial port.
  */
 void serial8250_suspend_port(int line)
 {
@@ -763,10 +763,10 @@ void serial8250_suspend_port(int line)
 EXPORT_SYMBOL(serial8250_suspend_port);
 
 /**
- *	serial8250_resume_port - resume one serial port
- *	@line:  serial line number
+ * serial8250_resume_port() - resume one serial port
+ * @line: serial line number
  *
- *	Resume one serial port.
+ * Resume one serial port.
  */
 void serial8250_resume_port(int line)
 {
@@ -943,17 +943,17 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 }
 
 /**
- *	serial8250_register_8250_port - register a serial port
- *	@up: serial port template
+ * serial8250_register_8250_port() - register a serial port
+ * @up: serial port template
  *
- *	Configure the serial port specified by the request. If the
- *	port exists and is in use, it is hung up and unregistered
- *	first.
+ * Configure the serial port specified by the request. If the
+ * port exists and is in use, it is hung up and unregistered
+ * first.
  *
- *	The port is then probed and if necessary the IRQ is autodetected
- *	If this fails an error is returned.
+ * The port is then probed and if necessary the IRQ is autodetected
+ * If this fails an error is returned.
  *
- *	On success the port is ready to use and the line number is returned.
+ * On success the port is ready to use and the line number is returned.
  */
 int serial8250_register_8250_port(struct uart_8250_port *up)
 {
@@ -1063,11 +1063,11 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 EXPORT_SYMBOL(serial8250_register_8250_port);
 
 /**
- *	serial8250_unregister_port - remove a 16x50 serial port at runtime
- *	@line: serial line number
+ * serial8250_unregister_port() - remove a 16x50 serial port at runtime
+ * @line: serial line number
  *
- *	Remove one serial port.  This may not be called from interrupt
- *	context.  We hand the port back to the our control.
+ * Remove one serial port.  This may not be called from interrupt
+ * context.  We hand the port back to the our control.
  */
 void serial8250_unregister_port(int line)
 {
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f776b3eafb96..c3c20310c30c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -618,24 +618,24 @@ void serial8250_rpm_put(struct uart_8250_port *p)
 EXPORT_SYMBOL_GPL(serial8250_rpm_put);
 
 /**
- *	serial8250_em485_init() - put uart_8250_port into rs485 emulating
- *	@p:	uart_8250_port port instance
+ * serial8250_em485_init() - put uart_8250_port into rs485 emulating
+ * @p: uart_8250_port port instance
  *
- *	The function is used to start rs485 software emulating on the
- *	&struct uart_8250_port* @p. Namely, RTS is switched before/after
- *	transmission. The function is idempotent, so it is safe to call it
- *	multiple times.
+ * The function is used to start rs485 software emulating on the
+ * &struct uart_8250_port* @p. Namely, RTS is switched before/after
+ * transmission. The function is idempotent, so it is safe to call it
+ * multiple times.
  *
- *	The caller MUST enable interrupt on empty shift register before
- *	calling serial8250_em485_init(). This interrupt is not a part of
- *	8250 standard, but implementation defined.
+ * The caller MUST enable interrupt on empty shift register before
+ * calling serial8250_em485_init(). This interrupt is not a part of
+ * 8250 standard, but implementation defined.
  *
- *	The function is supposed to be called from .rs485_config callback
- *	or from any other callback protected with p->port.lock spinlock.
+ * The function is supposed to be called from .rs485_config callback
+ * or from any other callback protected with p->port.lock spinlock.
  *
- *	See also serial8250_em485_destroy()
+ * See also serial8250_em485_destroy()
  *
- *	Return 0 - success, -errno - otherwise
+ * Return 0 - success, -errno - otherwise
  */
 int serial8250_em485_init(struct uart_8250_port *p)
 {
@@ -661,17 +661,17 @@ int serial8250_em485_init(struct uart_8250_port *p)
 EXPORT_SYMBOL_GPL(serial8250_em485_init);
 
 /**
- *	serial8250_em485_destroy() - put uart_8250_port into normal state
- *	@p:	uart_8250_port port instance
+ * serial8250_em485_destroy() - put uart_8250_port into normal state
+ * @p: uart_8250_port port instance
  *
- *	The function is used to stop rs485 software emulating on the
- *	&struct uart_8250_port* @p. The function is idempotent, so it is safe to
- *	call it multiple times.
+ * The function is used to stop rs485 software emulating on the
+ * &struct uart_8250_port* @p. The function is idempotent, so it is safe to
+ * call it multiple times.
  *
- *	The function is supposed to be called from .rs485_config callback
- *	or from any other callback protected with p->port.lock spinlock.
+ * The function is supposed to be called from .rs485_config callback
+ * or from any other callback protected with p->port.lock spinlock.
  *
- *	See also serial8250_em485_init()
+ * See also serial8250_em485_init()
  */
 void serial8250_em485_destroy(struct uart_8250_port *p)
 {
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8a47ba2cfe54..589adc597923 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2340,22 +2340,22 @@ static int __init pl011_console_setup(struct console *co, char *options)
 }
 
 /**
- *	pl011_console_match - non-standard console matching
- *	@co:	  registering console
- *	@name:	  name from console command line
- *	@idx:	  index from console command line
- *	@options: ptr to option string from console command line
+ * pl011_console_match() - non-standard console matching
+ * @co: registering console
+ * @name: name from console command line
+ * @idx: index from console command line
+ * @options: ptr to option string from console command line
  *
- *	Only attempts to match console command lines of the form:
- *	    console=pl011,mmio|mmio32,<addr>[,<options>]
- *	    console=pl011,0x<addr>[,<options>]
- *	This form is used to register an initial earlycon boot console and
- *	replace it with the amba_console at pl011 driver init.
+ * Only attempts to match console command lines of the form:
+ *     console=pl011,mmio|mmio32,<addr>[,<options>]
+ *     console=pl011,0x<addr>[,<options>]
+ * This form is used to register an initial earlycon boot console and
+ * replace it with the amba_console at pl011 driver init.
  *
- *	Performs console setup for a match (as required by interface)
- *	If no <options> are specified, then assume the h/w is already setup.
+ * Performs console setup for a match (as required by interface)
+ * If no <options> are specified, then assume the h/w is already setup.
  *
- *	Returns 0 if console matches; otherwise non-zero to use default matching
+ * Returns 0 if console matches; otherwise non-zero to use default matching
  */
 static int __init pl011_console_match(struct console *co, char *name, int idx,
 				      char *options)
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index c14873b67803..85bd5a5d7f39 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -150,22 +150,22 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 }
 
 /**
- *	setup_earlycon - match and register earlycon console
- *	@buf:	earlycon param string
+ * setup_earlycon() - match and register earlycon console
+ * @buf: earlycon param string
  *
- *	Registers the earlycon console matching the earlycon specified
- *	in the param string @buf. Acceptable param strings are of the form
- *	   <name>,io|mmio|mmio32|mmio32be,<addr>,<options>
- *	   <name>,0x<addr>,<options>
- *	   <name>,<options>
- *	   <name>
+ * Registers the earlycon console matching the earlycon specified
+ * in the param string @buf. Acceptable param strings are of the form
+ *    <name>,io|mmio|mmio32|mmio32be,<addr>,<options>
+ *    <name>,0x<addr>,<options>
+ *    <name>,<options>
+ *    <name>
  *
- *	Only for the third form does the earlycon setup() method receive the
- *	<options> string in the 'options' parameter; all other forms set
- *	the parameter to NULL.
+ * Only for the third form does the earlycon setup() method receive the
+ * <options> string in the 'options' parameter; all other forms set
+ * the parameter to NULL.
  *
- *	Returns 0 if an attempt to register the earlycon was made,
- *	otherwise negative error code
+ * Returns 0 if an attempt to register the earlycon was made,
+ * otherwise negative error code
  */
 int __init setup_earlycon(char *buf)
 {
diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index ffefd218761e..3ddd320162c0 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -101,8 +101,8 @@ static int ifx_modem_reboot_callback(struct notifier_block *nfb,
 /* GPIO/GPE settings */
 
 /**
- *	mrdy_set_high		-	set MRDY GPIO
- *	@ifx: device we are controlling
+ * mrdy_set_high() - set MRDY GPIO
+ * @ifx: device we are controlling
  *
  */
 static inline void mrdy_set_high(struct ifx_spi_device *ifx)
@@ -111,8 +111,8 @@ static inline void mrdy_set_high(struct ifx_spi_device *ifx)
 }
 
 /**
- *	mrdy_set_low		-	clear MRDY GPIO
- *	@ifx: device we are controlling
+ * mrdy_set_low() - clear MRDY GPIO
+ * @ifx: device we are controlling
  *
  */
 static inline void mrdy_set_low(struct ifx_spi_device *ifx)
@@ -121,11 +121,11 @@ static inline void mrdy_set_low(struct ifx_spi_device *ifx)
 }
 
 /**
- *	ifx_spi_power_state_set
- *	@ifx_dev: our SPI device
- *	@val: bits to set
+ * ifx_spi_power_state_set()
+ * @ifx_dev: our SPI device
+ * @val: bits to set
  *
- *	Set bit in power status and signal power system if status becomes non-0
+ * Set bit in power status and signal power system if status becomes non-0
  */
 static void
 ifx_spi_power_state_set(struct ifx_spi_device *ifx_dev, unsigned char val)
@@ -146,11 +146,11 @@ ifx_spi_power_state_set(struct ifx_spi_device *ifx_dev, unsigned char val)
 }
 
 /**
- *	ifx_spi_power_state_clear	-	clear power bit
- *	@ifx_dev: our SPI device
- *	@val: bits to clear
+ * ifx_spi_power_state_clear() - clear power bit
+ * @ifx_dev: our SPI device
+ * @val: bits to clear
  *
- *	clear bit in power status and signal power system if status becomes 0
+ * clear bit in power status and signal power system if status becomes 0
  */
 static void
 ifx_spi_power_state_clear(struct ifx_spi_device *ifx_dev, unsigned char val)
@@ -169,12 +169,12 @@ ifx_spi_power_state_clear(struct ifx_spi_device *ifx_dev, unsigned char val)
 }
 
 /**
- *	swap_buf_8
- *	@buf: our buffer
- *	@len : number of bytes (not words) in the buffer
- *	@end: end of buffer
+ * swap_buf_8()
+ * @buf: our buffer
+ * @len: number of bytes (not words) in the buffer
+ * @end: end of buffer
  *
- *	Swap the contents of a buffer into big endian format
+ * Swap the contents of a buffer into big endian format
  */
 static inline void swap_buf_8(unsigned char *buf, int len, void *end)
 {
@@ -183,12 +183,12 @@ static inline void swap_buf_8(unsigned char *buf, int len, void *end)
 }
 
 /**
- *	swap_buf_16
- *	@buf: our buffer
- *	@len : number of bytes (not words) in the buffer
- *	@end: end of buffer
+ * swap_buf_16()
+ * @buf: our buffer
+ * @len: number of bytes (not words) in the buffer
+ * @end: end of buffer
  *
- *	Swap the contents of a buffer into big endian format
+ * Swap the contents of a buffer into big endian format
  */
 static inline void swap_buf_16(unsigned char *buf, int len, void *end)
 {
@@ -208,12 +208,12 @@ static inline void swap_buf_16(unsigned char *buf, int len, void *end)
 }
 
 /**
- *	swap_buf_32
- *	@buf: our buffer
- *	@len : number of bytes (not words) in the buffer
- *	@end: end of buffer
+ * swap_buf_32()
+ * @buf: our buffer
+ * @len: number of bytes (not words) in the buffer
+ * @end: end of buffer
  *
- *	Swap the contents of a buffer into big endian format
+ * Swap the contents of a buffer into big endian format
  */
 static inline void swap_buf_32(unsigned char *buf, int len, void *end)
 {
@@ -234,13 +234,13 @@ static inline void swap_buf_32(unsigned char *buf, int len, void *end)
 }
 
 /**
- *	mrdy_assert		-	assert MRDY line
- *	@ifx_dev: our SPI device
+ * mrdy_assert() - assert MRDY line
+ * @ifx_dev: our SPI device
  *
- *	Assert mrdy and set timer to wait for SRDY interrupt, if SRDY is low
- *	now.
+ * Assert mrdy and set timer to wait for SRDY interrupt, if SRDY is low
+ * now.
  *
- *	FIXME: Can SRDY even go high as we are running this code ?
+ * FIXME: Can SRDY even go high as we are running this code ?
  */
 static void mrdy_assert(struct ifx_spi_device *ifx_dev)
 {
@@ -257,11 +257,11 @@ static void mrdy_assert(struct ifx_spi_device *ifx_dev)
 }
 
 /**
- *	ifx_spi_timeout		-	SPI timeout
- *	@arg: our SPI device
+ * ifx_spi_timeout() - SPI timeout
+ * @arg: our SPI device
  *
- *	The SPI has timed out: hang up the tty. Users will then see a hangup
- *	and error events.
+ * The SPI has timed out: hang up the tty. Users will then see a hangup
+ * and error events.
  */
 static void ifx_spi_timeout(struct timer_list *t)
 {
@@ -276,12 +276,12 @@ static void ifx_spi_timeout(struct timer_list *t)
 /* char/tty operations */
 
 /**
- *	ifx_spi_tiocmget	-	get modem lines
- *	@tty: our tty device
- *	@filp: file handle issuing the request
+ * ifx_spi_tiocmget() - get modem lines
+ * @tty: our tty device
+ * @filp: file handle issuing the request
  *
- *	Map the signal state into Linux modem flags and report the value
- *	in Linux terms
+ * Map the signal state into Linux modem flags and report the value
+ * in Linux terms
  */
 static int ifx_spi_tiocmget(struct tty_struct *tty)
 {
@@ -299,15 +299,15 @@ static int ifx_spi_tiocmget(struct tty_struct *tty)
 }
 
 /**
- *	ifx_spi_tiocmset	-	set modem bits
- *	@tty: the tty structure
- *	@set: bits to set
- *	@clear: bits to clear
+ * ifx_spi_tiocmset() - set modem bits
+ * @tty: the tty structure
+ * @set: bits to set
+ * @clear: bits to clear
  *
- *	The IFX6x60 only supports DTR and RTS. Set them accordingly
- *	and flag that an update to the modem is needed.
+ * The IFX6x60 only supports DTR and RTS. Set them accordingly
+ * and flag that an update to the modem is needed.
  *
- *	FIXME: do we need to kick the tranfers when we do this ?
+ * FIXME: do we need to kick the tranfers when we do this ?
  */
 static int ifx_spi_tiocmset(struct tty_struct *tty,
 			    unsigned int set, unsigned int clear)
@@ -328,14 +328,14 @@ static int ifx_spi_tiocmset(struct tty_struct *tty,
 }
 
 /**
- *	ifx_spi_open	-	called on tty open
- *	@tty: our tty device
- *	@filp: file handle being associated with the tty
+ * ifx_spi_open() - called on tty open
+ * @tty: our tty device
+ * @filp: file handle being associated with the tty
  *
- *	Open the tty interface. We let the tty_port layer do all the work
- *	for us.
+ * Open the tty interface. We let the tty_port layer do all the work
+ * for us.
  *
- *	FIXME: Remove single device assumption and saved_ifx_dev
+ * FIXME: Remove single device assumption and saved_ifx_dev
  */
 static int ifx_spi_open(struct tty_struct *tty, struct file *filp)
 {
@@ -343,12 +343,12 @@ static int ifx_spi_open(struct tty_struct *tty, struct file *filp)
 }
 
 /**
- *	ifx_spi_close	-	called when our tty closes
- *	@tty: the tty being closed
- *	@filp: the file handle being closed
+ * ifx_spi_close() - called when our tty closes
+ * @tty: the tty being closed
+ * @filp: the file handle being closed
  *
- *	Perform the close of the tty. We use the tty_port layer to do all
- *	our hard work.
+ * Perform the close of the tty. We use the tty_port layer to do all
+ * our hard work.
  */
 static void ifx_spi_close(struct tty_struct *tty, struct file *filp)
 {
@@ -358,17 +358,17 @@ static void ifx_spi_close(struct tty_struct *tty, struct file *filp)
 }
 
 /**
- *	ifx_decode_spi_header	-	decode received header
- *	@buffer: the received data
- *	@length: decoded length
- *	@more: decoded more flag
- *	@received_cts: status of cts we received
+ * ifx_decode_spi_header() - decode received header
+ * @buffer: the received data
+ * @length: decoded length
+ * @more: decoded more flag
+ * @received_cts: status of cts we received
  *
- *	Note how received_cts is handled -- if header is all F it is left
- *	the same as it was, if header is all 0 it is set to 0 otherwise it is
- *	taken from the incoming header.
+ * Note how received_cts is handled -- if header is all F it is left
+ * the same as it was, if header is all 0 it is set to 0 otherwise it is
+ * taken from the incoming header.
  *
- *	FIXME: endianness
+ * FIXME: endianness
  */
 static int ifx_spi_decode_spi_header(unsigned char *buffer, int *length,
 			unsigned char *more, unsigned char *received_cts)
@@ -397,14 +397,14 @@ static int ifx_spi_decode_spi_header(unsigned char *buffer, int *length,
 }
 
 /**
- *	ifx_setup_spi_header	-	set header fields
- *	@txbuffer: pointer to start of SPI buffer
- *	@tx_count: bytes
- *	@more: indicate if more to follow
+ * ifx_setup_spi_header() - set header fields
+ * @txbuffer: pointer to start of SPI buffer
+ * @tx_count: bytes
+ * @more: indicate if more to follow
  *
- *	Format up an SPI header for a transfer
+ * Format up an SPI header for a transfer
  *
- *	FIXME: endianness?
+ * FIXME: endianness?
  */
 static void ifx_spi_setup_spi_header(unsigned char *txbuffer, int tx_count,
 					unsigned char more)
@@ -415,16 +415,16 @@ static void ifx_spi_setup_spi_header(unsigned char *txbuffer, int tx_count,
 }
 
 /**
- *	ifx_spi_prepare_tx_buffer	-	prepare transmit frame
- *	@ifx_dev: our SPI device
+ * ifx_spi_prepare_tx_buffer() - prepare transmit frame
+ * @ifx_dev: our SPI device
  *
- *	The transmit buffr needs a header and various other bits of
- *	information followed by as much data as we can pull from the FIFO
- *	and transfer. This function formats up a suitable buffer in the
- *	ifx_dev->tx_buffer
+ * The transmit buffr needs a header and various other bits of
+ * information followed by as much data as we can pull from the FIFO
+ * and transfer. This function formats up a suitable buffer in the
+ * ifx_dev->tx_buffer
  *
- *	FIXME: performance - should we wake the tty when the queue is half
- *			     empty ?
+ * FIXME: performance() - should we wake the tty when the queue is half
+ *        empty ?
  */
 static int ifx_spi_prepare_tx_buffer(struct ifx_spi_device *ifx_dev)
 {
@@ -476,14 +476,14 @@ static int ifx_spi_prepare_tx_buffer(struct ifx_spi_device *ifx_dev)
 }
 
 /**
- *	ifx_spi_write		-	line discipline write
- *	@tty: our tty device
- *	@buf: pointer to buffer to write (kernel space)
- *	@count: size of buffer
+ * ifx_spi_write() - line discipline write
+ * @tty: our tty device
+ * @buf: pointer to buffer to write (kernel space)
+ * @count: size of buffer
  *
- *	Write the characters we have been given into the FIFO. If the device
- *	is not active then activate it, when the SRDY line is asserted back
- *	this will commence I/O
+ * Write the characters we have been given into the FIFO. If the device
+ * is not active then activate it, when the SRDY line is asserted back
+ * this will commence I/O
  */
 static int ifx_spi_write(struct tty_struct *tty, const unsigned char *buf,
 			 int count)
@@ -505,11 +505,11 @@ static int ifx_spi_write(struct tty_struct *tty, const unsigned char *buf,
 }
 
 /**
- *	ifx_spi_chars_in_buffer	-	line discipline helper
- *	@tty: our tty device
+ * ifx_spi_write_room() - line discipline helper
+ * @tty: our tty device
  *
- *	Report how much data we can accept before we drop bytes. As we use
- *	a simple FIFO this is nice and easy.
+ * Report how much data we can accept before we drop bytes. As we use
+ * a simple FIFO this is nice and easy.
  */
 static int ifx_spi_write_room(struct tty_struct *tty)
 {
@@ -518,11 +518,11 @@ static int ifx_spi_write_room(struct tty_struct *tty)
 }
 
 /**
- *	ifx_spi_chars_in_buffer	-	line discipline helper
- *	@tty: our tty device
+ * ifx_spi_chars_in_buffer() - line discipline helper
+ * @tty: our tty device
  *
- *	Report how many characters we have buffered. In our case this is the
- *	number of bytes sitting in our transmit FIFO.
+ * Report how many characters we have buffered. In our case this is the
+ * number of bytes sitting in our transmit FIFO.
  */
 static int ifx_spi_chars_in_buffer(struct tty_struct *tty)
 {
@@ -531,12 +531,12 @@ static int ifx_spi_chars_in_buffer(struct tty_struct *tty)
 }
 
 /**
- *	ifx_port_hangup
- *	@port: our tty port
+ * ifx_port_hangup()
+ * @port: our tty port
  *
- *	tty port hang up. Called when tty_hangup processing is invoked either
- *	by loss of carrier, or by software (eg vhangup). Serialized against
- *	activate/shutdown by the tty layer.
+ * tty port hang up. Called when tty_hangup processing is invoked either
+ * by loss of carrier, or by software (eg vhangup). Serialized against
+ * activate/shutdown by the tty layer.
  */
 static void ifx_spi_hangup(struct tty_struct *tty)
 {
@@ -545,11 +545,11 @@ static void ifx_spi_hangup(struct tty_struct *tty)
 }
 
 /**
- *	ifx_port_activate
- *	@port: our tty port
+ * ifx_port_activate()
+ * @port: our tty port
  *
- *	tty port activate method - called for first open. Serialized
- *	with hangup and shutdown by the tty layer.
+ * tty port activate method - called for first open. Serialized
+ * with hangup and shutdown by the tty layer.
  */
 static int ifx_port_activate(struct tty_port *port, struct tty_struct *tty)
 {
@@ -576,11 +576,11 @@ static int ifx_port_activate(struct tty_port *port, struct tty_struct *tty)
 }
 
 /**
- *	ifx_port_shutdown
- *	@port: our tty port
+ * ifx_port_shutdown()
+ * @port: our tty port
  *
- *	tty port shutdown method - called for last port close. Serialized
- *	with hangup and activate by the tty layer.
+ * tty port shutdown method - called for last port close. Serialized
+ * with hangup and activate by the tty layer.
  */
 static void ifx_port_shutdown(struct tty_port *port)
 {
@@ -611,13 +611,13 @@ static const struct tty_operations ifx_spi_serial_ops = {
 };
 
 /**
- *	ifx_spi_insert_fip_string	-	queue received data
- *	@ifx_ser: our SPI device
- *	@chars: buffer we have received
- *	@size: number of chars reeived
+ * ifx_spi_insert_fip_string() - queue received data
+ * @ifx_ser: our SPI device
+ * @chars: buffer we have received
+ * @size: number of chars reeived
  *
- *	Queue bytes to the tty assuming the tty side is currently open. If
- *	not the discard the data.
+ * Queue bytes to the tty assuming the tty side is currently open. If
+ * not the discard the data.
  */
 static void ifx_spi_insert_flip_string(struct ifx_spi_device *ifx_dev,
 				    unsigned char *chars, size_t size)
@@ -627,11 +627,11 @@ static void ifx_spi_insert_flip_string(struct ifx_spi_device *ifx_dev,
 }
 
 /**
- *	ifx_spi_complete	-	SPI transfer completed
- *	@ctx: our SPI device
+ * ifx_spi_complete() - SPI transfer completed
+ * @ctx: our SPI device
  *
- *	An SPI transfer has completed. Process any received data and kick off
- *	any further transmits we can commence.
+ * An SPI transfer has completed. Process any received data and kick off
+ * any further transmits we can commence.
  */
 static void ifx_spi_complete(void *ctx)
 {
@@ -720,11 +720,11 @@ static void ifx_spi_complete(void *ctx)
 }
 
 /**
- *	ifx_spio_io		-	I/O tasklet
- *	@data: our SPI device
+ * ifx_spio_io() - I/O tasklet
+ * @data: our SPI device
  *
- *	Queue data for transmission if possible and then kick off the
- *	transfer.
+ * Queue data for transmission if possible and then kick off the
+ * transfer.
  */
 static void ifx_spi_io(unsigned long data)
 {
@@ -792,10 +792,10 @@ static void ifx_spi_io(unsigned long data)
 }
 
 /**
- *	ifx_spi_free_port	-	free up the tty side
- *	@ifx_dev: IFX device going away
+ * ifx_spi_free_port() - free up the tty side
+ * @ifx_dev: IFX device going away
  *
- *	Unregister and free up a port when the device goes away
+ * Unregister and free up a port when the device goes away
  */
 static void ifx_spi_free_port(struct ifx_spi_device *ifx_dev)
 {
@@ -806,11 +806,11 @@ static void ifx_spi_free_port(struct ifx_spi_device *ifx_dev)
 }
 
 /**
- *	ifx_spi_create_port	-	create a new port
- *	@ifx_dev: our spi device
+ * ifx_spi_create_port() - create a new port
+ * @ifx_dev: our spi device
  *
- *	Allocate and initialise the tty port that goes with this interface
- *	and add it to the tty layer so that it can be opened.
+ * Allocate and initialise the tty port that goes with this interface
+ * and add it to the tty layer so that it can be opened.
  */
 static int ifx_spi_create_port(struct ifx_spi_device *ifx_dev)
 {
@@ -847,12 +847,12 @@ static int ifx_spi_create_port(struct ifx_spi_device *ifx_dev)
 }
 
 /**
- *	ifx_spi_handle_srdy		-	handle SRDY
- *	@ifx_dev: device asserting SRDY
+ * ifx_spi_handle_srdy() - handle SRDY
+ * @ifx_dev: device asserting SRDY
  *
- *	Check our device state and see what we need to kick off when SRDY
- *	is asserted. This usually means killing the timer and firing off the
- *	I/O processing.
+ * Check our device state and see what we need to kick off when SRDY
+ * is asserted. This usually means killing the timer and firing off the
+ * I/O processing.
  */
 static void ifx_spi_handle_srdy(struct ifx_spi_device *ifx_dev)
 {
@@ -870,11 +870,11 @@ static void ifx_spi_handle_srdy(struct ifx_spi_device *ifx_dev)
 }
 
 /**
- *	ifx_spi_srdy_interrupt	-	SRDY asserted
- *	@irq: our IRQ number
- *	@dev: our ifx device
+ * ifx_spi_srdy_interrupt() - SRDY asserted
+ * @irq: our IRQ number
+ * @dev: our ifx device
  *
- *	The modem asserted SRDY. Handle the srdy event
+ * The modem asserted SRDY. Handle the srdy event
  */
 static irqreturn_t ifx_spi_srdy_interrupt(int irq, void *dev)
 {
@@ -885,15 +885,15 @@ static irqreturn_t ifx_spi_srdy_interrupt(int irq, void *dev)
 }
 
 /**
- *	ifx_spi_reset_interrupt	-	Modem has changed reset state
- *	@irq: interrupt number
- *	@dev: our device pointer
+ * ifx_spi_reset_interrupt() - Modem has changed reset state
+ * @irq: interrupt number
+ * @dev: our device pointer
  *
- *	The modem has either entered or left reset state. Check the GPIO
- *	line to see which.
+ * The modem has either entered or left reset state. Check the GPIO
+ * line to see which.
  *
- *	FIXME: review locking on MR_INPROGRESS versus
- *	parallel unsolicited reset/solicited reset
+ * FIXME: review locking on MR_INPROGRESS versus
+ * parallel unsolicited reset/solicited reset
  */
 static irqreturn_t ifx_spi_reset_interrupt(int irq, void *dev)
 {
@@ -920,10 +920,10 @@ static irqreturn_t ifx_spi_reset_interrupt(int irq, void *dev)
 }
 
 /**
- *	ifx_spi_free_device - free device
- *	@ifx_dev: device to free
+ * ifx_spi_free_device() - free device
+ * @ifx_dev: device to free
  *
- *	Free the IFX device
+ * Free the IFX device
  */
 static void ifx_spi_free_device(struct ifx_spi_device *ifx_dev)
 {
@@ -939,10 +939,10 @@ static void ifx_spi_free_device(struct ifx_spi_device *ifx_dev)
 }
 
 /**
- *	ifx_spi_reset	-	reset modem
- *	@ifx_dev: modem to reset
+ * ifx_spi_reset() - reset modem
+ * @ifx_dev: modem to reset
  *
- *	Perform a reset on the modem
+ * Perform a reset on the modem
  */
 static int ifx_spi_reset(struct ifx_spi_device *ifx_dev)
 {
@@ -975,15 +975,15 @@ static int ifx_spi_reset(struct ifx_spi_device *ifx_dev)
 }
 
 /**
- *	ifx_spi_spi_probe	-	probe callback
- *	@spi: our possible matching SPI device
+ * ifx_spi_spi_probe() - probe callback
+ * @spi: our possible matching SPI device
  *
- *	Probe for a 6x60 modem on SPI bus. Perform any needed device and
- *	GPIO setup.
+ * Probe for a 6x60 modem on SPI bus. Perform any needed device and
+ * GPIO setup.
  *
- *	FIXME:
- *	-	Support for multiple devices
- *	-	Split out MID specific GPIO handling eventually
+ * FIXME:
+ * -	Support for multiple devices
+ * -	Split out MID specific GPIO handling eventually
  */
 
 static int ifx_spi_spi_probe(struct spi_device *spi)
@@ -1218,11 +1218,11 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 }
 
 /**
- *	ifx_spi_spi_remove	-	SPI device was removed
- *	@spi: SPI device
+ * ifx_spi_spi_remove() - SPI device was removed
+ * @spi: SPI device
  *
- *	FIXME: We should be shutting the device down here not in
- *	the module unload path.
+ * FIXME: We should be shutting the device down here not in
+ * the module unload path.
  */
 
 static int ifx_spi_spi_remove(struct spi_device *spi)
@@ -1248,10 +1248,10 @@ static int ifx_spi_spi_remove(struct spi_device *spi)
 }
 
 /**
- *	ifx_spi_spi_shutdown	-	called on SPI shutdown
- *	@spi: SPI device
+ * ifx_spi_spi_shutdown() - called on SPI shutdown
+ * @spi: SPI device
  *
- *	No action needs to be taken here
+ * No action needs to be taken here
  */
 
 static void ifx_spi_spi_shutdown(struct spi_device *spi)
@@ -1267,11 +1267,11 @@ static void ifx_spi_spi_shutdown(struct spi_device *spi)
  */
 
 /**
- *	ifx_spi_pm_suspend	-	suspend modem on system suspend
- *	@dev: device being suspended
+ * ifx_spi_pm_suspend() - suspend modem on system suspend
+ * @dev: device being suspended
  *
- *	Suspend the modem. No action needed on Intel MID platforms, may
- *	need extending for other systems.
+ * Suspend the modem. No action needed on Intel MID platforms, may
+ * need extending for other systems.
  */
 static int ifx_spi_pm_suspend(struct device *dev)
 {
@@ -1279,12 +1279,12 @@ static int ifx_spi_pm_suspend(struct device *dev)
 }
 
 /**
- *	ifx_spi_pm_resume	-	resume modem on system resume
- *	@dev: device being suspended
+ * ifx_spi_pm_resume() - resume modem on system resume
+ * @dev: device being resumed
  *
- *	Allow the modem to resume. No action needed.
+ * Allow the modem to resume. No action needed.
  *
- *	FIXME: do we need to reset anything here ?
+ * FIXME: do we need to reset anything here ?
  */
 static int ifx_spi_pm_resume(struct device *dev)
 {
@@ -1292,10 +1292,10 @@ static int ifx_spi_pm_resume(struct device *dev)
 }
 
 /**
- *	ifx_spi_pm_runtime_resume	-	suspend modem
- *	@dev: device being suspended
+ * ifx_spi_pm_runtime_resume() - suspend modem
+ * @dev: device being resumed
  *
- *	Allow the modem to resume. No action needed.
+ * Allow the modem to resume. No action needed.
  */
 static int ifx_spi_pm_runtime_resume(struct device *dev)
 {
@@ -1303,11 +1303,11 @@ static int ifx_spi_pm_runtime_resume(struct device *dev)
 }
 
 /**
- *	ifx_spi_pm_runtime_suspend	-	suspend modem
- *	@dev: device being suspended
+ * ifx_spi_pm_runtime_suspend() - suspend modem
+ * @dev: device being suspended
  *
- *	Allow the modem to suspend and thus suspend to continue up the
- *	device tree.
+ * Allow the modem to suspend and thus suspend to continue up the
+ * device tree.
  */
 static int ifx_spi_pm_runtime_suspend(struct device *dev)
 {
@@ -1315,10 +1315,10 @@ static int ifx_spi_pm_runtime_suspend(struct device *dev)
 }
 
 /**
- *	ifx_spi_pm_runtime_idle		-	check if modem idle
- *	@dev: our device
+ * ifx_spi_pm_runtime_idle() - check if modem idle
+ * @dev: our device
  *
- *	Check conditions and queue runtime suspend if idle.
+ * Check conditions and queue runtime suspend if idle.
  */
 static int ifx_spi_pm_runtime_idle(struct device *dev)
 {
@@ -1359,9 +1359,9 @@ static struct spi_driver ifx_spi_driver = {
 };
 
 /**
- *	ifx_spi_exit	-	module exit
+ * ifx_spi_exit() - module exit
  *
- *	Unload the module.
+ * Unload the module.
  */
 
 static void __exit ifx_spi_exit(void)
@@ -1374,11 +1374,11 @@ static void __exit ifx_spi_exit(void)
 }
 
 /**
- *	ifx_spi_init		-	module entry point
+ * ifx_spi_init() - module entry point
  *
- *	Initialise the SPI and tty interfaces for the IFX SPI driver
- *	We need to initialize upper-edge spi driver after the tty
- *	driver because otherwise the spi probe will race
+ * Initialise the SPI and tty interfaces for the IFX SPI driver
+ * We need to initialize upper-edge spi driver after the tty
+ * driver because otherwise the spi probe will race
  */
 
 static int __init ifx_spi_init(void)
diff --git a/drivers/tty/serial/ioc3_serial.c b/drivers/tty/serial/ioc3_serial.c
index d8a1cdd6a53d..f0f76ea6f8ea 100644
--- a/drivers/tty/serial/ioc3_serial.c
+++ b/drivers/tty/serial/ioc3_serial.c
@@ -298,7 +298,7 @@ struct ring_buffer {
 
 
 /**
- * set_baud - Baud rate setting code
+ * set_baud() - Baud rate setting code
  * @port: port to set
  * @baud: baud rate to use
  */
@@ -346,7 +346,7 @@ static int set_baud(struct ioc3_port *port, int baud)
 }
 
 /**
- * get_ioc3_port - given a uart port, return the control structure
+ * get_ioc3_port() - given a uart port, return the control structure
  * @the_port: uart port to find
  */
 static struct ioc3_port *get_ioc3_port(struct uart_port *the_port)
@@ -370,7 +370,7 @@ static struct ioc3_port *get_ioc3_port(struct uart_port *the_port)
 }
 
 /**
- * port_init - Initialize the sio and ioc3 hardware for a given port
+ * port_init() - Initialize the sio and ioc3 hardware for a given port
  *			called per port from attach...
  * @port: port to initialize
  */
@@ -474,7 +474,7 @@ static inline int port_init(struct ioc3_port *port)
 }
 
 /**
- * enable_intrs - enable interrupts
+ * enable_intrs() - enable interrupts
  * @port: port to enable
  * @mask: mask to use
  */
@@ -487,7 +487,7 @@ static void enable_intrs(struct ioc3_port *port, uint32_t mask)
 }
 
 /**
- * local_open - local open a port
+ * local_open() - local open a port
  * @port: port to open
  */
 static inline int local_open(struct ioc3_port *port)
@@ -536,7 +536,7 @@ static inline int local_open(struct ioc3_port *port)
 }
 
 /**
- * set_rx_timeout - Set rx timeout and threshold values.
+ * set_rx_timeout() - Set rx timeout and threshold values.
  * @port: port to use
  * @timeout: timeout value in ticks
  */
@@ -575,7 +575,7 @@ static inline int set_rx_timeout(struct ioc3_port *port, int timeout)
 }
 
 /**
- * config_port - config the hardware
+ * config_port() - config the hardware
  * @port: port to config
  * @baud: baud rate for the port
  * @byte_size: data size
@@ -667,7 +667,7 @@ config_port(struct ioc3_port *port,
 }
 
 /**
- * do_write - Write bytes to the port.  Returns the number of bytes
+ * do_write() - Write bytes to the port.  Returns the number of bytes
  *			actually written. Called from transmit_chars
  * @port: port to use
  * @buf: the stuff to write
@@ -752,7 +752,7 @@ static inline int do_write(struct ioc3_port *port, char *buf, int len)
 }
 
 /**
- * disable_intrs - disable interrupts
+ * disable_intrs() - disable interrupts
  * @port: port to enable
  * @mask: mask to use
  */
@@ -765,7 +765,7 @@ static inline void disable_intrs(struct ioc3_port *port, uint32_t mask)
 }
 
 /**
- * set_notification - Modify event notification
+ * set_notification() - Modify event notification
  * @port: port to use
  * @mask: events mask
  * @set_on: set ?
@@ -814,7 +814,7 @@ static int set_notification(struct ioc3_port *port, int mask, int set_on)
 }
 
 /**
- * set_mcr - set the master control reg
+ * set_mcr() - set the master control reg
  * @the_port: port to use
  * @mask1: mcr mask
  * @mask2: shadow mask
@@ -858,7 +858,7 @@ static inline int set_mcr(struct uart_port *the_port,
 }
 
 /**
- * ioc3_set_proto - set the protocol for the port
+ * ioc3_set_proto() - set the protocol for the port
  * @port: port to use
  * @proto: protocol to use
  */
@@ -886,7 +886,7 @@ static int ioc3_set_proto(struct ioc3_port *port, int proto)
 }
 
 /**
- * transmit_chars - upper level write, called with the_port->lock
+ * transmit_chars() - upper level write, called with the_port->lock
  * @the_port: port to write
  */
 static void transmit_chars(struct uart_port *the_port)
@@ -942,7 +942,7 @@ static void transmit_chars(struct uart_port *the_port)
 }
 
 /**
- * ioc3_change_speed - change the speed of the port
+ * ioc3_change_speed() - change the speed of the port
  * @the_port: port to change
  * @new_termios: new termios settings
  * @old_termios: old termios settings
@@ -1040,7 +1040,7 @@ ioc3_change_speed(struct uart_port *the_port,
 }
 
 /**
- * ic3_startup_local - Start up the serial port - returns >= 0 if no errors
+ * ic3_startup_local() - Start up the serial port - returns >= 0 if no errors
  * @the_port: Port to operate on
  */
 static inline int ic3_startup_local(struct uart_port *the_port)
@@ -1104,7 +1104,7 @@ static void ioc3_cb_post_ncs(struct uart_port *the_port, int ncs)
 }
 
 /**
- * do_read - Read in bytes from the port.  Return the number of bytes
+ * do_read() - Read in bytes from the port.  Return the number of bytes
  *			actually read.
  * @the_port: port to use
  * @buf: place to put the stuff we read
@@ -1385,7 +1385,7 @@ static inline int do_read(struct uart_port *the_port, char *buf, int len)
 }
 
 /**
- * receive_chars - upper level read.
+ * receive_chars() - upper level read.
  * @the_port: port to read from
  */
 static int receive_chars(struct uart_port *the_port)
@@ -1421,7 +1421,7 @@ static int receive_chars(struct uart_port *the_port)
 }
 
 /**
- * ioc3uart_intr_one - lowest level (per port) interrupt handler.
+ * ioc3uart_intr_one() - lowest level (per port) interrupt handler.
  * @is : submodule
  * @idd: driver data
  * @pending: interrupts to handle
@@ -1620,7 +1620,7 @@ ioc3uart_intr_one(struct ioc3_submodule *is,
 }
 
 /**
- * ioc3uart_intr - field all serial interrupts
+ * ioc3uart_intr() - field all serial interrupts
  * @is : submodule
  * @idd: driver data
  * @pending: interrupts to handle
@@ -1660,7 +1660,7 @@ static const char *ic3_type(struct uart_port *the_port)
 }
 
 /**
- * ic3_tx_empty - Is the transmitter empty?
+ * ic3_tx_empty() - Is the transmitter empty?
  * @port: Port to operate on
  *
  */
@@ -1675,7 +1675,7 @@ static unsigned int ic3_tx_empty(struct uart_port *the_port)
 }
 
 /**
- * ic3_stop_tx - stop the transmitter
+ * ic3_stop_tx() - stop the transmitter
  * @port: Port to operate on
  *
  */
@@ -1688,7 +1688,7 @@ static void ic3_stop_tx(struct uart_port *the_port)
 }
 
 /**
- * ic3_stop_rx - stop the receiver
+ * ic3_stop_rx() - stop the receiver
  * @port: Port to operate on
  *
  */
@@ -1710,7 +1710,7 @@ static void null_void_function(struct uart_port *the_port)
 }
 
 /**
- * ic3_shutdown - shut down the port - free irq and disable
+ * ic3_shutdown() - shut down the port - free irq and disable
  * @port: port to shut down
  *
  */
@@ -1733,7 +1733,7 @@ static void ic3_shutdown(struct uart_port *the_port)
 }
 
 /**
- * ic3_set_mctrl - set control lines (dtr, rts, etc)
+ * ic3_set_mctrl() - set control lines (dtr, rts, etc)
  * @port: Port to operate on
  * @mctrl: Lines to set/unset
  *
@@ -1757,7 +1757,7 @@ static void ic3_set_mctrl(struct uart_port *the_port, unsigned int mctrl)
 }
 
 /**
- * ic3_get_mctrl - get control line info
+ * ic3_get_mctrl() - get control line info
  * @port: port to operate on
  *
  */
@@ -1781,7 +1781,7 @@ static unsigned int ic3_get_mctrl(struct uart_port *the_port)
 }
 
 /**
- * ic3_start_tx - Start transmitter. Called with the_port->lock
+ * ic3_start_tx() - Start transmitter. Called with the_port->lock
  * @port: Port to operate on
  *
  */
@@ -1796,7 +1796,7 @@ static void ic3_start_tx(struct uart_port *the_port)
 }
 
 /**
- * ic3_break_ctl - handle breaks
+ * ic3_break_ctl() - handle breaks
  * @port: Port to operate on
  * @break_state: Break state
  *
@@ -1806,7 +1806,7 @@ static void ic3_break_ctl(struct uart_port *the_port, int break_state)
 }
 
 /**
- * ic3_startup - Start up the serial port - always return 0 (We're always on)
+ * ic3_startup() - Start up the serial port - always return 0 (We're always on)
  * @port: Port to operate on
  *
  */
@@ -1842,7 +1842,7 @@ static int ic3_startup(struct uart_port *the_port)
 }
 
 /**
- * ic3_set_termios - set termios stuff
+ * ic3_set_termios() - set termios stuff
  * @port: port to operate on
  * @termios: New settings
  * @termios: Old
@@ -1860,7 +1860,7 @@ ic3_set_termios(struct uart_port *the_port,
 }
 
 /**
- * ic3_request_port - allocate resources for port - no op....
+ * ic3_request_port() - allocate resources for port - no op....
  * @port: port to operate on
  *
  */
@@ -1900,7 +1900,7 @@ static struct uart_driver ioc3_uart = {
 };
 
 /**
- * ioc3_serial_core_attach - register with serial core
+ * ioc3_serial_core_attach() - register with serial core
  *		This is done during pci probing
  * @is: submodule struct for this
  * @idd: handle for this card
@@ -1960,7 +1960,7 @@ static inline int ioc3_serial_core_attach( struct ioc3_submodule *is,
 }
 
 /**
- * ioc3uart_remove - register detach function
+ * ioc3uart_remove() - register detach function
  * @is: submodule struct for this submodule
  * @idd: ioc3 driver data for this submodule
  */
@@ -1998,7 +1998,7 @@ static int ioc3uart_remove(struct ioc3_submodule *is,
 }
 
 /**
- * ioc3uart_probe - card probe function called from shim driver
+ * ioc3uart_probe() - card probe function called from shim driver
  * @is: submodule struct for this submodule
  * @idd: ioc3 driver data for this card
  */
@@ -2162,7 +2162,7 @@ static struct ioc3_submodule ioc3uart_ops = {
 };
 
 /**
- * ioc3_detect - module init called,
+ * ioc3_detect() - module init called
  */
 static int __init ioc3uart_init(void)
 {
diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index db5b979e5a0c..804002fae0ee 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -651,7 +651,7 @@ static inline int port_is_active(struct ioc4_port *port,
 
 
 /**
- * write_ireg - write the interrupt regs
+ * write_ireg() - write the interrupt regs
  * @ioc4_soft: ptr to soft struct for this port
  * @val: value to write
  * @which: which register
@@ -697,7 +697,7 @@ write_ireg(struct ioc4_soft *ioc4_soft, uint32_t val, int which, int type)
 }
 
 /**
- * set_baud - Baud rate setting code
+ * set_baud() - Baud rate setting code
  * @port: port to set
  * @baud: baud rate to use
  */
@@ -733,7 +733,7 @@ static int set_baud(struct ioc4_port *port, int baud)
 
 
 /**
- * get_ioc4_port - given a uart port, return the control structure
+ * get_ioc4_port() - given a uart port, return the control structure
  * @port: uart port
  * @set: set this port as current
  */
@@ -817,7 +817,7 @@ pending_intrs(struct ioc4_soft *soft, int type)
 }
 
 /**
- * port_init - Initialize the sio and ioc4 hardware for a given port
+ * port_init() - Initialize the sio and ioc4 hardware for a given port
  *			called per port from attach...
  * @port: port to initialize
  */
@@ -910,7 +910,7 @@ static inline int port_init(struct ioc4_port *port)
 }
 
 /**
- * handle_dma_error_intr - service any pending DMA error interrupts for the
+ * handle_dma_error_intr() - service any pending DMA error interrupts for the
  *			given port - 2nd level called via sd_intr
  * @arg: handler arg
  * @other_ir: ioc4regs
@@ -954,7 +954,7 @@ static void handle_dma_error_intr(void *arg, uint32_t other_ir)
 }
 
 /**
- * intr_connect - interrupt connect function
+ * intr_connect() - interrupt connect function
  * @soft: soft struct for this card
  * @type: interrupt type
  * @intrbits: bit pattern to set
@@ -982,7 +982,7 @@ intr_connect(struct ioc4_soft *soft, int type,
 }
 
 /**
- * ioc4_intr - Top level IOC4 interrupt handler.
+ * ioc4_intr() - Top level IOC4 interrupt handler.
  * @irq: irq value
  * @arg: handler arg
  */
@@ -1040,9 +1040,9 @@ static irqreturn_t ioc4_intr(int irq, void *arg)
 }
 
 /**
- * ioc4_attach_local - Device initialization.
- *			Called at *_attach() time for each
- *			IOC4 with serial ports in the system.
+ * ioc4_attach_local() - Device initialization.
+ *                       Called at *_attach() time for each
+ *                       IOC4 with serial ports in the system.
  * @idd: Master module data for this IOC4
  */
 static inline int ioc4_attach_local(struct ioc4_driver_data *idd)
@@ -1195,7 +1195,7 @@ static inline int ioc4_attach_local(struct ioc4_driver_data *idd)
 }
 
 /**
- * enable_intrs - enable interrupts
+ * enable_intrs() - enable interrupts
  * @port: port to enable
  * @mask: mask to use
  */
@@ -1215,7 +1215,7 @@ static void enable_intrs(struct ioc4_port *port, uint32_t mask)
 }
 
 /**
- * local_open - local open a port
+ * local_open() - local open a port
  * @port: port to open
  */
 static inline int local_open(struct ioc4_port *port)
@@ -1264,7 +1264,7 @@ static inline int local_open(struct ioc4_port *port)
 }
 
 /**
- * set_rx_timeout - Set rx timeout and threshold values.
+ * set_rx_timeout() - Set rx timeout and threshold values.
  * @port: port to use
  * @timeout: timeout value in ticks
  */
@@ -1305,7 +1305,7 @@ static inline int set_rx_timeout(struct ioc4_port *port, int timeout)
 }
 
 /**
- * config_port - config the hardware
+ * config_port() - config the hardware
  * @port: port to config
  * @baud: baud rate for the port
  * @byte_size: data size
@@ -1396,7 +1396,7 @@ config_port(struct ioc4_port *port,
 }
 
 /**
- * do_write - Write bytes to the port.  Returns the number of bytes
+ * do_write() - Write bytes to the port.  Returns the number of bytes
  *			actually written. Called from transmit_chars
  * @port: port to use
  * @buf: the stuff to write
@@ -1481,7 +1481,7 @@ static inline int do_write(struct ioc4_port *port, char *buf, int len)
 }
 
 /**
- * disable_intrs - disable interrupts
+ * disable_intrs() - disable interrupts
  * @port: port to enable
  * @mask: mask to use
  */
@@ -1501,7 +1501,7 @@ static void disable_intrs(struct ioc4_port *port, uint32_t mask)
 }
 
 /**
- * set_notification - Modify event notification
+ * set_notification() - Modify event notification
  * @port: port to use
  * @mask: events mask
  * @set_on: set ?
@@ -1550,7 +1550,7 @@ static int set_notification(struct ioc4_port *port, int mask, int set_on)
 }
 
 /**
- * set_mcr - set the master control reg
+ * set_mcr() - set the master control reg
  * @the_port: port to use
  * @mask1: mcr mask
  * @mask2: shadow mask
@@ -1595,7 +1595,7 @@ static inline int set_mcr(struct uart_port *the_port,
 }
 
 /**
- * ioc4_set_proto - set the protocol for the port
+ * ioc4_set_proto() - set the protocol for the port
  * @port: port to use
  * @proto: protocol to use
  */
@@ -1621,7 +1621,7 @@ static int ioc4_set_proto(struct ioc4_port *port, int proto)
 }
 
 /**
- * transmit_chars - upper level write, called with ip_lock
+ * transmit_chars() - upper level write, called with ip_lock
  * @the_port: port to write
  */
 static void transmit_chars(struct uart_port *the_port)
@@ -1677,7 +1677,7 @@ static void transmit_chars(struct uart_port *the_port)
 }
 
 /**
- * ioc4_change_speed - change the speed of the port
+ * ioc4_change_speed() - change the speed of the port
  * @the_port: port to change
  * @new_termios: new termios settings
  * @old_termios: old termios settings
@@ -1783,7 +1783,7 @@ ioc4_change_speed(struct uart_port *the_port,
 }
 
 /**
- * ic4_startup_local - Start up the serial port - returns >= 0 if no errors
+ * ic4_startup_local() - Start up the serial port - returns >= 0 if no errors
  * @the_port: Port to operate on
  */
 static inline int ic4_startup_local(struct uart_port *the_port)
@@ -1829,7 +1829,7 @@ static void ioc4_cb_output_lowat(struct uart_port *the_port)
 }
 
 /**
- * handle_intr - service any interrupts for the given port - 2nd level
+ * handle_intr() - service any interrupts for the given port - 2nd level
  *			called via sd_intr
  * @arg: handler arg
  * @sio_ir: ioc4regs
@@ -2058,7 +2058,7 @@ static void ioc4_cb_post_ncs(struct uart_port *the_port, int ncs)
 }
 
 /**
- * do_read - Read in bytes from the port.  Return the number of bytes
+ * do_read() - Read in bytes from the port.  Return the number of bytes
  *			actually read.
  * @the_port: port to use
  * @buf: place to put the stuff we read
@@ -2338,7 +2338,7 @@ static inline int do_read(struct uart_port *the_port, unsigned char *buf,
 }
 
 /**
- * receive_chars - upper level read. Called with ip_lock.
+ * receive_chars() - upper level read. Called with ip_lock.
  * @the_port: port to read from
  */
 static void receive_chars(struct uart_port *the_port)
@@ -2372,7 +2372,7 @@ static void receive_chars(struct uart_port *the_port)
 }
 
 /**
- * ic4_type - What type of console are we?
+ * ic4_type() - What type of console are we?
  * @port: Port to operate with (we ignore since we only have one port)
  *
  */
@@ -2385,7 +2385,7 @@ static const char *ic4_type(struct uart_port *the_port)
 }
 
 /**
- * ic4_tx_empty - Is the transmitter empty?
+ * ic4_tx_empty() - Is the transmitter empty?
  * @port: Port to operate on
  *
  */
@@ -2402,7 +2402,7 @@ static unsigned int ic4_tx_empty(struct uart_port *the_port)
 }
 
 /**
- * ic4_stop_tx - stop the transmitter
+ * ic4_stop_tx() - stop the transmitter
  * @port: Port to operate on
  *
  */
@@ -2415,7 +2415,7 @@ static void ic4_stop_tx(struct uart_port *the_port)
 }
 
 /**
- * null_void_function -
+ * null_void_function()
  * @port: Port to operate on
  *
  */
@@ -2424,7 +2424,7 @@ static void null_void_function(struct uart_port *the_port)
 }
 
 /**
- * ic4_shutdown - shut down the port - free irq and disable
+ * ic4_shutdown() - shut down the port - free irq and disable
  * @port: Port to shut down
  *
  */
@@ -2453,7 +2453,7 @@ static void ic4_shutdown(struct uart_port *the_port)
 }
 
 /**
- * ic4_set_mctrl - set control lines (dtr, rts, etc)
+ * ic4_set_mctrl() - set control lines (dtr, rts, etc)
  * @port: Port to operate on
  * @mctrl: Lines to set/unset
  *
@@ -2482,7 +2482,7 @@ static void ic4_set_mctrl(struct uart_port *the_port, unsigned int mctrl)
 }
 
 /**
- * ic4_get_mctrl - get control line info
+ * ic4_get_mctrl() - get control line info
  * @port: port to operate on
  *
  */
@@ -2506,7 +2506,7 @@ static unsigned int ic4_get_mctrl(struct uart_port *the_port)
 }
 
 /**
- * ic4_start_tx - Start transmitter, flush any output
+ * ic4_start_tx() - Start transmitter, flush any output
  * @port: Port to operate on
  *
  */
@@ -2521,7 +2521,7 @@ static void ic4_start_tx(struct uart_port *the_port)
 }
 
 /**
- * ic4_break_ctl - handle breaks
+ * ic4_break_ctl() - handle breaks
  * @port: Port to operate on
  * @break_state: Break state
  *
@@ -2531,7 +2531,7 @@ static void ic4_break_ctl(struct uart_port *the_port, int break_state)
 }
 
 /**
- * ic4_startup - Start up the serial port
+ * ic4_startup() - Start up the serial port
  * @port: Port to operate on
  *
  */
@@ -2564,7 +2564,7 @@ static int ic4_startup(struct uart_port *the_port)
 }
 
 /**
- * ic4_set_termios - set termios stuff
+ * ic4_set_termios() - set termios stuff
  * @port: port to operate on
  * @termios: New settings
  * @termios: Old
@@ -2582,7 +2582,7 @@ ic4_set_termios(struct uart_port *the_port,
 }
 
 /**
- * ic4_request_port - allocate resources for port - no op....
+ * ic4_request_port() - allocate resources for port - no op....
  * @port: port to operate on
  *
  */
@@ -2633,7 +2633,7 @@ static struct uart_driver ioc4_uart_rs422 = {
 
 
 /**
- * ioc4_serial_remove_one - detach function
+ * ioc4_serial_remove_one() - detach function
  *
  * @idd: IOC4 master module data for this IOC4
  */
@@ -2700,7 +2700,7 @@ static int ioc4_serial_remove_one(struct ioc4_driver_data *idd)
 
 
 /**
- * ioc4_serial_core_attach_rs232 - register with serial core
+ * ioc4_serial_core_attach_rs232() - register with serial core
  *		This is done during pci probing
  * @pdev: handle for this card
  */
@@ -2765,7 +2765,7 @@ ioc4_serial_core_attach(struct pci_dev *pdev, int port_type)
 }
 
 /**
- * ioc4_serial_attach_one - register attach function
+ * ioc4_serial_attach_one() - register attach function
  *		called per card found from IOC4 master module.
  * @idd: Master module data for this IOC4
  */
@@ -2906,7 +2906,7 @@ static struct ioc4_submodule ioc4_serial_submodule = {
 };
 
 /**
- * ioc4_serial_init - module init
+ * ioc4_serial_init() - module init
  */
 static int __init ioc4_serial_init(void)
 {
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 4029272891f9..f4fa9c6d61ab 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -154,7 +154,7 @@ static int kgdb_nmi_poll_one_knock(void)
 }
 
 /**
- * kgdb_nmi_poll_knock - Check if it is time to enter the debugger
+ * kgdb_nmi_poll_knock() - Check if it is time to enter the debugger
  *
  * "Serial ports are often noisy, especially when muxed over another port (we
  * often use serial over the headset connector). Noise on the async command
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index f7d67125675e..40fccbf384ca 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -68,7 +68,7 @@ static struct timer_list mux_timer;
 #define UART_GET_FIFO_CNT(p) __raw_readl((p)->membase + IO_DCOUNT_REG_OFFSET)
 
 /**
- * get_mux_port_count - Get the number of available ports on the Mux.
+ * get_mux_port_count() - Get the number of available ports on the Mux.
  * @dev: The parisc device.
  *
  * This function is used to determine the number of ports the Mux
@@ -98,7 +98,7 @@ static int __init get_mux_port_count(struct parisc_device *dev)
 }
 
 /**
- * mux_tx_empty - Check if the transmitter fifo is empty.
+ * mux_tx_empty() - Check if the transmitter fifo is empty.
  * @port: Ptr to the uart_port.
  *
  * This function test if the transmitter fifo for the port
@@ -111,7 +111,7 @@ static unsigned int mux_tx_empty(struct uart_port *port)
 }
 
 /**
- * mux_set_mctrl - Set the current state of the modem control inputs.
+ * mux_set_mctrl() - Set the current state of the modem control inputs.
  * @ports: Ptr to the uart_port.
  * @mctrl: Modem control bits.
  *
@@ -123,7 +123,7 @@ static void mux_set_mctrl(struct uart_port *port, unsigned int mctrl)
 }
 
 /**
- * mux_get_mctrl - Returns the current state of modem control inputs.
+ * mux_get_mctrl() - Returns the current state of modem control inputs.
  * @port: Ptr to the uart_port.
  *
  * The Serial MUX does not support CTS, DCD or DSR so these lines are
@@ -135,7 +135,7 @@ static unsigned int mux_get_mctrl(struct uart_port *port)
 }
 
 /**
- * mux_stop_tx - Stop transmitting characters.
+ * mux_stop_tx() - Stop transmitting characters.
  * @port: Ptr to the uart_port.
  *
  * The Serial MUX does not support this function.
@@ -145,7 +145,7 @@ static void mux_stop_tx(struct uart_port *port)
 }
 
 /**
- * mux_start_tx - Start transmitting characters.
+ * mux_start_tx() - Start transmitting characters.
  * @port: Ptr to the uart_port.
  *
  * The Serial Mux does not support this function.
@@ -155,7 +155,7 @@ static void mux_start_tx(struct uart_port *port)
 }
 
 /**
- * mux_stop_rx - Stop receiving characters.
+ * mux_stop_rx() - Stop receiving characters.
  * @port: Ptr to the uart_port.
  *
  * The Serial Mux does not support this function.
@@ -165,7 +165,7 @@ static void mux_stop_rx(struct uart_port *port)
 }
 
 /**
- * mux_break_ctl - Control the transmitssion of a break signal.
+ * mux_break_ctl() - Control the transmitssion of a break signal.
  * @port: Ptr to the uart_port.
  * @break_state: Raise/Lower the break signal.
  *
@@ -176,7 +176,7 @@ static void mux_break_ctl(struct uart_port *port, int break_state)
 }
 
 /**
- * mux_write - Write chars to the mux fifo.
+ * mux_write() - Write chars to the mux fifo.
  * @port: Ptr to the uart_port.
  *
  * This function writes all the data from the uart buffer to
@@ -220,7 +220,7 @@ static void mux_write(struct uart_port *port)
 }
 
 /**
- * mux_read - Read chars from the mux fifo.
+ * mux_read() - Read chars from the mux fifo.
  * @port: Ptr to the uart_port.
  *
  * This reads all available data from the mux's fifo and pushes
@@ -260,7 +260,7 @@ static void mux_read(struct uart_port *port)
 }
 
 /**
- * mux_startup - Initialize the port.
+ * mux_startup() - Initialize the port.
  * @port: Ptr to the uart_port.
  *
  * Grab any resources needed for this port and start the
@@ -273,7 +273,7 @@ static int mux_startup(struct uart_port *port)
 }
 
 /**
- * mux_shutdown - Disable the port.
+ * mux_shutdown() - Disable the port.
  * @port: Ptr to the uart_port.
  *
  * Release any resources needed for the port.
@@ -284,7 +284,7 @@ static void mux_shutdown(struct uart_port *port)
 }
 
 /**
- * mux_set_termios - Chane port parameters.
+ * mux_set_termios() - Chane port parameters.
  * @port: Ptr to the uart_port.
  * @termios: new termios settings.
  * @old: old termios settings.
@@ -298,7 +298,7 @@ mux_set_termios(struct uart_port *port, struct ktermios *termios,
 }
 
 /**
- * mux_type - Describe the port.
+ * mux_type() - Describe the port.
  * @port: Ptr to the uart_port.
  *
  * Return a pointer to a string constant describing the
@@ -310,7 +310,7 @@ static const char *mux_type(struct uart_port *port)
 }
 
 /**
- * mux_release_port - Release memory and IO regions.
+ * mux_release_port() - Release memory and IO regions.
  * @port: Ptr to the uart_port.
  *
  * Release any memory and IO region resources currently in use by
@@ -321,7 +321,7 @@ static void mux_release_port(struct uart_port *port)
 }
 
 /**
- * mux_request_port - Request memory and IO regions.
+ * mux_request_port() - Request memory and IO regions.
  * @port: Ptr to the uart_port.
  *
  * Request any memory and IO region resources required by the port.
@@ -334,7 +334,7 @@ static int mux_request_port(struct uart_port *port)
 }
 
 /**
- * mux_config_port - Perform port autoconfiguration.
+ * mux_config_port() - Perform port autoconfiguration.
  * @port: Ptr to the uart_port.
  * @type: Bitmask of required configurations.
  *
@@ -350,7 +350,7 @@ static void mux_config_port(struct uart_port *port, int type)
 }
 
 /**
- * mux_verify_port - Verify the port information.
+ * mux_verify_port() - Verify the port information.
  * @port: Ptr to the uart_port.
  * @ser: Ptr to the serial information.
  *
@@ -366,7 +366,7 @@ static int mux_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 /**
- * mux_drv_poll - Mux poll function.
+ * mux_drv_poll() - Mux poll function.
  * @unused: Unused variable
  *
  * This function periodically polls the Serial MUX to check for new data.
@@ -442,7 +442,7 @@ static const struct uart_ops mux_pops = {
 };
 
 /**
- * mux_probe - Determine if the Serial Mux should claim this device.
+ * mux_probe() - Determine if the Serial Mux should claim this device.
  * @dev: The parisc device.
  *
  * Deterimine if the Serial Mux should claim this chip (return 0)
@@ -561,7 +561,7 @@ static struct parisc_driver serial_mux_driver __refdata = {
 };
 
 /**
- * mux_init - Serial MUX initialization procedure.
+ * mux_init() - Serial MUX initialization procedure.
  *
  * Register the Serial MUX driver.
  */
@@ -584,7 +584,7 @@ static int __init mux_init(void)
 }
 
 /**
- * mux_exit - Serial MUX cleanup procedure.
+ * mux_exit() - Serial MUX cleanup procedure.
  *
  * Unregister the Serial MUX driver from the tty layer.
  */
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index af2a29cfbbe9..872f3b2ed196 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -219,7 +219,7 @@ static void tegra_uart_break_ctl(struct uart_port *u, int break_ctl)
 }
 
 /**
- * tegra_uart_wait_cycle_time: Wait for N UART clock periods
+ * tegra_uart_wait_cycle_time() - Wait for N UART clock periods
  *
  * @tup:	Tegra serial port data structure.
  * @cycles:	Number of clock periods to wait.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 70402cdb4d8c..2d28afaf67e4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -309,13 +309,13 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 }
 
 /**
- *	uart_update_timeout - update per-port FIFO timeout.
- *	@port:  uart_port structure describing the port
- *	@cflag: termios cflag value
- *	@baud:  speed of the port
+ * uart_update_timeout() - update per-port FIFO timeout.
+ * @port: uart_port structure describing the port
+ * @cflag: termios cflag value
+ * @baud: speed of the port
  *
- *	Set the port FIFO timeout value.  The @cflag value should
- *	reflect the actual hardware settings.
+ * Set the port FIFO timeout value.  The @cflag value should
+ * reflect the actual hardware settings.
  */
 void
 uart_update_timeout(struct uart_port *port, unsigned int cflag,
@@ -359,23 +359,23 @@ uart_update_timeout(struct uart_port *port, unsigned int cflag,
 EXPORT_SYMBOL(uart_update_timeout);
 
 /**
- *	uart_get_baud_rate - return baud rate for a particular port
- *	@port: uart_port structure describing the port in question.
- *	@termios: desired termios settings.
- *	@old: old termios (or NULL)
- *	@min: minimum acceptable baud rate
- *	@max: maximum acceptable baud rate
+ * uart_get_baud_rate() - return baud rate for a particular port
+ * @port: uart_port structure describing the port in question.
+ * @termios: desired termios settings.
+ * @old: old termios (or NULL)
+ * @min: minimum acceptable baud rate
+ * @max: maximum acceptable baud rate
  *
- *	Decode the termios structure into a numeric baud rate,
- *	taking account of the magic 38400 baud rate (with spd_*
- *	flags), and mapping the %B0 rate to 9600 baud.
+ * Decode the termios structure into a numeric baud rate,
+ * taking account of the magic 38400 baud rate (with spd_*
+ * flags), and mapping the %B0 rate to 9600 baud.
  *
- *	If the new baud rate is invalid, try the old termios setting.
- *	If it's still invalid, we try 9600 baud.
+ * If the new baud rate is invalid, try the old termios setting.
+ * If it's still invalid, we try 9600 baud.
  *
- *	Update the @termios structure to reflect the baud rate
- *	we're actually going to be using. Don't do this for the case
- *	where B0 is requested ("hang up").
+ * Update the @termios structure to reflect the baud rate
+ * we're actually going to be using. Don't do this for the case
+ * where B0 is requested ("hang up").
  */
 unsigned int
 uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
@@ -461,11 +461,11 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 EXPORT_SYMBOL(uart_get_baud_rate);
 
 /**
- *	uart_get_divisor - return uart clock divisor
- *	@port: uart_port structure describing the port.
- *	@baud: desired baud rate
+ * uart_get_divisor() - return uart clock divisor
+ * @port: uart_port structure describing the port.
+ * @baud: desired baud rate
  *
- *	Calculate the uart clock divisor for the port.
+ * Calculate the uart clock divisor for the port.
  */
 unsigned int
 uart_get_divisor(struct uart_port *port, unsigned int baud)
@@ -1014,10 +1014,10 @@ static int uart_set_info_user(struct tty_struct *tty, struct uart_state *state,
 }
 
 /**
- *	uart_get_lsr_info	-	get line status register info
- *	@tty: tty associated with the UART
- *	@state: UART being queried
- *	@value: returned modem value
+ * uart_get_lsr_info() - get line status register info
+ * @tty: tty associated with the UART
+ * @state: UART being queried
+ * @value: returned modem value
  */
 static int uart_get_lsr_info(struct tty_struct *tty,
 			struct uart_state *state, unsigned int __user *value)
@@ -1900,11 +1900,11 @@ static int uart_proc_show(struct seq_file *m, void *v)
 
 #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
 /**
- *	uart_console_write - write a console message to a serial port
- *	@port: the port to write the message
- *	@s: array of characters
- *	@count: number of characters in string to write
- *	@putchar: function to write character to port
+ * uart_console_write() - write a console message to a serial port
+ * @port: the port to write the message
+ * @s: array of characters
+ * @count: number of characters in string to write
+ * @putchar: function to write character to port
  */
 void uart_console_write(struct uart_port *port, const char *s,
 			unsigned int count,
@@ -1943,22 +1943,22 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
 }
 
 /**
- *	uart_parse_earlycon - Parse earlycon options
- *	@p:	  ptr to 2nd field (ie., just beyond '<name>,')
- *	@iotype:  ptr for decoded iotype (out)
- *	@addr:    ptr for decoded mapbase/iobase (out)
- *	@options: ptr for <options> field; NULL if not present (out)
+ * uart_parse_earlycon() - Parse earlycon options
+ * @p: ptr to 2nd field (ie., just beyond '<name>,')
+ * @iotype: ptr for decoded iotype (out)
+ * @addr: ptr for decoded mapbase/iobase (out)
+ * @options: ptr for <options> field; NULL if not present (out)
  *
- *	Decodes earlycon kernel command line parameters of the form
- *	   earlycon=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
- *	   console=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
+ * Decodes earlycon kernel command line parameters of the form
+ *    earlycon=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
+ *    console=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
  *
- *	The optional form
- *	   earlycon=<name>,0x<addr>,<options>
- *	   console=<name>,0x<addr>,<options>
- *	is also accepted; the returned @iotype will be UPIO_MEM.
+ * The optional form
+ *    earlycon=<name>,0x<addr>,<options>
+ *    console=<name>,0x<addr>,<options>
+ * is also accepted; the returned @iotype will be UPIO_MEM.
  *
- *	Returns 0 on success or -EINVAL on failure
+ * Returns 0 on success or -EINVAL on failure
  */
 int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
 			char **options)
@@ -2003,16 +2003,16 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
 EXPORT_SYMBOL_GPL(uart_parse_earlycon);
 
 /**
- *	uart_parse_options - Parse serial port baud/parity/bits/flow control.
- *	@options: pointer to option string
- *	@baud: pointer to an 'int' variable for the baud rate.
- *	@parity: pointer to an 'int' variable for the parity.
- *	@bits: pointer to an 'int' variable for the number of data bits.
- *	@flow: pointer to an 'int' variable for the flow control character.
+ * uart_parse_options() - Parse serial port baud/parity/bits/flow control.
+ * @options: pointer to option string
+ * @baud: pointer to an 'int' variable for the baud rate.
+ * @parity: pointer to an 'int' variable for the parity.
+ * @bits: pointer to an 'int' variable for the number of data bits.
+ * @flow: pointer to an 'int' variable for the flow control character.
  *
- *	uart_parse_options decodes a string containing the serial console
- *	options.  The format of the string is <baud><parity><bits><flow>,
- *	eg: 115200n8r
+ * uart_parse_options decodes a string containing the serial console
+ * options.  The format of the string is <baud><parity><bits><flow>,
+ * eg: 115200n8r
  */
 void
 uart_parse_options(const char *options, int *baud, int *parity,
@@ -2033,13 +2033,13 @@ uart_parse_options(const char *options, int *baud, int *parity,
 EXPORT_SYMBOL_GPL(uart_parse_options);
 
 /**
- *	uart_set_options - setup the serial console parameters
- *	@port: pointer to the serial ports uart_port structure
- *	@co: console pointer
- *	@baud: baud rate
- *	@parity: parity character - 'n' (none), 'o' (odd), 'e' (even)
- *	@bits: number of data bits
- *	@flow: flow control character - 'r' (rts)
+ * uart_set_options() - setup the serial console parameters
+ * @port: pointer to the serial ports uart_port structure
+ * @co: console pointer
+ * @baud: baud rate
+ * @parity: parity character - 'n' (none), 'o' (odd), 'e' (even)
+ * @bits: number of data bits
+ * @flow: flow control character - 'r' (rts)
  */
 int
 uart_set_options(struct uart_port *port, struct console *co,
@@ -2101,7 +2101,7 @@ EXPORT_SYMBOL_GPL(uart_set_options);
 #endif /* CONFIG_SERIAL_CORE_CONSOLE */
 
 /**
- * uart_change_pm - set power state of the port
+ * uart_change_pm() - set power state of the port
  *
  * @state: port descriptor
  * @pm_state: new state
@@ -2489,17 +2489,17 @@ static const struct tty_port_operations uart_port_ops = {
 };
 
 /**
- *	uart_register_driver - register a driver with the uart core layer
- *	@drv: low level driver structure
+ * uart_register_driver() - register a driver with the uart core layer
+ * @drv: low level driver structure
  *
- *	Register a uart driver with the core driver.  We in turn register
- *	with the tty layer, and initialise the core driver per-port state.
+ * Register a uart driver with the core driver.  We in turn register
+ * with the tty layer, and initialise the core driver per-port state.
  *
- *	We have a proc file in /proc/tty/driver which is named after the
- *	normal driver.
+ * We have a proc file in /proc/tty/driver which is named after the
+ * normal driver.
  *
- *	drv->port should be NULL, and the per-port structures should be
- *	registered using uart_add_one_port after this call has succeeded.
+ * drv->port should be NULL, and the per-port structures should be
+ * registered using uart_add_one_port after this call has succeeded.
  */
 int uart_register_driver(struct uart_driver *drv)
 {
@@ -2560,13 +2560,13 @@ int uart_register_driver(struct uart_driver *drv)
 }
 
 /**
- *	uart_unregister_driver - remove a driver from the uart core layer
- *	@drv: low level driver structure
+ * uart_unregister_driver() - remove a driver from the uart core layer
+ * @drv: low level driver structure
  *
- *	Remove all references to a driver from the core driver.  The low
- *	level driver must have removed all its ports via the
- *	uart_remove_one_port() if it registered them with uart_add_one_port().
- *	(ie, drv->port == NULL)
+ * Remove all references to a driver from the core driver.  The low
+ * level driver must have removed all its ports via the
+ * uart_remove_one_port() if it registered them with uart_add_one_port().
+ * (ie, drv->port == NULL)
  */
 void uart_unregister_driver(struct uart_driver *drv)
 {
@@ -2760,14 +2760,14 @@ static const struct attribute_group tty_dev_attr_group = {
 	};
 
 /**
- *	uart_add_one_port - attach a driver-defined port structure
- *	@drv: pointer to the uart low level driver structure for this port
- *	@uport: uart port structure to use for this port.
+ * uart_add_one_port() - attach a driver-defined port structure
+ * @drv: pointer to the uart low level driver structure for this port
+ * @uport: uart port structure to use for this port.
  *
- *	This allows the driver to register its own uart_port structure
- *	with the core driver.  The main purpose is to allow the low
- *	level uart drivers to expand uart_port, rather than having yet
- *	more levels of structures.
+ * This allows the driver to register its own uart_port structure
+ * with the core driver.  The main purpose is to allow the low
+ * level uart drivers to expand uart_port, rather than having yet
+ * more levels of structures.
  */
 int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
@@ -2863,13 +2863,13 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 }
 
 /**
- *	uart_remove_one_port - detach a driver defined port structure
- *	@drv: pointer to the uart low level driver structure for this port
- *	@uport: uart port structure for this port
+ * uart_remove_one_port() - detach a driver defined port structure
+ * @drv: pointer to the uart low level driver structure for this port
+ * @uport: uart port structure for this port
  *
- *	This unhooks (and hangs up) the specified port structure from the
- *	core driver.  No further calls will be made to the low-level code
- *	for this port.
+ * This unhooks (and hangs up) the specified port structure from the
+ * core driver.  No further calls will be made to the low-level code
+ * for this port.
  */
 int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
@@ -2969,11 +2969,11 @@ int uart_match_port(struct uart_port *port1, struct uart_port *port2)
 EXPORT_SYMBOL(uart_match_port);
 
 /**
- *	uart_handle_dcd_change - handle a change of carrier detect state
- *	@uport: uart_port structure for the open port
- *	@status: new carrier detect status, nonzero if active
+ * uart_handle_dcd_change() - handle a change of carrier detect state
+ * @uport: uart_port structure for the open port
+ * @status: new carrier detect status, nonzero if active
  *
- *	Caller must hold uport->lock
+ * Caller must hold uport->lock
  */
 void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 {
@@ -3004,11 +3004,11 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
 
 /**
- *	uart_handle_cts_change - handle a change of clear-to-send state
- *	@uport: uart_port structure for the open port
- *	@status: new clear to send status, nonzero if active
+ * uart_handle_cts_change() - handle a change of clear-to-send state
+ * @uport: uart_port structure for the open port
+ * @status: new clear to send status, nonzero if active
  *
- *	Caller must hold uport->lock
+ * Caller must hold uport->lock
  */
 void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 {
@@ -3035,7 +3035,7 @@ void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 EXPORT_SYMBOL_GPL(uart_handle_cts_change);
 
 /**
- * uart_insert_char - push a char to the uart layer
+ * uart_insert_char() - push a char to the uart layer
  *
  * User is responsible to call tty_flip_buffer_push when they are done with
  * insertion.
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 33c630d0f1b2..b6b17d5005f6 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1004,15 +1004,15 @@ int __init early_serial_txx9_setup(struct uart_port *port)
 static DEFINE_MUTEX(serial_txx9_mutex);
 
 /**
- *	serial_txx9_register_port - register a serial port
- *	@port: serial port template
+ * serial_txx9_register_port() - register a serial port
+ * @port: serial port template
  *
- *	Configure the serial port specified by the request.
+ * Configure the serial port specified by the request.
  *
- *	The port is then probed and if necessary the IRQ is autodetected
- *	If this fails an error is returned.
+ * The port is then probed and if necessary the IRQ is autodetected
+ * If this fails an error is returned.
  *
- *	On success the port is ready to use and the line number is returned.
+ * On success the port is ready to use and the line number is returned.
  */
 static int serial_txx9_register_port(struct uart_port *port)
 {
@@ -1056,11 +1056,11 @@ static int serial_txx9_register_port(struct uart_port *port)
 }
 
 /**
- *	serial_txx9_unregister_port - remove a txx9 serial port at runtime
- *	@line: serial line number
+ * serial_txx9_unregister_port() - remove a txx9 serial port at runtime
+ * @line: serial line number
  *
- *	Remove one serial port.  This may not be called from interrupt
- *	context.  We hand the port back to the our control.
+ * Remove one serial port.  This may not be called from interrupt
+ * context.  We hand the port back to the our control.
  */
 static void serial_txx9_unregister_port(int line)
 {
diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index 457a062fffd8..2c01168319db 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -141,7 +141,7 @@ static struct sn_sal_ops intr_ops = {
 /* routines for running the console in polling mode */
 
 /**
- * snt_poll_getc - Get a character from the console in polling mode
+ * snt_poll_getc() - Get a character from the console in polling mode
  *
  */
 static int snt_poll_getc(void)
@@ -153,7 +153,7 @@ static int snt_poll_getc(void)
 }
 
 /**
- * snt_poll_input_pending - Check if any input is waiting - polling mode.
+ * snt_poll_input_pending() - Check if any input is waiting - polling mode.
  *
  */
 static int snt_poll_input_pending(void)
@@ -167,7 +167,7 @@ static int snt_poll_input_pending(void)
 /* routines for an interrupt driven console (normal) */
 
 /**
- * snt_intr_getc - Get a character from the console, interrupt mode
+ * snt_intr_getc() - Get a character from the console, interrupt mode
  *
  */
 static int snt_intr_getc(void)
@@ -176,7 +176,7 @@ static int snt_intr_getc(void)
 }
 
 /**
- * snt_intr_input_pending - Check if input is pending, interrupt mode
+ * snt_intr_input_pending() - Check if input is pending, interrupt mode
  *
  */
 static int snt_intr_input_pending(void)
@@ -187,7 +187,7 @@ static int snt_intr_input_pending(void)
 /* these functions are polled and interrupt */
 
 /**
- * snt_hw_puts_raw - Send raw string to the console, polled or interrupt mode
+ * snt_hw_puts_raw() - Send raw string to the console, polled or interrupt mode
  * @s: String
  * @len: Length
  *
@@ -199,7 +199,7 @@ static int snt_hw_puts_raw(const char *s, int len)
 }
 
 /**
- * snt_hw_puts_buffered - Send string to console, polled or interrupt mode
+ * snt_hw_puts_buffered() - Send string to console, polled or interrupt mode
  * @s: String
  * @len: Length
  *
@@ -218,7 +218,7 @@ static int snt_hw_puts_buffered(const char *s, int len)
  */
 
 /**
- * snp_type - What type of console are we?
+ * snp_type() - What type of console are we?
  * @port: Port to operate with (we ignore since we only have one port)
  *
  */
@@ -228,7 +228,7 @@ static const char *snp_type(struct uart_port *port)
 }
 
 /**
- * snp_tx_empty - Is the transmitter empty?  We pretend we're always empty
+ * snp_tx_empty() - Is the transmitter empty?  We pretend we're always empty
  * @port: Port to operate on (we ignore since we only have one port)
  *
  */
@@ -238,7 +238,7 @@ static unsigned int snp_tx_empty(struct uart_port *port)
 }
 
 /**
- * snp_stop_tx - stop the transmitter - no-op for us
+ * snp_stop_tx() - stop the transmitter - no-op for us
  * @port: Port to operat eon - we ignore - no-op function
  *
  */
@@ -247,7 +247,7 @@ static void snp_stop_tx(struct uart_port *port)
 }
 
 /**
- * snp_release_port - Free i/o and resources for port - no-op for us
+ * snp_release_port() - Free i/o and resources for port - no-op for us
  * @port: Port to operate on - we ignore - no-op function
  *
  */
@@ -256,7 +256,7 @@ static void snp_release_port(struct uart_port *port)
 }
 
 /**
- * snp_shutdown - shut down the port - free irq and disable - no-op for us
+ * snp_shutdown() - shut down the port - free irq and disable - no-op for us
  * @port: Port to shut down - we ignore
  *
  */
@@ -265,7 +265,7 @@ static void snp_shutdown(struct uart_port *port)
 }
 
 /**
- * snp_set_mctrl - set control lines (dtr, rts, etc) - no-op for our console
+ * snp_set_mctrl() - set control lines (dtr, rts, etc) - no-op for our console
  * @port: Port to operate on - we ignore
  * @mctrl: Lines to set/unset - we ignore
  *
@@ -275,7 +275,7 @@ static void snp_set_mctrl(struct uart_port *port, unsigned int mctrl)
 }
 
 /**
- * snp_get_mctrl - get contorl line info, we just return a static value
+ * snp_get_mctrl() - get contorl line info, we just return a static value
  * @port: port to operate on - we only have one port so we ignore this
  *
  */
@@ -285,7 +285,7 @@ static unsigned int snp_get_mctrl(struct uart_port *port)
 }
 
 /**
- * snp_stop_rx - Stop the receiver - we ignor ethis
+ * snp_stop_rx() - Stop the receiver - we ignor ethis
  * @port: Port to operate on - we ignore
  *
  */
@@ -294,7 +294,7 @@ static void snp_stop_rx(struct uart_port *port)
 }
 
 /**
- * snp_start_tx - Start transmitter
+ * snp_start_tx() - Start transmitter
  * @port: Port to operate on
  *
  */
@@ -317,7 +317,7 @@ static void snp_break_ctl(struct uart_port *port, int break_state)
 }
 
 /**
- * snp_startup - Start up the serial port - always return 0 (We're always on)
+ * snp_startup() - Start up the serial port - always return 0 (We're always on)
  * @port: Port to operate on
  *
  */
@@ -327,7 +327,7 @@ static int snp_startup(struct uart_port *port)
 }
 
 /**
- * snp_set_termios - set termios stuff - we ignore these
+ * snp_set_termios() - set termios stuff - we ignore these
  * @port: port to operate on
  * @termios: New settings
  * @termios: Old
@@ -340,7 +340,7 @@ snp_set_termios(struct uart_port *port, struct ktermios *termios,
 }
 
 /**
- * snp_request_port - allocate resources for port - ignored by us
+ * snp_request_port() - allocate resources for port - ignored by us
  * @port: port to operate on
  *
  */
@@ -350,7 +350,7 @@ static int snp_request_port(struct uart_port *port)
 }
 
 /**
- * snp_config_port - allocate resources, set up - we ignore,  we're always on
+ * snp_config_port() - allocate resources, set up - we ignore,  we're always on
  * @port: Port to operate on
  * @flags: flags used for port setup
  *
@@ -385,7 +385,7 @@ static const struct uart_ops sn_console_ops = {
 #ifdef DEBUG
 
 /**
- * sn_debug_printf - close to hardware debugging printf
+ * sn_debug_printf() - close to hardware debugging printf
  * @fmt: printf format
  *
  * This is as "close to the metal" as we can get, used when the driver
@@ -417,7 +417,7 @@ static int sn_debug_printf(const char *fmt, ...)
  */
 
 /**
- * sn_receive_chars - Grab characters, pass them to tty layer
+ * sn_receive_chars() - Grab characters, pass them to tty layer
  * @port: Port to operate on
  * @flags: irq flags
  *
@@ -495,7 +495,7 @@ sn_receive_chars(struct sn_cons_port *port, unsigned long flags)
 }
 
 /**
- * sn_transmit_chars - grab characters from serial core, send off
+ * sn_transmit_chars() - grab characters from serial core, send off
  * @port: Port to operate on
  * @raw: Transmit raw or buffered
  *
@@ -578,7 +578,7 @@ static void sn_transmit_chars(struct sn_cons_port *port, int raw)
 }
 
 /**
- * sn_sal_interrupt - Handle console interrupts
+ * sn_sal_interrupt() - Handle console interrupts
  * @irq: irq #, useful for debug statements
  * @dev_id: our pointer to our port (sn_cons_port which contains the uart port)
  *
@@ -604,7 +604,7 @@ static irqreturn_t sn_sal_interrupt(int irq, void *dev_id)
 }
 
 /**
- * sn_sal_timer_poll - this function handles polled console mode
+ * sn_sal_timer_poll() - this function handles polled console mode
  * @data: A pointer to our sn_cons_port (which contains the uart port)
  *
  * data is the pointer that init_timer will store for us.  This function is
@@ -636,7 +636,7 @@ static void sn_sal_timer_poll(struct timer_list *t)
  */
 
 /**
- * sn_sal_switch_to_asynch - Switch to async mode (as opposed to synch)
+ * sn_sal_switch_to_asynch() - Switch to async mode (as opposed to synch)
  * @port: Our sn_cons_port (which contains the uart port)
  *
  * So this is used by sn_sal_serial_console_init (early on, before we're
@@ -685,7 +685,7 @@ static void __init sn_sal_switch_to_asynch(struct sn_cons_port *port)
 }
 
 /**
- * sn_sal_switch_to_interrupts - Switch to interrupt driven mode
+ * sn_sal_switch_to_interrupts() - Switch to interrupt driven mode
  * @port: Our sn_cons_port (which contains the uart port)
  *
  * In sn_sal_init, after we're registered with serial core and
@@ -752,7 +752,7 @@ static struct uart_driver sal_console_uart = {
 };
 
 /**
- * sn_sal_init - When the kernel loads us, get us rolling w/ serial core
+ * sn_sal_init() - When the kernel loads us, get us rolling w/ serial core
  *
  * Before this is called, we've been printing kernel messages in a special
  * early mode not making use of the serial core infrastructure.  When our
@@ -826,7 +826,7 @@ static int __init sn_sal_init(void)
 device_initcall(sn_sal_init);
 
 /**
- * puts_raw_fixed - sn_sal_console_write helper for adding \r's as required
+ * puts_raw_fixed() - sn_sal_console_write helper for adding \r's as required
  * @puts_raw : puts function to do the writing
  * @s: input string
  * @count: length
@@ -852,7 +852,7 @@ static void puts_raw_fixed(int (*puts_raw) (const char *s, int len),
 }
 
 /**
- * sn_sal_console_write - Print statements before serial core available
+ * sn_sal_console_write() - Print statements before serial core available
  * @console: Console to operate on - we ignore since we have just one
  * @s: String to send
  * @count: length
@@ -945,7 +945,7 @@ sn_sal_console_write(struct console *co, const char *s, unsigned count)
 
 
 /**
- * sn_sal_console_setup - Set up console for early printing
+ * sn_sal_console_setup() - Set up console for early printing
  * @co: Console to work with
  * @options: Options to set
  *
@@ -962,7 +962,7 @@ static int sn_sal_console_setup(struct console *co, char *options)
 }
 
 /**
- * sn_sal_console_write_early - simple early output routine
+ * sn_sal_console_write_early() - simple early output routine
  * @co - console struct
  * @s - string to print
  * @count - count
@@ -988,7 +988,7 @@ static struct console sal_console_early __initdata = {
 };
 
 /**
- * sn_serial_console_early_setup - Sets up early console output support
+ * sn_serial_console_early_setup() - Sets up early console output support
  *
  * Register a console early on...  This is for output before even
  * sn_sal_serial_cosnole_init is called.  This function is called from
@@ -1010,7 +1010,7 @@ int __init sn_serial_console_early_setup(void)
 }
 
 /**
- * sn_sal_serial_console_init - Early console output - set up for register
+ * sn_sal_serial_console_init() - Early console output - set up for register
  *
  * This function is called when regular console init happens.  Because we
  * support even earlier console output with sn_serial_console_early_setup
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f0344adc86db..94a91748da40 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -603,7 +603,8 @@ static struct uart_driver ulite_uart_driver = {
  * Port assignment functions (mapping devices to uart_port structures)
  */
 
-/** ulite_assign: register a uartlite device with the driver
+/**
+ * ulite_assign() - register a uartlite device with the driver
  *
  * @dev: pointer to device structure
  * @id: requested id number.  Pass -1 for automatic port assignment
@@ -684,7 +685,8 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	return 0;
 }
 
-/** ulite_release: register a uartlite device with the driver
+/**
+ * ulite_release() - register a uartlite device with the driver
  *
  * @dev: pointer to device structure
  */
@@ -703,7 +705,7 @@ static int ulite_release(struct device *dev)
 }
 
 /**
- * ulite_suspend - Stop the device.
+ * ulite_suspend() - Stop the device.
  *
  * @dev: handle to the device structure.
  * Return: 0 always.
@@ -719,7 +721,7 @@ static int __maybe_unused ulite_suspend(struct device *dev)
 }
 
 /**
- * ulite_resume - Resume the device.
+ * ulite_resume() - Resume the device.
  *
  * @dev: handle to the device structure.
  * Return: 0 on success, errno otherwise.
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c3f6cce300aa..5ed85c49bbce 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -201,7 +201,7 @@ struct cdns_platform_data {
 		clk_rate_change_nb);
 
 /**
- * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.
+ * cdns_uart_handle_rx() - Handle the received bytes along with Rx errors.
  * @dev_id: Id of the UART port
  * @isrstatus: The interrupt status register value as read
  * Return: None
@@ -297,7 +297,7 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 }
 
 /**
- * cdns_uart_handle_tx - Handle the bytes to be Txed.
+ * cdns_uart_handle_tx() - Handle the bytes to be Txed.
  * @dev_id: Id of the UART port
  * Return: None
  */
@@ -341,7 +341,7 @@ static void cdns_uart_handle_tx(void *dev_id)
 }
 
 /**
- * cdns_uart_isr - Interrupt handler
+ * cdns_uart_isr() - Interrupt handler
  * @irq: Irq number
  * @dev_id: Id of the port
  *
@@ -372,7 +372,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 }
 
 /**
- * cdns_uart_calc_baud_divs - Calculate baud rate divisors
+ * cdns_uart_calc_baud_divs() - Calculate baud rate divisors
  * @clk: UART module input clock
  * @baud: Desired baud rate
  * @rbdiv: BDIV value (return value)
@@ -434,7 +434,7 @@ static unsigned int cdns_uart_calc_baud_divs(unsigned int clk,
 }
 
 /**
- * cdns_uart_set_baud_rate - Calculate and set the baud rate
+ * cdns_uart_set_baud_rate() - Calculate and set the baud rate
  * @port: Handle to the uart port structure
  * @baud: Baud rate to set
  * Return: baud rate, requested baud when possible, or actual baud when there
@@ -468,7 +468,7 @@ static unsigned int cdns_uart_set_baud_rate(struct uart_port *port,
 
 #ifdef CONFIG_COMMON_CLK
 /**
- * cdns_uart_clk_notitifer_cb - Clock notifier callback
+ * cdns_uart_clk_notitifer_cb() - Clock notifier callback
  * @nb:		Notifier block
  * @event:	Notify event
  * @data:	Notifier data
@@ -563,7 +563,7 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 #endif
 
 /**
- * cdns_uart_start_tx -  Start transmitting bytes
+ * cdns_uart_start_tx() -  Start transmitting bytes
  * @port: Handle to the uart port structure
  */
 static void cdns_uart_start_tx(struct uart_port *port)
@@ -593,7 +593,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
 }
 
 /**
- * cdns_uart_stop_tx - Stop TX
+ * cdns_uart_stop_tx() - Stop TX
  * @port: Handle to the uart port structure
  */
 static void cdns_uart_stop_tx(struct uart_port *port)
@@ -607,7 +607,7 @@ static void cdns_uart_stop_tx(struct uart_port *port)
 }
 
 /**
- * cdns_uart_stop_rx - Stop RX
+ * cdns_uart_stop_rx() - Stop RX
  * @port: Handle to the uart port structure
  */
 static void cdns_uart_stop_rx(struct uart_port *port)
@@ -624,7 +624,7 @@ static void cdns_uart_stop_rx(struct uart_port *port)
 }
 
 /**
- * cdns_uart_tx_empty -  Check whether TX is empty
+ * cdns_uart_tx_empty() -  Check whether TX is empty
  * @port: Handle to the uart port structure
  *
  * Return: TIOCSER_TEMT on success, 0 otherwise
@@ -639,7 +639,7 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
 }
 
 /**
- * cdns_uart_break_ctl - Based on the input ctl we have to start or stop
+ * cdns_uart_break_ctl() - Based on the input ctl we have to start or stop
  *			transmitting char breaks
  * @port: Handle to the uart port structure
  * @ctl: Value based on which start or stop decision is taken
@@ -665,7 +665,7 @@ static void cdns_uart_break_ctl(struct uart_port *port, int ctl)
 }
 
 /**
- * cdns_uart_set_termios - termios operations, handling data length, parity,
+ * cdns_uart_set_termios() - termios operations, handling data length, parity,
  *				stop bits, flow control, baud rate
  * @port: Handle to the uart port structure
  * @termios: Handle to the input termios structure
@@ -796,7 +796,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
 }
 
 /**
- * cdns_uart_startup - Called when an application opens a cdns_uart port
+ * cdns_uart_startup() - Called when an application opens a cdns_uart port
  * @port: Handle to the uart port structure
  *
  * Return: 0 on success, negative errno otherwise
@@ -879,7 +879,7 @@ static int cdns_uart_startup(struct uart_port *port)
 }
 
 /**
- * cdns_uart_shutdown - Called when an application closes a cdns_uart port
+ * cdns_uart_shutdown() - Called when an application closes a cdns_uart port
  * @port: Handle to the uart port structure
  */
 static void cdns_uart_shutdown(struct uart_port *port)
@@ -904,7 +904,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
 }
 
 /**
- * cdns_uart_type - Set UART type to cdns_uart port
+ * cdns_uart_type() - Set UART type to cdns_uart port
  * @port: Handle to the uart port structure
  *
  * Return: string on success, NULL otherwise
@@ -915,7 +915,7 @@ static const char *cdns_uart_type(struct uart_port *port)
 }
 
 /**
- * cdns_uart_verify_port - Verify the port params
+ * cdns_uart_verify_port() - Verify the port params
  * @port: Handle to the uart port structure
  * @ser: Handle to the structure whose members are compared
  *
@@ -938,7 +938,7 @@ static int cdns_uart_verify_port(struct uart_port *port,
 }
 
 /**
- * cdns_uart_request_port - Claim the memory region attached to cdns_uart port,
+ * cdns_uart_request_port() - Claim the memory region attached to cdns_uart port,
  *				called when the driver adds a cdns_uart port via
  *				uart_add_one_port()
  * @port: Handle to the uart port structure
@@ -962,7 +962,7 @@ static int cdns_uart_request_port(struct uart_port *port)
 }
 
 /**
- * cdns_uart_release_port - Release UART port
+ * cdns_uart_release_port() - Release UART port
  * @port: Handle to the uart port structure
  *
  * Release the memory region attached to a cdns_uart port. Called when the
@@ -976,7 +976,7 @@ static void cdns_uart_release_port(struct uart_port *port)
 }
 
 /**
- * cdns_uart_config_port - Configure UART port
+ * cdns_uart_config_port() - Configure UART port
  * @port: Handle to the uart port structure
  * @flags: If any
  */
@@ -987,7 +987,7 @@ static void cdns_uart_config_port(struct uart_port *port, int flags)
 }
 
 /**
- * cdns_uart_get_mctrl - Get the modem control state
+ * cdns_uart_get_mctrl() - Get the modem control state
  * @port: Handle to the uart port structure
  *
  * Return: the modem control state
@@ -1101,7 +1101,7 @@ static const struct uart_ops cdns_uart_ops = {
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
- * cdns_uart_console_putchar - write the character to the FIFO buffer
+ * cdns_uart_console_putchar() - write the character to the FIFO buffer
  * @port: Handle to the uart port structure
  * @ch: Character to be written
  */
@@ -1165,7 +1165,7 @@ OF_EARLYCON_DECLARE(cdns, "xlnx,zynqmp-uart", cdns_early_console_setup);
 static struct uart_port *console_port;
 
 /**
- * cdns_uart_console_write - perform write operation
+ * cdns_uart_console_write() - perform write operation
  * @co: Console handle
  * @s: Pointer to character array
  * @count: No of characters
@@ -1212,7 +1212,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 }
 
 /**
- * cdns_uart_console_setup - Initialize the uart to default config
+ * cdns_uart_console_setup() - Initialize the uart to default config
  * @co: Console handle
  * @options: Initial settings of uart
  *
@@ -1242,7 +1242,7 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 
 #ifdef CONFIG_PM_SLEEP
 /**
- * cdns_uart_suspend - suspend event
+ * cdns_uart_suspend() - suspend event
  * @device: Pointer to the device structure
  *
  * Return: 0
@@ -1278,7 +1278,7 @@ static int cdns_uart_suspend(struct device *device)
 }
 
 /**
- * cdns_uart_resume - Resume after a previous suspend
+ * cdns_uart_resume() - Resume after a previous suspend
  * @device: Pointer to the device structure
  *
  * Return: 0
@@ -1454,7 +1454,7 @@ static int cdns_get_id(struct platform_device *pdev)
 }
 
 /**
- * cdns_uart_probe - Platform driver probe
+ * cdns_uart_probe() - Platform driver probe
  * @pdev: Pointer to the platform device structure
  *
  * Return: 0 on success, negative errno otherwise
@@ -1675,7 +1675,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 }
 
 /**
- * cdns_uart_remove - called when the platform driver is unregistered
+ * cdns_uart_remove() - called when the platform driver is unregistered
  * @pdev: Pointer to the platform device structure
  *
  * Return: 0 on success, negative errno otherwise
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 50f567b6a66e..54574c8d677e 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -83,10 +83,10 @@ static void tty_audit_log(const char *description, dev_t dev,
 }
 
 /**
- *	tty_audit_buf_push	-	Push buffered data out
+ * tty_audit_buf_push() - Push buffered data out
  *
- *	Generate an audit message from the contents of @buf, which is owned by
- *	the current task.  @buf->mutex must be locked.
+ * Generate an audit message from the contents of @buf, which is owned by
+ * the current task.  @buf->mutex must be locked.
  */
 static void tty_audit_buf_push(struct tty_audit_buf *buf)
 {
@@ -101,13 +101,13 @@ static void tty_audit_buf_push(struct tty_audit_buf *buf)
 }
 
 /**
- *	tty_audit_exit	-	Handle a task exit
+ * tty_audit_exit() - Handle a task exit
  *
- *	Make sure all buffered data is written out and deallocate the buffer.
- *	Only needs to be called if current->signal->tty_audit_buf != %NULL.
+ * Make sure all buffered data is written out and deallocate the buffer.
+ * Only needs to be called if current->signal->tty_audit_buf != %NULL.
  *
- *	The process is single-threaded at this point; no other threads share
- *	current->signal.
+ * The process is single-threaded at this point; no other threads share
+ * current->signal.
  */
 void tty_audit_exit(void)
 {
@@ -122,9 +122,9 @@ void tty_audit_exit(void)
 }
 
 /**
- *	tty_audit_fork	-	Copy TTY audit state for a new task
+ * tty_audit_fork() - Copy TTY audit state for a new task
  *
- *	Set up TTY audit state in @sig from current.  @sig needs no locking.
+ * Set up TTY audit state in @sig from current.  @sig needs no locking.
  */
 void tty_audit_fork(struct signal_struct *sig)
 {
@@ -132,7 +132,7 @@ void tty_audit_fork(struct signal_struct *sig)
 }
 
 /**
- *	tty_audit_tiocsti	-	Log TIOCSTI
+ * tty_audit_tiocsti() - Log TIOCSTI
  */
 void tty_audit_tiocsti(struct tty_struct *tty, char ch)
 {
@@ -147,9 +147,9 @@ void tty_audit_tiocsti(struct tty_struct *tty, char ch)
 }
 
 /**
- *	tty_audit_push	-	Flush current's pending audit data
+ * tty_audit_push() - Flush current's pending audit data
  *
- *	Returns 0 if success, -EPERM if tty audit is disabled
+ * Returns 0 if success, -EPERM if tty audit is disabled
  */
 int tty_audit_push(void)
 {
@@ -168,11 +168,11 @@ int tty_audit_push(void)
 }
 
 /**
- *	tty_audit_buf_get	-	Get an audit buffer.
+ * tty_audit_buf_get() - Get an audit buffer.
  *
- *	Get an audit buffer, allocate it if necessary.  Return %NULL
- *	if out of memory or ERR_PTR(-ESRCH) if tty_audit_exit() has already
- *	occurred.  Otherwise, return a new reference to the buffer.
+ * Get an audit buffer, allocate it if necessary.  Return %NULL
+ * if out of memory or ERR_PTR(-ESRCH) if tty_audit_exit() has already
+ * occurred.  Otherwise, return a new reference to the buffer.
  */
 static struct tty_audit_buf *tty_audit_buf_get(void)
 {
@@ -195,9 +195,9 @@ static struct tty_audit_buf *tty_audit_buf_get(void)
 }
 
 /**
- *	tty_audit_add_data	-	Add data for TTY auditing.
+ * tty_audit_add_data() - Add data for TTY auditing.
  *
- *	Audit @data of @size from @tty, if necessary.
+ * Audit @data of @size from @tty, if necessary.
  */
 void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size)
 {
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index ceee34760c62..a3c4969d4265 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -47,15 +47,15 @@ static const tcflag_t baud_bits[] = {
 static int n_baud_table = ARRAY_SIZE(baud_table);
 
 /**
- *	tty_termios_baud_rate
- *	@termios: termios structure
+ * tty_termios_baud_rate()
+ * @termios: termios structure
  *
- *	Convert termios baud rate data into a speed. This should be called
- *	with the termios lock held if this termios is a terminal termios
- *	structure. May change the termios data. Device drivers can call this
- *	function but should use ->c_[io]speed directly as they are updated.
+ * Convert termios baud rate data into a speed. This should be called
+ * with the termios lock held if this termios is a terminal termios
+ * structure. May change the termios data. Device drivers can call this
+ * function but should use ->c_[io]speed directly as they are updated.
  *
- *	Locking: none
+ * Locking: none
  */
 
 speed_t tty_termios_baud_rate(struct ktermios *termios)
@@ -82,15 +82,15 @@ speed_t tty_termios_baud_rate(struct ktermios *termios)
 EXPORT_SYMBOL(tty_termios_baud_rate);
 
 /**
- *	tty_termios_input_baud_rate
- *	@termios: termios structure
+ * tty_termios_input_baud_rate()
+ * @termios: termios structure
  *
- *	Convert termios baud rate data into a speed. This should be called
- *	with the termios lock held if this termios is a terminal termios
- *	structure. May change the termios data. Device drivers can call this
- *	function but should use ->c_[io]speed directly as they are updated.
+ * Convert termios baud rate data into a speed. This should be called
+ * with the termios lock held if this termios is a terminal termios
+ * structure. May change the termios data. Device drivers can call this
+ * function but should use ->c_[io]speed directly as they are updated.
  *
- *	Locking: none
+ * Locking: none
  */
 
 speed_t tty_termios_input_baud_rate(struct ktermios *termios)
@@ -121,25 +121,25 @@ speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 EXPORT_SYMBOL(tty_termios_input_baud_rate);
 
 /**
- *	tty_termios_encode_baud_rate
- *	@termios: ktermios structure holding user requested state
- *	@ispeed: input speed
- *	@ospeed: output speed
+ * tty_termios_encode_baud_rate()
+ * @termios: ktermios structure holding user requested state
+ * @ispeed: input speed
+ * @ospeed: output speed
  *
- *	Encode the speeds set into the passed termios structure. This is
- *	used as a library helper for drivers so that they can report back
- *	the actual speed selected when it differs from the speed requested
+ * Encode the speeds set into the passed termios structure. This is
+ * used as a library helper for drivers so that they can report back
+ * the actual speed selected when it differs from the speed requested
  *
- *	For maximal back compatibility with legacy SYS5/POSIX *nix behaviour
- *	we need to carefully set the bits when the user does not get the
- *	desired speed. We allow small margins and preserve as much of possible
- *	of the input intent to keep compatibility.
+ * For maximal back compatibility with legacy SYS5/POSIX *nix behaviour
+ * we need to carefully set the bits when the user does not get the
+ * desired speed. We allow small margins and preserve as much of possible
+ * of the input intent to keep compatibility.
  *
- *	Locking: Caller should hold termios lock. This is already held
- *	when calling this function from the driver termios handler.
+ * Locking: Caller should hold termios lock. This is already held
+ * when calling this function from the driver termios handler.
  *
- *	The ifdefs deal with platforms whose owners have yet to update them
- *	and will all go away once this is done.
+ * The ifdefs deal with platforms whose owners have yet to update them
+ * and will all go away once this is done.
  */
 
 void tty_termios_encode_baud_rate(struct ktermios *termios,
@@ -225,13 +225,13 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 EXPORT_SYMBOL_GPL(tty_termios_encode_baud_rate);
 
 /**
- *	tty_encode_baud_rate		-	set baud rate of the tty
- *	@ibaud: input baud rate
- *	@obad: output baud rate
+ * tty_encode_baud_rate() - set baud rate of the tty
+ * @ibaud: input baud rate
+ * @obad: output baud rate
  *
- *	Update the current termios data for the tty with the new speed
- *	settings. The caller must hold the termios_rwsem for the tty in
- *	question.
+ * Update the current termios data for the tty with the new speed
+ * settings. The caller must hold the termios_rwsem for the tty in
+ * question.
  */
 
 void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud, speed_t obaud)
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 77070c2d1240..bd08f2aa1da0 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -39,18 +39,18 @@
 #define TTY_BUFFER_PAGE	(((PAGE_SIZE - sizeof(struct tty_buffer)) / 2) & ~0xFF)
 
 /**
- *	tty_buffer_lock_exclusive	-	gain exclusive access to buffer
- *	tty_buffer_unlock_exclusive	-	release exclusive access
+ * tty_buffer_lock_exclusive() - gain exclusive access to buffer
+ * tty_buffer_unlock_exclusive() - release exclusive access
  *
- *	@port - tty_port owning the flip buffer
+ * @port - tty_port owning the flip buffer
  *
- *	Guarantees safe use of the line discipline's receive_buf() method by
- *	excluding the buffer work and any pending flush from using the flip
- *	buffer. Data can continue to be added concurrently to the flip buffer
- *	from the driver side.
+ * Guarantees safe use of the line discipline's receive_buf() method by
+ * excluding the buffer work and any pending flush from using the flip
+ * buffer. Data can continue to be added concurrently to the flip buffer
+ * from the driver side.
  *
- *	On release, the buffer work is restarted if there is data in the
- *	flip buffer
+ * On release, the buffer work is restarted if there is data in the
+ * flip buffer
  */
 
 void tty_buffer_lock_exclusive(struct tty_port *port)
@@ -77,15 +77,15 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
 EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
 /**
- *	tty_buffer_space_avail	-	return unused buffer space
- *	@port - tty_port owning the flip buffer
+ * tty_buffer_space_avail() - return unused buffer space
+ * @port - tty_port owning the flip buffer
  *
- *	Returns the # of bytes which can be written by the driver without
- *	reaching the buffer limit.
+ * Returns the # of bytes which can be written by the driver without
+ * reaching the buffer limit.
  *
- *	Note: this does not guarantee that memory is available to write
- *	the returned # of bytes (use tty_prepare_flip_string_xxx() to
- *	pre-allocate if memory guarantee is required).
+ * Note: this does not guarantee that memory is available to write
+ * the returned # of bytes (use tty_prepare_flip_string_xxx() to
+ * pre-allocate if memory guarantee is required).
  */
 
 int tty_buffer_space_avail(struct tty_port *port)
@@ -106,11 +106,11 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 }
 
 /**
- *	tty_buffer_free_all		-	free buffers used by a tty
- *	@tty: tty to free from
+ * tty_buffer_free_all() - free buffers used by a tty
+ * @tty: tty to free from
  *
- *	Remove all the buffers pending on a tty whether queued with data
- *	or in the free ring. Must be called when the tty is no longer in use
+ * Remove all the buffers pending on a tty whether queued with data
+ * or in the free ring. Must be called when the tty is no longer in use
  */
 
 void tty_buffer_free_all(struct tty_port *port)
@@ -141,15 +141,15 @@ void tty_buffer_free_all(struct tty_port *port)
 }
 
 /**
- *	tty_buffer_alloc	-	allocate a tty buffer
- *	@tty: tty device
- *	@size: desired size (characters)
+ * tty_buffer_alloc() - allocate a tty buffer
+ * @tty: tty device
+ * @size: desired size (characters)
  *
- *	Allocate a new tty buffer to hold the desired number of characters.
- *	We round our buffers off in 256 character chunks to get better
- *	allocation behaviour.
- *	Return NULL if out of memory or the allocation would exceed the
- *	per device queue
+ * Allocate a new tty buffer to hold the desired number of characters.
+ * We round our buffers off in 256 character chunks to get better
+ * allocation behaviour.
+ * Return NULL if out of memory or the allocation would exceed the
+ * per device queue
  */
 
 static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
@@ -183,12 +183,12 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 }
 
 /**
- *	tty_buffer_free		-	free a tty buffer
- *	@tty: tty owning the buffer
- *	@b: the buffer to free
+ * tty_buffer_free() - free a tty buffer
+ * @tty: tty owning the buffer
+ * @b: the buffer to free
  *
- *	Free a tty buffer, or add it to the free list according to our
- *	internal strategy
+ * Free a tty buffer, or add it to the free list according to our
+ * internal strategy
  */
 
 static void tty_buffer_free(struct tty_port *port, struct tty_buffer *b)
@@ -205,15 +205,15 @@ static void tty_buffer_free(struct tty_port *port, struct tty_buffer *b)
 }
 
 /**
- *	tty_buffer_flush		-	flush full tty buffers
- *	@tty: tty to flush
- *	@ld:  optional ldisc ptr (must be referenced)
+ * tty_buffer_flush() - flush full tty buffers
+ * @tty: tty to flush
+ * @ld: optional ldisc ptr (must be referenced)
  *
- *	flush all the buffers containing receive data. If ld != NULL,
- *	flush the ldisc input buffer.
+ * flush all the buffers containing receive data. If ld != NULL,
+ * flush the ldisc input buffer.
  *
- *	Locking: takes buffer lock to ensure single-threaded flip buffer
- *		 'consumer'
+ * Locking: takes buffer lock to ensure single-threaded flip buffer
+ * 	    'consumer'
  */
 
 void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
@@ -242,17 +242,17 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 }
 
 /**
- *	tty_buffer_request_room		-	grow tty buffer if needed
- *	@tty: tty structure
- *	@size: size desired
- *	@flags: buffer flags if new buffer allocated (default = 0)
+ * tty_buffer_request_room() - grow tty buffer if needed
+ * @tty: tty structure
+ * @size: size desired
+ * @flags: buffer flags if new buffer allocated (default = 0)
  *
- *	Make at least size bytes of linear space available for the tty
- *	buffer. If we fail return the size we managed to find.
+ * Make at least size bytes of linear space available for the tty
+ * buffer. If we fail return the size we managed to find.
  *
- *	Will change over to a new buffer if the current buffer is encoded as
- *	TTY_NORMAL (so has no flags buffer) and the new buffer requires
- *	a flags buffer.
+ * Will change over to a new buffer if the current buffer is encoded as
+ * TTY_NORMAL (so has no flags buffer) and the new buffer requires
+ * a flags buffer.
  */
 static int __tty_buffer_request_room(struct tty_port *port, size_t size,
 				     int flags)
@@ -298,14 +298,14 @@ int tty_buffer_request_room(struct tty_port *port, size_t size)
 EXPORT_SYMBOL_GPL(tty_buffer_request_room);
 
 /**
- *	tty_insert_flip_string_fixed_flag - Add characters to the tty buffer
- *	@port: tty port
- *	@chars: characters
- *	@flag: flag value for each character
- *	@size: size
+ * tty_insert_flip_string_fixed_flag() - Add characters to the tty buffer
+ * @port: tty port
+ * @chars: characters
+ * @flag: flag value for each character
+ * @size: size
  *
- *	Queue a series of bytes to the tty buffering. All the characters
- *	passed are marked with the supplied flag. Returns the number added.
+ * Queue a series of bytes to the tty buffering. All the characters
+ * passed are marked with the supplied flag. Returns the number added.
  */
 
 int tty_insert_flip_string_fixed_flag(struct tty_port *port,
@@ -333,15 +333,15 @@ int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 EXPORT_SYMBOL(tty_insert_flip_string_fixed_flag);
 
 /**
- *	tty_insert_flip_string_flags	-	Add characters to the tty buffer
- *	@port: tty port
- *	@chars: characters
- *	@flags: flag bytes
- *	@size: size
+ * tty_insert_flip_string_flags() - Add characters to the tty buffer
+ * @port: tty port
+ * @chars: characters
+ * @flags: flag bytes
+ * @size: size
  *
- *	Queue a series of bytes to the tty buffering. For each character
- *	the flags array indicates the status of the character. Returns the
- *	number added.
+ * Queue a series of bytes to the tty buffering. For each character
+ * the flags array indicates the status of the character. Returns the
+ * number added.
  */
 
 int tty_insert_flip_string_flags(struct tty_port *port,
@@ -368,13 +368,13 @@ int tty_insert_flip_string_flags(struct tty_port *port,
 EXPORT_SYMBOL(tty_insert_flip_string_flags);
 
 /**
- *	__tty_insert_flip_char   -	Add one character to the tty buffer
- *	@port: tty port
- *	@ch: character
- *	@flag: flag byte
+ * __tty_insert_flip_char() - Add one character to the tty buffer
+ * @port: tty port
+ * @ch: character
+ * @flag: flag byte
  *
- *	Queue a single byte to the tty buffering, with an optional flag.
- *	This is the slow path of tty_insert_flip_char.
+ * Queue a single byte to the tty buffering, with an optional flag.
+ * This is the slow path of tty_insert_flip_char.
  */
 int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag)
 {
@@ -394,12 +394,12 @@ int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag)
 EXPORT_SYMBOL(__tty_insert_flip_char);
 
 /**
- *	tty_schedule_flip	-	push characters to ldisc
- *	@port: tty port to push from
+ * tty_schedule_flip() - push characters to ldisc
+ * @port: tty port to push from
  *
- *	Takes any pending buffers and transfers their ownership to the
- *	ldisc side of the queue. It then schedules those characters for
- *	processing by the line discipline.
+ * Takes any pending buffers and transfers their ownership to the
+ * ldisc side of the queue. It then schedules those characters for
+ * processing by the line discipline.
  */
 
 void tty_schedule_flip(struct tty_port *port)
@@ -415,16 +415,16 @@ void tty_schedule_flip(struct tty_port *port)
 EXPORT_SYMBOL(tty_schedule_flip);
 
 /**
- *	tty_prepare_flip_string		-	make room for characters
- *	@port: tty port
- *	@chars: return pointer for character write area
- *	@size: desired size
+ * tty_prepare_flip_string() - make room for characters
+ * @port: tty port
+ * @chars: return pointer for character write area
+ * @size: desired size
  *
- *	Prepare a block of space in the buffer for data. Returns the length
- *	available and buffer pointer to the space which is now allocated and
- *	accounted for as ready for normal characters. This is used for drivers
- *	that need their own block copy routines into the buffer. There is no
- *	guarantee the buffer is a DMA target!
+ * Prepare a block of space in the buffer for data. Returns the length
+ * available and buffer pointer to the space which is now allocated and
+ * accounted for as ready for normal characters. This is used for drivers
+ * that need their own block copy routines into the buffer. There is no
+ * guarantee the buffer is a DMA target!
  */
 
 int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
@@ -443,16 +443,16 @@ int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
 EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
 
 /**
- *	tty_ldisc_receive_buf		-	forward data to line discipline
- *	@ld:	line discipline to process input
- *	@p:	char buffer
- *	@f:	TTY_* flags buffer
- *	@count:	number of bytes to process
+ * tty_ldisc_receive_buf() - forward data to line discipline
+ * @ld: line discipline to process input
+ * @p: char buffer
+ * @f: TTY_* flags buffer
+ * @count: number of bytes to process
  *
- *	Callers other than flush_to_ldisc() need to exclude the kworker
- *	from concurrent use of the line discipline, see paste_selection().
+ * Callers other than flush_to_ldisc() need to exclude the kworker
+ * from concurrent use of the line discipline, see paste_selection().
  *
- *	Returns the number of bytes processed
+ * Returns the number of bytes processed
  */
 int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 			  char *f, int count)
@@ -485,16 +485,16 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 }
 
 /**
- *	flush_to_ldisc
- *	@work: tty structure passed from work queue.
+ * flush_to_ldisc()
+ * @work: tty structure passed from work queue.
  *
- *	This routine is called out of the software interrupt to flush data
- *	from the buffer chain to the line discipline.
+ * This routine is called out of the software interrupt to flush data
+ * from the buffer chain to the line discipline.
  *
- *	The receive_buf method is single threaded for each tty instance.
+ * The receive_buf method is single threaded for each tty instance.
  *
- *	Locking: takes buffer lock to ensure single-threaded flip buffer
- *		 'consumer'
+ * Locking: takes buffer lock to ensure single-threaded flip buffer
+ * 	    'consumer'
  */
 
 static void flush_to_ldisc(struct work_struct *work)
@@ -541,14 +541,14 @@ static void flush_to_ldisc(struct work_struct *work)
 }
 
 /**
- *	tty_flip_buffer_push	-	terminal
- *	@port: tty port to push
+ * tty_flip_buffer_push() - terminal
+ * @port: tty port to push
  *
- *	Queue a push of the terminal flip buffers to the line discipline.
- *	Can be called from IRQ/atomic context.
+ * Queue a push of the terminal flip buffers to the line discipline.
+ * Can be called from IRQ/atomic context.
  *
- *	In the event of the queue being busy for flipping the work will be
- *	held off and retried later.
+ * In the event of the queue being busy for flipping the work will be
+ * held off and retried later.
  */
 
 void tty_flip_buffer_push(struct tty_port *port)
@@ -558,11 +558,11 @@ void tty_flip_buffer_push(struct tty_port *port)
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
 /**
- *	tty_buffer_init		-	prepare a tty buffer structure
- *	@tty: tty to initialise
+ * tty_buffer_init() - prepare a tty buffer structure
+ * @tty: tty to initialise
  *
- *	Set up the initial state of the buffer management for a tty device.
- *	Must be called before the other tty buffer functions are used.
+ * Set up the initial state of the buffer management for a tty device.
+ * Must be called before the other tty buffer functions are used.
  */
 
 void tty_buffer_init(struct tty_port *port)
@@ -581,11 +581,11 @@ void tty_buffer_init(struct tty_port *port)
 }
 
 /**
- *	tty_buffer_set_limit	-	change the tty buffer memory limit
- *	@port: tty port to change
+ * tty_buffer_set_limit() - change the tty buffer memory limit
+ * @port: tty port to change
  *
- *	Change the tty buffer memory limit.
- *	Must be called before the other tty buffer functions are used.
+ * Change the tty buffer memory limit.
+ * Must be called before the other tty buffer functions are used.
  */
 
 int tty_buffer_set_limit(struct tty_port *port, int limit)
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6e47e9a5e86d..1cf7ce8cd36c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -158,12 +158,12 @@ static int tty_fasync(int fd, struct file *filp, int on);
 static void release_tty(struct tty_struct *tty, int idx);
 
 /**
- *	free_tty_struct		-	free a disused tty
- *	@tty: tty struct to free
+ * free_tty_struct() - free a disused tty
+ * @tty: tty struct to free
  *
- *	Free the write buffers, tty queue and tty memory itself.
+ * Free the write buffers, tty queue and tty memory itself.
  *
- *	Locking: none. Must be called after tty is definitely unused
+ * Locking: none. Must be called after tty is definitely unused
  */
 
 static void free_tty_struct(struct tty_struct *tty)
@@ -207,7 +207,7 @@ void tty_add_file(struct tty_struct *tty, struct file *file)
 }
 
 /**
- * tty_free_file - free file->private_data
+ * tty_free_file() - free file->private_data
  *
  * This shall be used only for fail path handling when tty_add_file was not
  * called yet.
@@ -233,13 +233,13 @@ static void tty_del_file(struct file *file)
 }
 
 /**
- *	tty_name	-	return tty naming
- *	@tty: tty structure
+ * tty_name() - return tty naming
+ * @tty: tty structure
  *
- *	Convert a tty structure into a name. The name reflects the kernel
- *	naming policy and if udev is in use may not reflect user space
+ * Convert a tty structure into a name. The name reflects the kernel
+ * naming policy and if udev is in use may not reflect user space
  *
- *	Locking: none
+ * Locking: none
  */
 
 const char *tty_name(const struct tty_struct *tty)
@@ -304,14 +304,14 @@ static int check_tty_count(struct tty_struct *tty, const char *routine)
 }
 
 /**
- *	get_tty_driver		-	find device of a tty
- *	@dev_t: device identifier
- *	@index: returns the index of the tty
+ * get_tty_driver() - find device of a tty
+ * @dev_t: device identifier
+ * @index: returns the index of the tty
  *
- *	This routine returns a tty driver structure, given a device number
- *	and also passes back the index number.
+ * This routine returns a tty driver structure, given a device number
+ * and also passes back the index number.
  *
- *	Locking: caller must hold tty_mutex
+ * Locking: caller must hold tty_mutex
  */
 
 static struct tty_driver *get_tty_driver(dev_t device, int *index)
@@ -329,17 +329,17 @@ static struct tty_driver *get_tty_driver(dev_t device, int *index)
 }
 
 /**
- *	tty_dev_name_to_number	-	return dev_t for device name
- *	@name: user space name of device under /dev
- *	@number: pointer to dev_t that this function will populate
+ * tty_dev_name_to_number() - return dev_t for device name
+ * @name: user space name of device under /dev
+ * @number: pointer to dev_t that this function will populate
  *
- *	This function converts device names like ttyS0 or ttyUSB1 into dev_t
- *	like (4, 64) or (188, 1). If no corresponding driver is registered then
- *	the function returns -ENODEV.
+ * This function converts device names like ttyS0 or ttyUSB1 into dev_t
+ * like (4, 64) or (188, 1). If no corresponding driver is registered then
+ * the function returns -ENODEV.
  *
- *	Locking: this acquires tty_mutex to protect the tty_drivers list from
- *		being modified while we are traversing it, and makes sure to
- *		release it before exiting.
+ * Locking: this acquires tty_mutex to protect the tty_drivers list from
+ *          being modified while we are traversing it, and makes sure to
+ *          release it before exiting.
  */
 int tty_dev_name_to_number(const char *name, dev_t *number)
 {
@@ -381,13 +381,13 @@ EXPORT_SYMBOL_GPL(tty_dev_name_to_number);
 #ifdef CONFIG_CONSOLE_POLL
 
 /**
- *	tty_find_polling_driver	-	find device of a polled tty
- *	@name: name string to match
- *	@line: pointer to resulting tty line nr
+ * tty_find_polling_driver() - find device of a polled tty
+ * @name: name string to match
+ * @line: pointer to resulting tty line nr
  *
- *	This routine returns a tty driver structure, given a name
- *	and the condition that the tty driver is capable of polled
- *	operation.
+ * This routine returns a tty driver structure, given a name
+ * and the condition that the tty driver is capable of polled
+ * operation.
  */
 struct tty_driver *tty_find_polling_driver(char *name, int *line)
 {
@@ -513,12 +513,12 @@ static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
 /**
- *	tty_wakeup	-	request more data
- *	@tty: terminal
+ * tty_wakeup() - request more data
+ * @tty: terminal
  *
- *	Internal and external helper for wakeups of tty. This function
- *	informs the line discipline if present that the driver is ready
- *	to receive more output data.
+ * Internal and external helper for wakeups of tty. This function
+ * informs the line discipline if present that the driver is ready
+ * to receive more output data.
  */
 
 void tty_wakeup(struct tty_struct *tty)
@@ -539,26 +539,26 @@ void tty_wakeup(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_wakeup);
 
 /**
- *	__tty_hangup		-	actual handler for hangup events
- *	@work: tty device
- *
- *	This can be called by a "kworker" kernel thread.  That is process
- *	synchronous but doesn't hold any locks, so we need to make sure we
- *	have the appropriate locks for what we're doing.
- *
- *	The hangup event clears any pending redirections onto the hung up
- *	device. It ensures future writes will error and it does the needed
- *	line discipline hangup and signal delivery. The tty object itself
- *	remains intact.
- *
- *	Locking:
- *		BTM
- *		  redirect lock for undoing redirection
- *		  file list lock for manipulating list of ttys
- *		  tty_ldiscs_lock from called functions
- *		  termios_rwsem resetting termios data
- *		  tasklist_lock to walk task list for hangup event
- *		    ->siglock to protect ->signal/->sighand
+ * __tty_hangup() - actual handler for hangup events
+ * @work: tty device
+ *
+ * This can be called by a "kworker" kernel thread.  That is process
+ * synchronous but doesn't hold any locks, so we need to make sure we
+ * have the appropriate locks for what we're doing.
+ *
+ * The hangup event clears any pending redirections onto the hung up
+ * device. It ensures future writes will error and it does the needed
+ * line discipline hangup and signal delivery. The tty object itself
+ * remains intact.
+ *
+ * Locking:
+ *         BTM
+ *           redirect lock for undoing redirection
+ *           file list lock for manipulating list of ttys
+ *           tty_ldiscs_lock from called functions
+ *           termios_rwsem resetting termios data
+ *           tasklist_lock to walk task list for hangup event
+ *           ->siglock to protect ->signal/->sighand
  */
 static void __tty_hangup(struct tty_struct *tty, int exit_session)
 {
@@ -664,11 +664,11 @@ static void do_tty_hangup(struct work_struct *work)
 }
 
 /**
- *	tty_hangup		-	trigger a hangup event
- *	@tty: tty to hangup
+ * tty_hangup() - trigger a hangup event
+ * @tty: tty to hangup
  *
- *	A carrier loss (virtual or otherwise) has occurred on this like
- *	schedule a hangup sequence to run after this event.
+ * A carrier loss (virtual or otherwise) has occurred on this like
+ * schedule a hangup sequence to run after this event.
  */
 
 void tty_hangup(struct tty_struct *tty)
@@ -680,12 +680,12 @@ void tty_hangup(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_hangup);
 
 /**
- *	tty_vhangup		-	process vhangup
- *	@tty: tty to hangup
+ * tty_vhangup() - process vhangup
+ * @tty: tty to hangup
  *
- *	The user has asked via system call for the terminal to be hung up.
- *	We do this synchronously so that when the syscall returns the process
- *	is complete. That guarantee is necessary for security reasons.
+ * The user has asked via system call for the terminal to be hung up.
+ * We do this synchronously so that when the syscall returns the process
+ * is complete. That guarantee is necessary for security reasons.
  */
 
 void tty_vhangup(struct tty_struct *tty)
@@ -698,9 +698,9 @@ EXPORT_SYMBOL(tty_vhangup);
 
 
 /**
- *	tty_vhangup_self	-	process vhangup for own ctty
+ * tty_vhangup_self() - process vhangup for own ctty
  *
- *	Perform a vhangup on the current controlling tty
+ * Perform a vhangup on the current controlling tty
  */
 
 void tty_vhangup_self(void)
@@ -715,14 +715,14 @@ void tty_vhangup_self(void)
 }
 
 /**
- *	tty_vhangup_session		-	hangup session leader exit
- *	@tty: tty to hangup
+ * tty_vhangup_session() - hangup session leader exit
+ * @tty: tty to hangup
  *
- *	The session leader is exiting and hanging up its controlling terminal.
- *	Every process in the foreground process group is signalled SIGHUP.
+ * The session leader is exiting and hanging up its controlling terminal.
+ * Every process in the foreground process group is signalled SIGHUP.
  *
- *	We do this synchronously so that when the syscall returns the process
- *	is complete. That guarantee is necessary for security reasons.
+ * We do this synchronously so that when the syscall returns the process
+ * is complete. That guarantee is necessary for security reasons.
  */
 
 void tty_vhangup_session(struct tty_struct *tty)
@@ -732,11 +732,11 @@ void tty_vhangup_session(struct tty_struct *tty)
 }
 
 /**
- *	tty_hung_up_p		-	was tty hung up
- *	@filp: file pointer of tty
+ * tty_hung_up_p() - was tty hung up
+ * @filp: file pointer of tty
  *
- *	Return true if the tty has been subject to a vhangup or a carrier
- *	loss
+ * Return true if the tty has been subject to a vhangup or a carrier
+ * loss
  */
 
 int tty_hung_up_p(struct file *filp)
@@ -747,20 +747,20 @@ int tty_hung_up_p(struct file *filp)
 EXPORT_SYMBOL(tty_hung_up_p);
 
 /**
- *	stop_tty	-	propagate flow control
- *	@tty: tty to stop
+ * stop_tty() - propagate flow control
+ * @tty: tty to stop
  *
- *	Perform flow control to the driver. May be called
- *	on an already stopped device and will not re-call the driver
- *	method.
+ * Perform flow control to the driver. May be called
+ * on an already stopped device and will not re-call the driver
+ * method.
  *
- *	This functionality is used by both the line disciplines for
- *	halting incoming flow and by the driver. It may therefore be
- *	called from any context, may be under the tty atomic_write_lock
- *	but not always.
+ * This functionality is used by both the line disciplines for
+ * halting incoming flow and by the driver. It may therefore be
+ * called from any context, may be under the tty atomic_write_lock
+ * but not always.
  *
- *	Locking:
- *		flow_lock
+ * Locking:
+ *         flow_lock
  */
 
 void __stop_tty(struct tty_struct *tty)
@@ -783,15 +783,15 @@ void stop_tty(struct tty_struct *tty)
 EXPORT_SYMBOL(stop_tty);
 
 /**
- *	start_tty	-	propagate flow control
- *	@tty: tty to start
+ * start_tty() - propagate flow control
+ * @tty: tty to start
  *
- *	Start a tty that has been stopped if at all possible. If this
- *	tty was previous stopped and is now being started, the driver
- *	start method is invoked and the line discipline woken.
+ * Start a tty that has been stopped if at all possible. If this
+ * tty was previous stopped and is now being started, the driver
+ * start method is invoked and the line discipline woken.
  *
- *	Locking:
- *		flow_lock
+ * Locking:
+ *         flow_lock
  */
 
 void __start_tty(struct tty_struct *tty)
@@ -829,18 +829,18 @@ static void tty_update_time(struct timespec64 *time)
 }
 
 /**
- *	tty_read	-	read method for tty device files
- *	@file: pointer to tty file
- *	@buf: user buffer
- *	@count: size of user buffer
- *	@ppos: unused
+ * tty_read() - read method for tty device files
+ * @file: pointer to tty file
+ * @buf: user buffer
+ * @count: size of user buffer
+ * @ppos: unused
  *
- *	Perform the read system call function on this terminal device. Checks
- *	for hung up devices before calling the line discipline method.
+ * Perform the read system call function on this terminal device. Checks
+ * for hung up devices before calling the line discipline method.
  *
- *	Locking:
- *		Locks the line discipline internally while needed. Multiple
- *	read calls may be outstanding in parallel.
+ * Locking:
+ *         Locks the line discipline internally while needed. Multiple
+ * read calls may be outstanding in parallel.
  */
 
 static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
@@ -978,7 +978,7 @@ static inline ssize_t do_tty_write(
 }
 
 /**
- * tty_write_message - write a message to a certain tty, not just the console.
+ * tty_write_message() - write a message to a certain tty, not just the console.
  * @tty: the destination tty_struct
  * @msg: the message to write
  *
@@ -1004,19 +1004,19 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 
 
 /**
- *	tty_write		-	write method for tty device file
- *	@file: tty file pointer
- *	@buf: user data to write
- *	@count: bytes to write
- *	@ppos: unused
+ * tty_write() - write method for tty device file
+ * @file: tty file pointer
+ * @buf: user data to write
+ * @count: bytes to write
+ * @ppos: unused
  *
- *	Write data to a tty device via the line discipline.
+ * Write data to a tty device via the line discipline.
  *
- *	Locking:
- *		Locks the line discipline as required
- *		Writes to the tty driver are serialized by the atomic_write_lock
- *	and are then processed in chunks to the device. The line discipline
- *	write method will not be invoked in parallel for each device.
+ * Locking:
+ *         Locks the line discipline as required
+ *         Writes to the tty driver are serialized by the atomic_write_lock
+ * and are then processed in chunks to the device. The line discipline
+ * write method will not be invoked in parallel for each device.
  */
 
 static ssize_t tty_write(struct file *file, const char __user *buf,
@@ -1064,11 +1064,11 @@ ssize_t redirected_tty_write(struct file *file, const char __user *buf,
 }
 
 /**
- *	tty_send_xchar	-	send priority character
+ * tty_send_xchar() - send priority character
  *
- *	Send a high priority character to the tty even if stopped
+ * Send a high priority character to the tty even if stopped
  *
- *	Locking: none for xchar method, write ordering for write method.
+ * Locking: none for xchar method, write ordering for write method.
  */
 
 int tty_send_xchar(struct tty_struct *tty, char ch)
@@ -1099,15 +1099,15 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
 static char ptychar[] = "pqrstuvwxyzabcde";
 
 /**
- *	pty_line_name	-	generate name for a pty
- *	@driver: the tty driver in use
- *	@index: the minor number
- *	@p: output buffer of at least 6 bytes
+ * pty_line_name() - generate name for a pty
+ * @driver: the tty driver in use
+ * @index: the minor number
+ * @p: output buffer of at least 6 bytes
  *
- *	Generate a name from a driver reference and write it to the output
- *	buffer.
+ * Generate a name from a driver reference and write it to the output
+ * buffer.
  *
- *	Locking: None
+ * Locking: None
  */
 static void pty_line_name(struct tty_driver *driver, int index, char *p)
 {
@@ -1119,15 +1119,15 @@ static void pty_line_name(struct tty_driver *driver, int index, char *p)
 }
 
 /**
- *	tty_line_name	-	generate name for a tty
- *	@driver: the tty driver in use
- *	@index: the minor number
- *	@p: output buffer of at least 7 bytes
+ * tty_line_name() - generate name for a tty
+ * @driver: the tty driver in use
+ * @index: the minor number
+ * @p: output buffer of at least 7 bytes
  *
- *	Generate a name from a driver reference and write it to the output
- *	buffer.
+ * Generate a name from a driver reference and write it to the output
+ * buffer.
  *
- *	Locking: None
+ * Locking: None
  */
 static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 {
@@ -1139,14 +1139,14 @@ static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 }
 
 /**
- *	tty_driver_lookup_tty() - find an existing tty, if any
- *	@driver: the driver for the tty
- *	@idx:	 the minor number
+ * tty_driver_lookup_tty() - find an existing tty, if any
+ * @driver: the driver for the tty
+ * @idx: the minor number
  *
- *	Return the tty, if found. If not found, return NULL or ERR_PTR() if the
- *	driver lookup() method returns an error.
+ * Return the tty, if found. If not found, return NULL or ERR_PTR() if the
+ * driver lookup() method returns an error.
  *
- *	Locking: tty_mutex must be held. If the tty is found, bump the tty kref.
+ * Locking: tty_mutex must be held. If the tty is found, bump the tty kref.
  */
 static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 		struct file *file, int idx)
@@ -1167,11 +1167,11 @@ static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 }
 
 /**
- *	tty_init_termios	-  helper for termios setup
- *	@tty: the tty to set up
+ * tty_init_termios() - helper for termios setup
+ * @tty: the tty to set up
  *
- *	Initialise the termios structures for this tty. Thus runs under
- *	the tty_mutex currently so we can be relaxed about ordering.
+ * Initialise the termios structures for this tty. Thus runs under
+ * the tty_mutex currently so we can be relaxed about ordering.
  */
 
 void tty_init_termios(struct tty_struct *tty)
@@ -1207,16 +1207,16 @@ int tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_standard_install);
 
 /**
- *	tty_driver_install_tty() - install a tty entry in the driver
- *	@driver: the driver for the tty
- *	@tty: the tty
+ * tty_driver_install_tty() - install a tty entry in the driver
+ * @driver: the driver for the tty
+ * @tty: the tty
  *
- *	Install a tty object into the driver tables. The tty->index field
- *	will be set by the time this is called. This method is responsible
- *	for ensuring any need additional structures are allocated and
- *	configured.
+ * Install a tty object into the driver tables. The tty->index field
+ * will be set by the time this is called. This method is responsible
+ * for ensuring any need additional structures are allocated and
+ * configured.
  *
- *	Locking: tty_mutex for now
+ * Locking: tty_mutex for now
  */
 static int tty_driver_install_tty(struct tty_driver *driver,
 						struct tty_struct *tty)
@@ -1226,14 +1226,14 @@ static int tty_driver_install_tty(struct tty_driver *driver,
 }
 
 /**
- *	tty_driver_remove_tty() - remove a tty from the driver tables
- *	@driver: the driver for the tty
- *	@idx:	 the minor number
+ * tty_driver_remove_tty() - remove a tty from the driver tables
+ * @driver: the driver for the tty
+ * @idx: the minor number
  *
- *	Remvoe a tty object from the driver tables. The tty->index field
- *	will be set by the time this is called.
+ * Remvoe a tty object from the driver tables. The tty->index field
+ * will be set by the time this is called.
  *
- *	Locking: tty_mutex for now
+ * Locking: tty_mutex for now
  */
 static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *tty)
 {
@@ -1247,10 +1247,10 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
  *	tty_reopen()	- fast re-open of an open tty
  *	@tty	- the tty to open
  *
- *	Return 0 on success, -errno on error.
- *	Re-opens on master ptys are not allowed and return -EIO.
+ * Return 0 on success, -errno on error.
+ * Re-opens on master ptys are not allowed and return -EIO.
  *
- *	Locking: Caller must hold tty_lock
+ * Locking: Caller must hold tty_lock
  */
 static int tty_reopen(struct tty_struct *tty)
 {
@@ -1280,22 +1280,22 @@ static int tty_reopen(struct tty_struct *tty)
 }
 
 /**
- *	tty_init_dev		-	initialise a tty device
- *	@driver: tty driver we are opening a device on
- *	@idx: device index
- *	@ret_tty: returned tty structure
+ * tty_init_dev() - initialise a tty device
+ * @driver: tty driver we are opening a device on
+ * @idx: device index
+ * @ret_tty: returned tty structure
  *
- *	Prepare a tty device. This may not be a "new" clean device but
- *	could also be an active device. The pty drivers require special
- *	handling because of this.
+ * Prepare a tty device. This may not be a "new" clean device but
+ * could also be an active device. The pty drivers require special
+ * handling because of this.
  *
- *	Locking:
- *		The function is called under the tty_mutex, which
- *	protects us from the tty struct or driver itself going away.
+ * Locking:
+ *         The function is called under the tty_mutex, which
+ * protects us from the tty struct or driver itself going away.
  *
- *	On exit the tty device has the line discipline attached and
- *	a reference count of 1. If a pair was created for pty/tty use
- *	and the other was a pty master then it too has a reference count of 1.
+ * On exit the tty device has the line discipline attached and
+ * a reference count of 1. If a pair was created for pty/tty use
+ * and the other was a pty master then it too has a reference count of 1.
  *
  * WSH 06/09/97: Rewritten to remove races and properly clean up after a
  * failed open.  The new code protects the open with a mutex, so it's
@@ -1393,10 +1393,10 @@ static void tty_free_termios(struct tty_struct *tty)
 }
 
 /**
- *	tty_flush_works		-	flush all works of a tty/pty pair
- *	@tty: tty device to flush works for (or either end of a pty pair)
+ * tty_flush_works() - flush all works of a tty/pty pair
+ * @tty: tty device to flush works for (or either end of a pty pair)
  *
- *	Sync flush all works belonging to @tty (and the 'other' tty).
+ * Sync flush all works belonging to @tty (and the 'other' tty).
  */
 static void tty_flush_works(struct tty_struct *tty)
 {
@@ -1409,19 +1409,19 @@ static void tty_flush_works(struct tty_struct *tty)
 }
 
 /**
- *	release_one_tty		-	release tty structure memory
- *	@kref: kref of tty we are obliterating
+ * release_one_tty() - release tty structure memory
+ * @kref: kref of tty we are obliterating
  *
- *	Releases memory associated with a tty structure, and clears out the
- *	driver table slots. This function is called when a device is no longer
- *	in use. It also gets called when setup of a device fails.
+ * Releases memory associated with a tty structure, and clears out the
+ * driver table slots. This function is called when a device is no longer
+ * in use. It also gets called when setup of a device fails.
  *
- *	Locking:
- *		takes the file list lock internally when working on the list
- *	of ttys that the driver keeps.
+ * Locking:
+ *         takes the file list lock internally when working on the list
+ * of ttys that the driver keeps.
  *
- *	This method gets called from a work queue so that the driver private
- *	cleanup ops can sleep (needed for USB at least)
+ * This method gets called from a work queue so that the driver private
+ * cleanup ops can sleep (needed for USB at least)
  */
 static void release_one_tty(struct work_struct *work)
 {
@@ -1457,11 +1457,11 @@ static void queue_release_one_tty(struct kref *kref)
 }
 
 /**
- *	tty_kref_put		-	release a tty kref
- *	@tty: tty device
+ * tty_kref_put() - release a tty kref
+ * @tty: tty device
  *
- *	Release a reference to a tty device and if need be let the kref
- *	layer destruct the object for us
+ * Release a reference to a tty device and if need be let the kref
+ * layer destruct the object for us
  */
 
 void tty_kref_put(struct tty_struct *tty)
@@ -1472,15 +1472,15 @@ void tty_kref_put(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_kref_put);
 
 /**
- *	release_tty		-	release tty structure memory
+ * release_tty() - release tty structure memory
  *
- *	Release both @tty and a possible linked partner (think pty pair),
- *	and decrement the refcount of the backing module.
+ * Release both @tty and a possible linked partner (think pty pair),
+ * and decrement the refcount of the backing module.
  *
- *	Locking:
- *		tty_mutex
- *		takes the file list lock internally when working on the list
- *	of ttys that the driver keeps.
+ * Locking:
+ *         tty_mutex
+ *         takes the file list lock internally when working on the list
+ * of ttys that the driver keeps.
  *
  */
 static void release_tty(struct tty_struct *tty, int idx)
@@ -1504,13 +1504,13 @@ static void release_tty(struct tty_struct *tty, int idx)
 }
 
 /**
- *	tty_release_checks - check a tty before real release
- *	@tty: tty to check
- *	@o_tty: link of @tty (if any)
- *	@idx: index of the tty
+ * tty_release_checks() - check a tty before real release
+ * @tty: tty to check
+ * @o_tty: link of @tty (if any)
+ * @idx: index of the tty
  *
- *	Performs some paranoid checking before true release of the @tty.
- *	This is a no-op unless TTY_PARANOIA_CHECK is defined.
+ * Performs some paranoid checking before true release of the @tty.
+ * This is a no-op unless TTY_PARANOIA_CHECK is defined.
  */
 static int tty_release_checks(struct tty_struct *tty, int idx)
 {
@@ -1547,12 +1547,12 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 }
 
 /**
- *      tty_kclose      -       closes tty opened by tty_kopen
- *      @tty: tty device
+ * tty_kclose() - closes tty opened by tty_kopen
+ * @tty: tty device
  *
- *      Performs the final steps to release and free a tty device. It is the
- *      same as tty_release_struct except that it also resets TTY_PORT_KOPENED
- *      flag on tty->port.
+ * Performs the final steps to release and free a tty device. It is the
+ * same as tty_release_struct except that it also resets TTY_PORT_KOPENED
+ * flag on tty->port.
  */
 void tty_kclose(struct tty_struct *tty)
 {
@@ -1579,12 +1579,12 @@ void tty_kclose(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_kclose);
 
 /**
- *	tty_release_struct	-	release a tty struct
- *	@tty: tty device
- *	@idx: index of the tty
+ * tty_release_struct() - release a tty struct
+ * @tty: tty device
+ * @idx: index of the tty
  *
- *	Performs the final steps to release and free a tty device. It is
- *	roughly the reverse of tty_init_dev.
+ * Performs the final steps to release and free a tty device. It is
+ * roughly the reverse of tty_init_dev.
  */
 void tty_release_struct(struct tty_struct *tty, int idx)
 {
@@ -1610,15 +1610,15 @@ void tty_release_struct(struct tty_struct *tty, int idx)
 EXPORT_SYMBOL_GPL(tty_release_struct);
 
 /**
- *	tty_release		-	vfs callback for close
- *	@inode: inode of tty
- *	@filp: file pointer for handle to tty
+ * tty_release() - vfs callback for close
+ * @inode: inode of tty
+ * @filp: file pointer for handle to tty
  *
- *	Called the last time each file handle is closed that references
- *	this tty. There may however be several such references.
+ * Called the last time each file handle is closed that references
+ * this tty. There may however be several such references.
  *
- *	Locking:
- *		Takes bkl. See tty_release_dev
+ * Locking:
+ *         Takes bkl. See tty_release_dev
  *
  * Even releasing the tty structures is a tricky business.. We have
  * to be very careful that the structures are all released at the
@@ -1769,15 +1769,15 @@ int tty_release(struct inode *inode, struct file *filp)
 }
 
 /**
- *	tty_open_current_tty - get locked tty of current task
- *	@device: device number
- *	@filp: file pointer to tty
- *	@return: locked tty of the current task iff @device is /dev/tty
+ * tty_open_current_tty() - get locked tty of current task
+ * @device: device number
+ * @filp: file pointer to tty
+ * @return: locked tty of the current task iff @device is /dev/tty
  *
- *	Performs a re-open of the current task's controlling tty.
+ * Performs a re-open of the current task's controlling tty.
  *
- *	We cannot return driver and index like for the other nodes because
- *	devpts will not work then. It expects inodes to be from devpts FS.
+ * We cannot return driver and index like for the other nodes because
+ * devpts will not work then. It expects inodes to be from devpts FS.
  */
 static struct tty_struct *tty_open_current_tty(dev_t device, struct file *filp)
 {
@@ -1805,16 +1805,16 @@ static struct tty_struct *tty_open_current_tty(dev_t device, struct file *filp)
 }
 
 /**
- *	tty_lookup_driver - lookup a tty driver for a given device file
- *	@device: device number
- *	@filp: file pointer to tty
- *	@index: index for the device in the @return driver
- *	@return: driver for this inode (with increased refcount)
+ * tty_lookup_driver() - lookup a tty driver for a given device file
+ * @device: device number
+ * @filp: file pointer to tty
+ * @index: index for the device in the @return driver
+ * @return: driver for this inode (with increased refcount)
  *
  *	If @return is not erroneous, the caller is responsible to decrement the
  *	refcount by tty_driver_kref_put.
  *
- *	Locking: tty_mutex protects get_tty_driver
+ * Locking: tty_mutex protects get_tty_driver
  */
 static struct tty_driver *tty_lookup_driver(dev_t device, struct file *filp,
 		int *index)
@@ -1852,19 +1852,19 @@ static struct tty_driver *tty_lookup_driver(dev_t device, struct file *filp,
 }
 
 /**
- *	tty_kopen	-	open a tty device for kernel
- *	@device: dev_t of device to open
+ * tty_kopen() - open a tty device for kernel
+ * @device: dev_t of device to open
  *
- *	Opens tty exclusively for kernel. Performs the driver lookup,
- *	makes sure it's not already opened and performs the first-time
- *	tty initialization.
+ * Opens tty exclusively for kernel. Performs the driver lookup,
+ * makes sure it's not already opened and performs the first-time
+ * tty initialization.
  *
- *	Returns the locked initialized &tty_struct
+ * Returns the locked initialized &tty_struct
  *
- *	Claims the global tty_mutex to serialize:
- *	  - concurrent first-time tty initialization
- *	  - concurrent tty driver removal w/ lookup
- *	  - concurrent tty removal from driver table
+ * Claims the global tty_mutex to serialize:
+ *   - concurrent first-time tty initialization
+ *   - concurrent tty driver removal w/ lookup
+ *   - concurrent tty removal from driver table
  */
 struct tty_struct *tty_kopen(dev_t device)
 {
@@ -1902,20 +1902,20 @@ struct tty_struct *tty_kopen(dev_t device)
 EXPORT_SYMBOL_GPL(tty_kopen);
 
 /**
- *	tty_open_by_driver	-	open a tty device
- *	@device: dev_t of device to open
- *	@inode: inode of device file
- *	@filp: file pointer to tty
+ * tty_open_by_driver() - open a tty device
+ * @device: dev_t of device to open
+ * @inode: inode of device file
+ * @filp: file pointer to tty
  *
- *	Performs the driver lookup, checks for a reopen, or otherwise
- *	performs the first-time tty initialization.
+ * Performs the driver lookup, checks for a reopen, or otherwise
+ * performs the first-time tty initialization.
  *
- *	Returns the locked initialized or re-opened &tty_struct
+ * Returns the locked initialized or re-opened &tty_struct
  *
- *	Claims the global tty_mutex to serialize:
- *	  - concurrent first-time tty initialization
- *	  - concurrent tty driver removal w/ lookup
- *	  - concurrent tty removal from driver table
+ * Claims the global tty_mutex to serialize:
+ *   - concurrent first-time tty initialization
+ *   - concurrent tty driver removal w/ lookup
+ *   - concurrent tty removal from driver table
  */
 static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
 					     struct file *filp)
@@ -1970,27 +1970,27 @@ static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
 }
 
 /**
- *	tty_open		-	open a tty device
- *	@inode: inode of device file
- *	@filp: file pointer to tty
+ * tty_open() - open a tty device
+ * @inode: inode of device file
+ * @filp: file pointer to tty
  *
- *	tty_open and tty_release keep up the tty count that contains the
- *	number of opens done on a tty. We cannot use the inode-count, as
- *	different inodes might point to the same tty.
+ * tty_open and tty_release keep up the tty count that contains the
+ * number of opens done on a tty. We cannot use the inode-count, as
+ * different inodes might point to the same tty.
  *
- *	Open-counting is needed for pty masters, as well as for keeping
- *	track of serial lines: DTR is dropped when the last close happens.
- *	(This is not done solely through tty->count, now.  - Ted 1/27/92)
+ * Open-counting is needed for pty masters, as well as for keeping
+ * track of serial lines: DTR is dropped when the last close happens.
+ * (This is not done solely through tty->count, now.  - Ted 1/27/92)
  *
- *	The termios state of a pty is reset on first open so that
- *	settings don't persist across reuse.
+ * The termios state of a pty is reset on first open so that
+ * settings don't persist across reuse.
  *
- *	Locking: tty_mutex protects tty, tty_lookup_driver and tty_init_dev.
- *		 tty->count should protect the rest.
- *		 ->siglock protects ->signal/->sighand
+ * Locking: tty_mutex protects tty, tty_lookup_driver and tty_init_dev.
+ * 	 tty->count should protect the rest.
+ * 	 ->siglock protects ->signal/->sighand
  *
- *	Note: the tty_unlock/lock cases without a ref are only safe due to
- *	tty_mutex
+ * Note: the tty_unlock/lock cases without a ref are only safe due to
+ * tty_mutex
  */
 
 static int tty_open(struct inode *inode, struct file *filp)
@@ -2066,15 +2066,15 @@ static int tty_open(struct inode *inode, struct file *filp)
 
 
 /**
- *	tty_poll	-	check tty status
- *	@filp: file being polled
- *	@wait: poll wait structures to update
+ * tty_poll() - check tty status
+ * @filp: file being polled
+ * @wait: poll wait structures to update
  *
- *	Call the line discipline polling method to obtain the poll
- *	status of the device.
+ * Call the line discipline polling method to obtain the poll
+ * status of the device.
  *
- *	Locking: locks called line discipline but ldisc poll method
- *	may be re-entered freely by other callers.
+ * Locking: locks called line discipline but ldisc poll method
+ * may be re-entered freely by other callers.
  */
 
 static __poll_t tty_poll(struct file *filp, poll_table *wait)
@@ -2144,20 +2144,20 @@ static int tty_fasync(int fd, struct file *filp, int on)
 }
 
 /**
- *	tiocsti			-	fake input character
- *	@tty: tty to fake input into
- *	@p: pointer to character
+ * tiocsti() - fake input character
+ * @tty: tty to fake input into
+ * @p: pointer to character
  *
- *	Fake input to a tty device. Does the necessary locking and
- *	input management.
+ * Fake input to a tty device. Does the necessary locking and
+ * input management.
  *
- *	FIXME: does not honour flow control ??
+ * FIXME: does not honour flow control ??
  *
- *	Locking:
- *		Called functions take tty_ldiscs_lock
- *		current->signal->tty check is safe without locks
+ * Locking:
+ *         Called functions take tty_ldiscs_lock
+ *         current->signal->tty check is safe without locks
  *
- *	FIXME: may race normal receive processing
+ * FIXME: may race normal receive processing
  */
 
 static int tiocsti(struct tty_struct *tty, char __user *p)
@@ -2179,14 +2179,14 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 }
 
 /**
- *	tiocgwinsz		-	implement window query ioctl
- *	@tty; tty
- *	@arg: user buffer for result
+ * tiocgwinsz() - implement window query ioctl
+ * @tty; tty
+ * @arg: user buffer for result
  *
- *	Copies the kernel idea of the window size into the user buffer.
+ * Copies the kernel idea of the window size into the user buffer.
  *
- *	Locking: tty->winsize_mutex is taken to ensure the winsize data
- *		is consistent.
+ * Locking: tty->winsize_mutex is taken to ensure the winsize data
+ *          is consistent.
  */
 
 static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
@@ -2201,13 +2201,13 @@ static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 }
 
 /**
- *	tty_do_resize		-	resize event
- *	@tty: tty being resized
- *	@rows: rows (character)
- *	@cols: cols (character)
+ * tty_do_resize() - resize event
+ * @tty: tty being resized
+ * @rows: rows (character)
+ * @cols: cols (character)
  *
- *	Update the termios variables and send the necessary signals to
- *	peform a terminal resize correctly
+ * Update the termios variables and send the necessary signals to
+ * peform a terminal resize correctly
  */
 
 int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
@@ -2233,18 +2233,18 @@ int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
 EXPORT_SYMBOL(tty_do_resize);
 
 /**
- *	tiocswinsz		-	implement window size set ioctl
- *	@tty; tty side of tty
- *	@arg: user buffer for result
+ * tiocswinsz() - implement window size set ioctl
+ * @tty; tty side of tty
+ * @arg: user buffer for result
  *
- *	Copies the user idea of the window size to the kernel. Traditionally
- *	this is just advisory information but for the Linux console it
- *	actually has driver level meaning and triggers a VC resize.
+ * Copies the user idea of the window size to the kernel. Traditionally
+ * this is just advisory information but for the Linux console it
+ * actually has driver level meaning and triggers a VC resize.
  *
- *	Locking:
- *		Driver dependent. The default do_resize method takes the
- *	tty termios mutex and ctrl_lock. The console takes its own lock
- *	then calls into the default method.
+ * Locking:
+ *         Driver dependent. The default do_resize method takes the
+ * tty termios mutex and ctrl_lock. The console takes its own lock
+ * then calls into the default method.
  */
 
 static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
@@ -2260,12 +2260,12 @@ static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
 }
 
 /**
- *	tioccons	-	allow admin to move logical console
- *	@file: the file to become console
+ * tioccons() - allow admin to move logical console
+ * @file: the file to become console
  *
- *	Allow the administrator to move the redirected console device
+ * Allow the administrator to move the redirected console device
  *
- *	Locking: uses redirect_lock to guard the redirect information
+ * Locking: uses redirect_lock to guard the redirect information
  */
 
 static int tioccons(struct file *file)
@@ -2293,15 +2293,15 @@ static int tioccons(struct file *file)
 }
 
 /**
- *	fionbio		-	non blocking ioctl
- *	@file: file to set blocking value
- *	@p: user parameter
+ * fionbio() - non blocking ioctl
+ * @file: file to set blocking value
+ * @p: user parameter
  *
- *	Historical tty interfaces had a blocking control ioctl before
- *	the generic functionality existed. This piece of history is preserved
- *	in the expected tty API of posix OS's.
+ * Historical tty interfaces had a blocking control ioctl before
+ * the generic functionality existed. This piece of history is preserved
+ * in the expected tty API of posix OS's.
  *
- *	Locking: none, the open file handle ensures it won't go away.
+ * Locking: none, the open file handle ensures it won't go away.
  */
 
 static int fionbio(struct file *file, int __user *p)
@@ -2321,13 +2321,13 @@ static int fionbio(struct file *file, int __user *p)
 }
 
 /**
- *	tiocsetd	-	set line discipline
- *	@tty: tty device
- *	@p: pointer to user data
+ * tiocsetd() - set line discipline
+ * @tty: tty device
+ * @p: pointer to user data
  *
- *	Set the line discipline according to user request.
+ * Set the line discipline according to user request.
  *
- *	Locking: see tty_set_ldisc, this function is just a helper
+ * Locking: see tty_set_ldisc, this function is just a helper
  */
 
 static int tiocsetd(struct tty_struct *tty, int __user *p)
@@ -2344,14 +2344,14 @@ static int tiocsetd(struct tty_struct *tty, int __user *p)
 }
 
 /**
- *	tiocgetd	-	get line discipline
- *	@tty: tty device
- *	@p: pointer to user data
+ * tiocgetd() - get line discipline
+ * @tty: tty device
+ * @p: pointer to user data
  *
- *	Retrieves the line discipline id directly from the ldisc.
+ * Retrieves the line discipline id directly from the ldisc.
  *
- *	Locking: waits for ldisc reference (in case the line discipline
- *		is changing or the tty is being hungup)
+ * Locking: waits for ldisc reference (in case the line discipline
+ *          is changing or the tty is being hungup)
  */
 
 static int tiocgetd(struct tty_struct *tty, int __user *p)
@@ -2368,15 +2368,15 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
 }
 
 /**
- *	send_break	-	performed time break
- *	@tty: device to break on
- *	@duration: timeout in mS
+ * send_break() - performed time break
+ * @tty: device to break on
+ * @duration: timeout in mS
  *
- *	Perform a timed break on hardware that lacks its own driver level
- *	timed break functionality.
+ * Perform a timed break on hardware that lacks its own driver level
+ * timed break functionality.
  *
- *	Locking:
- *		atomic_write_lock serializes
+ * Locking:
+ *         atomic_write_lock serializes
  *
  */
 
@@ -2408,15 +2408,15 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 }
 
 /**
- *	tty_tiocmget		-	get modem status
- *	@tty: tty device
- *	@file: user file pointer
- *	@p: pointer to result
+ * tty_tiocmget() - get modem status
+ * @tty: tty device
+ * @file: user file pointer
+ * @p: pointer to result
  *
- *	Obtain the modem status bits from the tty driver if the feature
- *	is supported. Return -EINVAL if it is not available.
+ * Obtain the modem status bits from the tty driver if the feature
+ * is supported. Return -EINVAL if it is not available.
  *
- *	Locking: none (up to the driver)
+ * Locking: none (up to the driver)
  */
 
 static int tty_tiocmget(struct tty_struct *tty, int __user *p)
@@ -2433,15 +2433,15 @@ static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 }
 
 /**
- *	tty_tiocmset		-	set modem status
- *	@tty: tty device
- *	@cmd: command - clear bits, set bits or set all
- *	@p: pointer to desired bits
+ * tty_tiocmset() - set modem status
+ * @tty: tty device
+ * @cmd: command - clear bits, set bits or set all
+ * @p: pointer to desired bits
  *
- *	Set the modem status bits from the tty driver if the feature
- *	is supported. Return -EINVAL if it is not available.
+ * Set the modem status bits from the tty driver if the feature
+ * is supported. Return -EINVAL if it is not available.
  *
- *	Locking: none (up to the driver)
+ * Locking: none (up to the driver)
  */
 
 static int tty_tiocmset(struct tty_struct *tty, unsigned int cmd,
@@ -2555,7 +2555,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 
 	/*
-	 *	Now do the stuff.
+	 * Now do the stuff.
 	 */
 	switch (cmd) {
 	case TIOCSTI:
@@ -2804,11 +2804,11 @@ static struct device *tty_get_device(struct tty_struct *tty)
 
 
 /**
- *	alloc_tty_struct
+ * alloc_tty_struct()
  *
- *	This subroutine allocates and initializes a tty structure.
+ * This subroutine allocates and initializes a tty structure.
  *
- *	Locking: none - tty in question is not exposed at this point
+ * Locking: none - tty in question is not exposed at this point
  */
 
 struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
@@ -2852,15 +2852,15 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 }
 
 /**
- *	tty_put_char	-	write one character to a tty
- *	@tty: tty
- *	@ch: character
+ * tty_put_char() - write one character to a tty
+ * @tty: tty
+ * @ch: character
  *
- *	Write one byte to the tty using the provided put_char method
- *	if present. Returns the number of characters successfully output.
+ * Write one byte to the tty using the provided put_char method
+ * if present. Returns the number of characters successfully output.
  *
- *	Note: the specific put_char operation in the driver layer may go
- *	away soon. Don't call it directly, use this method
+ * Note: the specific put_char operation in the driver layer may go
+ * away soon. Don't call it directly, use this method
  */
 
 int tty_put_char(struct tty_struct *tty, unsigned char ch)
@@ -2891,22 +2891,22 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
 }
 
 /**
- *	tty_register_device - register a tty device
- *	@driver: the tty driver that describes the tty device
- *	@index: the index in the tty driver for this tty device
- *	@device: a struct device that is associated with this tty device.
- *		This field is optional, if there is no known struct device
- *		for this tty device it can be set to NULL safely.
+ * tty_register_device() - register a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
+ * @device: a struct device that is associated with this tty device.
+ *          This field is optional, if there is no known struct device
+ *          for this tty device it can be set to NULL safely.
  *
- *	Returns a pointer to the struct device for this tty device
- *	(or ERR_PTR(-EFOO) on error).
+ * Returns a pointer to the struct device for this tty device
+ * (or ERR_PTR(-EFOO) on error).
  *
- *	This call is required to be made to register an individual tty device
- *	if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
- *	that bit is not set, this function should not be called by a tty
- *	driver.
+ * This call is required to be made to register an individual tty device
+ * if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
+ * that bit is not set, this function should not be called by a tty
+ * driver.
  *
- *	Locking: ??
+ * Locking: ??
  */
 
 struct device *tty_register_device(struct tty_driver *driver, unsigned index,
@@ -2923,24 +2923,24 @@ static void tty_device_create_release(struct device *dev)
 }
 
 /**
- *	tty_register_device_attr - register a tty device
- *	@driver: the tty driver that describes the tty device
- *	@index: the index in the tty driver for this tty device
- *	@device: a struct device that is associated with this tty device.
- *		This field is optional, if there is no known struct device
- *		for this tty device it can be set to NULL safely.
- *	@drvdata: Driver data to be set to device.
- *	@attr_grp: Attribute group to be set on device.
+ * tty_register_device_attr() - register a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
+ * @device: a struct device that is associated with this tty device.
+ *          This field is optional, if there is no known struct device
+ *          for this tty device it can be set to NULL safely.
+ * @drvdata: Driver data to be set to device.
+ * @attr_grp: Attribute group to be set on device.
  *
- *	Returns a pointer to the struct device for this tty device
- *	(or ERR_PTR(-EFOO) on error).
+ * Returns a pointer to the struct device for this tty device
+ * (or ERR_PTR(-EFOO) on error).
  *
- *	This call is required to be made to register an individual tty device
- *	if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
- *	that bit is not set, this function should not be called by a tty
- *	driver.
+ * This call is required to be made to register an individual tty device
+ * if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
+ * that bit is not set, this function should not be called by a tty
+ * driver.
  *
- *	Locking: ??
+ * Locking: ??
  */
 struct device *tty_register_device_attr(struct tty_driver *driver,
 				   unsigned index, struct device *device,
@@ -3013,14 +3013,14 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 EXPORT_SYMBOL_GPL(tty_register_device_attr);
 
 /**
- *	tty_unregister_device - unregister a tty device
- *	@driver: the tty driver that describes the tty device
- *	@index: the index in the tty driver for this tty device
+ * tty_unregister_device() - unregister a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
  *
- *	If a tty device is registered with a call to tty_register_device() then
- *	this function must be called when the tty device is gone.
+ * If a tty device is registered with a call to tty_register_device() then
+ * this function must be called when the tty device is gone.
  *
- *	Locking: ??
+ * Locking: ??
  */
 
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
@@ -3035,7 +3035,7 @@ void tty_unregister_device(struct tty_driver *driver, unsigned index)
 EXPORT_SYMBOL(tty_unregister_device);
 
 /**
- * __tty_alloc_driver -- allocate tty driver
+ * __tty_alloc_driver() -- allocate tty driver
  * @lines: count of lines this driver can handle at most
  * @owner: module which is responsible for this driver
  * @flags: some of TTY_DRIVER_* flags, will be set in driver->flags
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 56426611050d..2fae67242885 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -45,12 +45,12 @@
 
 
 /**
- *	tty_chars_in_buffer	-	characters pending
- *	@tty: terminal
+ * tty_chars_in_buffer() - characters pending
+ * @tty: terminal
  *
- *	Return the number of bytes of data in the device private
- *	output queue. If no private method is supplied there is assumed
- *	to be no queue on the device.
+ * Return the number of bytes of data in the device private
+ * output queue. If no private method is supplied there is assumed
+ * to be no queue on the device.
  */
 
 int tty_chars_in_buffer(struct tty_struct *tty)
@@ -63,14 +63,14 @@ int tty_chars_in_buffer(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_chars_in_buffer);
 
 /**
- *	tty_write_room		-	write queue space
- *	@tty: terminal
+ * tty_write_room() - write queue space
+ * @tty: terminal
  *
- *	Return the number of bytes that can be queued to this device
- *	at the present time. The result should be treated as a guarantee
- *	and the driver cannot offer a value it later shrinks by more than
- *	the number of bytes written. If no method is provided 2K is always
- *	returned and data may be lost as there will be no flow control.
+ * Return the number of bytes that can be queued to this device
+ * at the present time. The result should be treated as a guarantee
+ * and the driver cannot offer a value it later shrinks by more than
+ * the number of bytes written. If no method is provided 2K is always
+ * returned and data may be lost as there will be no flow control.
  */
 
 int tty_write_room(struct tty_struct *tty)
@@ -82,12 +82,12 @@ int tty_write_room(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_write_room);
 
 /**
- *	tty_driver_flush_buffer	-	discard internal buffer
- *	@tty: terminal
+ * tty_driver_flush_buffer() - discard internal buffer
+ * @tty: terminal
  *
- *	Discard the internal output buffer for this device. If no method
- *	is provided then either the buffer cannot be hardware flushed or
- *	there is no buffer driver side.
+ * Discard the internal output buffer for this device. If no method
+ * is provided then either the buffer cannot be hardware flushed or
+ * there is no buffer driver side.
  */
 void tty_driver_flush_buffer(struct tty_struct *tty)
 {
@@ -97,13 +97,13 @@ void tty_driver_flush_buffer(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_driver_flush_buffer);
 
 /**
- *	tty_throttle		-	flow control
- *	@tty: terminal
+ * tty_throttle() - flow control
+ * @tty: terminal
  *
- *	Indicate that a tty should stop transmitting data down the stack.
- *	Takes the termios rwsem to protect against parallel throttle/unthrottle
- *	and also to ensure the driver can consistently reference its own
- *	termios data at this point when implementing software flow control.
+ * Indicate that a tty should stop transmitting data down the stack.
+ * Takes the termios rwsem to protect against parallel throttle/unthrottle
+ * and also to ensure the driver can consistently reference its own
+ * termios data at this point when implementing software flow control.
  */
 
 void tty_throttle(struct tty_struct *tty)
@@ -119,16 +119,16 @@ void tty_throttle(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_throttle);
 
 /**
- *	tty_unthrottle		-	flow control
- *	@tty: terminal
+ * tty_unthrottle() - flow control
+ * @tty: terminal
  *
- *	Indicate that a tty may continue transmitting data down the stack.
- *	Takes the termios rwsem to protect against parallel throttle/unthrottle
- *	and also to ensure the driver can consistently reference its own
- *	termios data at this point when implementing software flow control.
+ * Indicate that a tty may continue transmitting data down the stack.
+ * Takes the termios rwsem to protect against parallel throttle/unthrottle
+ * and also to ensure the driver can consistently reference its own
+ * termios data at this point when implementing software flow control.
  *
- *	Drivers should however remember that the stack can issue a throttle,
- *	then change flow control method, then unthrottle.
+ * Drivers should however remember that the stack can issue a throttle,
+ * then change flow control method, then unthrottle.
  */
 
 void tty_unthrottle(struct tty_struct *tty)
@@ -143,15 +143,15 @@ void tty_unthrottle(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_unthrottle);
 
 /**
- *	tty_throttle_safe	-	flow control
- *	@tty: terminal
+ * tty_throttle_safe() - flow control
+ * @tty: terminal
  *
- *	Similar to tty_throttle() but will only attempt throttle
- *	if tty->flow_change is TTY_THROTTLE_SAFE. Prevents an accidental
- *	throttle due to race conditions when throttling is conditional
- *	on factors evaluated prior to throttling.
+ * Similar to tty_throttle() but will only attempt throttle
+ * if tty->flow_change is TTY_THROTTLE_SAFE. Prevents an accidental
+ * throttle due to race conditions when throttling is conditional
+ * on factors evaluated prior to throttling.
  *
- *	Returns 0 if tty is throttled (or was already throttled)
+ * Returns 0 if tty is throttled (or was already throttled)
  */
 
 int tty_throttle_safe(struct tty_struct *tty)
@@ -174,15 +174,15 @@ int tty_throttle_safe(struct tty_struct *tty)
 }
 
 /**
- *	tty_unthrottle_safe	-	flow control
- *	@tty: terminal
+ * tty_unthrottle_safe() - flow control
+ * @tty: terminal
  *
- *	Similar to tty_unthrottle() but will only attempt unthrottle
- *	if tty->flow_change is TTY_UNTHROTTLE_SAFE. Prevents an accidental
- *	unthrottle due to race conditions when unthrottling is conditional
- *	on factors evaluated prior to unthrottling.
+ * Similar to tty_unthrottle() but will only attempt unthrottle
+ * if tty->flow_change is TTY_UNTHROTTLE_SAFE. Prevents an accidental
+ * unthrottle due to race conditions when unthrottling is conditional
+ * on factors evaluated prior to unthrottling.
  *
- *	Returns 0 if tty is unthrottled (or was already unthrottled)
+ * Returns 0 if tty is unthrottled (or was already unthrottled)
  */
 
 int tty_unthrottle_safe(struct tty_struct *tty)
@@ -205,14 +205,14 @@ int tty_unthrottle_safe(struct tty_struct *tty)
 }
 
 /**
- *	tty_wait_until_sent	-	wait for I/O to finish
- *	@tty: tty we are waiting for
- *	@timeout: how long we will wait
+ * tty_wait_until_sent() - wait for I/O to finish
+ * @tty: tty we are waiting for
+ * @timeout: how long we will wait
  *
- *	Wait for characters pending in a tty driver to hit the wire, or
- *	for a timeout to occur (eg due to flow control)
+ * Wait for characters pending in a tty driver to hit the wire, or
+ * for a timeout to occur (eg due to flow control)
  *
- *	Locking: none
+ * Locking: none
  */
 
 void tty_wait_until_sent(struct tty_struct *tty, long timeout)
@@ -237,7 +237,7 @@ EXPORT_SYMBOL(tty_wait_until_sent);
 
 
 /*
- *		Termios Helper Methods
+ * 	Termios Helper Methods
  */
 
 static void unset_locked_termios(struct tty_struct *tty, struct ktermios *old)
@@ -260,14 +260,14 @@ static void unset_locked_termios(struct tty_struct *tty, struct ktermios *old)
 }
 
 /**
- *	tty_termios_copy_hw	-	copy hardware settings
- *	@new: New termios
- *	@old: Old termios
+ * tty_termios_copy_hw() - copy hardware settings
+ * @new: New termios
+ * @old: Old termios
  *
- *	Propagate the hardware specific terminal setting bits from
- *	the old termios structure to the new one. This is used in cases
- *	where the hardware does not support reconfiguration or as a helper
- *	in some cases where only minimal reconfiguration is supported
+ * Propagate the hardware specific terminal setting bits from
+ * the old termios structure to the new one. This is used in cases
+ * where the hardware does not support reconfiguration or as a helper
+ * in some cases where only minimal reconfiguration is supported
  */
 
 void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old)
@@ -282,12 +282,12 @@ void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old)
 EXPORT_SYMBOL(tty_termios_copy_hw);
 
 /**
- *	tty_termios_hw_change	-	check for setting change
- *	@a: termios
- *	@b: termios to compare
+ * tty_termios_hw_change() - check for setting change
+ * @a: termios
+ * @b: termios to compare
  *
- *	Check if any of the bits that affect a dumb device have changed
- *	between the two termios structures, or a speed change is needed.
+ * Check if any of the bits that affect a dumb device have changed
+ * between the two termios structures, or a speed change is needed.
  */
 
 int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
@@ -301,14 +301,14 @@ int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
 EXPORT_SYMBOL(tty_termios_hw_change);
 
 /**
- *	tty_set_termios		-	update termios values
- *	@tty: tty to update
- *	@new_termios: desired new value
+ * tty_set_termios() - update termios values
+ * @tty: tty to update
+ * @new_termios: desired new value
  *
- *	Perform updates to the termios values set on this terminal.
- *	A master pty's termios should never be set.
+ * Perform updates to the termios values set on this terminal.
+ * A master pty's termios should never be set.
  *
- *	Locking: termios_rwsem
+ * Locking: termios_rwsem
  */
 
 int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
@@ -319,7 +319,7 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 		tty->driver->subtype == PTY_TYPE_MASTER);
 	/*
-	 *	Perform the actual termios internal changes under lock.
+	 * Perform the actual termios internal changes under lock.
 	 */
 
 
@@ -347,16 +347,16 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 EXPORT_SYMBOL_GPL(tty_set_termios);
 
 /**
- *	set_termios		-	set termios values for a tty
- *	@tty: terminal device
- *	@arg: user data
- *	@opt: option information
+ * set_termios() - set termios values for a tty
+ * @tty: terminal device
+ * @arg: user data
+ * @opt: option information
  *
- *	Helper function to prepare termios data and run necessary other
- *	functions before using tty_set_termios to do the actual changes.
+ * Helper function to prepare termios data and run necessary other
+ * functions before using tty_set_termios to do the actual changes.
  *
- *	Locking:
- *		Called functions take ldisc and termios_rwsem locks
+ * Locking:
+ *         Called functions take ldisc and termios_rwsem locks
  */
 
 static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
@@ -447,13 +447,13 @@ static int get_termio(struct tty_struct *tty, struct termio __user *termio)
 #ifdef TCGETX
 
 /**
- *	set_termiox	-	set termiox fields if possible
- *	@tty: terminal
- *	@arg: termiox structure from user
- *	@opt: option flags for ioctl type
+ * set_termiox() - set termiox fields if possible
+ * @tty: terminal
+ * @arg: termiox structure from user
+ * @opt: option flags for ioctl type
  *
- *	Implement the device calling points for the SYS5 termiox ioctl
- *	interface in Linux
+ * Implement the device calling points for the SYS5 termiox ioctl
+ * interface in Linux
  */
 
 static int set_termiox(struct tty_struct *tty, void __user *arg, int opt)
@@ -554,14 +554,14 @@ static void set_sgflags(struct ktermios *termios, int flags)
 }
 
 /**
- *	set_sgttyb		-	set legacy terminal values
- *	@tty: tty structure
- *	@sgttyb: pointer to old style terminal structure
+ * set_sgttyb() - set legacy terminal values
+ * @tty: tty structure
+ * @sgttyb: pointer to old style terminal structure
  *
- *	Updates a terminal from the legacy BSD style terminal information
- *	structure.
+ * Updates a terminal from the legacy BSD style terminal information
+ * structure.
  *
- *	Locking: termios_rwsem
+ * Locking: termios_rwsem
  */
 
 static int set_sgttyb(struct tty_struct *tty, struct sgttyb __user *sgttyb)
@@ -667,12 +667,12 @@ static int set_ltchars(struct tty_struct *tty, struct ltchars __user *ltchars)
 #endif
 
 /**
- *	tty_change_softcar	-	carrier change ioctl helper
- *	@tty: tty to update
- *	@arg: enable/disable CLOCAL
+ * tty_change_softcar() - carrier change ioctl helper
+ * @tty: tty to update
+ * @arg: enable/disable CLOCAL
  *
- *	Perform a change to the CLOCAL state and call into the driver
- *	layer to make it visible. All done with the termios rwsem
+ * Perform a change to the CLOCAL state and call into the driver
+ * layer to make it visible. All done with the termios rwsem
  */
 
 static int tty_change_softcar(struct tty_struct *tty, int arg)
@@ -694,15 +694,15 @@ static int tty_change_softcar(struct tty_struct *tty, int arg)
 }
 
 /**
- *	tty_mode_ioctl		-	mode related ioctls
- *	@tty: tty for the ioctl
- *	@file: file pointer for the tty
- *	@cmd: command
- *	@arg: ioctl argument
+ * tty_mode_ioctl() - mode related ioctls
+ * @tty: tty for the ioctl
+ * @file: file pointer for the tty
+ * @cmd: command
+ * @arg: ioctl argument
  *
- *	Perform non line discipline specific mode control ioctls. This
- *	is designed to be called by line disciplines to ensure they provide
- *	consistent mode setting.
+ * Perform non line discipline specific mode control ioctls. This
+ * is designed to be called by line disciplines to ensure they provide
+ * consistent mode setting.
  */
 
 int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 6155cc7b3f56..0ad21eafd53a 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -19,14 +19,14 @@ static int is_ignored(int sig)
 }
 
 /**
- *	tty_check_change	-	check for POSIX terminal changes
- *	@tty: tty to check
+ * tty_check_change() - check for POSIX terminal changes
+ * @tty: tty to check
  *
- *	If we try to write to, or set the state of, a terminal and we're
- *	not in the foreground, send a SIGTTOU.  If the signal is blocked or
- *	ignored, go ahead and perform the operation.  (POSIX 7.2)
+ * If we try to write to, or set the state of, a terminal and we're
+ * not in the foreground, send a SIGTTOU.  If the signal is blocked or
+ * ignored, go ahead and perform the operation.  (POSIX 7.2)
  *
- *	Locking: ctrl_lock
+ * Locking: ctrl_lock
  */
 int __tty_check_change(struct tty_struct *tty, int sig)
 {
@@ -82,14 +82,14 @@ void proc_clear_tty(struct task_struct *p)
 }
 
 /**
- * proc_set_tty -  set the controlling terminal
+ * proc_set_tty() - set the controlling terminal
  *
  * Only callable by the session leader and only if it does not already have
  * a controlling terminal.
  *
  * Caller must hold:  tty_lock()
- *		      a readlock on tasklist_lock
- *		      sighand lock
+ * 	      a readlock on tasklist_lock
+ * 	      sighand lock
  */
 static void __proc_set_tty(struct tty_struct *tty)
 {
@@ -177,16 +177,16 @@ void session_clear_tty(struct pid *session)
 }
 
 /**
- *	tty_signal_session_leader	- sends SIGHUP to session leader
- *	@tty		controlling tty
- *	@exit_session	if non-zero, signal all foreground group processes
+ * tty_signal_session_leader() - sends SIGHUP to session leader
+ * @tty controlling tty
+ * @exit_session if non-zero, signal all foreground group processes
  *
- *	Send SIGHUP and SIGCONT to the session leader and its process group.
- *	Optionally, signal all processes in the foreground process group.
+ * Send SIGHUP and SIGCONT to the session leader and its process group.
+ * Optionally, signal all processes in the foreground process group.
  *
- *	Returns the number of processes in the session with this tty
- *	as their controlling terminal. This value is used to drop
- *	tty references for those processes.
+ * Returns the number of processes in the session with this tty
+ * as their controlling terminal. This value is used to drop
+ * tty references for those processes.
  */
 int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
 {
@@ -231,28 +231,28 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
 }
 
 /**
- *	disassociate_ctty	-	disconnect controlling tty
- *	@on_exit: true if exiting so need to "hang up" the session
+ * disassociate_ctty() - disconnect controlling tty
+ * @on_exit: true if exiting so need to "hang up" the session
  *
- *	This function is typically called only by the session leader, when
- *	it wants to disassociate itself from its controlling tty.
+ * This function is typically called only by the session leader, when
+ * it wants to disassociate itself from its controlling tty.
  *
- *	It performs the following functions:
+ * It performs the following functions:
  *	(1)  Sends a SIGHUP and SIGCONT to the foreground process group
  *	(2)  Clears the tty from being controlling the session
  *	(3)  Clears the controlling tty for all processes in the
  *		session group.
  *
- *	The argument on_exit is set to 1 if called when a process is
- *	exiting; it is 0 if called by the ioctl TIOCNOTTY.
+ * The argument on_exit is set to 1 if called when a process is
+ * exiting; it is 0 if called by the ioctl TIOCNOTTY.
  *
- *	Locking:
- *		BTM is taken for hysterical raisons, and held when
- *		  called from no_tty().
- *		  tty_mutex is taken to protect tty
- *		  ->siglock is taken to protect ->signal/->sighand
- *		  tasklist_lock is taken to walk process list for sessions
- *		    ->siglock is taken to protect ->signal/->sighand
+ * Locking:
+ *	BTM is taken for hysterical raisons, and held when
+ *	  called from no_tty().
+ *	  tty_mutex is taken to protect tty
+ *	  ->siglock is taken to protect ->signal/->sighand
+ *	  tasklist_lock is taken to walk process list for sessions
+ *	    ->siglock is taken to protect ->signal/->sighand
  */
 void disassociate_ctty(int on_exit)
 {
@@ -315,7 +315,7 @@ void disassociate_ctty(int on_exit)
 
 /**
  *
- *	no_tty	- Ensure the current process does not have a controlling tty
+ * no_tty() - Ensure the current process does not have a controlling tty
  */
 void no_tty(void)
 {
@@ -328,17 +328,17 @@ void no_tty(void)
 }
 
 /**
- *	tiocsctty	-	set controlling tty
- *	@tty: tty structure
- *	@arg: user argument
+ * tiocsctty() - set controlling tty
+ * @tty: tty structure
+ * @arg: user argument
  *
- *	This ioctl is used to manage job control. It permits a session
- *	leader to set this tty as the controlling tty for the session.
+ * This ioctl is used to manage job control. It permits a session
+ * leader to set this tty as the controlling tty for the session.
  *
- *	Locking:
- *		Takes tty_lock() to serialize proc_set_tty() for this tty
- *		Takes tasklist_lock internally to walk sessions
- *		Takes ->siglock() when updating signal->tty
+ * Locking:
+ *         Takes tty_lock() to serialize proc_set_tty() for this tty
+ *         Takes tasklist_lock internally to walk sessions
+ *         Takes ->siglock() when updating signal->tty
  */
 static int tiocsctty(struct tty_struct *tty, struct file *file, int arg)
 {
@@ -389,11 +389,11 @@ static int tiocsctty(struct tty_struct *tty, struct file *file, int arg)
 }
 
 /**
- *	tty_get_pgrp	-	return a ref counted pgrp pid
- *	@tty: tty to read
+ * tty_get_pgrp() - return a ref counted pgrp pid
+ * @tty: tty to read
  *
- *	Returns a refcounted instance of the pid struct for the process
- *	group controlling the tty.
+ * Returns a refcounted instance of the pid struct for the process
+ * group controlling the tty.
  */
 struct pid *tty_get_pgrp(struct tty_struct *tty)
 {
@@ -430,15 +430,15 @@ static struct pid *session_of_pgrp(struct pid *pgrp)
 }
 
 /**
- *	tiocgpgrp		-	get process group
- *	@tty: tty passed by user
- *	@real_tty: tty side of the tty passed by the user if a pty else the tty
- *	@p: returned pid
+ * tiocgpgrp() - get process group
+ * @tty: tty passed by user
+ * @real_tty: tty side of the tty passed by the user if a pty else the tty
+ * @p: returned pid
  *
- *	Obtain the process group of the tty. If there is no process group
- *	return an error.
+ * Obtain the process group of the tty. If there is no process group
+ * return an error.
  *
- *	Locking: none. Reference to current->signal->tty is safe.
+ * Locking: none. Reference to current->signal->tty is safe.
  */
 static int tiocgpgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
@@ -457,15 +457,15 @@ static int tiocgpgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
 }
 
 /**
- *	tiocspgrp		-	attempt to set process group
- *	@tty: tty passed by user
- *	@real_tty: tty side device matching tty passed by user
- *	@p: pid pointer
+ * tiocspgrp() - attempt to set process group
+ * @tty: tty passed by user
+ * @real_tty: tty side device matching tty passed by user
+ * @p: pid pointer
  *
- *	Set the process group of the tty to the session passed. Only
- *	permitted where the tty session is our session.
+ * Set the process group of the tty to the session passed. Only
+ * permitted where the tty session is our session.
  *
- *	Locking: RCU, ctrl lock
+ * Locking: RCU, ctrl lock
  */
 static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
@@ -504,15 +504,15 @@ static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
 }
 
 /**
- *	tiocgsid		-	get session id
- *	@tty: tty passed by user
- *	@real_tty: tty side of the tty passed by the user if a pty else the tty
- *	@p: pointer to returned session id
+ * tiocgsid() - get session id
+ * @tty: tty passed by user
+ * @real_tty: tty side of the tty passed by the user if a pty else the tty
+ * @p: pointer to returned session id
  *
- *	Obtain the session id of the tty. If there is no session
- *	return an error.
+ * Obtain the session id of the tty. If there is no session
+ * return an error.
  *
- *	Locking: none. Reference to current->signal->tty is safe.
+ * Locking: none. Reference to current->signal->tty is safe.
  */
 static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index fc4c97cae01e..2c62caf345d6 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -46,16 +46,16 @@ static DEFINE_RAW_SPINLOCK(tty_ldiscs_lock);
 static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
 
 /**
- *	tty_register_ldisc	-	install a line discipline
- *	@disc: ldisc number
- *	@new_ldisc: pointer to the ldisc object
+ * tty_register_ldisc() - install a line discipline
+ * @disc: ldisc number
+ * @new_ldisc: pointer to the ldisc object
  *
- *	Installs a new line discipline into the kernel. The discipline
- *	is set up as unreferenced and then made available to the kernel
- *	from this point onwards.
+ * Installs a new line discipline into the kernel. The discipline
+ * is set up as unreferenced and then made available to the kernel
+ * from this point onwards.
  *
- *	Locking:
- *		takes tty_ldiscs_lock to guard against ldisc races
+ * Locking:
+ *         takes tty_ldiscs_lock to guard against ldisc races
  */
 
 int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc)
@@ -77,15 +77,15 @@ int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc)
 EXPORT_SYMBOL(tty_register_ldisc);
 
 /**
- *	tty_unregister_ldisc	-	unload a line discipline
- *	@disc: ldisc number
- *	@new_ldisc: pointer to the ldisc object
+ * tty_unregister_ldisc() - unload a line discipline
+ * @disc: ldisc number
+ * @new_ldisc: pointer to the ldisc object
  *
- *	Remove a line discipline from the kernel providing it is not
- *	currently in use.
+ * Remove a line discipline from the kernel providing it is not
+ * currently in use.
  *
- *	Locking:
- *		takes tty_ldiscs_lock to guard against ldisc races
+ * Locking:
+ *         takes tty_ldiscs_lock to guard against ldisc races
  */
 
 int tty_unregister_ldisc(int disc)
@@ -137,23 +137,23 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 }
 
 /**
- *	tty_ldisc_get		-	take a reference to an ldisc
- *	@disc: ldisc number
+ * tty_ldisc_get() - take a reference to an ldisc
+ * @disc: ldisc number
  *
- *	Takes a reference to a line discipline. Deals with refcounts and
- *	module locking counts.
+ * Takes a reference to a line discipline. Deals with refcounts and
+ * module locking counts.
  *
- *	Returns: -EINVAL if the discipline index is not [N_TTY..NR_LDISCS] or
- *			 if the discipline is not registered
- *		 -EAGAIN if request_module() failed to load or register the
- *			 the discipline
- *		 -ENOMEM if allocation failure
+ * Returns: -EINVAL if the discipline index is not [N_TTY..NR_LDISCS] or
+ * 		 if the discipline is not registered
+ *          -EAGAIN if request_module() failed to load or register the
+ * 		 the discipline
+ *          -ENOMEM if allocation failure
  *
- *		 Otherwise, returns a pointer to the discipline and bumps the
- *		 ref count
+ * 	 Otherwise, returns a pointer to the discipline and bumps the
+ * 	 ref count
  *
- *	Locking:
- *		takes tty_ldiscs_lock to guard against ldisc races
+ * Locking:
+ *         takes tty_ldiscs_lock to guard against ldisc races
  */
 
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
@@ -188,9 +188,9 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 }
 
 /**
- *	tty_ldisc_put		-	release the ldisc
+ * tty_ldisc_put() - release the ldisc
  *
- *	Complement of tty_ldisc_get().
+ * Complement of tty_ldisc_get().
  */
 static void tty_ldisc_put(struct tty_ldisc *ld)
 {
@@ -237,23 +237,23 @@ const struct seq_operations tty_ldiscs_seq_ops = {
 };
 
 /**
- *	tty_ldisc_ref_wait	-	wait for the tty ldisc
- *	@tty: tty device
+ * tty_ldisc_ref_wait() - wait for the tty ldisc
+ * @tty: tty device
  *
- *	Dereference the line discipline for the terminal and take a
- *	reference to it. If the line discipline is in flux then
- *	wait patiently until it changes.
+ * Dereference the line discipline for the terminal and take a
+ * reference to it. If the line discipline is in flux then
+ * wait patiently until it changes.
  *
- *	Returns: NULL if the tty has been hungup and not re-opened with
- *		 a new file descriptor, otherwise valid ldisc reference
+ * Returns: NULL if the tty has been hungup and not re-opened with
+ * 	 a new file descriptor, otherwise valid ldisc reference
  *
- *	Note: Must not be called from an IRQ/timer context. The caller
- *	must also be careful not to hold other locks that will deadlock
- *	against a discipline change, such as an existing ldisc reference
- *	(which we check for)
+ * Note: Must not be called from an IRQ/timer context. The caller
+ * must also be careful not to hold other locks that will deadlock
+ * against a discipline change, such as an existing ldisc reference
+ * (which we check for)
  *
- *	Note: a file_operations routine (read/poll/write) should use this
- *	function to wait for any ldisc lifetime events to finish.
+ * Note: a file_operations routine (read/poll/write) should use this
+ * function to wait for any ldisc lifetime events to finish.
  */
 
 struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
@@ -269,12 +269,12 @@ struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_ldisc_ref_wait);
 
 /**
- *	tty_ldisc_ref		-	get the tty ldisc
- *	@tty: tty device
+ * tty_ldisc_ref() - get the tty ldisc
+ * @tty: tty device
  *
- *	Dereference the line discipline for the terminal and take a
- *	reference to it. If the line discipline is in flux then
- *	return NULL. Can be called from IRQ and timer functions.
+ * Dereference the line discipline for the terminal and take a
+ * reference to it. If the line discipline is in flux then
+ * return NULL. Can be called from IRQ and timer functions.
  */
 
 struct tty_ldisc *tty_ldisc_ref(struct tty_struct *tty)
@@ -291,11 +291,11 @@ struct tty_ldisc *tty_ldisc_ref(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_ldisc_ref);
 
 /**
- *	tty_ldisc_deref		-	free a tty ldisc reference
- *	@ld: reference to free up
+ * tty_ldisc_deref() - free a tty ldisc reference
+ * @ld: reference to free up
  *
- *	Undoes the effect of tty_ldisc_ref or tty_ldisc_ref_wait. May
- *	be called in IRQ context.
+ * Undoes the effect of tty_ldisc_ref or tty_ldisc_ref_wait. May
+ * be called in IRQ context.
  */
 
 void tty_ldisc_deref(struct tty_ldisc *ld)
@@ -390,11 +390,11 @@ static void tty_ldisc_unlock_pair(struct tty_struct *tty,
 }
 
 /**
- *	tty_ldisc_flush	-	flush line discipline queue
- *	@tty: tty
+ * tty_ldisc_flush() - flush line discipline queue
+ * @tty: tty
  *
- *	Flush the line discipline queue (if any) and the tty flip buffers
- *	for this tty.
+ * Flush the line discipline queue (if any) and the tty flip buffers
+ * for this tty.
  */
 
 void tty_ldisc_flush(struct tty_struct *tty)
@@ -408,19 +408,19 @@ void tty_ldisc_flush(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_ldisc_flush);
 
 /**
- *	tty_set_termios_ldisc		-	set ldisc field
- *	@tty: tty structure
- *	@disc: line discipline number
+ * tty_set_termios_ldisc() - set ldisc field
+ * @tty: tty structure
+ * @disc: line discipline number
  *
- *	This is probably overkill for real world processors but
- *	they are not on hot paths so a little discipline won't do
- *	any harm.
+ * This is probably overkill for real world processors but
+ * they are not on hot paths so a little discipline won't do
+ * any harm.
  *
- *	The line discipline-related tty_struct fields are reset to
- *	prevent the ldisc driver from re-using stale information for
- *	the new ldisc instance.
+ * The line discipline-related tty_struct fields are reset to
+ * prevent the ldisc driver from re-using stale information for
+ * the new ldisc instance.
  *
- *	Locking: takes termios_rwsem
+ * Locking: takes termios_rwsem
  */
 
 static void tty_set_termios_ldisc(struct tty_struct *tty, int disc)
@@ -434,14 +434,14 @@ static void tty_set_termios_ldisc(struct tty_struct *tty, int disc)
 }
 
 /**
- *	tty_ldisc_open		-	open a line discipline
- *	@tty: tty we are opening the ldisc on
- *	@ld: discipline to open
+ * tty_ldisc_open() - open a line discipline
+ * @tty: tty we are opening the ldisc on
+ * @ld: discipline to open
  *
- *	A helper opening method. Also a convenient debugging and check
- *	point.
+ * A helper opening method. Also a convenient debugging and check
+ * point.
  *
- *	Locking: always called with BTM already held.
+ * Locking: always called with BTM already held.
  */
 
 static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
@@ -461,12 +461,12 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 }
 
 /**
- *	tty_ldisc_close		-	close a line discipline
- *	@tty: tty we are opening the ldisc on
- *	@ld: discipline to close
+ * tty_ldisc_close() - close a line discipline
+ * @tty: tty we are opening the ldisc on
+ * @ld: discipline to close
  *
- *	A helper close method. Also a convenient debugging and check
- *	point.
+ * A helper close method. Also a convenient debugging and check
+ * point.
  */
 
 static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
@@ -479,12 +479,12 @@ static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 }
 
 /**
- *	tty_ldisc_failto	-	helper for ldisc failback
- *	@tty: tty to open the ldisc on
- *	@ld: ldisc we are trying to fail back to
+ * tty_ldisc_failto() - helper for ldisc failback
+ * @tty: tty to open the ldisc on
+ * @ld: ldisc we are trying to fail back to
  *
- *	Helper to try and recover a tty when switching back to the old
- *	ldisc fails and we need something attached.
+ * Helper to try and recover a tty when switching back to the old
+ * ldisc fails and we need something attached.
  */
 
 static int tty_ldisc_failto(struct tty_struct *tty, int ld)
@@ -502,12 +502,12 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 }
 
 /**
- *	tty_ldisc_restore	-	helper for tty ldisc change
- *	@tty: tty to recover
- *	@old: previous ldisc
+ * tty_ldisc_restore() - helper for tty ldisc change
+ * @tty: tty to recover
+ * @old: previous ldisc
  *
- *	Restore the previous line discipline or N_TTY when a line discipline
- *	change fails due to an open error
+ * Restore the previous line discipline or N_TTY when a line discipline
+ * change fails due to an open error
  */
 
 static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
@@ -527,14 +527,14 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 }
 
 /**
- *	tty_set_ldisc		-	set line discipline
- *	@tty: the terminal to set
- *	@ldisc: the line discipline
- *
- *	Set the discipline of a tty line. Must be called from a process
- *	context. The ldisc change logic has to protect itself against any
- *	overlapping ldisc change (including on the other end of pty pairs),
- *	the close of one side of a tty/pty pair, and eventually hangup.
+ * tty_set_ldisc() - set line discipline
+ * @tty: the terminal to set
+ * @ldisc: the line discipline
+ *
+ * Set the discipline of a tty line. Must be called from a process
+ * context. The ldisc change logic has to protect itself against any
+ * overlapping ldisc change (including on the other end of pty pairs),
+ * the close of one side of a tty/pty pair, and eventually hangup.
  */
 
 int tty_set_ldisc(struct tty_struct *tty, int disc)
@@ -608,10 +608,10 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
 EXPORT_SYMBOL_GPL(tty_set_ldisc);
 
 /**
- *	tty_ldisc_kill	-	teardown ldisc
- *	@tty: tty being released
+ * tty_ldisc_kill() - teardown ldisc
+ * @tty: tty being released
  *
- *	Perform final close of the ldisc and reset tty->ldisc
+ * Perform final close of the ldisc and reset tty->ldisc
  */
 static void tty_ldisc_kill(struct tty_struct *tty)
 {
@@ -627,10 +627,10 @@ static void tty_ldisc_kill(struct tty_struct *tty)
 }
 
 /**
- *	tty_reset_termios	-	reset terminal state
- *	@tty: tty to reset
+ * tty_reset_termios() - reset terminal state
+ * @tty: tty to reset
  *
- *	Restore a terminal to the driver default state.
+ * Restore a terminal to the driver default state.
  */
 
 static void tty_reset_termios(struct tty_struct *tty)
@@ -644,17 +644,17 @@ static void tty_reset_termios(struct tty_struct *tty)
 
 
 /**
- *	tty_ldisc_reinit	-	reinitialise the tty ldisc
- *	@tty: tty to reinit
- *	@disc: line discipline to reinitialize
+ * tty_ldisc_reinit() - reinitialise the tty ldisc
+ * @tty: tty to reinit
+ * @disc: line discipline to reinitialize
  *
- *	Completely reinitialize the line discipline state, by closing the
- *	current instance, if there is one, and opening a new instance. If
- *	an error occurs opening the new non-N_TTY instance, the instance
- *	is dropped and tty->ldisc reset to NULL. The caller can then retry
- *	with N_TTY instead.
+ * Completely reinitialize the line discipline state, by closing the
+ * current instance, if there is one, and opening a new instance. If
+ * an error occurs opening the new non-N_TTY instance, the instance
+ * is dropped and tty->ldisc reset to NULL. The caller can then retry
+ * with N_TTY instead.
  *
- *	Returns 0 if successful, otherwise error code < 0
+ * Returns 0 if successful, otherwise error code < 0
  */
 
 int tty_ldisc_reinit(struct tty_struct *tty, int disc)
@@ -685,18 +685,18 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 }
 
 /**
- *	tty_ldisc_hangup		-	hangup ldisc reset
- *	@tty: tty being hung up
+ * tty_ldisc_hangup() - hangup ldisc reset
+ * @tty: tty being hung up
  *
- *	Some tty devices reset their termios when they receive a hangup
- *	event. In that situation we must also switch back to N_TTY properly
- *	before we reset the termios data.
+ * Some tty devices reset their termios when they receive a hangup
+ * event. In that situation we must also switch back to N_TTY properly
+ * before we reset the termios data.
  *
- *	Locking: We can take the ldisc mutex as the rest of the code is
- *	careful to allow for this.
+ * Locking: We can take the ldisc mutex as the rest of the code is
+ * careful to allow for this.
  *
- *	In the pty pair case this occurs in the close() path of the
- *	tty itself so we must be careful about locking rules.
+ * In the pty pair case this occurs in the close() path of the
+ * tty itself so we must be careful about locking rules.
  */
 
 void tty_ldisc_hangup(struct tty_struct *tty, bool reinit)
@@ -744,13 +744,13 @@ void tty_ldisc_hangup(struct tty_struct *tty, bool reinit)
 }
 
 /**
- *	tty_ldisc_setup			-	open line discipline
- *	@tty: tty being shut down
- *	@o_tty: pair tty for pty/tty pairs
+ * tty_ldisc_setup() - open line discipline
+ * @tty: tty being shut down
+ * @o_tty: pair tty for pty/tty pairs
  *
- *	Called during the initial open of a tty/pty pair in order to set up the
- *	line disciplines and bind them to the tty. This has no locking issues
- *	as the device isn't yet active.
+ * Called during the initial open of a tty/pty pair in order to set up the
+ * line disciplines and bind them to the tty. This has no locking issues
+ * as the device isn't yet active.
  */
 
 int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
@@ -770,11 +770,11 @@ int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
 }
 
 /**
- *	tty_ldisc_release		-	release line discipline
- *	@tty: tty being shut down (or one end of pty pair)
+ * tty_ldisc_release() - release line discipline
+ * @tty: tty being shut down (or one end of pty pair)
  *
- *	Called during the final close of a tty or a pty pair in order to shut
- *	down the line discpline layer. On exit, each tty's ldisc is NULL.
+ * Called during the final close of a tty or a pty pair in order to shut
+ * down the line discpline layer. On exit, each tty's ldisc is NULL.
  */
 
 void tty_ldisc_release(struct tty_struct *tty)
@@ -800,11 +800,11 @@ void tty_ldisc_release(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_ldisc_release);
 
 /**
- *	tty_ldisc_init		-	ldisc setup for new tty
- *	@tty: tty being allocated
+ * tty_ldisc_init() - ldisc setup for new tty
+ * @tty: tty being allocated
  *
- *	Set up the line discipline objects for a newly allocated tty. Note that
- *	the tty structure is not completely set up when this call is made.
+ * Set up the line discipline objects for a newly allocated tty. Note that
+ * the tty structure is not completely set up when this call is made.
  */
 
 int tty_ldisc_init(struct tty_struct *tty)
@@ -817,10 +817,10 @@ int tty_ldisc_init(struct tty_struct *tty)
 }
 
 /**
- *	tty_ldisc_deinit	-	ldisc cleanup for new tty
- *	@tty: tty that was allocated recently
+ * tty_ldisc_deinit() - ldisc cleanup for new tty
+ * @tty: tty that was allocated recently
  *
- *	The tty structure must not becompletely set up (tty_ldisc_setup) when
+ * The tty structure must not becompletely set up (tty_ldisc_setup) when
  *      this call is made.
  */
 void tty_ldisc_deinit(struct tty_struct *tty)
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index cb6075096a5b..60927a52ec9c 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -74,7 +74,7 @@ void tty_port_init(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_init);
 
 /**
- * tty_port_link_device - link tty and tty_port
+ * tty_port_link_device() - link tty and tty_port
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -94,7 +94,7 @@ void tty_port_link_device(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_link_device);
 
 /**
- * tty_port_register_device - register tty device
+ * tty_port_register_device() - register tty device
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -113,7 +113,7 @@ struct device *tty_port_register_device(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_register_device);
 
 /**
- * tty_port_register_device_attr - register tty device
+ * tty_port_register_device_attr() - register tty device
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -137,7 +137,7 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr);
 
 /**
- * tty_port_register_device_attr_serdev - register tty or serdev device
+ * tty_port_register_device_attr_serdev() - register tty or serdev device
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -169,7 +169,7 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr_serdev);
 
 /**
- * tty_port_register_device_serdev - register tty or serdev device
+ * tty_port_register_device_serdev() - register tty or serdev device
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -188,7 +188,7 @@ struct device *tty_port_register_device_serdev(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_register_device_serdev);
 
 /**
- * tty_port_unregister_device - deregister a tty or serdev device
+ * tty_port_unregister_device() - deregister a tty or serdev device
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -235,7 +235,7 @@ void tty_port_free_xmit_buf(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_free_xmit_buf);
 
 /**
- * tty_port_destroy -- destroy inited port
+ * tty_port_destroy() - destroy inited port
  * @port: tty port to be destroyed
  *
  * When a port was initialized using tty_port_init, one has to destroy the
@@ -273,11 +273,11 @@ void tty_port_put(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_put);
 
 /**
- *	tty_port_tty_get	-	get a tty reference
- *	@port: tty port
+ * tty_port_tty_get() - get a tty reference
+ * @port: tty port
  *
- *	Return a refcount protected tty instance or NULL if the port is not
- *	associated with a tty (eg due to close or hangup)
+ * Return a refcount protected tty instance or NULL if the port is not
+ * associated with a tty (eg due to close or hangup)
  */
 struct tty_struct *tty_port_tty_get(struct tty_port *port)
 {
@@ -292,12 +292,12 @@ struct tty_struct *tty_port_tty_get(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_tty_get);
 
 /**
- *	tty_port_tty_set	-	set the tty of a port
- *	@port: tty port
- *	@tty: the tty
+ * tty_port_tty_set() - set the tty of a port
+ * @port: tty port
+ * @tty: the tty
  *
- *	Associate the port and tty pair. Manages any internal refcounts.
- *	Pass NULL to deassociate a port
+ * Associate the port and tty pair. Manages any internal refcounts.
+ * Pass NULL to deassociate a port
  */
 void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 {
@@ -333,13 +333,13 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 }
 
 /**
- *	tty_port_hangup		-	hangup helper
- *	@port: tty port
+ * tty_port_hangup() - hangup helper
+ * @port: tty port
  *
- *	Perform port level tty hangup flag and count changes. Drop the tty
- *	reference.
+ * Perform port level tty hangup flag and count changes. Drop the tty
+ * reference.
  *
- *	Caller holds tty lock.
+ * Caller holds tty lock.
  */
 void tty_port_hangup(struct tty_port *port)
 {
@@ -362,7 +362,7 @@ void tty_port_hangup(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_hangup);
 
 /**
- * tty_port_tty_hangup - helper to hang up a tty
+ * tty_port_tty_hangup() - helper to hang up a tty
  *
  * @port: tty port
  * @check_clocal: hang only ttys with CLOCAL unset?
@@ -378,7 +378,7 @@ void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
 
 /**
- * tty_port_tty_wakeup - helper to wake up a tty
+ * tty_port_tty_wakeup() - helper to wake up a tty
  *
  * @port: tty port
  */
@@ -389,12 +389,12 @@ void tty_port_tty_wakeup(struct tty_port *port)
 EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
 
 /**
- *	tty_port_carrier_raised	-	carrier raised check
- *	@port: tty port
+ * tty_port_carrier_raised() - carrier raised check
+ * @port: tty port
  *
- *	Wrapper for the carrier detect logic. For the moment this is used
- *	to hide some internal details. This will eventually become entirely
- *	internal to the tty port.
+ * Wrapper for the carrier detect logic. For the moment this is used
+ * to hide some internal details. This will eventually become entirely
+ * internal to the tty port.
  */
 int tty_port_carrier_raised(struct tty_port *port)
 {
@@ -405,12 +405,12 @@ int tty_port_carrier_raised(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_carrier_raised);
 
 /**
- *	tty_port_raise_dtr_rts	-	Raise DTR/RTS
- *	@port: tty port
+ * tty_port_raise_dtr_rts() - Raise DTR/RTS
+ * @port: tty port
  *
- *	Wrapper for the DTR/RTS raise logic. For the moment this is used
- *	to hide some internal details. This will eventually become entirely
- *	internal to the tty port.
+ * Wrapper for the DTR/RTS raise logic. For the moment this is used
+ * to hide some internal details. This will eventually become entirely
+ * internal to the tty port.
  */
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
@@ -420,12 +420,12 @@ void tty_port_raise_dtr_rts(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
 
 /**
- *	tty_port_lower_dtr_rts	-	Lower DTR/RTS
- *	@port: tty port
+ * tty_port_lower_dtr_rts() - Lower DTR/RTS
+ * @port: tty port
  *
- *	Wrapper for the DTR/RTS raise logic. For the moment this is used
- *	to hide some internal details. This will eventually become entirely
- *	internal to the tty port.
+ * Wrapper for the DTR/RTS raise logic. For the moment this is used
+ * to hide some internal details. This will eventually become entirely
+ * internal to the tty port.
  */
 void tty_port_lower_dtr_rts(struct tty_port *port)
 {
@@ -435,28 +435,28 @@ void tty_port_lower_dtr_rts(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_lower_dtr_rts);
 
 /**
- *	tty_port_block_til_ready	-	Waiting logic for tty open
- *	@port: the tty port being opened
- *	@tty: the tty device being bound
- *	@filp: the file pointer of the opener or NULL
+ * tty_port_block_til_ready() - Waiting logic for tty open
+ * @port: the tty port being opened
+ * @tty: the tty device being bound
+ * @filp: the file pointer of the opener or NULL
  *
- *	Implement the core POSIX/SuS tty behaviour when opening a tty device.
- *	Handles:
- *		- hangup (both before and during)
- *		- non blocking open
- *		- rts/dtr/dcd
- *		- signals
- *		- port flags and counts
+ * Implement the core POSIX/SuS tty behaviour when opening a tty device.
+ * Handles:
+ *  - hangup (both before and during)
+ *  - non blocking open
+ *  - rts/dtr/dcd
+ *  - signals
+ *  - port flags and counts
  *
- *	The passed tty_port must implement the carrier_raised method if it can
- *	do carrier detect and the dtr_rts method if it supports software
- *	management of these lines. Note that the dtr/rts raise is done each
- *	iteration as a hangup may have previously dropped them while we wait.
+ * The passed tty_port must implement the carrier_raised method if it can
+ * do carrier detect and the dtr_rts method if it supports software
+ * management of these lines. Note that the dtr/rts raise is done each
+ * iteration as a hangup may have previously dropped them while we wait.
  *
- *	Caller holds tty lock.
+ * Caller holds tty lock.
  *
- *      NB: May drop and reacquire tty lock when blocking, so tty and tty_port
- *      may have changed state (eg., may have been hung up).
+ * NB: May drop and reacquire tty lock when blocking, so tty and tty_port
+ * may have changed state (eg., may have been hung up).
  */
 int tty_port_block_til_ready(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
@@ -623,7 +623,7 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 EXPORT_SYMBOL(tty_port_close_end);
 
 /**
- * tty_port_close
+ * tty_port_close()
  *
  * Caller holds tty lock
  */
@@ -640,7 +640,7 @@ void tty_port_close(struct tty_port *port, struct tty_struct *tty,
 EXPORT_SYMBOL(tty_port_close);
 
 /**
- * tty_port_install - generic tty->ops->install handler
+ * tty_port_install() - generic tty->ops->install handler
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @tty: tty to be installed
@@ -658,7 +658,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
 EXPORT_SYMBOL_GPL(tty_port_install);
 
 /**
- * tty_port_open
+ * tty_port_open()
  *
  * Caller holds tty lock.
  *
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 71086e4abc9a..74f4ef98aa7d 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -646,15 +646,15 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 }
 
 /**
- *	con_set_default_unimap	-	set default unicode map
- *	@vc: the console we are updating
+ * con_set_default_unimap() - set default unicode map
+ * @vc: the console we are updating
  *
- *	Loads the unimap for the hardware font, as defined in uni_hash.tbl.
- *	The representation used was the most compact I could come up
- *	with.  This routine is executed at video setup, and when the
- *	PIO_FONTRESET ioctl is called.
+ * Loads the unimap for the hardware font, as defined in uni_hash.tbl.
+ * The representation used was the most compact I could come up
+ * with.  This routine is executed at video setup, and when the
+ * PIO_FONTRESET ioctl is called.
  *
- *	The caller must hold the console lock
+ * The caller must hold the console lock
  */
 int con_set_default_unimap(struct vc_data *vc)
 {
@@ -706,11 +706,11 @@ int con_set_default_unimap(struct vc_data *vc)
 EXPORT_SYMBOL(con_set_default_unimap);
 
 /**
- *	con_copy_unimap		-	copy unimap between two vts
- *	@dst_vc: target
- *	@src_vt: source
+ * con_copy_unimap() - copy unimap between two vts
+ * @dst_vc: target
+ * @src_vt: source
  *
- *	The caller must hold the console lock when invoking this method
+ * The caller must hold the console lock when invoking this method
  */
 int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc)
 {
@@ -729,11 +729,11 @@ int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc)
 EXPORT_SYMBOL(con_copy_unimap);
 
 /**
- *	con_get_unimap		-	get the unicode map
- *	@vc: the console to read from
+ * con_get_unimap() - get the unicode map
+ * @vc: the console to read from
  *
- *	Read the console unicode data for this console. Called from the ioctl
- *	handlers.
+ * Read the console unicode data for this console. Called from the ioctl
+ * handlers.
  */
 int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct unipair __user *list)
 {
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 4d044bc7122f..3c3eb14e1565 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1134,11 +1134,11 @@ static inline unsigned char getleds(void)
 }
 
 /**
- *	vt_get_leds	-	helper for braille console
- *	@console: console to read
- *	@flag: flag we want to check
+ * vt_get_leds() - helper for braille console
+ * @console: console to read
+ * @flag: flag we want to check
  *
- *	Check the status of a keyboard led flag and report it back
+ * Check the status of a keyboard led flag and report it back
  */
 int vt_get_leds(int console, int flag)
 {
@@ -1155,12 +1155,12 @@ int vt_get_leds(int console, int flag)
 EXPORT_SYMBOL_GPL(vt_get_leds);
 
 /**
- *	vt_set_led_state	-	set LED state of a console
- *	@console: console to set
- *	@leds: LED bits
+ * vt_set_led_state() - set LED state of a console
+ * @console: console to set
+ * @leds: LED bits
  *
- *	Set the LEDs on a console. This is a wrapper for the VT layer
- *	so that we can keep kbd knowledge internal
+ * Set the LEDs on a console. This is a wrapper for the VT layer
+ * so that we can keep kbd knowledge internal
  */
 void vt_set_led_state(int console, int leds)
 {
@@ -1169,17 +1169,17 @@ void vt_set_led_state(int console, int leds)
 }
 
 /**
- *	vt_kbd_con_start	-	Keyboard side of console start
- *	@console: console
+ * vt_kbd_con_start() - Keyboard side of console start
+ * @console: console
  *
- *	Handle console start. This is a wrapper for the VT layer
- *	so that we can keep kbd knowledge internal
+ * Handle console start. This is a wrapper for the VT layer
+ * so that we can keep kbd knowledge internal
  *
- *	FIXME: We eventually need to hold the kbd lock here to protect
- *	the LED updating. We can't do it yet because fn_hold calls stop_tty
- *	and start_tty under the kbd_event_lock, while normal tty paths
- *	don't hold the lock. We probably need to split out an LED lock
- *	but not during an -rc release!
+ * FIXME: We eventually need to hold the kbd lock here to protect
+ * the LED updating. We can't do it yet because fn_hold calls stop_tty
+ * and start_tty under the kbd_event_lock, while normal tty paths
+ * don't hold the lock. We probably need to split out an LED lock
+ * but not during an -rc release!
  */
 void vt_kbd_con_start(int console)
 {
@@ -1192,11 +1192,11 @@ void vt_kbd_con_start(int console)
 }
 
 /**
- *	vt_kbd_con_stop		-	Keyboard side of console stop
- *	@console: console
+ * vt_kbd_con_stop() - Keyboard side of console stop
+ * @console: console
  *
- *	Handle console stop. This is a wrapper for the VT layer
- *	so that we can keep kbd knowledge internal
+ * Handle console stop. This is a wrapper for the VT layer
+ * so that we can keep kbd knowledge internal
  */
 void vt_kbd_con_stop(int console)
 {
@@ -1634,13 +1634,13 @@ int __init kbd_init(void)
 /* Ioctl support code */
 
 /**
- *	vt_do_diacrit		-	diacritical table updates
- *	@cmd: ioctl request
- *	@udp: pointer to user data for ioctl
- *	@perm: permissions check computed by caller
+ * vt_do_diacrit() - diacritical table updates
+ * @cmd: ioctl request
+ * @udp: pointer to user data for ioctl
+ * @perm: permissions check computed by caller
  *
- *	Update the diacritical tables atomically and safely. Lock them
- *	against simultaneous keypresses
+ * Update the diacritical tables atomically and safely. Lock them
+ * against simultaneous keypresses
  */
 int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 {
@@ -1784,12 +1784,12 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 }
 
 /**
- *	vt_do_kdskbmode		-	set keyboard mode ioctl
- *	@console: the console to use
- *	@arg: the requested mode
+ * vt_do_kdskbmode() - set keyboard mode ioctl
+ * @console: the console to use
+ * @arg: the requested mode
  *
- *	Update the keyboard mode bits while holding the correct locks.
- *	Return 0 for success or an error code.
+ * Update the keyboard mode bits while holding the correct locks.
+ * Return 0 for success or an error code.
  */
 int vt_do_kdskbmode(int console, unsigned int arg)
 {
@@ -1824,12 +1824,12 @@ int vt_do_kdskbmode(int console, unsigned int arg)
 }
 
 /**
- *	vt_do_kdskbmeta		-	set keyboard meta state
- *	@console: the console to use
- *	@arg: the requested meta state
+ * vt_do_kdskbmeta() - set keyboard meta state
+ * @console: the console to use
+ * @arg: the requested meta state
  *
- *	Update the keyboard meta bits while holding the correct locks.
- *	Return 0 for success or an error code.
+ * Update the keyboard meta bits while holding the correct locks.
+ * Return 0 for success or an error code.
  */
 int vt_do_kdskbmeta(int console, unsigned int arg)
 {
@@ -2158,10 +2158,10 @@ int vt_do_kdgkbmode(int console)
 }
 
 /**
- *	vt_do_kdgkbmeta		-	report meta status
- *	@console: console to report
+ * vt_do_kdgkbmeta() - report meta status
+ * @console: console to report
  *
- *	Report the meta flag status of this console
+ * Report the meta flag status of this console
  */
 int vt_do_kdgkbmeta(int console)
 {
@@ -2171,10 +2171,10 @@ int vt_do_kdgkbmeta(int console)
 }
 
 /**
- *	vt_reset_unicode	-	reset the unicode status
- *	@console: console being reset
+ * vt_reset_unicode() - reset the unicode status
+ * @console: console being reset
  *
- *	Restore the unicode console state to its default
+ * Restore the unicode console state to its default
  */
 void vt_reset_unicode(int console)
 {
@@ -2186,10 +2186,10 @@ void vt_reset_unicode(int console)
 }
 
 /**
- *	vt_get_shiftstate	-	shift bit state
+ * vt_get_shiftstate() - shift bit state
  *
- *	Report the shift bits from the keyboard state. We have to export
- *	this to support some oddities in the vt layer.
+ * Report the shift bits from the keyboard state. We have to export
+ * this to support some oddities in the vt layer.
  */
 int vt_get_shift_state(void)
 {
@@ -2198,11 +2198,11 @@ int vt_get_shift_state(void)
 }
 
 /**
- *	vt_reset_keyboard	-	reset keyboard state
- *	@console: console to reset
+ * vt_reset_keyboard() - reset keyboard state
+ * @console: console to reset
  *
- *	Reset the keyboard bits for a console as part of a general console
- *	reset event
+ * Reset the keyboard bits for a console as part of a general console
+ * reset event
  */
 void vt_reset_keyboard(int console)
 {
@@ -2226,12 +2226,12 @@ void vt_reset_keyboard(int console)
 }
 
 /**
- *	vt_get_kbd_mode_bit	-	read keyboard status bits
- *	@console: console to read from
- *	@bit: mode bit to read
+ * vt_get_kbd_mode_bit() - read keyboard status bits
+ * @console: console to read from
+ * @bit: mode bit to read
  *
- *	Report back a vt mode bit. We do this without locking so the
- *	caller must be sure that there are no synchronization needs
+ * Report back a vt mode bit. We do this without locking so the
+ * caller must be sure that there are no synchronization needs
  */
 
 int vt_get_kbd_mode_bit(int console, int bit)
@@ -2241,12 +2241,12 @@ int vt_get_kbd_mode_bit(int console, int bit)
 }
 
 /**
- *	vt_set_kbd_mode_bit	-	read keyboard status bits
- *	@console: console to read from
- *	@bit: mode bit to read
+ * vt_set_kbd_mode_bit() - read keyboard status bits
+ * @console: console to read from
+ * @bit: mode bit to read
  *
- *	Set a vt mode bit. We do this without locking so the
- *	caller must be sure that there are no synchronization needs
+ * Set a vt mode bit. We do this without locking so the
+ * caller must be sure that there are no synchronization needs
  */
 
 void vt_set_kbd_mode_bit(int console, int bit)
@@ -2260,12 +2260,12 @@ void vt_set_kbd_mode_bit(int console, int bit)
 }
 
 /**
- *	vt_clr_kbd_mode_bit	-	read keyboard status bits
- *	@console: console to read from
- *	@bit: mode bit to read
+ * vt_clr_kbd_mode_bit() - read keyboard status bits
+ * @console: console to read from
+ * @bit: mode bit to read
  *
- *	Report back a vt mode bit. We do this without locking so the
- *	caller must be sure that there are no synchronization needs
+ * Report back a vt mode bit. We do this without locking so the
+ * caller must be sure that there are no synchronization needs
  */
 
 void vt_clr_kbd_mode_bit(int console, int bit)
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 75aa58ea79b6..473015beb0f2 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -67,10 +67,10 @@ sel_pos(int n)
 }
 
 /**
- *	clear_selection		-	remove current selection
+ * clear_selection() - remove current selection
  *
- *	Remove the current selection highlight, if any from the console
- *	holding the selection. The caller must hold the console lock.
+ * Remove the current selection highlight, if any from the console
+ * holding the selection. The caller must hold the console lock.
  */
 void clear_selection(void)
 {
@@ -98,11 +98,11 @@ static inline int inword(const u32 c)
 }
 
 /**
- *	set loadlut		-	load the LUT table
- *	@p: user table
+ * sel_loadlut() - load the LUT table
+ * @p: user table
  *
- *	Load the LUT table from user space. The caller must hold the console
- *	lock. Make a temporary copy so a partial update doesn't make a mess.
+ * Load the LUT table from user space. The caller must hold the console
+ * lock. Make a temporary copy so a partial update doesn't make a mess.
  */
 int sel_loadlut(char __user *p)
 {
@@ -154,14 +154,14 @@ static int store_utf8(u32 c, char *p)
 }
 
 /**
- *	set_selection		-	set the current selection.
- *	@sel: user selection info
- *	@tty: the console tty
+ * set_selection() - set the current selection.
+ * @sel: user selection info
+ * @tty: the console tty
  *
- *	Invoked by the ioctl handle for the vt layer.
+ * Invoked by the ioctl handle for the vt layer.
  *
- *	The entire selection process is managed under the console_lock. It's
- *	 a lot under the lock but its hardly a performance path
+ * The entire selection process is managed under the console_lock. It's
+ * a lot under the lock but its hardly a performance path
  */
 int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty)
 {
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 27f0f19a4c31..dae5a7a82aee 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1129,19 +1129,19 @@ static inline int resize_screen(struct vc_data *vc, int width, int height,
 #define VC_RESIZE_MAXROW (32767)
 
 /**
- *	vc_do_resize	-	resizing method for the tty
- *	@tty: tty being resized
- *	@real_tty: real tty (different to tty if a pty/tty pair)
- *	@vc: virtual console private data
- *	@cols: columns
- *	@lines: lines
+ * vc_do_resize() - resizing method for the tty
+ * @tty: tty being resized
+ * @real_tty: real tty (different to tty if a pty/tty pair)
+ * @vc: virtual console private data
+ * @cols: columns
+ * @lines: lines
  *
- *	Resize a virtual console, clipping according to the actual constraints.
- *	If the caller passes a tty structure then update the termios winsize
- *	information and perform any necessary signal handling.
+ * Resize a virtual console, clipping according to the actual constraints.
+ * If the caller passes a tty structure then update the termios winsize
+ * information and perform any necessary signal handling.
  *
- *	Caller must hold the console semaphore. Takes the termios rwsem and
- *	ctrl_lock of the tty IFF a tty is passed.
+ * Caller must hold the console semaphore. Takes the termios rwsem and
+ * ctrl_lock of the tty IFF a tty is passed.
  */
 
 static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
@@ -1279,15 +1279,15 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 }
 
 /**
- *	vc_resize		-	resize a VT
- *	@vc: virtual console
- *	@cols: columns
- *	@rows: rows
+ * vc_resize() - resize a VT
+ * @vc: virtual console
+ * @cols: columns
+ * @rows: rows
  *
- *	Resize a virtual console as seen from the console end of things. We
- *	use the common vc_do_resize methods to update the structures. The
- *	caller must hold the console sem to protect console internals and
- *	vc->port.tty
+ * Resize a virtual console as seen from the console end of things. We
+ * use the common vc_do_resize methods to update the structures. The
+ * caller must hold the console sem to protect console internals and
+ * vc->port.tty
  */
 
 int vc_resize(struct vc_data *vc, unsigned int cols, unsigned int rows)
@@ -1296,16 +1296,16 @@ int vc_resize(struct vc_data *vc, unsigned int cols, unsigned int rows)
 }
 
 /**
- *	vt_resize		-	resize a VT
- *	@tty: tty to resize
- *	@ws: winsize attributes
+ * vt_resize() - resize a VT
+ * @tty: tty to resize
+ * @ws: winsize attributes
  *
- *	Resize a virtual terminal. This is called by the tty layer as we
- *	register our own handler for resizing. The mutual helper does all
- *	the actual work.
+ * Resize a virtual terminal. This is called by the tty layer as we
+ * register our own handler for resizing. The mutual helper does all
+ * the actual work.
  *
- *	Takes the console sem and the called methods then take the tty
- *	termios_rwsem and the tty ctrl_lock in that order.
+ * Takes the console sem and the called methods then take the tty
+ * termios_rwsem and the tty ctrl_lock in that order.
  */
 static int vt_resize(struct tty_struct *tty, struct winsize *ws)
 {
@@ -2846,8 +2846,8 @@ struct tty_driver *console_driver;
 
 /**
  * vt_kmsg_redirect() - Sets/gets the kernel message console
- * @new:	The new virtual terminal number or -1 if the console should stay
- *		unchanged
+ * @new: The new virtual terminal number or -1 if the console should stay
+ *       unchanged
  *
  * By default, the kernel messages are always printed on the current virtual
  * console. However, the user may modify that default with the
@@ -3794,7 +3794,7 @@ static void vtconsole_deinit_device(struct con_driver *con)
 }
 
 /**
- * con_is_bound - checks if driver is bound to the console
+ * con_is_bound() - checks if driver is bound to the console
  * @csw: console driver
  *
  * RETURNS: zero if unbound, nonzero if bound
@@ -3818,7 +3818,7 @@ int con_is_bound(const struct consw *csw)
 EXPORT_SYMBOL(con_is_bound);
 
 /**
- * con_debug_enter - prepare the console for the kernel debugger
+ * con_debug_enter() - prepare the console for the kernel debugger
  * @sw: console driver
  *
  * Called when the console is taken over by the kernel debugger, this
@@ -3876,7 +3876,7 @@ int con_debug_enter(struct vc_data *vc)
 EXPORT_SYMBOL_GPL(con_debug_enter);
 
 /**
- * con_debug_leave - restore console state
+ * con_debug_leave() - restore console state
  * @sw: console driver
  *
  * Restore the console state to what it was before the kernel debugger
@@ -3974,7 +3974,7 @@ static int do_register_con_driver(const struct consw *csw, int first, int last)
 
 
 /**
- * do_unregister_con_driver - unregister console driver from console layer
+ * do_unregister_con_driver() - unregister console driver from console layer
  * @csw: console driver
  *
  * DESCRIPTION: All drivers that registers to the console layer must
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 801f2f6e1302..0d1b232cb5fd 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -79,12 +79,12 @@ static DEFINE_SPINLOCK(vt_event_lock);
 static DECLARE_WAIT_QUEUE_HEAD(vt_event_waitqueue);
 
 /**
- *	vt_event_post
- *	@event: the event that occurred
- *	@old: old console
- *	@new: new console
+ * vt_event_post()
+ * @event: the event that occurred
+ * @old: old console
+ * @new: new console
  *
- *	Post an VT event to interested VT handlers
+ * Post an VT event to interested VT handlers
  */
 
 void vt_event_post(unsigned int event, unsigned int old, unsigned int new)
@@ -143,14 +143,13 @@ static void __vt_event_dequeue(struct vt_event_wait *vw)
 }
 
 /**
- *	vt_event_wait		-	wait for an event
- *	@vw: our event
+ * vt_event_wait() - wait for an event
+ * @vw: our event
  *
- *	Waits for an event to occur which completes our vt_event_wait
- *	structure. On return the structure has wv->done set to 1 for success
- *	or 0 if some event such as a signal ended the wait.
+ * Waits for an event to occur which completes our vt_event_wait
+ * structure. On return the structure has wv->done set to 1 for success
+ * or 0 if some event such as a signal ended the wait.
  */
-
 static void vt_event_wait(struct vt_event_wait *vw)
 {
 	__vt_event_queue(vw);
@@ -159,10 +158,10 @@ static void vt_event_wait(struct vt_event_wait *vw)
 }
 
 /**
- *	vt_event_wait_ioctl	-	event ioctl handler
- *	@arg: argument to ioctl
+ * vt_event_wait_ioctl() - event ioctl handler
+ * @arg: argument to ioctl
  *
- *	Implement the VT_WAITEVENT ioctl using the VT event interface
+ * Implement the VT_WAITEVENT ioctl using the VT event interface
  */
 
 static int vt_event_wait_ioctl(struct vt_event __user *event)
@@ -186,12 +185,12 @@ static int vt_event_wait_ioctl(struct vt_event __user *event)
 }
 
 /**
- *	vt_waitactive	-	active console wait
- *	@event: event code
- *	@n: new console
+ * vt_waitactive() - active console wait
+ * @event: event code
+ * @n: new console
  *
- *	Helper for event waits. Used to implement the legacy
- *	event waiting ioctls in terms of events
+ * Helper for event waits. Used to implement the legacy
+ * event waiting ioctls in terms of events
  */
 
 int vt_waitactive(int n)
-- 
2.17.1

