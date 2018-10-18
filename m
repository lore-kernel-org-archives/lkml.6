Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C493ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2042020866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="taOmORyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2042020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJSGlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:41:42 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:33219 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727219AbeJSGlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:41:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C485FC7E;
        Thu, 18 Oct 2018 18:38:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Oct 2018 18:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=vhSkcABHhQuth5OaBRwDaq9eebhXk
        RvUoMg/d0HeQNQ=; b=taOmORyqyBCPrniFU7uxEWq/MQ2iKFqLWFbmKnuVpAOPy
        VtJjZaV1duLbI9cksdfn8hlvPPOHH7WZjW58tnwE4vfpVxOIMhlQ/rHmyvM0gVAL
        gBhcCUQASN+TuRcVh6eWCrqXrYSG7R8jQekKn9C7mKX+vmaUN+Bnoi2IRSlRXYPU
        ko4NqnH9dBu38mj8RfpCwPcWuFdBZJ6xgZ+jS4SWV8ZEqUedi+bHt2iR+XWnqvpy
        EBSoadyAHYhBoyM9qr/YQyYCsOBMdt67CTQFsMkcvnrGAmow0g9kh7bGpeSEDlyf
        N7Surc+v7FF0gRHvSn9zq0jBL8l3nIxW23bo19y0g==
X-ME-Sender: <xms:ZQvJW_k7N_fpMIJW8gEfGe8f0QJ-gyt_va_sHbkcOExxzeAaKeeImA>
X-ME-Proxy: <xmx:ZQvJWybKi3KYZ8dGc50yuSp7Qcgbza410CFSYyMM83kGiYPRdPZcKw>
    <xmx:ZQvJW-hjYw6sDHXZvsLPl8bPDZMd8F_OyERuBNJ0LVEc_zpQPXmWfw>
    <xmx:ZQvJW11sGEobZBBbgXNfIVgcGjpW67unxtiVK2F7ZQANkBF716L6DA>
    <xmx:ZQvJW3SlmJkxjLKmsjkWLJB3A1aV66xdZ3CkTZ1fJbslna8rEUgJ0g>
    <xmx:ZQvJW1AFq712pexW-r_RrtPn4rleiXQiUHQTIDVbWBxFgtkAp7X4Zg>
    <xmx:ZQvJW0-U1s3GLNWdXbLNForhppZK77XXF_G1TtUottdT9VnDt-7xCA>
