Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779B8C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244C026FDC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244C026FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933710AbeF1Gzx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:55:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49727 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933470AbeF1Gzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:55:51 -0400
X-UUID: 1289ec5497f94bb7995c3f0fc43331c2-20180628
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 6793205; Thu, 28 Jun 2018 14:55:43 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n2.mediatek.inc
 (172.21.101.79) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 28 Jun
 2018 14:55:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 14:55:37 +0800
Message-ID: <1530168937.21275.4.camel@mhfsdcap03>
Subject: Re: [PATCH v21 2/4] mailbox: mediatek: Add Mediatek CMDQ driver
From:   houlong wei <houlong.wei@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>
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
        Cawa Cheng =?UTF-8?Q?=28=E9=84=AD=E6=9B=84=E7=A6=A7=29?= 
        <cawa.cheng@mediatek.com>,
        Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?= 
        <Bibby.Hsieh@mediatek.com>,
        YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= 
        <Yt.Shen@mediatek.com>,
        Daoyuan Huang =?UTF-8?Q?=28=E9=BB=83=E9=81=93=E5=8E=9F=29?= 
        <Daoyuan.Huang@mediatek.com>,
        Damon Chu =?UTF-8?Q?=28=E6=9C=B1=E5=B3=BB=E8=B3=A2=29?= 
        <Damon.Chu@mediatek.com>,
        Josh-YC Liu =?UTF-8?Q?=28=E5=8A=89=E8=82=B2=E8=AA=A0=29?= 
        <Josh-YC.Liu@mediatek.com>,
        Glory Hung =?UTF-8?Q?=28=E6=B4=AA=E6=99=BA=E7=91=8B=29?= 
        <glory.hung@mediatek.com>,
        Jiaguang Zhang =?UTF-8?Q?=28=E5=BC=A0=E5=8A=A0=E5=B9=BF=29?= 
        <Jiaguang.Zhang@mediatek.com>,
        Dennis-YC Hsieh =?UTF-8?Q?=28=E8=AC=9D=E5=AE=87=E5=93=B2=29?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        Monica Wang =?UTF-8?Q?=28=E7=8E=8B=E5=AD=9F=E5=A9=B7=29?= 
        <monica.wang@mediatek.com>,
        Hs Liao =?UTF-8?Q?=28=E5=BB=96=E5=AE=8F=E7=A5=A5=29?= 
        <Hs.Liao@mediatek.com>
Date:   Thu, 28 Jun 2018 14:55:37 +0800
In-Reply-To: <1530151059.6193.27.camel@mtksdaap41>
References: <1517383693-25591-1-git-send-email-houlong.wei@mediatek.com>
         <1517383693-25591-3-git-send-email-houlong.wei@mediatek.com>
         <1519185212.8716.32.camel@mtksdaap41>
         <1530100416.31725.15.camel@mhfsdcap03>
         <1530151059.6193.27.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 09:57 +0800, CK Hu wrote:
