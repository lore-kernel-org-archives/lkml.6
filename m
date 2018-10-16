Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80415C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B3A21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvwdjEYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B3A21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJQHPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:15:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48967 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbeJQHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:15:12 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 671772202D;
        Tue, 16 Oct 2018 19:22:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Oct 2018 19:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=zbUEHdy5/QyeDfLrsDQxfLcV0pPO5
        B5n6oBNGewMv2E=; b=CvwdjEYV5ZGCutVFent0iYUs8iHPB3H/72LmWwNcuKXuB
        U0WwuplHG9RMc5YmvY5JRCZVzy2lBuATqvzGYNB+FfAuvYc92dHvPi8N/5bn9qog
        PZZS2Hs8Ij1hrQTTqC7f5INP4yYXconKNrOKkZiJmt3obpr/6Y4one258cyC1Fqa
        aU1u908cKOoMNYe/D66xGETghnbY2HiEmZeLHVLztFS+xY5LqKhXlWt+Su4BGie7
        HjMmMklYofqxsfozUJ4E7KDKeoqFhJfgQnr+w87sbypMM8ivEEMQSmdFo4yR2T5Y
        58/O4fQQmDTRAtF+nyhc72+Piq+6oeSAH6c5vgDuw==
X-ME-Sender: <xms:rXLGWx5qHv9md7bKHKy3cZhQr7D7T4DVEYfLrdQ_XW2rSOuusHESoQ>
X-ME-Proxy: <xmx:rnLGW_bJV9OAwakmE3chKJVCc4_fOkAzdQpmmaNigllqjqkEZQH1lA>
    <xmx:rnLGW7Ck3fd0XESKHBHxTMMuBQHfGPcXV2_2eQDmhIQ2i-haupUMUA>
    <xmx:rnLGW9sskAwiMg6M2LmJnS230AJuq0QCLPi18wYLDhZY6hrATHoK3A>
    <xmx:rnLGW5eRMqDCOUyjak9WEWNiRZsjTUOX66mCYC1P6BgxcsF1D-tlaA>
    <xmx:rnLGW8apjamiGcFK8eQnoEJR15Wg6eUkatyamo4sKmQdfDMzYeX6nQ>
    <xmx:rnLGW6R7Dj9ga_moFglVQs-k-jPa0CrSr35tMGVmjrul06O63Si0dA>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id 989FAE4124;
        Tue, 16 Oct 2018 19:22:20 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] tty: Fix section format
Date:   Wed, 17 Oct 2018 10:21:30 +1100
Message-Id: <20181016232130.728-8-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016232130.728-1-tobin@kernel.org>
References: <20181016232130.728-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sections (specifically 'Return:' and 'Context:') are
non-uniform and/or incorrectly labelled.  We should use the format
outlined in Documentation/doc-guide/kernel-doc.rst.  This patch is a bit
of a mash up because text is on occasions mixed up in the current
comments.

 - Use 'Context:' (Replaces 'Locking')

   * Context: Describes whether the function can sleep, what locks it takes,
   *          releases, or expects to be held. It can extend over multiple
   *          lines.

 - Use 'Return:'

   * Return: Describe the return value of foobar.
   *
   * The return value description can also have multiple paragraphs, and should
   * be placed at the end of the comment block.

 - If brief description is too long spilt it up into brief and longer.

   * A longer description, with more discussion of the function function_name()
   * that might be useful to those using or modifying it. Begins with an
   * empty comment line, and may include additional embedded empty
   * comment lines.

This patch leaves some instances of 'Locking:' still in the code (if I
was not _sure_ of the documented locking or if changing it would make
the comment less legible).

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 drivers/tty/hvc/hvc_console.c       |   4 +-
 drivers/tty/hvc/hvc_iucv.c          |  14 +--
 drivers/tty/mips_ejtag_fdc.c        |   4 +-
 drivers/tty/n_gsm.c                 |  37 ++++----
 drivers/tty/n_hdlc.c                |  14 +--
 drivers/tty/n_tracerouter.c         |  14 ++-
 drivers/tty/n_tracesink.c           |  20 ++---
 drivers/tty/n_tty.c                 | 117 ++++++++++++------------
 drivers/tty/pty.c                   |  19 ++--
 drivers/tty/serial/8250/8250_core.c |  14 +--
 drivers/tty/serial/amba-pl011.c     |   2 +-
 drivers/tty/serial/earlycon.c       |   4 +-
 drivers/tty/serial/ifx6x60.c        |  12 +--
 drivers/tty/serial/serial_txx9.c    |   5 +-
 drivers/tty/serial/xilinx_uartps.c  |  21 +++--
 drivers/tty/tty_audit.c             |   9 +-
 drivers/tty/tty_baudrate.c          |  31 +++----
 drivers/tty/tty_buffer.c            |  26 +++---
 drivers/tty/tty_io.c                | 135 +++++++++++++---------------
 drivers/tty/tty_ioctl.c             |  15 ++--
 drivers/tty/tty_jobctrl.c           |  17 ++--
 drivers/tty/tty_ldisc.c             |  43 +++++----
 drivers/tty/tty_port.c              |   8 +-
 drivers/tty/vt/consolemap.c         |   4 +-
 drivers/tty/vt/keyboard.c           |   6 +-
 drivers/tty/vt/selection.c          |  10 ++-
 drivers/tty/vt/vt.c                 |  26 +++---
 27 files changed, 312 insertions(+), 319 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 6d57d0bfff5d..9379de272995 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -569,7 +569,7 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
  * The routine shall not be called within an atomic context because it
  * might sleep.
  *