Received: from localhost (124-169-31-211.dyn.iinet.net.au [124.169.31.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id D62F6E4408;
        Thu, 18 Oct 2018 18:38:27 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] tty: Remove newline after function kernel-doc
Date:   Fri, 19 Oct 2018 09:37:06 +1100
Message-Id: <20181018223707.9891-7-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018223707.9891-1-tobin@kernel.org>
References: <20181018223707.9891-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are many places were a newline is left between the
kernel-doc function comment and the function it is documenting.  There
should not be a newline here.

Remove newline after function kernel-doc.  This patch is whitespace
only.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

 drivers/tty/n_gsm.c                | 46 ------------------------------
 drivers/tty/n_tty.c                | 33 ---------------------
 drivers/tty/pty.c                  |  7 -----
 drivers/tty/serial/ifx6x60.c       |  5 ----
 drivers/tty/serial/ioc3_serial.c   |  5 ----
 drivers/tty/serial/ioc4_serial.c   |  3 --
 drivers/tty/serial/men_z135_uart.c |  1 -
 drivers/tty/serial/sn_console.c    |  1 -
 drivers/tty/tty_baudrate.c         |  4 ---
 drivers/tty/tty_buffer.c           | 14 ---------
 drivers/tty/tty_io.c               | 36 -----------------------
 drivers/tty/tty_ioctl.c            | 13 ---------
 drivers/tty/tty_ldisc.c            | 19 ------------
 drivers/tty/vt/vt_ioctl.c          |  3 --
 14 files changed, 190 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e25944ee2766..c65a9afb7cc4 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -366,7 +366,6 @@ static const u8 gsm_fcs8[256] = {
  * Update the FCS to include c. Uses the algorithm in the specification
  * notes.
  */
-
 static inline u8 gsm_fcs_add(u8 fcs, u8 c)
 {
 	return gsm_fcs8[fcs ^ c];
@@ -381,7 +380,6 @@ static inline u8 gsm_fcs_add(u8 fcs, u8 c)
  * Update the FCS to include c. Uses the algorithm in the specification
  * notes.
  */
-
 static inline u8 gsm_fcs_add_block(u8 fcs, u8 *c, int len)
 {
 	while (len--)
@@ -397,7 +395,6 @@ static inline u8 gsm_fcs_add_block(u8 fcs, u8 *c, int len)
  * Processes one byte of an EA. Updates the passed variable
  * and returns 1 if the EA is now completely read
  */
-
 static int gsm_read_ea(unsigned int *val, u8 c)
 {
 	/* Add the next 7 bits into the value */
@@ -414,7 +411,6 @@ static int gsm_read_ea(unsigned int *val, u8 c)
  * Returns the correct GSM encoded modem status bits (6 bit field) for
  * the current status of the DLCI and attached tty object
  */
-
 static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 {
 	u8 modembits = 0;
@@ -444,7 +440,6 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
  * Displays a packet in human readable format for debugging purposes. The
  * style is based on amateur radio LAP-B dump display.
  */
-
 static void gsm_print_packet(const char *hdr, int addr, int cr,
 					u8 control, const u8 *data, int dlen)
 {
@@ -525,7 +520,6 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
  * is doubling and the caller is responsible for handing out
  * suitable sized buffers.
  */
-
 static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
 {
 	int olen = 0;
@@ -555,7 +549,6 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
  *
  * FIXME: Lock versus data TX path
  */
-
 static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 {
 	int len;
@@ -602,7 +595,6 @@ static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
  *
  * Format up and transmit a link level response frame.
  */
-
 static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
 {
 	gsm_send(gsm, addr, 0, control);
@@ -616,7 +608,6 @@ static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
  *
  * Format up and transmit a link level command frame.
  */
-
 static inline void gsm_command(struct gsm_mux *gsm, int addr, int control)
 {
 	gsm_send(gsm, addr, 1, control);
@@ -637,7 +628,6 @@ static inline void gsm_command(struct gsm_mux *gsm, int addr, int control)
  * at the front for header bytes but that is treated as an implementation
  * detail and not for the high level code to use
  */
-
 static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 								u8 ctrl)
 {
@@ -664,7 +654,6 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
  *
  * FIXME: lock against link layer control transmissions
  */
-
 static void gsm_data_kick(struct gsm_mux *gsm)
 {
 	struct gsm_msg *msg, *nmsg;
@@ -715,7 +704,6 @@ static void gsm_data_kick(struct gsm_mux *gsm)
  * out of the mux tty if not already doing so. The Caller must hold
  * the gsm tx lock.
  */
-
 static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 {
 	struct gsm_mux *gsm = dlci->gsm;
@@ -766,7 +754,6 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
  * out of the mux tty if not already doing so. Take the
  * the gsm tx lock and dlci lock.
  */
-
 static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 {
 	unsigned long flags;
@@ -786,7 +773,6 @@ static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
  *
  * Caller must hold the tx_lock of the mux.
  */
-
 static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 {
 	struct gsm_msg *msg;
@@ -839,7 +825,6 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
  *
  * Caller must hold the tx_lock of the mux.
  */
-
 static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 						struct gsm_dlci *dlci)
 {
@@ -913,7 +898,6 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
  * FIXME: We should round robin between groups and in theory you can
  * renegotiate DLCI priorities with optional stuff. Needs optimising.
  */
-
 static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
 {
 	int len;
@@ -950,7 +934,6 @@ static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
  * a tty wakeup except when we filled the pipe so we need to fire off
  * new data ourselves in other cases.
  */
-
 static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
 {
 	unsigned long flags;
@@ -987,7 +970,6 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
  *
  * Encode up and queue a UI/UIH frame containing our response.
  */
-
 static void gsm_control_reply(struct gsm_mux *gsm, int cmd, u8 *data,
 					int dlen)
 {
@@ -1010,7 +992,6 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, u8 *data,
  * Used when a modem control message or line state inline in adaption
  * layer 2 is processed. Sort out the local modem state and throttles
  */
-
 static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 							u32 modem, int clen)
 {
@@ -1072,7 +1053,6 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
  * to indicate break signals. Unpack it, convert to Linux representation
  * and if need be stuff a break message down the tty.
  */
-
 static void gsm_control_modem(struct gsm_mux *gsm, u8 *data, int clen)
 {
 	unsigned int addr = 0;
@@ -1133,7 +1113,6 @@ static void gsm_control_modem(struct gsm_mux *gsm, u8 *data, int clen)
  * it wishes to send us an error state from the virtual link. Stuff
  * this into the uplink tty if present
  */
-
 static void gsm_control_rls(struct gsm_mux *gsm, u8 *data, int clen)
 {
 	struct tty_port *port;
@@ -1187,7 +1166,6 @@ static void gsm_dlci_begin_close(struct gsm_dlci *dlci);
  * Processes the incoming request and queues a response frame or an
  * NSC response if not supported
  */
-
 static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 							u8 *data, int clen)
 {
@@ -1259,7 +1237,6 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
  * is done by the caller, we just update the fields, flag it as done
  * and return
  */
-
 static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 							u8 *data, int clen)
 {
@@ -1291,7 +1268,6 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
  *
  * Send out a pending control command (called under control lock)
  */
-
 static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
 {
 	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, ctrl->len + 1, gsm->ftype);
@@ -1312,7 +1288,6 @@ static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
  * In that situation the timer may still occur in a small window but
  * gsm->pending_cmd will be NULL and we just let the timer expire.
  */
-
 static void gsm_control_retransmit(struct timer_list *t)
 {
 	struct gsm_mux *gsm = from_timer(gsm, t, t2_timer);
@@ -1347,7 +1322,6 @@ static void gsm_control_retransmit(struct timer_list *t)
  * active at a time. In theory more can be outstanding but the matching
  * gets really complicated so for now stick to one outstanding.
  */
-
 static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
 		unsigned int command, u8 *data, int clen)
 {
@@ -1389,7 +1363,6 @@ static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
  * resources and returns 0 for success, or an error if the remote
  * rejected or ignored the request.
  */
-
 static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
 {
 	int err;
@@ -1415,7 +1388,6 @@ static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
  * Perform processing when moving a DLCI into closed state. If there
  * is an attached tty this is hung up
  */
-
 static void gsm_dlci_close(struct gsm_dlci *dlci)
 {
 	del_timer(&dlci->t1);
@@ -1438,7 +1410,6 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
  *
  * Perform processing when moving a DLCI into open state.
  */
-
 static void gsm_dlci_open(struct gsm_dlci *dlci)
 {
 	/* Note that SABM UA .. SABM UA first UA lost can mean that we go
@@ -1465,7 +1436,6 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
  * fine. In that case we can just keep the control dlci open after the
  * DLCI_OPENING retries time out.
  */
-
 static void gsm_dlci_t1(struct timer_list *t)
 {
 	struct gsm_dlci *dlci = from_timer(dlci, t, t1);
@@ -1508,7 +1478,6 @@ static void gsm_dlci_t1(struct timer_list *t)
  * we will move into open state. Opening is done asynchronously with retry
  * running off timers and the responses.
  */
-
 static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 {
 	struct gsm_mux *gsm = dlci->gsm;
@@ -1530,7 +1499,6 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
  * off timers. We may also receive a DM reply from the other end which
  * indicates the channel was already closed.
  */
-
 static void gsm_dlci_begin_close(struct gsm_dlci *dlci)
 {
 	struct gsm_mux *gsm = dlci->gsm;
@@ -1552,7 +1520,6 @@ static void gsm_dlci_begin_close(struct gsm_dlci *dlci)
  * other than the control channel. If the relevant virtual tty is
  * open we shovel the bits down it, if not we drop them.
  */
-
 static void gsm_dlci_data(struct gsm_dlci *dlci, u8 *data, int clen)
 {
 	/* krefs .. */
@@ -1602,7 +1569,6 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, u8 *data, int clen)
  * control data bytes. The command EA contains a command/response bit
  * and we divide up the work accordingly.
  */
-
 static void gsm_dlci_command(struct gsm_dlci *dlci, u8 *data, int len)
 {
 	/* See what command is involved */
@@ -1640,7 +1606,6 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, u8 *data, int len)
  *
  * FIXME: review locking races
  */
-
 static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 {
 	struct gsm_dlci *dlci = kzalloc(sizeof(struct gsm_dlci), GFP_ATOMIC);
@@ -1741,7 +1706,6 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
  * been handled below us and the frame is unpacked into the structures.
  * The fcs holds the header FCS but any data FCS must be added here.
  */
-
 static void gsm_queue(struct gsm_mux *gsm)
 {
 	struct gsm_dlci *dlci;
@@ -2012,7 +1976,6 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
  *
  * FIXME: better diagnostics ?
  */
-
 static void gsm_error(struct gsm_mux *gsm,
 				unsigned char data, unsigned char flag)
 {
@@ -2055,7 +2018,6 @@ static int gsm_disconnect(struct gsm_mux *gsm)
  * protocols. Remove the mux from the mux table, stop all the timers
  * and then shut down each device hanging up the channels as we go.
  */
-
 static void gsm_cleanup_mux(struct gsm_mux *gsm)
 {
 	int i;
@@ -2101,7 +2063,6 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
  * protocols. Add the mux to the mux table so it can be opened and
  * finally kick off connecting to DLCI 0 on the modem.
  */
-
 static int gsm_activate_mux(struct gsm_mux *gsm)
 {
 	struct gsm_dlci *dlci;
@@ -2220,7 +2181,6 @@ static struct gsm_mux *gsm_alloc_mux(void)
  * Write a block of data from the GSM mux to the data channel. This
  * will eventually be serialized from above but at the moment isn't.
  */
-
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 {
 	if (tty_write_room(gsm->tty) < len) {
@@ -2243,7 +2203,6 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
  * modem. Currently called from the line discipline set up but
  * will need moving to an ioctl path.
  */
-
 static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
 	int ret, i, base;
@@ -2340,7 +2299,6 @@ static void gsmld_flush_buffer(struct tty_struct *tty)
  * discipline change. The function will not be called while other
  * ldisc methods are in progress.
  */
-
 static void gsmld_close(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm = tty->disc_data;
@@ -2361,7 +2319,6 @@ static void gsmld_close(struct tty_struct *tty)
  * other events will occur in parallel. No further open will occur
  * until a close.
  */
-
 static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
@@ -2426,7 +2383,6 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
  *
  * This code must be sure never to sleep through a hangup.
  */
-
 static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
 			 unsigned char __user *buf, size_t nr)
 {
@@ -2446,7 +2402,6 @@ static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
  * by userspace. Frames are either sent whole or not at all as this
  * avoids pain user side.
  */
-
 static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *buf, size_t nr)
 {
@@ -2470,7 +2425,6 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
  * This code must be sure never to sleep through a hangup.
  * Called without the kernel lock held - fine
  */
-
 static __poll_t gsmld_poll(struct tty_struct *tty, struct file *file,
 							poll_table *wait)
 {
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index af0836f11459..3e2b59e99153 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -198,7 +198,6 @@ static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
  * n_tty_read()/consumer path:
  *    holds non-exclusive termios_rwsem
  */
-
 static void n_tty_kick_worker(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -239,7 +238,6 @@ static ssize_t chars_in_buffer(struct tty_struct *tty)
  * that attach themselves to the master and rely on ASYNC
  * IO must be woken up
  */
-
 static void n_tty_write_wakeup(struct tty_struct *tty)
 {
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -311,7 +309,6 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
  * n_tty_receive_buf()/producer path:
  *     caller holds non-exclusive termios_rwsem
  */
-
 static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
 {
 	*read_buf_addr(ldata, ldata->read_head) = c;
@@ -328,7 +325,6 @@ static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
  * Locking: caller holds exclusive termios_rwsem
  *          (or locking is not required)
  */
-
 static void reset_buffer_flags(struct n_tty_data *ldata)
 {
 	ldata->read_head = ldata->canon_head = ldata->read_tail = 0;
@@ -365,7 +361,6 @@ static void n_tty_packet_mode_flush(struct tty_struct *tty)
  *
  * Locking: ctrl_lock, exclusive termios_rwsem
  */
-
 static void n_tty_flush_buffer(struct tty_struct *tty)
 {
 	down_write(&tty->termios_rwsem);
@@ -385,7 +380,6 @@ static void n_tty_flush_buffer(struct tty_struct *tty)
  * character. We use this to correctly compute the on screen size
  * of the character when printing
  */
-
 static inline int is_utf8_continuation(unsigned char c)
 {
 	return (c & 0xc0) == 0x80;
@@ -398,7 +392,6 @@ static inline int is_utf8_continuation(unsigned char c)
  * Returns true if the utf8 character 'c' is a multibyte continuation
  * character and the terminal is in unicode mode.
  */
-
 static inline int is_continuation(unsigned char c, struct tty_struct *tty)
 {
 	return I_IUTF8(tty) && is_utf8_continuation(c);
@@ -425,7 +418,6 @@ static inline int is_continuation(unsigned char c, struct tty_struct *tty)
  * Locking: should be called under the output_lock to protect
  *          the column state and space left in the buffer
  */
-
 static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -500,7 +492,6 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
  *          (also, this is called from n_tty_write under the
  *          tty layer write lock)
  */
-
 static int process_output(unsigned char c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -536,7 +527,6 @@ static int process_output(unsigned char c, struct tty_struct *tty)
  *          (also, this is called from n_tty_write under the
  *          tty layer write lock)
  */
-
 static ssize_t process_output_block(struct tty_struct *tty,
 				    const unsigned char *buf, unsigned int nr)
 {
@@ -620,7 +610,6 @@ static ssize_t process_output_block(struct tty_struct *tty,
  *
  * Locking: callers must hold output_lock
  */
-
 static size_t __process_echoes(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -835,7 +824,6 @@ static void flush_echoes(struct tty_struct *tty)
  *
  * Add a character or operation byte to the echo buffer.
  */
-
 static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
 {
 	*echo_buf_addr(ldata, ldata->echo_head) = c;
@@ -849,7 +837,6 @@ static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
  *
  * Add an operation to the echo buffer to move back one column.
  */
-
 static void echo_move_back_col(struct n_tty_data *ldata)
 {
 	add_echo_byte(ECHO_OP_START, ldata);
@@ -863,7 +850,6 @@ static void echo_move_back_col(struct n_tty_data *ldata)
  * Add an operation to the echo buffer to set the canon column
  * to the current column.
  */
-
 static void echo_set_canon_col(struct n_tty_data *ldata)
 {
 	add_echo_byte(ECHO_OP_START, ldata);
@@ -884,7 +870,6 @@ static void echo_set_canon_col(struct n_tty_data *ldata)
  * canon column (if applicable), to go back the correct number
  * of columns.
  */
-
 static void echo_erase_tab(unsigned int num_chars, int after_tab,
 			   struct n_tty_data *ldata)
 {
@@ -911,7 +896,6 @@ static void echo_erase_tab(unsigned int num_chars, int after_tab,
  *
  * This variant does not treat control characters specially.
  */
-
 static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
 {
 	if (c == ECHO_OP_START) {
@@ -933,7 +917,6 @@ static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
  * This variant tags control characters to be echoed as "^X"
  * (where X is the letter representing the control char).
  */
-
 static void echo_char(unsigned char c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -952,7 +935,6 @@ static void echo_char(unsigned char c, struct tty_struct *tty)
  * finish_erasing() - complete erase
  * @ldata: n_tty data
  */
-
 static inline void finish_erasing(struct n_tty_data *ldata)
 {
 	if (ldata->erasing) {
@@ -973,7 +955,6 @@ static inline void finish_erasing(struct n_tty_data *ldata)
  * n_tty_receive_buf()/producer path:
  *     caller holds non-exclusive termios_rwsem
  */
-
 static void eraser(unsigned char c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1106,7 +1087,6 @@ static void eraser(unsigned char c, struct tty_struct *tty)
  *
  * Locking: ctrl_lock
  */
-
 static void __isig(int sig, struct tty_struct *tty)
 {
 	struct pid *tty_pgrp = tty_get_pgrp(tty);
@@ -1163,7 +1143,6 @@ static void isig(int sig, struct tty_struct *tty)
  *
  * Note: may get exclusive termios_rwsem if flushing input buffer
  */
-
 static void n_tty_receive_break(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1193,7 +1172,6 @@ static void n_tty_receive_break(struct tty_struct *tty)
  * need locking as num_overrun and overrun_time are function
  * private.
  */
-
 static void n_tty_receive_overrun(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1264,7 +1242,6 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
  *
  * Returns 1 if LNEXT was received, else returns 0
  */
-
 static int
 n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 {
@@ -1788,7 +1765,6 @@ static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
  *
  * Locking: Caller holds tty->termios_rwsem
  */
-
 static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1882,7 +1858,6 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
  * discipline change. The function will not be called while other
  * ldisc methods are in progress.
  */
-
 static void n_tty_close(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1903,7 +1878,6 @@ static void n_tty_close(struct tty_struct *tty)
  * other events will occur in parallel. No further open will occur
  * until a close.
  */
-
 static int n_tty_open(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata;
@@ -1956,7 +1930,6 @@ static inline int input_available_p(struct tty_struct *tty, int poll)
  *     caller holds non-exclusive termios_rwsem
  *     read_tail published
  */
-
 static int copy_from_read_buf(struct tty_struct *tty,
 				      unsigned char __user **b,
 				      size_t *nr)
@@ -2012,7 +1985,6 @@ static int copy_from_read_buf(struct tty_struct *tty,
  *     caller holds non-exclusive termios_rwsem
  *     read_tail published
  */
-
 static int canon_copy_from_read_buf(struct tty_struct *tty,
 				    unsigned char __user **b,
 				    size_t *nr)
@@ -2093,7 +2065,6 @@ extern ssize_t redirected_tty_write(struct file *, const char __user *,
  *          current->signal->tty check is safe
  *          ctrl_lock to safely reference tty->pgrp
  */
-
 static int job_control(struct tty_struct *tty, struct file *file)
 {
 	/* Job control check -- must be done at start and after
@@ -2126,7 +2097,6 @@ static int job_control(struct tty_struct *tty, struct file *file)
  *     claims non-exclusive termios_rwsem
  *     publishes read_tail
  */
-
 static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 			 unsigned char __user *buf, size_t nr)
 {
@@ -2295,7 +2265,6 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
  *          (note that the process_output*() functions take this
  *          lock themselves)
  */
-
 static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *buf, size_t nr)
 {
@@ -2396,7 +2365,6 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
  * This code must be sure never to sleep through a hangup.
  * Called without the kernel lock held - fine
  */
-
 static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
 							poll_table *wait)
 {
@@ -2487,7 +2455,6 @@ static struct tty_ldisc_ops n_tty_ops = {
  *
  * Enables a 'subclass' line discipline to 'inherit' N_TTY methods.
  */
-
 void n_tty_inherit_ops(struct tty_ldisc_ops *ops)
 {
 	*ops = n_tty_ops;
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index a8ec902fd9be..35cb13995c1c 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -106,7 +106,6 @@ static void pty_unthrottle(struct tty_struct *tty)
  * end of the link as if we were an IRQ handler receiving stuff for
  * the other side of the pty/tty pair.
  */
-
 static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 {
 	struct tty_struct *to = tty->link;
@@ -134,7 +133,6 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
  * Report how many bytes the ldisc can send into the queue for
  * the other device.
  */
-
 static int pty_write_room(struct tty_struct *tty)
 {
 	if (tty->stopped)
@@ -149,7 +147,6 @@ static int pty_write_room(struct tty_struct *tty)
  * Report how much we have in the transmit queue. As everything is
  * instantly at the other end this is easy to implement.
  */
-
 static int pty_chars_in_buffer(struct tty_struct *tty)
 {
 	return 0;
@@ -298,7 +295,6 @@ static void pty_set_termios(struct tty_struct *tty,
  * Update the termios variables and send the necessary signals to
  * peform a terminal resize correctly
  */
-
 static int pty_resize(struct tty_struct *tty,  struct winsize *ws)
 {
 	struct pid *pgrp, *rpgrp;
@@ -694,7 +690,6 @@ static long pty_unix98_compat_ioctl(struct tty_struct *tty,
  * Look up a pty master device. Called under the tty_mutex for now.
  * This provides our locking.
  */
-
 static struct tty_struct *ptm_unix98_lookup(struct tty_driver *driver,
 		struct file *file, int idx)
 {
@@ -710,7 +705,6 @@ static struct tty_struct *ptm_unix98_lookup(struct tty_driver *driver,
  * Look up a pty master device. Called under the tty_mutex for now.
  * This provides our locking for the tty pointer.
  */
-
 static struct tty_struct *pts_unix98_lookup(struct tty_driver *driver,
 		struct file *file, int idx)
 {
@@ -797,7 +791,6 @@ static const struct tty_operations pty_unix98_ops = {
  *          protect the rest.
  *          allocated_ptys_lock handles the list of free pty numbers
  */
-
 static int ptmx_open(struct inode *inode, struct file *filp)
 {
 	struct pts_fs_info *fsi;
diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 3ddd320162c0..63c8b9f8c7b7 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -985,7 +985,6 @@ static int ifx_spi_reset(struct ifx_spi_device *ifx_dev)
  * -	Support for multiple devices
  * -	Split out MID specific GPIO handling eventually
  */
-
 static int ifx_spi_spi_probe(struct spi_device *spi)
 {
 	int ret;
@@ -1224,7 +1223,6 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
  * FIXME: We should be shutting the device down here not in
  * the module unload path.
  */
-
 static int ifx_spi_spi_remove(struct spi_device *spi)
 {
 	struct ifx_spi_device *ifx_dev = spi_get_drvdata(spi);
@@ -1253,7 +1251,6 @@ static int ifx_spi_spi_remove(struct spi_device *spi)
  *
  * No action needs to be taken here
  */
-
 static void ifx_spi_spi_shutdown(struct spi_device *spi)
 {
 	struct ifx_spi_device *ifx_dev = spi_get_drvdata(spi);
@@ -1363,7 +1360,6 @@ static struct spi_driver ifx_spi_driver = {
  *
  * Unload the module.
  */
-
 static void __exit ifx_spi_exit(void)
 {
 	/* unregister */
@@ -1380,7 +1376,6 @@ static void __exit ifx_spi_exit(void)
  * We need to initialize upper-edge spi driver after the tty
  * driver because otherwise the spi probe will race
  */
-
 static int __init ifx_spi_init(void)
 {
 	int result;
diff --git a/drivers/tty/serial/ioc3_serial.c b/drivers/tty/serial/ioc3_serial.c
index f0f76ea6f8ea..08c2206f4378 100644
--- a/drivers/tty/serial/ioc3_serial.c
+++ b/drivers/tty/serial/ioc3_serial.c
@@ -1110,7 +1110,6 @@ static void ioc3_cb_post_ncs(struct uart_port *the_port, int ncs)
  * @buf: place to put the stuff we read
  * @len: how big 'buf' is
  */
-
 static inline int do_read(struct uart_port *the_port, char *buf, int len)
 {
 	int prod_ptr, cons_ptr, total;
@@ -1426,7 +1425,6 @@ static int receive_chars(struct uart_port *the_port)
  * @idd: driver data
  * @pending: interrupts to handle
  */
-
 static inline int
 ioc3uart_intr_one(struct ioc3_submodule *is,
 			struct ioc3_driver_data *idd,
@@ -1626,7 +1624,6 @@ ioc3uart_intr_one(struct ioc3_submodule *is,
  * @pending: interrupts to handle
  *
  */
-
 static int ioc3uart_intr(struct ioc3_submodule *is,
 			struct ioc3_driver_data *idd,
 			unsigned int pending)
@@ -1964,7 +1961,6 @@ static inline int ioc3_serial_core_attach( struct ioc3_submodule *is,
  * @is: submodule struct for this submodule
  * @idd: ioc3 driver data for this submodule
  */
-
 static int ioc3uart_remove(struct ioc3_submodule *is,
 			struct ioc3_driver_data *idd)
 {
@@ -2002,7 +1998,6 @@ static int ioc3uart_remove(struct ioc3_submodule *is,
  * @is: submodule struct for this submodule
  * @idd: ioc3 driver data for this card
  */
-
 static int
 ioc3uart_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
 {
diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index 804002fae0ee..e2073a0e48d4 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -986,7 +986,6 @@ intr_connect(struct ioc4_soft *soft, int type,
  * @irq: irq value
  * @arg: handler arg
  */
-
 static irqreturn_t ioc4_intr(int irq, void *arg)
 {
 	struct ioc4_soft *soft;
@@ -2064,7 +2063,6 @@ static void ioc4_cb_post_ncs(struct uart_port *the_port, int ncs)
  * @buf: place to put the stuff we read
  * @len: how big 'buf' is
  */
-
 static inline int do_read(struct uart_port *the_port, unsigned char *buf,
 				int len)
 {
@@ -2637,7 +2635,6 @@ static struct uart_driver ioc4_uart_rs422 = {
  *
  * @idd: IOC4 master module data for this IOC4
  */
-
 static int ioc4_serial_remove_one(struct ioc4_driver_data *idd)
 {
 	int port_num, port_type;
diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 784756139935..59aee786820c 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -860,7 +860,6 @@ static int men_z135_probe(struct mcb_device *mdev,
 
 /**
  * men_z135_remove() - Remove a z135 instance from the system
- *
  * @mdev: The MCB device
  */
 static void men_z135_remove(struct mcb_device *mdev)
diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index 2c01168319db..f78aabce3f0d 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -835,7 +835,6 @@ device_initcall(sn_sal_init);
  * ia64_sn_console_putb (what sal_puts_raw below actually does).
  *
  */
-
 static void puts_raw_fixed(int (*puts_raw) (const char *s, int len),
 			   const char *s, int count)
 {
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index a3c4969d4265..fac79ff29fb1 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -57,7 +57,6 @@ static int n_baud_table = ARRAY_SIZE(baud_table);
  *
  * Locking: none
  */
-
 speed_t tty_termios_baud_rate(struct ktermios *termios)
 {
 	unsigned int cbaud;
@@ -92,7 +91,6 @@ EXPORT_SYMBOL(tty_termios_baud_rate);
  *
  * Locking: none
  */
-
 speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 {
 #ifdef IBSHIFT
@@ -141,7 +139,6 @@ EXPORT_SYMBOL(tty_termios_input_baud_rate);
  * The ifdefs deal with platforms whose owners have yet to update them
  * and will all go away once this is done.
  */
-
 void tty_termios_encode_baud_rate(struct ktermios *termios,
 				  speed_t ibaud, speed_t obaud)
 {
@@ -233,7 +230,6 @@ EXPORT_SYMBOL_GPL(tty_termios_encode_baud_rate);
  * settings. The caller must hold the termios_rwsem for the tty in
  * question.
  */
-
 void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud, speed_t obaud)
 {
 	tty_termios_encode_baud_rate(&tty->termios, ibaud, obaud);
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 5f05500ee4d0..447f235eeb0c 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -52,7 +52,6 @@
  * On release, the buffer work is restarted if there is data in the
  * flip buffer
  */
-
 void tty_buffer_lock_exclusive(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -87,7 +86,6 @@ EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
  * the returned # of bytes (use tty_prepare_flip_string_xxx() to
  * pre-allocate if memory guarantee is required).
  */
-
 int tty_buffer_space_avail(struct tty_port *port)
 {
 	int space = port->buf.mem_limit - atomic_read(&port->buf.mem_used);
@@ -112,7 +110,6 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
  * Remove all the buffers pending on a tty whether queued with data
  * or in the free ring. Must be called when the tty is no longer in use
  */
-
 void tty_buffer_free_all(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -152,7 +149,6 @@ void tty_buffer_free_all(struct tty_port *port)
  * Return NULL if out of memory or the allocation would exceed the
  * per device queue
  */
-
 static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 {
 	struct llist_node *free;
@@ -191,7 +187,6 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
  * Free a tty buffer, or add it to the free list according to our
  * internal strategy
  */
-
 static void tty_buffer_free(struct tty_port *port, struct tty_buffer *b)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -216,7 +211,6 @@ static void tty_buffer_free(struct tty_port *port, struct tty_buffer *b)
  * Locking: takes buffer lock to ensure single-threaded flip buffer
  *          'consumer'
  */
-
 void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 {
 	struct tty_port *port = tty->port;
@@ -308,7 +302,6 @@ EXPORT_SYMBOL_GPL(tty_buffer_request_room);
  * Queue a series of bytes to the tty buffering. All the characters
  * passed are marked with the supplied flag. Returns the number added.
  */
-
 int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 		const unsigned char *chars, char flag, size_t size)
 {
@@ -344,7 +337,6 @@ EXPORT_SYMBOL(tty_insert_flip_string_fixed_flag);
  * the flags array indicates the status of the character. Returns the
  * number added.
  */
-
 int tty_insert_flip_string_flags(struct tty_port *port,
 		const unsigned char *chars, const char *flags, size_t size)
 {
@@ -402,7 +394,6 @@ EXPORT_SYMBOL(__tty_insert_flip_char);
  * ldisc side of the queue. It then schedules those characters for
  * processing by the line discipline.
  */
-
 void tty_schedule_flip(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -427,7 +418,6 @@ EXPORT_SYMBOL(tty_schedule_flip);
  * that need their own block copy routines into the buffer. There is no
  * guarantee the buffer is a DMA target!
  */
-
 int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
 		size_t size)
 {
@@ -497,7 +487,6 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
  * Locking: takes buffer lock to ensure single-threaded flip buffer
  *          'consumer'
  */
-
 static void flush_to_ldisc(struct work_struct *work)
 {
 	struct tty_port *port = container_of(work, struct tty_port, buf.work);
@@ -551,7 +540,6 @@ static void flush_to_ldisc(struct work_struct *work)
  * In the event of the queue being busy for flipping the work will be
  * held off and retried later.
  */
-
 void tty_flip_buffer_push(struct tty_port *port)
 {
 	tty_schedule_flip(port);
@@ -565,7 +553,6 @@ EXPORT_SYMBOL(tty_flip_buffer_push);
  * Set up the initial state of the buffer management for a tty device.
  * Must be called before the other tty buffer functions are used.
  */
-
 void tty_buffer_init(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -588,7 +575,6 @@ void tty_buffer_init(struct tty_port *port)
  * Change the tty buffer memory limit.
  * Must be called before the other tty buffer functions are used.
  */
-
 int tty_buffer_set_limit(struct tty_port *port, int limit)
 {
 	if (limit < MIN_TTYB_SIZE)
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 695d80c7a030..938c9966c459 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -165,7 +165,6 @@ static void release_tty(struct tty_struct *tty, int idx);
  *
  * Locking: none. Must be called after tty is definitely unused
  */
-
 static void free_tty_struct(struct tty_struct *tty)
 {
 	tty_ldisc_deinit(tty);
@@ -241,7 +240,6 @@ static void tty_del_file(struct file *file)
  *
  * Locking: none
  */
-
 const char *tty_name(const struct tty_struct *tty)
 {
 	if (!tty) /* Hmm.  NULL pointer.  That's fun. */
@@ -313,7 +311,6 @@ static int check_tty_count(struct tty_struct *tty, const char *routine)
  *
  * Locking: caller must hold tty_mutex
  */
-
 static struct tty_driver *get_tty_driver(dev_t device, int *index)
 {
 	struct tty_driver *p;
@@ -520,7 +517,6 @@ static struct file *redirect;
  * informs the line discipline if present that the driver is ready
  * to receive more output data.
  */
-
 void tty_wakeup(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld;
@@ -670,7 +666,6 @@ static void do_tty_hangup(struct work_struct *work)
  * A carrier loss (virtual or otherwise) has occurred on this like
  * schedule a hangup sequence to run after this event.
  */
-
 void tty_hangup(struct tty_struct *tty)
 {
 	tty_debug_hangup(tty, "hangup\n");
@@ -687,7 +682,6 @@ EXPORT_SYMBOL(tty_hangup);
  * We do this synchronously so that when the syscall returns the process
  * is complete. That guarantee is necessary for security reasons.
  */
-
 void tty_vhangup(struct tty_struct *tty)
 {
 	tty_debug_hangup(tty, "vhangup\n");
@@ -702,7 +696,6 @@ EXPORT_SYMBOL(tty_vhangup);
  *
  * Perform a vhangup on the current controlling tty
  */
-
 void tty_vhangup_self(void)
 {
 	struct tty_struct *tty;
@@ -724,7 +717,6 @@ void tty_vhangup_self(void)
  * We do this synchronously so that when the syscall returns the process
  * is complete. That guarantee is necessary for security reasons.
  */
-
 void tty_vhangup_session(struct tty_struct *tty)
 {
 	tty_debug_hangup(tty, "session hangup\n");
@@ -738,7 +730,6 @@ void tty_vhangup_session(struct tty_struct *tty)
  * Return true if the tty has been subject to a vhangup or a carrier
  * loss
  */
-
 int tty_hung_up_p(struct file *filp)
 {
 	return (filp && filp->f_op == &hung_up_tty_fops);
@@ -762,7 +753,6 @@ EXPORT_SYMBOL(tty_hung_up_p);
  * Locking:
  *         flow_lock
  */
-
 void __stop_tty(struct tty_struct *tty)
 {
 	if (tty->stopped)
@@ -793,7 +783,6 @@ EXPORT_SYMBOL(stop_tty);
  * Locking:
  *         flow_lock
  */
-
 void __start_tty(struct tty_struct *tty)
 {
 	if (!tty->stopped || tty->flow_stopped)
@@ -842,7 +831,6 @@ static void tty_update_time(struct timespec64 *time)
  *         Locks the line discipline internally while needed. Multiple
  * read calls may be outstanding in parallel.
  */
-
 static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 			loff_t *ppos)
 {
@@ -988,7 +976,6 @@ static inline ssize_t do_tty_write(
  *
  * We must still hold the BTM and test the CLOSING flag for the moment.
  */
-
 void tty_write_message(struct tty_struct *tty, char *msg)
 {
 	if (tty) {
@@ -1018,7 +1005,6 @@ void tty_write_message(struct tty_struct *tty, char *msg)
  * and are then processed in chunks to the device. The line discipline
  * write method will not be invoked in parallel for each device.
  */
-
 static ssize_t tty_write(struct file *file, const char __user *buf,
 						size_t count, loff_t *ppos)
 {
@@ -1070,7 +1056,6 @@ ssize_t redirected_tty_write(struct file *file, const char __user *buf,
  *
  * Locking: none for xchar method, write ordering for write method.
  */
-
 int tty_send_xchar(struct tty_struct *tty, char ch)
 {
 	int	was_stopped = tty->stopped;
@@ -1173,7 +1158,6 @@ static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
  * Initialise the termios structures for this tty. Thus runs under
  * the tty_mutex currently so we can be relaxed about ordering.
  */
-
 void tty_init_termios(struct tty_struct *tty)
 {
 	struct ktermios *tp;
@@ -1302,7 +1286,6 @@ static int tty_reopen(struct tty_struct *tty)
  * really quite straightforward.  The mutex locking can probably be
  * relaxed for the (most common) case of reopening a tty.
  */
-
 struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 {
 	struct tty_struct *tty;
@@ -1463,7 +1446,6 @@ static void queue_release_one_tty(struct kref *kref)
  * Release a reference to a tty device and if need be let the kref
  * layer destruct the object for us
  */
-
 void tty_kref_put(struct tty_struct *tty)
 {
 	if (tty)
@@ -1627,7 +1609,6 @@ EXPORT_SYMBOL_GPL(tty_release_struct);
  * WSH 09/09/97: rewritten to avoid some nasty race conditions that could
  * lead to double frees or releasing memory still in use.
  */
-
 int tty_release(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty = file_tty(filp);
@@ -1992,7 +1973,6 @@ static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
  * Note: the tty_unlock/lock cases without a ref are only safe due to
  * tty_mutex
  */
-
 static int tty_open(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty;
@@ -2076,7 +2056,6 @@ static int tty_open(struct inode *inode, struct file *filp)
  * Locking: locks called line discipline but ldisc poll method
  * may be re-entered freely by other callers.
  */
-
 static __poll_t tty_poll(struct file *filp, poll_table *wait)
 {
 	struct tty_struct *tty = file_tty(filp);
@@ -2159,7 +2138,6 @@ static int tty_fasync(int fd, struct file *filp, int on)
  *
  * FIXME: may race normal receive processing
  */
-
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
 	char ch, mbz = 0;
@@ -2188,7 +2166,6 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
  * Locking: tty->winsize_mutex is taken to ensure the winsize data
  *          is consistent.
  */
-
 static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
 	int err;
@@ -2209,7 +2186,6 @@ static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
  * Update the termios variables and send the necessary signals to
  * peform a terminal resize correctly
  */
-
 int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
 {
 	struct pid *pgrp;
@@ -2246,7 +2222,6 @@ EXPORT_SYMBOL(tty_do_resize);
  * tty termios mutex and ctrl_lock. The console takes its own lock
  * then calls into the default method.
  */
-
 static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
 	struct winsize tmp_ws;
@@ -2267,7 +2242,6 @@ static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
  *
  * Locking: uses redirect_lock to guard the redirect information
  */
-
 static int tioccons(struct file *file)
 {
 	if (!capable(CAP_SYS_ADMIN))
@@ -2303,7 +2277,6 @@ static int tioccons(struct file *file)
  *
  * Locking: none, the open file handle ensures it won't go away.
  */
-
 static int fionbio(struct file *file, int __user *p)
 {
 	int nonblock;
@@ -2329,7 +2302,6 @@ static int fionbio(struct file *file, int __user *p)
  *
  * Locking: see tty_set_ldisc, this function is just a helper
  */
-
 static int tiocsetd(struct tty_struct *tty, int __user *p)
 {
 	int disc;
@@ -2353,7 +2325,6 @@ static int tiocsetd(struct tty_struct *tty, int __user *p)
  * Locking: waits for ldisc reference (in case the line discipline
  *          is changing or the tty is being hungup)
  */
-
 static int tiocgetd(struct tty_struct *tty, int __user *p)
 {
 	struct tty_ldisc *ld;
@@ -2379,7 +2350,6 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  *         atomic_write_lock serializes
  *
  */
-
 static int send_break(struct tty_struct *tty, unsigned int duration)
 {
 	int retval;
@@ -2418,7 +2388,6 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
  *
  * Locking: none (up to the driver)
  */
-
 static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 {
 	int retval = -EINVAL;
@@ -2443,7 +2412,6 @@ static int tty_tiocmget(struct tty_struct *tty, int __user *p)
  *
  * Locking: none (up to the driver)
  */
-
 static int tty_tiocmset(struct tty_struct *tty, unsigned int cmd,
 	     unsigned __user *p)
 {
@@ -2810,7 +2778,6 @@ static struct device *tty_get_device(struct tty_struct *tty)
  *
  * Locking: none - tty in question is not exposed at this point
  */
-
 struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 {
 	struct tty_struct *tty;
@@ -2862,7 +2829,6 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
  * Note: the specific put_char operation in the driver layer may go
  * away soon. Don't call it directly, use this method
  */
-
 int tty_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	if (tty->ops->put_char)
@@ -2908,7 +2874,6 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
  *
  * Locking: ??
  */
-
 struct device *tty_register_device(struct tty_driver *driver, unsigned index,
 				   struct device *device)
 {
@@ -3022,7 +2987,6 @@ EXPORT_SYMBOL_GPL(tty_register_device_attr);
  *
  * Locking: ??
  */
-
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	device_destroy(tty_class,
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index cb72dc6085d8..ca5d3923342d 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -52,7 +52,6 @@
  * output queue. If no private method is supplied there is assumed
  * to be no queue on the device.
  */
-
 int tty_chars_in_buffer(struct tty_struct *tty)
 {
 	if (tty->ops->chars_in_buffer)
@@ -72,7 +71,6 @@ EXPORT_SYMBOL(tty_chars_in_buffer);
  * the number of bytes written. If no method is provided 2K is always
  * returned and data may be lost as there will be no flow control.
  */
-
 int tty_write_room(struct tty_struct *tty)
 {
 	if (tty->ops->write_room)
@@ -105,7 +103,6 @@ EXPORT_SYMBOL(tty_driver_flush_buffer);
  * and also to ensure the driver can consistently reference its own
  * termios data at this point when implementing software flow control.
  */
-
 void tty_throttle(struct tty_struct *tty)
 {
 	down_write(&tty->termios_rwsem);
@@ -130,7 +127,6 @@ EXPORT_SYMBOL(tty_throttle);
  * Drivers should however remember that the stack can issue a throttle,
  * then change flow control method, then unthrottle.
  */
-
 void tty_unthrottle(struct tty_struct *tty)
 {
 	down_write(&tty->termios_rwsem);
@@ -153,7 +149,6 @@ EXPORT_SYMBOL(tty_unthrottle);
  *
  * Returns 0 if tty is throttled (or was already throttled)
  */
-
 int tty_throttle_safe(struct tty_struct *tty)
 {
 	int ret = 0;
@@ -184,7 +179,6 @@ int tty_throttle_safe(struct tty_struct *tty)
  *
  * Returns 0 if tty is unthrottled (or was already unthrottled)
  */
-
 int tty_unthrottle_safe(struct tty_struct *tty)
 {
 	int ret = 0;
@@ -214,7 +208,6 @@ int tty_unthrottle_safe(struct tty_struct *tty)
  *
  * Locking: none
  */
-
 void tty_wait_until_sent(struct tty_struct *tty, long timeout)
 {
 	tty_debug_wait_until_sent(tty, "wait until sent, timeout=%ld\n", timeout);
@@ -310,7 +303,6 @@ EXPORT_SYMBOL(tty_termios_hw_change);
  *
  * Locking: termios_rwsem
  */
-
 int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 {
 	struct ktermios old_termios;
@@ -358,7 +350,6 @@ EXPORT_SYMBOL_GPL(tty_set_termios);
  * Locking:
  *         Called functions take ldisc and termios_rwsem locks
  */
-
 static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 {
 	struct ktermios tmp_termios;
@@ -455,7 +446,6 @@ static int get_termio(struct tty_struct *tty, struct termio __user *termio)
  * Implement the device calling points for the SYS5 termiox ioctl
  * interface in Linux
  */
-
 static int set_termiox(struct tty_struct *tty, void __user *arg, int opt)
 {
 	struct termiox tnew;
@@ -563,7 +553,6 @@ static void set_sgflags(struct ktermios *termios, int flags)
  *
  * Locking: termios_rwsem
  */
-
 static int set_sgttyb(struct tty_struct *tty, struct sgttyb __user *sgttyb)
 {
 	int retval;
@@ -674,7 +663,6 @@ static int set_ltchars(struct tty_struct *tty, struct ltchars __user *ltchars)
  * Perform a change to the CLOCAL state and call into the driver
  * layer to make it visible. All done with the termios rwsem
  */
-
 static int tty_change_softcar(struct tty_struct *tty, int arg)
 {
 	int ret = 0;
@@ -704,7 +692,6 @@ static int tty_change_softcar(struct tty_struct *tty, int arg)
  * is designed to be called by line disciplines to ensure they provide
  * consistent mode setting.
  */
-
 int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index d86c4c516f25..d54985ea6088 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -57,7 +57,6 @@ static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
  * Locking:
  *         takes tty_ldiscs_lock to guard against ldisc races
  */
-
 int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc)
 {
 	unsigned long flags;
@@ -87,7 +86,6 @@ EXPORT_SYMBOL(tty_register_ldisc);
  * Locking:
  *         takes tty_ldiscs_lock to guard against ldisc races
  */
-
 int tty_unregister_ldisc(int disc)
 {
 	unsigned long flags;
@@ -155,7 +153,6 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
  * Locking:
  *         takes tty_ldiscs_lock to guard against ldisc races
  */
-
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 {
 	struct tty_ldisc *ld;
@@ -255,7 +252,6 @@ const struct seq_operations tty_ldiscs_seq_ops = {
  * Note: a file_operations routine (read/poll/write) should use this
  * function to wait for any ldisc lifetime events to finish.
  */
-
 struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld;
@@ -276,7 +272,6 @@ EXPORT_SYMBOL_GPL(tty_ldisc_ref_wait);
  * reference to it. If the line discipline is in flux then
  * return NULL. Can be called from IRQ and timer functions.
  */
-
 struct tty_ldisc *tty_ldisc_ref(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld = NULL;
@@ -297,7 +292,6 @@ EXPORT_SYMBOL_GPL(tty_ldisc_ref);
  * Undoes the effect of tty_ldisc_ref or tty_ldisc_ref_wait. May
  * be called in IRQ context.
  */
-
 void tty_ldisc_deref(struct tty_ldisc *ld)
 {
 	ldsem_up_read(&ld->tty->ldisc_sem);
@@ -396,7 +390,6 @@ static void tty_ldisc_unlock_pair(struct tty_struct *tty,
  * Flush the line discipline queue (if any) and the tty flip buffers
  * for this tty.
  */
-
 void tty_ldisc_flush(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld = tty_ldisc_ref(tty);
@@ -422,7 +415,6 @@ EXPORT_SYMBOL_GPL(tty_ldisc_flush);
  *
  * Locking: takes termios_rwsem
  */
-
 static void tty_set_termios_ldisc(struct tty_struct *tty, int disc)
 {
 	down_write(&tty->termios_rwsem);
@@ -443,7 +435,6 @@ static void tty_set_termios_ldisc(struct tty_struct *tty, int disc)
  *
  * Locking: always called with BTM already held.
  */
-
 static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 {
 	WARN_ON(test_and_set_bit(TTY_LDISC_OPEN, &tty->flags));
@@ -468,7 +459,6 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
  * A helper close method. Also a convenient debugging and check
  * point.
  */
-
 static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 {
 	WARN_ON(!test_bit(TTY_LDISC_OPEN, &tty->flags));
@@ -486,7 +476,6 @@ static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
  * Helper to try and recover a tty when switching back to the old
  * ldisc fails and we need something attached.
  */
-
 static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 {
 	struct tty_ldisc *disc = tty_ldisc_get(tty, ld);
@@ -509,7 +498,6 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
  * Restore the previous line discipline or N_TTY when a line discipline
  * change fails due to an open error
  */
-
 static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 {
 	/* There is an outstanding reference here so this is safe */
@@ -536,7 +524,6 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
  * overlapping ldisc change (including on the other end of pty pairs),
  * the close of one side of a tty/pty pair, and eventually hangup.
  */
-
 int tty_set_ldisc(struct tty_struct *tty, int disc)
 {
 	int retval;
@@ -632,7 +619,6 @@ static void tty_ldisc_kill(struct tty_struct *tty)
  *
  * Restore a terminal to the driver default state.
  */
-
 static void tty_reset_termios(struct tty_struct *tty)
 {
 	down_write(&tty->termios_rwsem);
@@ -656,7 +642,6 @@ static void tty_reset_termios(struct tty_struct *tty)
  *
  * Returns 0 if successful, otherwise error code < 0
  */
-
 int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 {
 	struct tty_ldisc *ld;
@@ -698,7 +683,6 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
  * In the pty pair case this occurs in the close() path of the
  * tty itself so we must be careful about locking rules.
  */
-
 void tty_ldisc_hangup(struct tty_struct *tty, bool reinit)
 {
 	struct tty_ldisc *ld;
@@ -752,7 +736,6 @@ void tty_ldisc_hangup(struct tty_struct *tty, bool reinit)
  * line disciplines and bind them to the tty. This has no locking issues
  * as the device isn't yet active.
  */
-
 int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
 {
 	int retval = tty_ldisc_open(tty, tty->ldisc);
@@ -776,7 +759,6 @@ int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
  * Called during the final close of a tty or a pty pair in order to shut
  * down the line discpline layer. On exit, each tty's ldisc is NULL.
  */
-
 void tty_ldisc_release(struct tty_struct *tty)
 {
 	struct tty_struct *o_tty = tty->link;
@@ -806,7 +788,6 @@ EXPORT_SYMBOL_GPL(tty_ldisc_release);
  * Set up the line discipline objects for a newly allocated tty. Note that
  * the tty structure is not completely set up when this call is made.
  */
-
 int tty_ldisc_init(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld = tty_ldisc_get(tty, N_TTY);
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 0d1b232cb5fd..46062e984daa 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -86,7 +86,6 @@ static DECLARE_WAIT_QUEUE_HEAD(vt_event_waitqueue);
  *
  * Post an VT event to interested VT handlers
  */
-
 void vt_event_post(unsigned int event, unsigned int old, unsigned int new)
 {
 	struct list_head *pos, *head;
@@ -163,7 +162,6 @@ static void vt_event_wait(struct vt_event_wait *vw)
  *
  * Implement the VT_WAITEVENT ioctl using the VT event interface
  */
-
 static int vt_event_wait_ioctl(struct vt_event __user *event)
 {
 	struct vt_event_wait vw;
@@ -192,7 +190,6 @@ static int vt_event_wait_ioctl(struct vt_event __user *event)
  * Helper for event waits. Used to implement the legacy
  * event waiting ioctls in terms of events
  */
-
 int vt_waitactive(int n)
 {
 	struct vt_event_wait vw;
-- 
2.17.1