> Hi, Houlong:
> 
> On Wed, 2018-06-27 at 19:53 +0800, houlong wei wrote:
> > On Wed, 2018-02-21 at 11:53 +0800, CK Hu wrote:
> > > Hi, Houlong:
> > > 
> > > I've one inline comment.
> > > 
> > > On Wed, 2018-01-31 at 15:28 +0800, houlong.wei@mediatek.com wrote:
> > > > From: "hs.liao@mediatek.com" <hs.liao@mediatek.com>
> > > > 
> > > > This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> > > > CMDQ is used to help write registers with critical time limitation,
> > > > such as updating display configuration during the vblank. It controls
> > > > Global Command Engine (GCE) hardware to achieve this requirement.
> > > > Currently, CMDQ only supports display related hardwares, but we expect
> > > > it can be extended to other hardwares for future requirements.
> > > > 
> > > > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > > ---
> > > >  drivers/mailbox/Kconfig                  |   10 +
> > > >  drivers/mailbox/Makefile                 |    2 +
> > > >  drivers/mailbox/mtk-cmdq-mailbox.c       |  594 ++++++++++++++++++++++++++++++
> > > >  include/linux/mailbox/mtk-cmdq-mailbox.h |   77 ++++
> > > >  4 files changed, 683 insertions(+)
> > > >  create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
> > > >  create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
> > > > 
> > > > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > > > index ba2f152..43bb26f 100644
> > > > --- a/drivers/mailbox/Kconfig
> > > > +++ b/drivers/mailbox/Kconfig
> > > > @@ -171,4 +171,14 @@ config BCM_FLEXRM_MBOX
> > > >  	  Mailbox implementation of the Broadcom FlexRM ring manager,
> > > >  	  which provides access to various offload engines on Broadcom
> > > >  	  SoCs. Say Y here if you want to use the Broadcom FlexRM.
> > > > +
> 
> [...]
> 
> > > > +
> > > > +static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
> > > > +{
> > > > +	struct cmdq *cmdq;
> > > > +	struct cmdq_task *task;
> > > > +	unsigned long curr_pa, end_pa;
> > > > +
> > > > +	cmdq = dev_get_drvdata(thread->chan->mbox->dev);
> > > > +
> > > > +	/* Client should not flush new tasks if suspended. */
> > > > +	WARN_ON(cmdq->suspended);
> > > > +
> > > > +	task = kzalloc(sizeof(*task), GFP_ATOMIC);
> > > > +	task->cmdq = cmdq;
> > > > +	INIT_LIST_HEAD(&task->list_entry);
> > > > +	task->pa_base = pkt->pa_base;
> > > > +	task->thread = thread;
> > > > +	task->pkt = pkt;
> > > > +
> > > > +	if (list_empty(&thread->task_busy_list)) {
> > > > +		WARN_ON(clk_enable(cmdq->clock) < 0);
> > > > +		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
> > > > +
> > > > +		writel(task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
> > > > +		writel(task->pa_base + pkt->cmd_buf_size,
> > > > +		       thread->base + CMDQ_THR_END_ADDR);
> > > > +		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
> > > > +		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
> > > > +
> > > > +		mod_timer(&thread->timeout,
> > > > +			  jiffies + msecs_to_jiffies(CMDQ_TIMEOUT_MS));
> > > > +	} else {
> > > > +		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> > > > +		curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR);
> > > > +		end_pa = readl(thread->base + CMDQ_THR_END_ADDR);
> > > > +
> > > > +		/*
> > > > +		 * Atomic execution should remove the following wfe, i.e. only
> > > > +		 * wait event at first task, and prevent to pause when running.
> > > > +		 */
> > > > +		if (thread->atomic_exec) {
> > > > +			/* GCE is executing if command is not WFE */
> > > > +			if (!cmdq_thread_is_in_wfe(thread)) {
> > > > +				cmdq_thread_resume(thread);
> > > > +				cmdq_thread_wait_end(thread, end_pa);
> > > > +				WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> > > > +				/* set to this task directly */
> > > > +				writel(task->pa_base,
> > > > +				       thread->base + CMDQ_THR_CURR_ADDR);
> > > > +			} else {
> > > > +				cmdq_task_insert_into_thread(task);
> > > > +				cmdq_task_remove_wfe(task);
> > > > +				smp_mb(); /* modify jump before enable thread */
> > > > +			}
> > > > +		} else {
> > > > +			/* check boundary */
> > > > +			if (curr_pa == end_pa - CMDQ_INST_SIZE ||
> > > > +			    curr_pa == end_pa) {
> > > > +				/* set to this task directly */
> > > > +				writel(task->pa_base,
> > > > +				       thread->base + CMDQ_THR_CURR_ADDR);
> > > > +			} else {
> > > > +				cmdq_task_insert_into_thread(task);
> > > > +				smp_mb(); /* modify jump before enable thread */
> > > > +			}
> > > > +		}
> > > > +		writel(task->pa_base + pkt->cmd_buf_size,
> > > > +		       thread->base + CMDQ_THR_END_ADDR);
> > > > +		cmdq_thread_resume(thread);
> > > > +	}
> > > > +	list_move_tail(&task->list_entry, &thread->task_busy_list);
> > > 
> > > You implement a list to queue command because you need to execute
> > > multiple packet in the same vblank period. I've a suggestion that you
> > > need not to implement a list. Once cmdq driver receive two packet as
> > > below:
> > > 
> > > Packet 1:
> > > (1) clear vblank event
> > > (2) wait vblank event
> > > (3) write register setting 1
> > > (4) no operation
> > > 
> > > Packet 2:
> > > (1) clear vblank event
> > > (2) wait vblank event
> > > (3) write register setting 2
> > > (4) no operation
> > > 
> > > In your current design, you modify these two packet as:
> > > 
> > > Packet 1:
> > > (1) clear vblank event
> > > (2) wait vblank event
> > > (3) write register setting 1
> > > (4) Jump to packet 2 (modified)
> > > 
> > > Packet 2:
> > > (1) no operation (modified)
> > > (2) no operation (modified)
> > > (3) write register setting 2
> > > (4) no operation
> > > 
> > > So the register setting 1 and register setting 2 could be executed in
> > > the same vblank period.
> > > 
> > > My suggestion is: when the client want to send packet 2, it 'abort'
> > > packet 1 at first. The 'abort' means remove it from channel. In current
> > > mailbox interface, mbox_free_channel() is most like abort function, but
> > > my abort would keep the channel. So maybe you need to implement a new
> > > mailbox interface which could remove packet in the channel. So the step
> > > would be:
> > > 
> > > (1) Client generate packet 1 which include write register setting 1
> > > (2) Client send packet 1 to channel A
> > > 
> > > When client want to send register setting 2,
> > > 
> > > (3) Client abort channel A
> > > (4) Client generate packet 2 which include write register setting 1 & 2
> > > (5) Client send packet 2 to channel A
> > > 
> > > Once you have the abort function, you could use the queue mechanism in
> > > mailbox core instead of implementing your own.
> > > 
> > > For the client which have the atomic requirement, it also need not to
> > > implement a list to keep what command have not executed. So the abort
> > > interface would make client and controller much simpler.
> > > 
> > > Regards,
> > > CK
> > > 
> > 
> > Hi CK, thanks for you suggestion. Since current mailbox framework has
> > no 'abort' function and need add new interface. It may be complicated
> > to do this. Could we keep current solution?
> > 
> 
> I imagine that 'abort' is a simple function. Is my imagination
> incorrect? So you would like choose implementing a complicated queue
> mechanism in mtk_cmdq driver rather than implementing abort function.
> Maybe both are complicated.
> 
> I think the more important thing is that do you and maintainer agree to
> implement abort function which could reduce mtk-self-queue in mtk_cmdq
> driver. If the answer is yes, there could be two patch sequence A and B,


Hello Jassi, what's your opinion on 'abort' function ?


> the patch sequence A is
> 
> A.1 mtk_cmdq driver with mtk-self-queue.
> A.2 mtk display driver use mtk_cmdq without abort function.
> A.3 add mailbox abort function
> A.4 mtk_cmdq driver support abort function and remove mtk-self-queue.
> A.5 mtk display driver use mtk_cmdq with abort function
> 
> And the patch sequence B is
> 
> B.1 add mailbox abort function
> B.2 mtk_cmdq driver with abort function and no mtk-self-queue
> B.3 mtk display driver use mtk_cmdq with abort function
> 
> Which one do you think is complicated?
> 
> So let's back to the more important thing: 'do you agree to implement
> abort function which could reduce mtk-self-queue in mtk_cmdq driver?'
> 
> Regards,
> CK
> 
> > > > +}
> > > > +
> 
> [...]
> 
> > 
> 
> 