- * Locking:	hp->lock
+ * Context: Take hp->lock
  */
 static void hvc_set_winsz(struct work_struct *work)
 {
@@ -784,7 +784,7 @@ EXPORT_SYMBOL_GPL(hvc_poll);
  * Stores the specified window size information in the hvc structure of @hp.
  * The function schedule the tty resize update.
  *
- * Locking:	Locking free; the function MUST be called holding hp->lock
+ * Context: Locking free; the function MUST be called holding hp->lock
  */
 void __hvc_resize(struct hvc_struct *hp, struct winsize ws)
 {
diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
index 2af1e5751bd6..0de673b29b31 100644
--- a/drivers/tty/hvc/hvc_iucv.c
+++ b/drivers/tty/hvc/hvc_iucv.c
@@ -147,7 +147,8 @@ static struct hvc_iucv_private *hvc_iucv_get_private(uint32_t num)
  * required for receiving and sending data with IUCV.
  * Note: The total message size arises from the internal buffer size and the
  *	 members of the iucv_tty_msg structure.
- * The function returns NULL if memory allocation has failed.
+ *
+ * Return: NULL if memory allocation has failed.
  */
 static struct iucv_tty_buffer *alloc_tty_buffer(size_t size, gfp_t flags)
 {
@@ -210,9 +211,9 @@ static void destroy_tty_buffer_list(struct list_head *list)
  * If all message data has been written, the message is removed from
  * the input queue.
  *
- * The function returns the number of bytes written to the terminal, zero if
- * there are no pending data messages available or if there is no established
- * IUCV path.
+ * Return: The number of bytes written to the terminal, zero if there are no
+ * pending data messages available or if there is no established IUCV path.
+ *
  * If the IUCV path has been severed, then -EPIPE is returned to cause a
  * hang up (that is issued by the HVC layer).
  */
@@ -309,9 +310,8 @@ static int hvc_iucv_write(struct hvc_iucv_private *priv,
  * If an IUCV communication path has been established, pending IUCV messages
  * are received and data is copied into buffer @buf up to @count bytes.
  *
- * Locking:	The routine gets called under an irqsave() spinlock; and
- *		the routine locks the struct hvc_iucv_private->lock to call
- *		helper functions.
+ * Context: The routine gets called under an irqsave() spinlock; locks
+ *          the struct hvc_iucv_private->lock to call helper functions.
  */
 static int hvc_iucv_get_chars(uint32_t vtermno, char *buf, int count)
 {
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 4c1cd49ae95b..6d2e9e145770 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -409,7 +409,7 @@ static struct mips_ejtag_fdc_console mips_ejtag_fdc_con = {
  * Write a single block of data out to the debug adapter. If the circular buffer
  * is wrapped then only the first block is written.
  *
- * Returns:	The number of bytes that were written.
+ * Return: The number of bytes that were written.
  */
 static unsigned int mips_ejtag_fdc_put_chan(struct mips_ejtag_fdc_tty *priv,
 					    unsigned int chan)
@@ -643,7 +643,7 @@ static void mips_ejtag_fdc_handle(struct mips_ejtag_fdc_tty *priv)
  *
  * It simply triggers the common FDC handler code.
  *
- * Returns:	IRQ_HANDLED if an FDC interrupt was pending.
+ * Return:	IRQ_HANDLED if an FDC interrupt was pending.
  *		IRQ_NONE otherwise.
  */
 static irqreturn_t mips_ejtag_fdc_isr(int irq, void *dev_id)
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c65a9afb7cc4..fbc8d0a15676 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -393,7 +393,8 @@ static inline u8 gsm_fcs_add_block(u8 fcs, u8 *c, int len)
  * @c: byte going into the EA
  *
  * Processes one byte of an EA. Updates the passed variable
- * and returns 1 if the EA is now completely read
+ *
+ * Return: 1 if the EA is now completely read.
  */
 static int gsm_read_ea(unsigned int *val, u8 c)
 {
@@ -701,8 +702,9 @@ static void gsm_data_kick(struct gsm_mux *gsm)
  * @msg: message queued
  *
  * Add data to the transmit queue and try and get stuff moving
- * out of the mux tty if not already doing so. The Caller must hold
- * the gsm tx lock.
+ * out of the mux tty if not already doing so.
+ *
+ * Context: The Caller must hold the gsm tx lock.
  */
 static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 {
@@ -751,8 +753,9 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
  * @msg: message queued
  *
  * Add data to the transmit queue and try and get stuff moving
- * out of the mux tty if not already doing so. Take the
- * the gsm tx lock and dlci lock.
+ * out of the mux tty if not already doing so.
+ *
+ * Context: Take the gsm tx lock and dlci lock.
  */
 static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 {
@@ -771,7 +774,7 @@ static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
  * is data. Keep to the MRU of the mux. This path handles the usual tty
  * interface which is a byte stream with optional modem data.
  *
- * Caller must hold the tx_lock of the mux.
+ * Context: Caller must hold the tx_lock of the mux.
  */
 static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 {
@@ -823,7 +826,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
  * is data. Keep to the MRU of the mux. This path handles framed data
  * queued as skbuffs to the DLCI.
  *
- * Caller must hold the tx_lock of the mux.
+ * Context: Caller must hold the tx_lock of the mux.
  */
 static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 						struct gsm_dlci *dlci)
@@ -1266,7 +1269,9 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
  * @gsm: gsm mux
  * @ctrl: frame to send
  *
- * Send out a pending control command (called under control lock)
+ * Send out a pending control command.
+
+ * Context: Called under control lock.
  */
 static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
 {
@@ -1360,8 +1365,10 @@ static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
  * @control: control we are waiting on
  *
  * Waits for the control to complete or time out. Frees any used
- * resources and returns 0 for success, or an error if the remote
- * rejected or ignored the request.
+ * resources.
+ *
+ * Return: 0 for success, or an error if the remote rejected or
+ *         ignored the request.
  */
 static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
 {
@@ -1641,7 +1648,7 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
  *
  * Free up a DLCI.
  *
- * Can sleep.
+ * Context: Can sleep.
  */
 static void gsm_dlci_free(struct tty_port *port)
 {
@@ -1674,7 +1681,7 @@ static void gsm_destroy_network(struct gsm_dlci *dlci);
  * Release a DLCI. Actual free is deferred until either
  * mux is closed or tty is closed - whichever is last.
  *
- * Can sleep.
+ * Context: Can sleep.
  */
 static void gsm_dlci_release(struct gsm_dlci *dlci)
 {
@@ -2381,7 +2388,7 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
  * parallel readers and must handle this ourselves. We may also get
  * a hangup. Always called in user context, may sleep.
  *
- * This code must be sure never to sleep through a hangup.
+ * Context: This code must be sure never to sleep through a hangup.
  */
 static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
 			 unsigned char __user *buf, size_t nr)
@@ -2422,8 +2429,8 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
  * for special events. This code is not serialized with respect to
  * other events save open/close.
  *
- * This code must be sure never to sleep through a hangup.
- * Called without the kernel lock held - fine
+ * Context: This code must be sure never to sleep through a hangup.
+ *          Called without the kernel lock held - fine.
  */
 static __poll_t gsmld_poll(struct tty_struct *tty, struct file *file,
 							poll_table *wait)
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 5b0c776a43a2..af134fd20838 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -321,7 +321,7 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
  * n_hdlc_tty_open() - called when line discipline changed to n_hdlc
  * @tty - pointer to tty info structure
  *
- * Returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code.
  */
 static int n_hdlc_tty_open (struct tty_struct *tty)
 {
@@ -555,7 +555,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
  * @buf - pointer to returned data buffer
  * @nr - size of returned data buffer
  *
- * Returns the number of bytes returned or error code.
+ * Return: The number of bytes returned or error code.
  */
 static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 			   __u8 __user *buf, size_t nr)
@@ -639,7 +639,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
  * @data - pointer to transmit data (one frame)
  * @count - size of transmit frame in bytes
  *
- * Returns the number of bytes written (or error code).
+ * Return: The number of bytes written or error code.
  */
 static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 			    const unsigned char *data, size_t count)
@@ -723,7 +723,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
  * @cmd - IOCTL command code
  * @arg - argument for IOCTL call (cmd dependent)
  *
- * Returns command dependent result.
+ * Return: Command dependent result.
  */
 static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 			    unsigned int cmd, unsigned long arg)
@@ -795,7 +795,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
  * Determine which operations (read/write) will not block and return info
  * to caller.
  *
- * Returns a bit mask containing info on which ops will not block.
+ * Return: A bit mask containing info on which ops will not block.
  */
 static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 				    poll_table *wait)
@@ -830,7 +830,7 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 /**
  * n_hdlc_alloc() - allocate an n_hdlc instance data structure
  *
- * Returns a pointer to newly created structure if success, otherwise %NULL
+ * Return: A pointer to newly created structure if success, otherwise %NULL.
  */
 static struct n_hdlc *n_hdlc_alloc(void)
 {
@@ -920,7 +920,7 @@ static void n_hdlc_buf_put(struct n_hdlc_buf_list *buf_list,
  * Remove and return an HDLC buffer from the head of the specified HDLC buffer
  * list.
  *
- * Returns a pointer to HDLC buffer if available, otherwise %NULL.
+ * Return: A pointer to HDLC buffer if available, otherwise %NULL.
  */
 static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *buf_list)
 {
diff --git a/drivers/tty/n_tracerouter.c b/drivers/tty/n_tracerouter.c
index f7a2616145cf..a54e1aed019f 100644
--- a/drivers/tty/n_tracerouter.c
+++ b/drivers/tty/n_tracerouter.c
@@ -53,10 +53,9 @@ static DEFINE_MUTEX(routelock);
  * n_tracerouter_open() - Called when a tty is opened by a SW entity.
  * @tty: terminal device to the ldisc.
  *
- * Return:
- *      0 for success.
- *
  * Caveats: This should only be opened one time per SW entity.
+ *
+ * Return: 0 for success.
  */
 static int n_tracerouter_open(struct tty_struct *tty)
 {
@@ -114,8 +113,7 @@ static void n_tracerouter_close(struct tty_struct *tty)
  * -EIO should be used just to show that there was an intent not to have
  * this function implemented.  Return value based on read() man pages.
  *
- * Return:
- *	 -EINVAL
+ * Return: -EINVAL
  */
 static ssize_t n_tracerouter_read(struct tty_struct *tty, struct file *file,
 				  unsigned char __user *buf, size_t nr) {
@@ -138,8 +136,7 @@ static ssize_t n_tracerouter_read(struct tty_struct *tty, struct file *file,
  * just to show that there was an intent not to have this function
  * implemented.  Return value based on write() man pages.
  *
- * Return:
- *	-EINVAL
+ * Return: -EINVAL
  */
 static ssize_t n_tracerouter_write(struct tty_struct *tty, struct file *file,
 				   const unsigned char *buf, size_t nr) {
@@ -188,8 +185,7 @@ static struct tty_ldisc_ops tty_ptirouter_ldisc = {
  *
  * Registers this module as a line discipline driver.
  *
- * Return:
- *	0 for success, any other value error.
+ * Return: 0 for success, any other value error.
  */
 static int __init n_tracerouter_init(void)
 {
diff --git a/drivers/tty/n_tracesink.c b/drivers/tty/n_tracesink.c
index 8feeea7d33b6..fc5013f34d51 100644
--- a/drivers/tty/n_tracesink.c
+++ b/drivers/tty/n_tracesink.c
@@ -51,15 +51,12 @@ static DEFINE_MUTEX(writelock);
  * n_tracesink_open() - Called when a tty is opened by a SW entity.
  * @tty: terminal device to the ldisc.
  *
- * Return:
- *      0 for success,
- *      -EFAULT = couldn't get a tty kref n_tracesink will sit
- *       on top of
- *      -EEXIST = open() called successfully once and it cannot
- *      be called again.
- *
  * Caveats: open() should only be successful the first time a
  * SW entity calls it.
+ *
+ * Return: 0 for success. -EFAULT = couldn't get a tty kref n_tracesink
+ *         will sit on top of. -EEXIST = open() called successfully once
+ *         and it cannot be called again.
  */
 static int n_tracesink_open(struct tty_struct *tty)
 {
@@ -111,8 +108,7 @@ static void n_tracesink_close(struct tty_struct *tty)
  * -EIO should be used just to show that there was an intent not to have
  * this function implemented.  Return value based on read() man pages.
  *
- * Return:
- *	 -EINVAL
+ * Return: -EINVAL
  */
 static ssize_t n_tracesink_read(struct tty_struct *tty, struct file *file,
 				unsigned char __user *buf, size_t nr) {
@@ -135,8 +131,7 @@ static ssize_t n_tracesink_read(struct tty_struct *tty, struct file *file,
  * just to show that there was an intent not to have this function
  * implemented.  Return value based on write() man pages.
  *
- * Return:
- *	-EINVAL
+ * Return: -EINVAL
  */
 static ssize_t n_tracesink_write(struct tty_struct *tty, struct file *file,
 				 const unsigned char *buf, size_t nr) {
@@ -192,8 +187,7 @@ static struct tty_ldisc_ops tty_n_tracesink = {
  *
  * Registers this module as a line discipline driver.
  *
- * Return:
- *	0 for success, any other value error.
+ * Return: 0 for success, any other value error.
  */
 static int __init n_tracesink_init(void)
 {
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 339926b27449..527d428ab79c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -193,10 +193,8 @@ static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
  *
  * Re-schedules the flip buffer work if it may have stopped
  *
- * Caller holds exclusive termios_rwsem
- *    or
- * n_tty_read()/consumer path:
- * 	holds non-exclusive termios_rwsem
+ * Context: Caller holds exclusive termios_rwsem or
+ *          n_tty_read()/consumer path: holds non-exclusive termios_rwsem
  */
 static void n_tty_kick_worker(struct tty_struct *tty)
 {
@@ -306,8 +304,8 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
  *
  * Add a character to the tty read_buf queue.
  *
- * n_tty_receive_buf()/producer path:
- * 	caller holds non-exclusive termios_rwsem
+ * Context: n_tty_receive_buf()/producer path: caller holds
+ *          non-exclusive termios_rwsem.
  */
 static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
 {
@@ -320,10 +318,9 @@ static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
  * @tty: terminal to reset
  *
  * Reset the read buffer counters and clear the flags.
- * Called from n_tty_open() and n_tty_flush_buffer().
  *
- * Locking: caller holds exclusive termios_rwsem
- *          (or locking is not required)
+ * Context: Called from n_tty_open() and n_tty_flush_buffer().  Caller
+ *          holds exclusive termios_rwsem (or locking is not required).
  */
 static void reset_buffer_flags(struct n_tty_data *ldata)
 {
@@ -359,7 +356,7 @@ static void n_tty_packet_mode_flush(struct tty_struct *tty)
  * Holds termios_rwsem to exclude producer/consumer while
  * buffer indices are reset.
  *
- * Locking: ctrl_lock, exclusive termios_rwsem
+ * Context: ctrl_lock, exclusive termios_rwsem.
  */
 static void n_tty_flush_buffer(struct tty_struct *tty)
 {
@@ -412,11 +409,11 @@ static inline int is_continuation(unsigned char c, struct tty_struct *tty)
  * and NLDLY.  They simply aren't relevant in the world today.
  * If you ever need them, add them here.
  *
- * Returns the number of bytes of buffer space used or -1 if
- * no space left.
+ * Context: should be called under the output_lock to protect
+ * 	    the column state and space left in the buffer.
  *
- * Locking: should be called under the output_lock to protect
- *          the column state and space left in the buffer
+ * Return: The number of bytes of buffer space used or -1 if
+ *         no space left.
  */
 static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 {
@@ -485,12 +482,13 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
  * @tty: terminal device
  *
  * Output one character with OPOST processing.
- * Returns -1 when the output device is full and the character
- * must be retried.
  *
- * Locking: output_lock to protect column state and space left
+ * Context: output_lock to protect column state and space left
  *          (also, this is called from n_tty_write under the
- *          tty layer write lock)
+ *          tty layer write lock).
+ *
+ * Return: -1 when the output device is full and the character
+ *         must be retried.
  */
 static int process_output(unsigned char c, struct tty_struct *tty)
 {
@@ -516,16 +514,17 @@ static int process_output(unsigned char c, struct tty_struct *tty)
  * @nr: number of bytes to output
  *
  * Output a block of characters with OPOST processing.
- * Returns the number of characters output.
  *
  * This path is used to speed up block console writes, among other
  * things when processing blocks of output data. It handles only
  * the simple cases normally found and helps to generate blocks of
  * symbols for the console driver and thus improve performance.
  *
- * Locking: output_lock to protect column state and space left
+ * Context: output_lock to protect column state and space left
  *          (also, this is called from n_tty_write under the
- *          tty layer write lock)
+ *          tty layer write lock).
+ *
+ * Return: The number of characters output.
  */
 static ssize_t process_output_block(struct tty_struct *tty,
 				    const unsigned char *buf, unsigned int nr)
@@ -608,7 +607,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
  * are prioritized.  Also, when control characters are echoed with a
  * prefixed "^", the pair is treated atomically and thus not separated.
  *
- * Locking: callers must hold output_lock
+ * Context: Caller must hold output_lock.
  */
 static size_t __process_echoes(struct tty_struct *tty)
 {
@@ -952,8 +951,8 @@ static inline void finish_erasing(struct n_tty_data *ldata)
  * present in the stream from the driver layer. Handles the complexities
  * of UTF-8 multibyte symbols.
  *
- * n_tty_receive_buf()/producer path:
- * 	caller holds non-exclusive termios_rwsem
+ * Context: n_tty_receive_buf()/producer path: caller holds
+ *          non-exclusive termios_rwsem
  */
 static void eraser(unsigned char c, struct tty_struct *tty)
 {
@@ -1085,7 +1084,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
  * buffer is 'output'. The signal is processed first to alert any current
  * readers or writers to discontinue and exit their i/o loops.
  *
- * Locking: ctrl_lock
+ * Context: ctrl_lock
  */
 static void __isig(int sig, struct tty_struct *tty)
 {
@@ -1138,8 +1137,8 @@ static void isig(int sig, struct tty_struct *tty)
  * An RS232 break event has been hit in the incoming bitstream. This
  * can cause a variety of events depending upon the termios settings.
  *
- * n_tty_receive_buf()/producer path:
- * 	caller holds non-exclusive termios_rwsem
+ * Context: n_tty_receive_buf()/producer path: caller holds
+ *          non-exclusive termios_rwsem.
  *
  * Note: may get exclusive termios_rwsem if flushing input buffer
  */
@@ -1193,8 +1192,8 @@ static void n_tty_receive_overrun(struct tty_struct *tty)
  * Process a parity error and queue the right data to indicate
  * the error case if necessary.
  *
- * n_tty_receive_buf()/producer path:
- * 	caller holds non-exclusive termios_rwsem
+ * Context: n_tty_receive_buf()/producer path: caller holds
+ *          non-exclusive termios_rwsem
  */
 static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 {
@@ -1236,11 +1235,11 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
  * This is serialized with respect to itself by the rules for the
  * driver above.
  *
- * n_tty_receive_buf()/producer path:
- *      caller holds non-exclusive termios_rwsem
- *      publishes canon_head if canonical mode is active
+ * Context: n_tty_receive_buf()/producer path: caller holds
+ *          non-exclusive termios_rwsem publishes canon_head if
+ *          canonical mode is active.
  *
- * Returns 1 if LNEXT was received, else returns 0
+ * Return: 1 if LNEXT was received, else returns 0.
  */
 static int
 n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
@@ -1649,8 +1648,6 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
  * not from interrupt context. The driver is responsible for making
  * calls one at a time and in order (or using flush_to_ldisc)
  *
- * Returns the # of input chars from @cp which were processed.
- *
  * In canonical mode, the maximum line length is 4096 chars (including
  * the line termination char); lines longer than 4096 chars are
  * truncated. After 4095 chars, input data is still processed but
@@ -1666,9 +1663,10 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
  * maximum canon line of 4096 chars when the mode is switched to
  * non-canonical.
  *
- * n_tty_receive_buf()/producer path:
- * 	claims non-exclusive termios_rwsem
- * 	publishes commit_head or canon_head
+ * Context: n_tty_receive_buf()/producer path: claims non-exclusive
+ *          termios_rwsem publishes commit_head or canon_head.
+ *
+ * Return: The number of input chars from @cp which were processed.
  */
 static int
 n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
@@ -1763,7 +1761,7 @@ static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
  * guaranteed that this function will not be re-entered or in progress
  * when the ldisc is closed.
  *
- * Locking: Caller holds tty->termios_rwsem
+ * Context: Caller holds tty->termios_rwsem.
  */
 static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
@@ -1873,10 +1871,11 @@ static void n_tty_close(struct tty_struct *tty)
  * n_tty_open() - open an ldisc
  * @tty: terminal to open
  *
- * Called when this line discipline is being attached to the
- * terminal device. Can sleep. Called serialized so that no
- * other events will occur in parallel. No further open will occur
- * until a close.
+ * Called when this line discipline is being attached to the terminal
+ * device. Called serialized so that no other events will occur in
+ * parallel. No further open will occur until a close.
+ *
+ * Context: Can sleep.
  */
 static int n_tty_open(struct tty_struct *tty)
 {
@@ -1924,11 +1923,9 @@ static inline int input_available_p(struct tty_struct *tty, int poll)
  * buffer, and once to drain the space from the (physical) beginning of
  * the buffer to head pointer.
  *
- * Called under the ldata->atomic_read_lock sem
- *
- * n_tty_read()/consumer path:
- * 	caller holds non-exclusive termios_rwsem
- * 	read_tail published
+ * Context: Called under the ldata->atomic_read_lock sem.
+ *          n_tty_read()/consumer path: caller holds non-exclusive
+ *          termios_rwsem read_tail published.
  */
 static int copy_from_read_buf(struct tty_struct *tty,
 				      unsigned char __user **b,
@@ -1979,11 +1976,9 @@ static int copy_from_read_buf(struct tty_struct *tty,
  * This causes data already processed as input to be immediately available
  * as input although a newline has not been received.
  *
- * Called under the atomic_read_lock mutex
- *
- * n_tty_read()/consumer path:
- * 	caller holds non-exclusive termios_rwsem
- * 	read_tail published
+ * Context: Called under the atomic_read_lock mutex.
+ *          n_tty_read()/consumer path: caller holds non-exclusive
+ *          termios_rwsem read_tail published.
  */
 static int canon_copy_from_read_buf(struct tty_struct *tty,
 				    unsigned char __user **b,
@@ -2061,9 +2056,9 @@ extern ssize_t redirected_tty_write(struct file *, const char __user *,
  * and if appropriate send any needed signals and return a negative
  * error code if action should be taken.
  *
- * Locking: redirected write test is safe
+ * Context: redirected write test is safe
  *          current->signal->tty check is safe
- *          ctrl_lock to safely reference tty->pgrp
+ *          ctrl_lock to safely reference tty->pgrp.
  */
 static int job_control(struct tty_struct *tty, struct file *file)
 {
@@ -2093,9 +2088,8 @@ static int job_control(struct tty_struct *tty, struct file *file)
  *
  * This code must be sure never to sleep through a hangup.
  *
- * n_tty_read()/consumer path:
- * 	claims non-exclusive termios_rwsem
- * 	publishes read_tail
+ * Context: n_tty_read()/consumer path: claims non-exclusive
+ *          termios_rwsem publishes read_tail.
  */
 static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 			 unsigned char __user *buf, size_t nr)
@@ -2261,9 +2255,9 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
  *
  * This code must be sure never to sleep through a hangup.
  *
- * Locking: output_lock to protect column state and space left
+ * Context: output_lock to protect column state and space left
  *          (note that the process_output*() functions take this
- *          lock themselves)
+ *          lock themselves).
  */
 static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *buf, size_t nr)
@@ -2363,7 +2357,8 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
  * other events save open/close.
  *
  * This code must be sure never to sleep through a hangup.
- * Called without the kernel lock held - fine
+ *
+ * Context: Called without the kernel lock held - fine.
  */
 static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
 							poll_table *wait)
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 35cb13995c1c..c3db7d6d7b5b 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -369,7 +369,7 @@ static void pty_stop(struct tty_struct *tty)
  * Perform the initial set up for the tty/pty pair. Called from the
  * tty layer when the port is first opened.
  *
- * Locking: the caller must hold the tty_mutex
+ * Context: The caller must hold the tty_mutex.
  */
 static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
 		bool legacy)
@@ -687,8 +687,9 @@ static long pty_unix98_compat_ioctl(struct tty_struct *tty,
  * @driver: ptm driver
  * @idx: tty index
  *
- * Look up a pty master device. Called under the tty_mutex for now.
- * This provides our locking.
+ * Look up a pty master device.
+ *
+ * Context: Called under the tty_mutex for now. This provides our locking.
  */
 static struct tty_struct *ptm_unix98_lookup(struct tty_driver *driver,
 		struct file *file, int idx)
@@ -702,8 +703,10 @@ static struct tty_struct *ptm_unix98_lookup(struct tty_driver *driver,
  * @driver: pts driver
  * @idx: tty index
  *
- * Look up a pty master device. Called under the tty_mutex for now.
- * This provides our locking for the tty pointer.
+ * Look up a pty master device.
+ *
+ * Context: Called under the tty_mutex for now.  This provides our
+ *          locking for the tty pointer.
  */
 static struct tty_struct *pts_unix98_lookup(struct tty_driver *driver,
 		struct file *file, int idx)
@@ -787,9 +790,9 @@ static const struct tty_operations pty_unix98_ops = {
  *
  * Allocate a unix98 pty master device from the ptmx driver.
  *
- * Locking: tty_mutex protects the init_dev work. tty->count should
- *          protect the rest.
- *          allocated_ptys_lock handles the list of free pty numbers
+ * Context: tty_mutex protects the init_dev work. tty->count should
+ *          protect the rest.  allocated_ptys_lock handles the list
+ *          of free pty numbers.
  */
 static int ptmx_open(struct inode *inode, struct file *filp)
 {
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 63d7537a1db1..e5157e0679de 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -404,9 +404,10 @@ static struct uart_8250_port serial8250_ports[UART_NR];
  * This struct *must* *not* be used to perform a 8250 or serial core operation
  * which is not accessible otherwise. Its only purpose is to make the struct
  * accessible to the runtime-pm callbacks for context suspend/restore.
- * The lock assumption made here is none because runtime-pm suspend/resume
- * callbacks should not be invoked if there is any operation performed on the
- * port.
+ *
+ * Context: The lock assumption made here is none because runtime-pm
+ *          suspend/resume callbacks should not be invoked if there is any
+ *          operation performed on the port.
  */
 struct uart_8250_port *serial8250_get_port(int line)
 {
@@ -624,7 +625,7 @@ static int univ8250_console_setup(struct console *co, char *options)
  * Performs console setup for a match (as required by interface)
  * If no <options> are specified, then assume the h/w is already setup.
  *
- * Returns 0 if console matches; otherwise non-zero to use default matching
+ * Return: 0 if console matches; otherwise non-zero to use default matching.
  */
 static int univ8250_console_match(struct console *co, char *name, int idx,
 				  char *options)
@@ -1066,8 +1067,9 @@ EXPORT_SYMBOL(serial8250_register_8250_port);
  * serial8250_unregister_port() - remove a 16x50 serial port at runtime
  * @line: serial line number
  *
- * Remove one serial port.  This may not be called from interrupt
- * context.  We hand the port back to the our control.
+ * Remove one serial port.  We hand the port back to the our control.
+ *
+ * Context: This may not be called from interrupt context.
  */
 void serial8250_unregister_port(int line)
 {
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 589adc597923..73fd98fd13e4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2355,7 +2355,7 @@ static int __init pl011_console_setup(struct console *co, char *options)
  * Performs console setup for a match (as required by interface)
  * If no <options> are specified, then assume the h/w is already setup.
  *
- * Returns 0 if console matches; otherwise non-zero to use default matching
+ * Return: 0 if console matches; otherwise non-zero to use default matching.
  */
 static int __init pl011_console_match(struct console *co, char *name, int idx,
 				      char *options)
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 85bd5a5d7f39..f56703c10ac6 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -164,8 +164,8 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
  * <options> string in the 'options' parameter; all other forms set
  * the parameter to NULL.
  *
- * Returns 0 if an attempt to register the earlycon was made,
- * otherwise negative error code
+ * Return: 0 if an attempt to register the earlycon was made,
+ *         otherwise negative error code.
  */
 int __init setup_earlycon(char *buf)
 {
diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 63c8b9f8c7b7..6d3a9cfaad34 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -169,12 +169,10 @@ ifx_spi_power_state_clear(struct ifx_spi_device *ifx_dev, unsigned char val)
 }
 
 /**
- * swap_buf_8()
+ * swap_buf_8() - Swap the contents of a buffer into big endian format.
  * @buf: our buffer
  * @len: number of bytes (not words) in the buffer
  * @end: end of buffer
- *
- * Swap the contents of a buffer into big endian format
  */
 static inline void swap_buf_8(unsigned char *buf, int len, void *end)
 {
@@ -183,12 +181,10 @@ static inline void swap_buf_8(unsigned char *buf, int len, void *end)
 }
 
 /**
- * swap_buf_16()
+ * swap_buf_16() - Swap the contents of a buffer into big endian format.
  * @buf: our buffer
  * @len: number of bytes (not words) in the buffer
  * @end: end of buffer
- *
- * Swap the contents of a buffer into big endian format
  */
 static inline void swap_buf_16(unsigned char *buf, int len, void *end)
 {
@@ -208,12 +204,10 @@ static inline void swap_buf_16(unsigned char *buf, int len, void *end)
 }
 
 /**
- * swap_buf_32()
+ * swap_buf_32() - Swap the contents of a buffer into big endian format.
  * @buf: our buffer
  * @len: number of bytes (not words) in the buffer
  * @end: end of buffer
- *
- * Swap the contents of a buffer into big endian format
  */
 static inline void swap_buf_32(unsigned char *buf, int len, void *end)
 {
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index b6b17d5005f6..621217e4ee27 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1059,8 +1059,9 @@ static int serial_txx9_register_port(struct uart_port *port)
  * serial_txx9_unregister_port() - remove a txx9 serial port at runtime
  * @line: serial line number
  *
- * Remove one serial port.  This may not be called from interrupt
- * context.  We hand the port back to the our control.
+ * Remove one serial port.  We hand the port back to the our control.
+ *
+ * Context: This may not be called from interrupt context.
  */
 static void serial_txx9_unregister_port(int line)
 {
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 5ed85c49bbce..527dd273fccb 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -204,7 +204,6 @@ struct cdns_platform_data {
  * cdns_uart_handle_rx() - Handle the received bytes along with Rx errors.
  * @dev_id: Id of the UART port
  * @isrstatus: The interrupt status register value as read
- * Return: None
  */
 static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 {
@@ -299,7 +298,6 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 /**
  * cdns_uart_handle_tx() - Handle the bytes to be Txed.
  * @dev_id: Id of the UART port
- * Return: None
  */
 static void cdns_uart_handle_tx(void *dev_id)
 {
@@ -378,8 +376,6 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
  * @rbdiv: BDIV value (return value)
  * @rcd: CD value (return value)
  * @div8: Value for clk_sel bit in mod (return value)
- * Return: baud rate, requested baud when possible, or actual baud when there
- *	was too much error, zero if no valid divisors are found.
  *
  * Formula to obtain baud rate is
  *	baud_tx/rx rate = clk/CD * (BDIV + 1)
@@ -390,6 +386,9 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
  *	CD and BDIV depends on values in
  *			baud rate generate register
  *			baud rate clock divisor register
+ *
+ * Return: Baud rate, requested baud when possible, or actual baud when
+ *         there was too much error, zero if no valid divisors are found.
  */
 static unsigned int cdns_uart_calc_baud_divs(unsigned int clk,
 		unsigned int baud, u32 *rbdiv, u32 *rcd, int *div8)
@@ -437,6 +436,7 @@ static unsigned int cdns_uart_calc_baud_divs(unsigned int clk,
  * cdns_uart_set_baud_rate() - Calculate and set the baud rate
  * @port: Handle to the uart port structure
  * @baud: Baud rate to set
+ *
  * Return: baud rate, requested baud when possible, or actual baud when there
  *	   was too much error, zero if no valid divisors are found.
  */
@@ -472,6 +472,7 @@ static unsigned int cdns_uart_set_baud_rate(struct uart_port *port,
  * @nb:		Notifier block
  * @event:	Notify event
  * @data:	Notifier data
+ *
  * Return:	NOTIFY_OK or NOTIFY_DONE on success, NOTIFY_BAD on error.
  */
 static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
@@ -665,11 +666,13 @@ static void cdns_uart_break_ctl(struct uart_port *port, int ctl)
 }
 
 /**
- * cdns_uart_set_termios() - termios operations, handling data length, parity,
- *				stop bits, flow control, baud rate
+ * cdns_uart_set_termios() - termios operations
  * @port: Handle to the uart port structure
  * @termios: Handle to the input termios structure
  * @old: Values of the previously saved termios structure
+ *
+ * Termios operations, handling data length, parity, stop bits,
+ * flow control, baud rate.
  */
 static void cdns_uart_set_termios(struct uart_port *port,
 				struct ktermios *termios, struct ktermios *old)
@@ -938,11 +941,11 @@ static int cdns_uart_verify_port(struct uart_port *port,
 }
 
 /**
- * cdns_uart_request_port() - Claim the memory region attached to cdns_uart port,
- *				called when the driver adds a cdns_uart port via
- *				uart_add_one_port()
+ * cdns_uart_request_port() - Claim the memory region attached to cdns_uart port.
  * @port: Handle to the uart port structure
  *
+ * Called when the driver adds a cdns_uart port via uart_add_one_port().
+ *
  * Return: 0 on success, negative errno otherwise.
  */
 static int cdns_uart_request_port(struct uart_port *port)
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 54574c8d677e..34d1b09b69a1 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -149,7 +149,7 @@ void tty_audit_tiocsti(struct tty_struct *tty, char ch)
 /**
  * tty_audit_push() - Flush current's pending audit data
  *
- * Returns 0 if success, -EPERM if tty audit is disabled
+ * Return: 0 if success, -EPERM if tty audit is disabled.
  */
 int tty_audit_push(void)
 {
@@ -170,9 +170,10 @@ int tty_audit_push(void)
 /**
  * tty_audit_buf_get() - Get an audit buffer.
  *
- * Get an audit buffer, allocate it if necessary.  Return %NULL
- * if out of memory or ERR_PTR(-ESRCH) if tty_audit_exit() has already
- * occurred.  Otherwise, return a new reference to the buffer.
+ * Get an audit buffer, allocate it if necessary.
+ *
+ * Return: %NULL if out of memory or ERR_PTR(-ESRCH) if tty_audit_exit()
+ * has already occurred.  Otherwise, return a new reference to the buffer.
  */
 static struct tty_audit_buf *tty_audit_buf_get(void)
 {
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index fac79ff29fb1..1bb4c3fb61b2 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -50,12 +50,12 @@ static int n_baud_table = ARRAY_SIZE(baud_table);
  * tty_termios_baud_rate()
  * @termios: termios structure
  *
- * Convert termios baud rate data into a speed. This should be called
- * with the termios lock held if this termios is a terminal termios
- * structure. May change the termios data. Device drivers can call this
- * function but should use ->c_[io]speed directly as they are updated.
+ * Convert termios baud rate data into a speed.
  *
- * Locking: none
+ * Context: This should be called with the termios lock held if this termios
+ *          is a terminal termios structure. May change the termios data.
+ *          Device drivers can call this function but should use ->c_[io]speed
+ *          directly as they are updated.
  */
 speed_t tty_termios_baud_rate(struct ktermios *termios)
 {
@@ -84,12 +84,12 @@ EXPORT_SYMBOL(tty_termios_baud_rate);
  * tty_termios_input_baud_rate()
  * @termios: termios structure
  *
- * Convert termios baud rate data into a speed. This should be called
- * with the termios lock held if this termios is a terminal termios
- * structure. May change the termios data. Device drivers can call this
- * function but should use ->c_[io]speed directly as they are updated.
+ * Convert termios baud rate data into a speed.
  *
- * Locking: none
+ * Context: This should be called with the termios lock held if this termios
+ *          is a terminal termios structure. May change the termios data.
+ *          Device drivers can call this function but should use ->c_[io]speed
+ *          directly as they are updated.
  */
 speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 {
@@ -133,11 +133,11 @@ EXPORT_SYMBOL(tty_termios_input_baud_rate);
  * desired speed. We allow small margins and preserve as much of possible
  * of the input intent to keep compatibility.
  *
- * Locking: Caller should hold termios lock. This is already held
- * when calling this function from the driver termios handler.
- *
  * The ifdefs deal with platforms whose owners have yet to update them
  * and will all go away once this is done.
+ *
+ * Context: Caller should hold termios lock. This is already held
+ *          when calling this function from the driver termios handler.
  */
 void tty_termios_encode_baud_rate(struct ktermios *termios,
 				  speed_t ibaud, speed_t obaud)
@@ -227,8 +227,9 @@ EXPORT_SYMBOL_GPL(tty_termios_encode_baud_rate);
  * @obad: output baud rate
  *
  * Update the current termios data for the tty with the new speed
- * settings. The caller must hold the termios_rwsem for the tty in
- * question.
+ * settings.
+ *
+ * Context: The caller must hold the termios_rwsem for the tty in question.
  */
 void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud, speed_t obaud)
 {
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index a7af04ed8bc5..499681719d6c 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -146,8 +146,8 @@ void tty_buffer_free_all(struct tty_port *port)
  * We round our buffers off in 256 character chunks to get better
  * allocation behaviour.
  *
- * Return NULL if out of memory or the allocation would exceed the
- * per device queue
+ * Return: NULL if out of memory or the allocation would exceed the
+ *         per device queue.
  */
 static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 {
@@ -208,8 +208,8 @@ static void tty_buffer_free(struct tty_port *port, struct tty_buffer *b)
  * flush all the buffers containing receive data. If ld != NULL,
  * flush the ldisc input buffer.
  *
- * Locking: takes buffer lock to ensure single-threaded flip buffer
- * 	    'consumer'
+ * Context: Takes buffer lock to ensure single-threaded flip buffer
+ * 	    'consumer'.
  */
 void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 {
@@ -300,7 +300,9 @@ EXPORT_SYMBOL_GPL(tty_buffer_request_room);
  * @size: size
  *
  * Queue a series of bytes to the tty buffering. All the characters
- * passed are marked with the supplied flag. Returns the number added.
+ * passed are marked with the supplied flag.
+ *
+ * Return: The number of bytes added.
  */
 int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 		const unsigned char *chars, char flag, size_t size)
@@ -334,8 +336,9 @@ EXPORT_SYMBOL(tty_insert_flip_string_fixed_flag);
  * @size: size
  *
  * Queue a series of bytes to the tty buffering. For each character
- * the flags array indicates the status of the character. Returns the
- * number added.
+ * the flags array indicates the status of the character.
+ *
+ * Return: The number of bytes added.
  */
 int tty_insert_flip_string_flags(struct tty_port *port,
 		const unsigned char *chars, const char *flags, size_t size)
@@ -443,7 +446,7 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
  * Callers other than flush_to_ldisc() need to exclude the kworker
  * from concurrent use of the line discipline, see paste_selection().
  *
- * Returns the number of bytes processed
+ * Return: The number of bytes processed.
  */
 int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 			  char *f, int count)
@@ -484,8 +487,8 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
  *
  * The receive_buf method is single threaded for each tty instance.
  *
- * Locking: takes buffer lock to ensure single-threaded flip buffer
- * 	    'consumer'
+ * Context: Takes buffer lock to ensure single-threaded flip buffer
+ * 	    'consumer'.
  */
 static void flush_to_ldisc(struct work_struct *work)
 {
@@ -535,10 +538,11 @@ static void flush_to_ldisc(struct work_struct *work)
  * @port: tty port to push
  *
  * Queue a push of the terminal flip buffers to the line discipline.
- * Can be called from IRQ/atomic context.
  *
  * In the event of the queue being busy for flipping the work will be
  * held off and retried later.
+ *
+ * Context: Can be called from IRQ/atomic context.
  */
 void tty_flip_buffer_push(struct tty_port *port)
 {
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1917e7255d13..d4e510309f75 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -163,7 +163,7 @@ static void release_tty(struct tty_struct *tty, int idx);
  *
  * Free the write buffers, tty queue and tty memory itself.
  *
- * Locking: none. Must be called after tty is definitely unused
+ * Context: No locks taken. Must be called after tty is definitely unused.
  */
 static void free_tty_struct(struct tty_struct *tty)
 {
@@ -238,7 +238,7 @@ static void tty_del_file(struct file *file)
  * Convert a tty structure into a name. The name reflects the kernel
  * naming policy and if udev is in use may not reflect user space
  *
- * Locking: none
+ * Context: No locks taken.
  */
 const char *tty_name(const struct tty_struct *tty)
 {
@@ -309,7 +309,7 @@ static int check_tty_count(struct tty_struct *tty, const char *routine)
  * This routine returns a tty driver structure, given a device number
  * and also passes back the index number.
  *
- * Locking: caller must hold tty_mutex
+ * Context: Caller must hold tty_mutex.
  */
 static struct tty_driver *get_tty_driver(dev_t device, int *index)
 {
@@ -334,7 +334,7 @@ static struct tty_driver *get_tty_driver(dev_t device, int *index)
  * like (4, 64) or (188, 1). If no corresponding driver is registered then
  * the function returns -ENODEV.
  *
- * Locking: this acquires tty_mutex to protect the tty_drivers list from
+ * Context: Acquires tty_mutex to protect the tty_drivers list from
  *          being modified while we are traversing it, and makes sure to
  *          release it before exiting.
  */
@@ -750,8 +750,7 @@ EXPORT_SYMBOL(tty_hung_up_p);
  * called from any context, may be under the tty atomic_write_lock
  * but not always.
  *
- * Locking:
- *         flow_lock
+ * Context: Takes flow_lock.
  */
 void __stop_tty(struct tty_struct *tty)
 {
@@ -780,8 +779,7 @@ EXPORT_SYMBOL(stop_tty);
  * tty was previous stopped and is now being started, the driver
  * start method is invoked and the line discipline woken.
  *
- * Locking:
- *         flow_lock
+ * Context: Takes flow_lock.
  */
 void __start_tty(struct tty_struct *tty)
 {
@@ -827,9 +825,8 @@ static void tty_update_time(struct timespec64 *time)
  * Perform the read system call function on this terminal device. Checks
  * for hung up devices before calling the line discipline method.
  *
- * Locking:
- *         Locks the line discipline internally while needed. Multiple
- * read calls may be outstanding in parallel.
+ * Context: Locks the line discipline internally while needed. Multiple
+ *          read calls may be outstanding in parallel.
  */
 static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 			loff_t *ppos)
@@ -999,11 +996,10 @@ void tty_write_message(struct tty_struct *tty, char *msg)
  *
  * Write data to a tty device via the line discipline.
  *
- * Locking:
- *         Locks the line discipline as required
- *         Writes to the tty driver are serialized by the atomic_write_lock
- * and are then processed in chunks to the device. The line discipline
- * write method will not be invoked in parallel for each device.
+ * Context: Locks the line discipline as required.  Writes to the tty
+ *          driver are serialized by the atomic_write_lock and are then
+ *          processed in chunks to the device. The line discipline write
+ *          method will not be invoked in parallel for each device.
  */
 static ssize_t tty_write(struct file *file, const char __user *buf,
 						size_t count, loff_t *ppos)
@@ -1054,7 +1050,7 @@ ssize_t redirected_tty_write(struct file *file, const char __user *buf,
  *
  * Send a high priority character to the tty even if stopped
  *
- * Locking: none for xchar method, write ordering for write method.
+ * Context: Takes termios_rwsem and write ordering for write method.
  */
 int tty_send_xchar(struct tty_struct *tty, char ch)
 {
@@ -1092,7 +1088,7 @@ static char ptychar[] = "pqrstuvwxyzabcde";
  * Generate a name from a driver reference and write it to the output
  * buffer.
  *
- * Locking: None
+ * Context: No locks taken.
  */
 static void pty_line_name(struct tty_driver *driver, int index, char *p)
 {
@@ -1112,7 +1108,7 @@ static void pty_line_name(struct tty_driver *driver, int index, char *p)
  * Generate a name from a driver reference and write it to the output
  * buffer.
  *
- * Locking: None
+ * Context: No locks taken.
  */
 static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 {
@@ -1131,7 +1127,7 @@ static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
  * Return the tty, if found. If not found, return NULL or ERR_PTR() if the
  * driver lookup() method returns an error.
  *
- * Locking: tty_mutex must be held. If the tty is found, bump the tty kref.
+ * Context: tty_mutex must be held. If the tty is found, bump the tty kref.
  */
 static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 		struct file *file, int idx)
@@ -1200,7 +1196,7 @@ EXPORT_SYMBOL_GPL(tty_standard_install);
  * for ensuring any need additional structures are allocated and
  * configured.
  *
- * Locking: tty_mutex for now
+ * Context: tty_mutex for now.
  */
 static int tty_driver_install_tty(struct tty_driver *driver,
 						struct tty_struct *tty)
@@ -1214,10 +1210,10 @@ static int tty_driver_install_tty(struct tty_driver *driver,
  * @driver: the driver for the tty
  * @idx: the minor number
  *
- * Remvoe a tty object from the driver tables. The tty->index field
+ * Remove a tty object from the driver tables. The tty->index field
  * will be set by the time this is called.
  *
- * Locking: tty_mutex for now
+ * Context: tty_mutex for now.
  */
 static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *tty)
 {
@@ -1273,10 +1269,6 @@ static int tty_reopen(struct tty_struct *tty)
  * could also be an active device. The pty drivers require special
  * handling because of this.
  *
- * Locking:
- *         The function is called under the tty_mutex, which
- * protects us from the tty struct or driver itself going away.
- *
  * On exit the tty device has the line discipline attached and
  * a reference count of 1. If a pair was created for pty/tty use
  * and the other was a pty master then it too has a reference count of 1.
@@ -1285,6 +1277,9 @@ static int tty_reopen(struct tty_struct *tty)
  * failed open.  The new code protects the open with a mutex, so it's
  * really quite straightforward.  The mutex locking can probably be
  * relaxed for the (most common) case of reopening a tty.
+ *
+ * Context: The function is called under the tty_mutex, which
+ *          protects us from the tty struct or driver itself going away.
  */
 struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 {
@@ -1399,12 +1394,11 @@ static void tty_flush_works(struct tty_struct *tty)
  * driver table slots. This function is called when a device is no longer
  * in use. It also gets called when setup of a device fails.
  *
- * Locking:
- *         takes the file list lock internally when working on the list
- * of ttys that the driver keeps.
- *
  * This method gets called from a work queue so that the driver private
  * cleanup ops can sleep (needed for USB at least)
+ *
+ * Context: Takes the file list lock internally when working on the list
+ *          of ttys that the driver keeps.
  */
 static void release_one_tty(struct work_struct *work)
 {
@@ -1599,15 +1593,14 @@ EXPORT_SYMBOL_GPL(tty_release_struct);
  * Called the last time each file handle is closed that references
  * this tty. There may however be several such references.
  *
- * Locking:
- *         Takes bkl. See tty_release_dev
- *
  * Even releasing the tty structures is a tricky business.. We have
  * to be very careful that the structures are all released at the
  * same time, as interrupts might otherwise get the wrong pointers.
  *
  * WSH 09/09/97: rewritten to avoid some nasty race conditions that could
  * lead to double frees or releasing memory still in use.
+ *
+ * Context: Takes bkl. See tty_release_dev
  */
 int tty_release(struct inode *inode, struct file *filp)
 {
@@ -1840,12 +1833,12 @@ static struct tty_driver *tty_lookup_driver(dev_t device, struct file *filp,
  * makes sure it's not already opened and performs the first-time
  * tty initialization.
  *
- * Returns the locked initialized &tty_struct
- *
- * Claims the global tty_mutex to serialize:
+ * Context: Claims the global tty_mutex to serialize:
  *   - concurrent first-time tty initialization
  *   - concurrent tty driver removal w/ lookup
  *   - concurrent tty removal from driver table
+ *
+ * Return: The locked initialized &tty_struct.
  */
 struct tty_struct *tty_kopen(dev_t device)
 {
@@ -1891,12 +1884,12 @@ EXPORT_SYMBOL_GPL(tty_kopen);
  * Performs the driver lookup, checks for a reopen, or otherwise
  * performs the first-time tty initialization.
  *
- * Returns the locked initialized or re-opened &tty_struct
- *
- * Claims the global tty_mutex to serialize:
+ * Context: Claims the global tty_mutex to serialize:
  *   - concurrent first-time tty initialization
  *   - concurrent tty driver removal w/ lookup
  *   - concurrent tty removal from driver table
+ *
+ * Return: The locked initialized or re-opened &tty_struct.
  */
 static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
 					     struct file *filp)
@@ -1966,9 +1959,9 @@ static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
  * The termios state of a pty is reset on first open so that
  * settings don't persist across reuse.
  *
- * Locking: tty_mutex protects tty, tty_lookup_driver and tty_init_dev.
- * 	 tty->count should protect the rest.
- * 	 ->siglock protects ->signal/->sighand
+ * Context: tty_mutex protects tty, tty_lookup_driver and tty_init_dev.
+ *          tty->count should protect the nrest.
+ *          ->siglock protects ->signal/->sighand
  *
  * Note: the tty_unlock/lock cases without a ref are only safe due to
  * tty_mutex
@@ -2053,8 +2046,8 @@ static int tty_open(struct inode *inode, struct file *filp)
  * Call the line discipline polling method to obtain the poll
  * status of the device.
  *
- * Locking: locks called line discipline but ldisc poll method
- * may be re-entered freely by other callers.
+ * Context: Locks called line discipline but ldisc poll method
+ *          may be re-entered freely by other callers.
  */
 static __poll_t tty_poll(struct file *filp, poll_table *wait)
 {
@@ -2132,9 +2125,8 @@ static int tty_fasync(int fd, struct file *filp, int on)
  *
  * FIXME: does not honour flow control ??
  *
- * Locking:
- *         Called functions take tty_ldiscs_lock
- *         current->signal->tty check is safe without locks
+ * Context: Called functions take tty_ldiscs_lock
+ *          current->signal->tty check is safe without locks
  *
  * FIXME: may race normal receive processing
  */
@@ -2163,8 +2155,8 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
  *
  * Copies the kernel idea of the window size into the user buffer.
  *
- * Locking: tty->winsize_mutex is taken to ensure the winsize data
- *          is consistent.
+ * Context: tty->winsize_mutex is taken to ensure the winsize data
+ * 	    is consistent.
  */
 static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
@@ -2217,10 +2209,9 @@ EXPORT_SYMBOL(tty_do_resize);
  * this is just advisory information but for the Linux console it
  * actually has driver level meaning and triggers a VC resize.
  *
- * Locking:
- *         Driver dependent. The default do_resize method takes the
- * tty termios mutex and ctrl_lock. The console takes its own lock
- * then calls into the default method.
+ * Context: Driver dependent. The default do_resize method takes the
+ *          tty termios mutex and ctrl_lock. The console takes its own lock
+ *          then calls into the default method.
  */
 static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
@@ -2240,7 +2231,7 @@ static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
  *
  * Allow the administrator to move the redirected console device
  *
- * Locking: uses redirect_lock to guard the redirect information
+ * Context: Uses redirect_lock to guard the redirect information.
  */
 static int tioccons(struct file *file)
 {
@@ -2275,7 +2266,7 @@ static int tioccons(struct file *file)
  * the generic functionality existed. This piece of history is preserved
  * in the expected tty API of posix OS's.
  *
- * Locking: none, the open file handle ensures it won't go away.
+ * Context: No locks taken, the open file handle ensures it won't go away.
  */
 static int fionbio(struct file *file, int __user *p)
 {
@@ -2300,7 +2291,7 @@ static int fionbio(struct file *file, int __user *p)
  *
  * Set the line discipline according to user request.
  *
- * Locking: see tty_set_ldisc, this function is just a helper
+ * Context: Please see tty_set_ldisc, this function is just a helper.
  */
 static int tiocsetd(struct tty_struct *tty, int __user *p)
 {
@@ -2322,8 +2313,8 @@ static int tiocsetd(struct tty_struct *tty, int __user *p)
  *
  * Retrieves the line discipline id directly from the ldisc.
  *
- * Locking: waits for ldisc reference (in case the line discipline
- *          is changing or the tty is being hungup)
+ * Context: Waits for ldisc reference (in case the line discipline
+ *          is changing or the tty is being hungup).
  */
 static int tiocgetd(struct tty_struct *tty, int __user *p)
 {
@@ -2346,9 +2337,7 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  * Perform a timed break on hardware that lacks its own driver level
  * timed break functionality.
  *
- * Locking:
- *         atomic_write_lock serializes
- *
+ * Context: atomic_write_lock serializes.
  */
 static int send_break(struct tty_struct *tty, unsigned int duration)
 {
@@ -2386,7 +2375,7 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
  * Obtain the modem status bits from the tty driver if the feature
  * is supported. Return -EINVAL if it is not available.
  *
- * Locking: none (up to the driver)
+ * Context: No locks taken (up to the driver).
  */
 static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 {
@@ -2410,7 +2399,7 @@ static int tty_tiocmget(struct tty_struct *tty, int __user *p)
  * Set the modem status bits from the tty driver if the feature
  * is supported. Return -EINVAL if it is not available.
  *
- * Locking: none (up to the driver)
+ * Context: No locks taken (up to the driver).
  */
 static int tty_tiocmset(struct tty_struct *tty, unsigned int cmd,
 	     unsigned __user *p)
@@ -2776,7 +2765,7 @@ static struct device *tty_get_device(struct tty_struct *tty)
  *
  * This subroutine allocates and initializes a tty structure.
  *
- * Locking: none - tty in question is not exposed at this point
+ * Locking: No locks taken - tty in question is not exposed at this point.
  */
 struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 {
@@ -2824,10 +2813,12 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
  * @ch: character
  *
  * Write one byte to the tty using the provided put_char method
- * if present. Returns the number of characters successfully output.
+ * if present.
  *
  * Note: the specific put_char operation in the driver layer may go
  * away soon. Don't call it directly, use this method
+ *
+ * Return: The number of characters successfully output.
  */
 int tty_put_char(struct tty_struct *tty, unsigned char ch)
 {
@@ -2864,15 +2855,15 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
  *          This field is optional, if there is no known struct device
  *          for this tty device it can be set to NULL safely.
  *
- * Returns a pointer to the struct device for this tty device
- * (or ERR_PTR(-EFOO) on error).
- *
  * This call is required to be made to register an individual tty device
  * if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
  * that bit is not set, this function should not be called by a tty
  * driver.
  *
  * Locking: ??
+ *
+ * Return: A pointer to the struct device for this tty device
+ *         (or ERR_PTR(-EFOO) on error).
  */
 struct device *tty_register_device(struct tty_driver *driver, unsigned index,
 				   struct device *device)
@@ -2897,15 +2888,15 @@ static void tty_device_create_release(struct device *dev)
  * @drvdata: Driver data to be set to device.
  * @attr_grp: Attribute group to be set on device.
  *
- * Returns a pointer to the struct device for this tty device
- * (or ERR_PTR(-EFOO) on error).
- *
  * This call is required to be made to register an individual tty device
  * if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
  * that bit is not set, this function should not be called by a tty
  * driver.
  *
  * Locking: ??
+ *
+ * Return: A pointer to the struct device for this tty device
+ *         (or ERR_PTR(-EFOO) on error).
  */
 struct device *tty_register_device_attr(struct tty_driver *driver,
 				   unsigned index, struct device *device,
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index b873625c685e..936190fa40c3 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -147,7 +147,7 @@ EXPORT_SYMBOL(tty_unthrottle);
  * throttle due to race conditions when throttling is conditional
  * on factors evaluated prior to throttling.
  *
- * Returns 0 if tty is throttled (or was already throttled)
+ * Return: 0 if tty is throttled (or was already throttled).
  */
 int tty_throttle_safe(struct tty_struct *tty)
 {
@@ -177,7 +177,7 @@ int tty_throttle_safe(struct tty_struct *tty)
  * unthrottle due to race conditions when unthrottling is conditional
  * on factors evaluated prior to unthrottling.
  *
- * Returns 0 if tty is unthrottled (or was already unthrottled)
+ * Return: 0 if tty is unthrottled (or was already unthrottled).
  */
 int tty_unthrottle_safe(struct tty_struct *tty)
 {
@@ -206,7 +206,7 @@ int tty_unthrottle_safe(struct tty_struct *tty)
  * Wait for characters pending in a tty driver to hit the wire, or
  * for a timeout to occur (eg due to flow control)
  *
- * Locking: none
+ * Context: No locks taken.
  */
 void tty_wait_until_sent(struct tty_struct *tty, long timeout)
 {
@@ -301,7 +301,7 @@ EXPORT_SYMBOL(tty_termios_hw_change);
  * Perform updates to the termios values set on this terminal.
  * A master pty's termios should never be set.
  *
- * Locking: termios_rwsem
+ * Context: Takes termios_rwsem.
  */
 int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 {
@@ -347,8 +347,7 @@ EXPORT_SYMBOL_GPL(tty_set_termios);
  * Helper function to prepare termios data and run necessary other
  * functions before using tty_set_termios to do the actual changes.
  *
- * Locking:
- *         Called functions take ldisc and termios_rwsem locks
+ * Context: Takes termios_rwsem.  Called functions take ldisc.
  */
 static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 {
@@ -551,7 +550,7 @@ static void set_sgflags(struct ktermios *termios, int flags)
  * Updates a terminal from the legacy BSD style terminal information
  * structure.
  *
- * Locking: termios_rwsem
+ * Context: Takes termios_rwsem.
  */
 static int set_sgttyb(struct tty_struct *tty, struct sgttyb __user *sgttyb)
 {
@@ -662,6 +661,8 @@ static int set_ltchars(struct tty_struct *tty, struct ltchars __user *ltchars)
  *
  * Perform a change to the CLOCAL state and call into the driver
  * layer to make it visible. All done with the termios rwsem
+ *
+ * Context: Takes termios_rwsem.
  */
 static int tty_change_softcar(struct tty_struct *tty, int arg)
 {
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 0ad21eafd53a..c69f25b47482 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -26,7 +26,7 @@ static int is_ignored(int sig)
  * not in the foreground, send a SIGTTOU.  If the signal is blocked or
  * ignored, go ahead and perform the operation.  (POSIX 7.2)
  *
- * Locking: ctrl_lock
+ * Context: Takes ctrl_lock.
  */
 int __tty_check_change(struct tty_struct *tty, int sig)
 {
@@ -87,7 +87,7 @@ void proc_clear_tty(struct task_struct *p)
  * Only callable by the session leader and only if it does not already have
  * a controlling terminal.
  *
- * Caller must hold:  tty_lock()
+ * Context: Caller must hold:  tty_lock()
  * 	      a readlock on tasklist_lock
  * 	      sighand lock
  */
@@ -335,10 +335,9 @@ void no_tty(void)
  * This ioctl is used to manage job control. It permits a session
  * leader to set this tty as the controlling tty for the session.
  *
- * Locking:
- *         Takes tty_lock() to serialize proc_set_tty() for this tty
- *         Takes tasklist_lock internally to walk sessions
- *         Takes ->siglock() when updating signal->tty
+ * Context: Takes tty_lock() to serialize proc_set_tty() for this tty
+ *          Takes tasklist_lock internally to walk sessions
+ *          Takes ->siglock() when updating signal->tty
  */
 static int tiocsctty(struct tty_struct *tty, struct file *file, int arg)
 {
@@ -438,7 +437,7 @@ static struct pid *session_of_pgrp(struct pid *pgrp)
  * Obtain the process group of the tty. If there is no process group
  * return an error.
  *
- * Locking: none. Reference to current->signal->tty is safe.
+ * Context: No Locks taken. Reference to current->signal->tty is safe.
  */
 static int tiocgpgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
@@ -465,7 +464,7 @@ static int tiocgpgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
  * Set the process group of the tty to the session passed. Only
  * permitted where the tty session is our session.
  *
- * Locking: RCU, ctrl lock
+ * Context: RCU, ctrl lock
  */
 static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
@@ -512,7 +511,7 @@ static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
  * Obtain the session id of the tty. If there is no session
  * return an error.
  *
- * Locking: none. Reference to current->signal->tty is safe.
+ * Context: No locks taken. Reference to current->signal->tty is safe.
  */
 static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 6c343bfa15f6..b9c62682996d 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -54,8 +54,7 @@ static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
  * is set up as unreferenced and then made available to the kernel
  * from this point onwards.
  *
- * Locking:
- *         takes tty_ldiscs_lock to guard against ldisc races
+ * Context: Takes tty_ldiscs_lock to guard against ldisc races.
  */
 int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc)
 {
@@ -83,8 +82,7 @@ EXPORT_SYMBOL(tty_register_ldisc);
  * Remove a line discipline from the kernel providing it is not
  * currently in use.
  *
- * Locking:
- *         takes tty_ldiscs_lock to guard against ldisc races
+ * Context: Takes tty_ldiscs_lock to guard against ldisc races.
  */
 int tty_unregister_ldisc(int disc)
 {
@@ -141,17 +139,16 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
  * Takes a reference to a line discipline. Deals with refcounts and
  * module locking counts.
  *
- * Returns: -EINVAL if the discipline index is not [N_TTY..NR_LDISCS] or
- * 		 if the discipline is not registered
- *          -EAGAIN if request_module() failed to load or register the
- * 		 the discipline
- *          -ENOMEM if allocation failure
+ * Context: Takes tty_ldiscs_lock to guard against ldisc races.
  *
- * 	 Otherwise, returns a pointer to the discipline and bumps the
- * 	 ref count
+ * Return: -EINVAL if the discipline index is not [N_TTY..NR_LDISCS] or
+ *                 if the discipline is not registered
+ *         -EAGAIN if request_module() failed to load or register the
+ *                 the discipline
+ *         -ENOMEM if allocation failure
  *
- * Locking:
- *         takes tty_ldiscs_lock to guard against ldisc races
+ *         Otherwise, returns a pointer to the discipline and bumps the
+ *         ref count.
  */
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 {
@@ -241,9 +238,6 @@ const struct seq_operations tty_ldiscs_seq_ops = {
  * reference to it. If the line discipline is in flux then
  * wait patiently until it changes.
  *
- * Returns: NULL if the tty has been hungup and not re-opened with
- * 	 a new file descriptor, otherwise valid ldisc reference
- *
  * Note: Must not be called from an IRQ/timer context. The caller
  * must also be careful not to hold other locks that will deadlock
  * against a discipline change, such as an existing ldisc reference
@@ -251,6 +245,9 @@ const struct seq_operations tty_ldiscs_seq_ops = {
  *
  * Note: a file_operations routine (read/poll/write) should use this
  * function to wait for any ldisc lifetime events to finish.
+ *
+ * Return: NULL if the tty has been hungup and not re-opened with
+ *         a new file descriptor, otherwise valid ldisc reference
  */
 struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
 {
@@ -413,7 +410,7 @@ EXPORT_SYMBOL_GPL(tty_ldisc_flush);
  * prevent the ldisc driver from re-using stale information for
  * the new ldisc instance.
  *
- * Locking: takes termios_rwsem
+ * Context: Takes termios_rwsem.
  */
 static void tty_set_termios_ldisc(struct tty_struct *tty, int disc)
 {
@@ -433,7 +430,7 @@ static void tty_set_termios_ldisc(struct tty_struct *tty, int disc)
  * A helper opening method. Also a convenient debugging and check
  * point.
  *
- * Locking: always called with BTM already held.
+ * Context: Always called with BTM already held.
  */
 static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 {
@@ -640,7 +637,7 @@ static void tty_reset_termios(struct tty_struct *tty)
  * is dropped and tty->ldisc reset to NULL. The caller can then retry
  * with N_TTY instead.
  *
- * Returns 0 if successful, otherwise error code < 0
+ * Return: 0 if successful, otherwise error code < 0.
  */
 int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 {
@@ -677,8 +674,8 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
  * event. In that situation we must also switch back to N_TTY properly
  * before we reset the termios data.
  *
- * Locking: We can take the ldisc mutex as the rest of the code is
- * careful to allow for this.
+ * Context: We can take the ldisc mutex as the rest of the code is
+ *          careful to allow for this.
  *
  * In the pty pair case this occurs in the close() path of the
  * tty itself so we must be careful about locking rules.
@@ -801,8 +798,8 @@ int tty_ldisc_init(struct tty_struct *tty)
  * tty_ldisc_deinit() - ldisc cleanup for new tty
  * @tty: tty that was allocated recently
  *
- * The tty structure must not becompletely set up (tty_ldisc_setup) when
- *      this call is made.
+ * The tty structure must not be completely set up (tty_ldisc_setup) when
+ * this call is made.
  */
 void tty_ldisc_deinit(struct tty_struct *tty)
 {
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index d4dfe29a6348..c5770682ee7a 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -339,7 +339,7 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
  * Perform port level tty hangup flag and count changes. Drop the tty
  * reference.
  *
- * Caller holds tty lock.
+ * Context: Caller holds tty lock.
  */
 void tty_port_hangup(struct tty_port *port)
 {
@@ -451,7 +451,7 @@ EXPORT_SYMBOL(tty_port_lower_dtr_rts);
  * management of these lines. Note that the dtr/rts raise is done each
  * iteration as a hangup may have previously dropped them while we wait.
  *
- * Caller holds tty lock.
+ * Context: Caller holds tty lock.
  *
  * NB: May drop and reacquire tty lock when blocking, so tty and tty_port
  * may have changed state (eg., may have been hung up).
@@ -623,7 +623,7 @@ EXPORT_SYMBOL(tty_port_close_end);
 /**
  * tty_port_close()
  *
- * Caller holds tty lock
+ * Context: Caller holds tty lock.
  */
 void tty_port_close(struct tty_port *port, struct tty_struct *tty,
 							struct file *filp)
@@ -658,7 +658,7 @@ EXPORT_SYMBOL_GPL(tty_port_install);
 /**
  * tty_port_open()
  *
- * Caller holds tty lock.
+ * Context: Caller holds tty lock.
  *
  * NB: may drop and reacquire tty lock (in tty_port_block_til_ready()) so
  * tty and tty_port may have changed state (eg., may be hung up now)
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 74f4ef98aa7d..45bc49229fe5 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -654,7 +654,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
  * with.  This routine is executed at video setup, and when the
  * PIO_FONTRESET ioctl is called.
  *
- * The caller must hold the console lock
+ * Context: The caller must hold the console lock.
  */
 int con_set_default_unimap(struct vc_data *vc)
 {
@@ -710,7 +710,7 @@ EXPORT_SYMBOL(con_set_default_unimap);
  * @dst_vc: target
  * @src_vt: source
  *
- * The caller must hold the console lock when invoking this method
+ * Context: The caller must hold the console lock.
  */
 int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc)
 {
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 3c3eb14e1565..487e5af87173 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1789,7 +1789,8 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
  * @arg: the requested mode
  *
  * Update the keyboard mode bits while holding the correct locks.
- * Return 0 for success or an error code.
+ *
+ * Return: 0 for success or an error code.
  */
 int vt_do_kdskbmode(int console, unsigned int arg)
 {
@@ -1829,7 +1830,8 @@ int vt_do_kdskbmode(int console, unsigned int arg)
  * @arg: the requested meta state
  *
  * Update the keyboard meta bits while holding the correct locks.
- * Return 0 for success or an error code.
+ *
+ * Return: 0 for success or an error code.
  */
 int vt_do_kdskbmeta(int console, unsigned int arg)
 {
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 473015beb0f2..309b3f043710 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -70,7 +70,9 @@ sel_pos(int n)
  * clear_selection() - remove current selection
  *
  * Remove the current selection highlight, if any from the console
- * holding the selection. The caller must hold the console lock.
+ * holding the selection.
+ *
+ * Context: The caller must hold the console lock.
  */
 void clear_selection(void)
 {
@@ -101,8 +103,10 @@ static inline int inword(const u32 c)
  * sel_loadlut() - load the LUT table
  * @p: user table
  *
- * Load the LUT table from user space. The caller must hold the console
- * lock. Make a temporary copy so a partial update doesn't make a mess.
+ * Load the LUT table from user space.  Make a temporary copy so a
+ * partial update doesn't make a mess.
+ *
+ * Context: The caller must hold the console lock.
  */
 int sel_loadlut(char __user *p)
 {
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index dae5a7a82aee..e0c989647d7e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1140,8 +1140,8 @@ static inline int resize_screen(struct vc_data *vc, int width, int height,
  * If the caller passes a tty structure then update the termios winsize
  * information and perform any necessary signal handling.
  *
- * Caller must hold the console semaphore. Takes the termios rwsem and
- * ctrl_lock of the tty IFF a tty is passed.
+ * Context: Caller must hold the console semaphore. Takes the termios_rwsem
+ *          and ctrl_lock of the tty IFF a tty is passed.
  */
 
 static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
@@ -3797,10 +3797,10 @@ static void vtconsole_deinit_device(struct con_driver *con)
  * con_is_bound() - checks if driver is bound to the console
  * @csw: console driver
  *
- * RETURNS: zero if unbound, nonzero if bound
- *
  * Drivers can call this and if zero, they should release
  * all resources allocated on con_startup()
+ *
+ * Return: zero if unbound, nonzero if bound.
  */
 int con_is_bound(const struct consw *csw)
 {
@@ -3825,9 +3825,8 @@ EXPORT_SYMBOL(con_is_bound);
  * function needs to save the current console state, then put the console
  * into a state suitable for the kernel debugger.
  *
- * RETURNS:
- * Zero on success, nonzero if a failure occurred when trying to prepare
- * the console for the debugger.
+ * Return: Zero on success, nonzero if a failure occurred when trying to
+ *         prepare the console for the debugger.
  */
 int con_debug_enter(struct vc_data *vc)
 {
@@ -3882,9 +3881,8 @@ EXPORT_SYMBOL_GPL(con_debug_enter);
  * Restore the console state to what it was before the kernel debugger
  * was invoked.
  *
- * RETURNS:
- * Zero on success, nonzero if a failure occurred when trying to restore
- * the console.
+ * Return: Zero on success, nonzero if a failure occurred when trying
+ *         to restore the console.
  */
 int con_debug_leave(void)
 {
@@ -3977,10 +3975,10 @@ static int do_register_con_driver(const struct consw *csw, int first, int last)
  * do_unregister_con_driver() - unregister console driver from console layer
  * @csw: console driver
  *
- * DESCRIPTION: All drivers that registers to the console layer must
- * call this function upon exit, or if the console driver is in a state
- * where it won't be able to handle console services, such as the
- * framebuffer console without loaded framebuffer drivers.
+ * All drivers that registers to the console layer must call this function
+ * upon exit, or if the console driver is in a state where it won't be able
+ * to handle console services, such as the framebuffer console without
+ * loaded framebuffer drivers.
  *
  * The driver must unbind first prior to unregistration.
  */
-- 
2.17.1

