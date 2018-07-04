Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86430C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34727208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34727208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934326AbeGDJDU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:03:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10918 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932439AbeGDJDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:03:17 -0400
X-UUID: 008cd18ec6df4a93854329560b469bae-20180704
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1886670273; Wed, 04 Jul 2018 17:03:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 4 Jul 2018 17:03:11 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 4 Jul 2018 17:03:10 +0800
Message-ID: <1530694990.24031.15.camel@mtksdaap41>
Subject: Re: [PATCH v22 2/4] mailbox: mediatek: Add Mediatek CMDQ driver
From:   CK Hu <ck.hu@mediatek.com>
To:     houlong wei <houlong.wei@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?= 
        <Bibby.Hsieh@mediatek.com>,
        YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= 
        <Yt.Shen@mediatek.com>,
        Daoyuan Huang =?UTF-8?Q?=28=E9=BB=83=E9=81=93=E5=8E=9F=29?= 
        <Daoyuan.Huang@mediatek.com>,
        Jiaguang Zhang =?UTF-8?Q?=28=E5=BC=A0=E5=8A=A0=E5=B9=BF=29?= 
        <Jiaguang.Zhang@mediatek.com>,
        Dennis-YC Hsieh =?UTF-8?Q?=28=E8=AC=9D=E5=AE=87=E5=93=B2=29?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        Monica Wang =?UTF-8?Q?=28=E7=8E=8B=E5=AD=9F=E5=A9=B7=29?= 
        <monica.wang@mediatek.com>,
        Hs Liao =?UTF-8?Q?=28=E5=BB=96=E5=AE=8F=E7=A5=A5=29?= 
        <Hs.Liao@mediatek.com>,
        Ginny Chen =?UTF-8?Q?=28=E9=99=B3=E6=B2=BB=E5=82=91=29?= 
        <ginny.chen@mediatek.com>,
        Enzhu Wang =?UTF-8?Q?=28=E7=8E=8B=E6=81=A9=E6=9F=B1=29?= 
        <enzhu.wang@mediatek.com>
Date:   Wed, 4 Jul 2018 17:03:10 +0800
In-Reply-To: <1530663042.21991.64.camel@mhfsdcap03>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
         <1530098172-31385-3-git-send-email-houlong.wei@mediatek.com>
         <1530256083.8518.36.camel@mtksdaap41>
         <1530663042.21991.64.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Houlong:

On Wed, 2018-07-04 at 08:10 +0800, houlong wei wrote:
> On Fri, 2018-06-29 at 15:08 +0800, CK Hu wrote:
> > Hi, Houlong:
> > 
> > Some inline comment.
> > 
> > On Wed, 2018-06-27 at 19:16 +0800, Houlong Wei wrote:
> > > This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> > > CMDQ is used to help write registers with critical time limitation,
> > > such as updating display configuration during the vblank. It controls
> > > Global Command Engine (GCE) hardware to achieve this requirement.
> > > Currently, CMDQ only supports display related hardwares, but we expect
> > > it can be extended to other hardwares for future requirements.
> > > 
> > > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > ---
> > >  drivers/mailbox/Kconfig                  |   10 +
> > >  drivers/mailbox/Makefile                 |    2 +
> > >  drivers/mailbox/mtk-cmdq-mailbox.c       |  634 ++++++++++++++++++++++++++++++
> > >  include/linux/mailbox/mtk-cmdq-mailbox.h |   70 ++++
> > >  4 files changed, 716 insertions(+)
> > >  create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
> > >  create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
> > > 
> > 
> > [...]
> > 
> > > +
> > > +static int cmdq_thread_reset(struct cmdq *cmdq, struct cmdq_thread *thread)
> > > +{
> > > +	u32 warm_reset;
> > > +
> > > +	writel(CMDQ_THR_DO_WARM_RESET, thread->base + CMDQ_THR_WARM_RESET);
> > > +	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_WARM_RESET,
> > > +			warm_reset, !(warm_reset & CMDQ_THR_DO_WARM_RESET),
> > > +			0, 10)) {
> > > +		dev_err(cmdq->mbox.dev, "reset GCE thread 0x%x failed\n",
> > > +			(u32)(thread->base - cmdq->base));
> > > +		return -EFAULT;
> > > +	}
> > > +	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
> > 
> > The CMDQ_THR_SLOT_CYCLES looks like not relevant to reset. Maybe you
> > just need to set this value when startup.
> 
> Will move configuration of CMDQ_THR_SLOT_CYCLES to cmdq_xlate() where is
> startup of a GCE thread.
> 
> > 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > 
> > [...]
> > 
> > > +
> > > +static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
> > > +{
> > > +	struct cmdq *cmdq;
> > > +	struct cmdq_task *task;
> > > +	unsigned long curr_pa, end_pa;
> > > +
> > > +	cmdq = dev_get_drvdata(thread->chan->mbox->dev);
> > > +
> > > +	/* Client should not flush new tasks if suspended. */
> > > +	WARN_ON(cmdq->suspended);
> > > +
> > > +	task = kzalloc(sizeof(*task), GFP_ATOMIC);
> > > +	task->cmdq = cmdq;
> > > +	INIT_LIST_HEAD(&task->list_entry);
> > > +	task->pa_base = pkt->pa_base;
> > > +	task->thread = thread;
> > > +	task->pkt = pkt;
> > > +
> > > +	if (list_empty(&thread->task_busy_list)) {
> > > +		WARN_ON(clk_enable(cmdq->clock) < 0);
> > > +		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
> > > +
> > > +		writel(task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
> > > +		writel(task->pa_base + pkt->cmd_buf_size,
> > > +		       thread->base + CMDQ_THR_END_ADDR);
> > > +		writel(thread->priority, thread->base + CMDQ_THR_PRIORITY);
> > > +		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
> > > +		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
> > > +
> > > +		if (thread->timeout_ms != CMDQ_NO_TIMEOUT)
> > > +			mod_timer(&thread->timeout,
> > > +				jiffies + msecs_to_jiffies(thread->timeout_ms));
> > 
> > I think the timeout processing should be done by client driver. The
> > total time to execute a command buffer does not depend on GCE HW speed
> > because the WFE (wait for event) command would wait for client HW event,
> > so the total time depend on how long a client HW send this event to GCE
> > and the timeout processing should be client driver's job. Each client
> > may have different timeout processing mechanism, for example, if display
> > could dynamic change panel frame rate between 120Hz and 60Hz, and the
> > timeout time is 2 frame, so it may dynamically change timeout time
> > between 17ms and 33ms. Another reason is that display have interrupt
> > every vblank, and it could check timeout in that interrupt, so the timer
> > in cmdq driver looks redundant. Because each client would define its own
> > timeout processing mechanism, so it's not wise to put timeout processing
> > in cmdq driver.
> 
> The client drivers' owners strongly hope to keep the current timeout
> mechanism, the reasons are below.
> 1. If remove, all clients should add timeout mechanism and the code will
> be redundant.
> 2. If timeout happens, only GCE driver can do reset and continue to
> execute next packet.

For the reason 2, GCE should not continue execute next packet because
the packets may have dependency. So GCE driver could only drop all
packet (this is what you do in cmdq_thread_handle_timeout()). For reason
1, you have a assumption that all client have the same request for
timeout: constant timeout value or no timeout. If it's so, that's ok to
put timeout mechanism in cmdq driver. But if one day, a new request for
timeout, for example, dynamic timeout value, that means not all client
driver implement timeout in the same way, putting timeout mechanism in
cmdq driver does not reduce any thing but just move multiple client
driver's code into cmdq driver. I would accept to put here only if all
client driver use the same timeout mechanism.

Regards,
CK

> 
> > 
> > > +	} else {
> > > +		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> > > +		curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR);
> > > +		end_pa = readl(thread->base + CMDQ_THR_END_ADDR);
> > > +
> > > +		/*
> > > +		 * Atomic execution should remove the following wfe, i.e. only
> > > +		 * wait event at first task, and prevent to pause when running.
> > > +		 */
> > > +		if (thread->atomic_exec) {
> > > +			/* GCE is executing if command is not WFE */
> > > +			if (!cmdq_thread_is_in_wfe(thread)) {
> > > +				cmdq_thread_resume(thread);
> > > +				cmdq_thread_wait_end(thread, end_pa);
> > > +				WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> > > +				/* set to this task directly */
> > > +				writel(task->pa_base,
> > > +				       thread->base + CMDQ_THR_CURR_ADDR);
> > > +			} else {
> > > +				cmdq_task_insert_into_thread(task);
> > > +				cmdq_task_remove_wfe(task);
> > > +				smp_mb(); /* modify jump before enable thread */
> > > +			}
> > > +		} else {
> > > +			/* check boundary */
> > > +			if (curr_pa == end_pa - CMDQ_INST_SIZE ||
> > > +			    curr_pa == end_pa) {
> > > +				/* set to this task directly */
> > > +				writel(task->pa_base,
> > > +				       thread->base + CMDQ_THR_CURR_ADDR);
> > > +			} else {
> > > +				cmdq_task_insert_into_thread(task);
> > > +				smp_mb(); /* modify jump before enable thread */
> > > +			}
> > > +		}
> > > +		writel(task->pa_base + pkt->cmd_buf_size,
> > > +		       thread->base + CMDQ_THR_END_ADDR);
> > > +		cmdq_thread_resume(thread);
> > > +	}
> > > +	list_move_tail(&task->list_entry, &thread->task_busy_list);
> > > +}
> > > +
> > > +static void cmdq_task_exec_done(struct cmdq_task *task, bool err)
> > > +{
> > > +	struct device *dev = task->cmdq->mbox.dev;
> > > +	struct cmdq_cb_data cmdq_cb_data;
> > > +
> > > +	dma_unmap_single(dev, task->pa_base, task->pkt->cmd_buf_size,
> > > +			 DMA_TO_DEVICE);
> > 
> > Move this to client driver.
> 
> map/unmap are common code for clients driver, could we move it to cmdq
> helper?
> 
> > 
> > > +	if (task->pkt->cb.cb) {
> > > +		cmdq_cb_data.err = err;
> > > +		cmdq_cb_data.data = task->pkt->cb.data;
> > > +		task->pkt->cb.cb(cmdq_cb_data);
> > > +	}
> > > +	list_del(&task->list_entry);
> > > +}
> > > +
> > 
> > [...]
> > 
> > > +
> > > +static bool cmdq_mbox_last_tx_done(struct mbox_chan *chan)
> > > +{
> > > +	return true;
> > > +}
> > > +
> > > +static const struct mbox_chan_ops cmdq_mbox_chan_ops = {
> > > +	.send_data = cmdq_mbox_send_data,
> > > +	.startup = cmdq_mbox_startup,
> > > +	.shutdown = cmdq_mbox_shutdown,
> > > +	.last_tx_done = cmdq_mbox_last_tx_done,
> > 
> > Because mbox->txdone_poll is false, so you need not to implement
> > last_tx_done.
> > 
> > Regards,
> > CK
> 
> Will remove cmdq_mbox_last_tx_done().
> 
> > 
> > > +};
> > > +
> > > +static struct mbox_chan *cmdq_xlate(struct mbox_controller *mbox,
> > > +		const struct of_phandle_args *sp)
> > > +{
> > > +	int ind = sp->args[0];
> > > +	struct cmdq_thread *thread;
> > > +
> > > +	if (ind >= mbox->num_chans)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	thread = mbox->chans[ind].con_priv;
> > > +	thread->timeout_ms = sp->args[1];
> > > +	thread->priority = sp->args[2];
> > > +	thread->atomic_exec = (sp->args[3] != 0);
> > > +	thread->chan = &mbox->chans[ind];
> > > +
> > > +	return &mbox->chans[ind];
> > > +}
> > > +
> > [...]
> > 
> > 
> 
> 


