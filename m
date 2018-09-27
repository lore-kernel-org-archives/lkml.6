Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4FBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDCF2150B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDCF2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeI0Qs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:48:29 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59909 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbeI0Qs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:48:27 -0400
X-UUID: 6e25e46227994875a424110e5e14f151-20180927
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 838928504; Thu, 27 Sep 2018 18:30:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Sep
 2018 18:30:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Sep 2018 18:30:46 +0800
Message-ID: <1538044246.17514.51.camel@mhfsdcap03>
Subject: Re: [PATCH v23 4/4] soc: mediatek: Add Mediatek CMDQ helper
From:   houlong wei <houlong.wei@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
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
        CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>,
        "Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?=" 
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
        <enzhu.wang@mediatek.com>, <houlong.wei@mediatek.com>
Date:   Thu, 27 Sep 2018 18:30:46 +0800
In-Reply-To: <3773f620-e135-578d-5307-08483436f4c2@gmail.com>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
         <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
         <ca12e8ab-e3d1-1cf0-8fe9-756d57bd5a3a@gmail.com>
         <1538013431.17514.31.camel@mhfsdcap03>
         <3773f620-e135-578d-5307-08483436f4c2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-27 at 15:50 +0800, Matthias Brugger wrote:
> 
> On 27/09/2018 03:57, houlong wei wrote:
[...]
> >>> +
> >>> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> >>> +				   u32 arg_a, u32 arg_b)
> >>> +{
> >>> +	u64 *cmd_ptr;
> >>> +
> >>> +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> >>> +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
> >>
> >> Why do we update the cmd_buf_size here?
> > 
> > Because in developing phase of consumer driver, the consumer has to know
> > the real command buffer size after adding command failure. Then the
> > consumer will increase the size and run the cmdq flow (cmdq_pkt_create,
> > cmdq_pkt_write/wfe...) again. Finally, the consumer get the real size
> > and fix it.
> > 
> 
> But the consumer should know the size it needs for it's buffer and if not it
> should be able to decide on it's own how much space it needs. If he get's a
> -ENOMEM he implicitly knows that he has to increase the buf_size. Now the size
> depends on how many command he has pending and wasn't able to write to the cmdq_pkt.
> 
> Regards,
> Matthias

The consumer doesn't know how to calculate the command buffer size that
he needs.
When the consumer driver is developing, he could ignore the return value
of cmdq_pkt_write and other command appending functions.
He can print the pkt->cmdq_buf_size after cmdq_pkt_flush() or
cmdq_pkt_flush_async() failure. Now he can get the buffer size he needs.

I copy your another comment here, so I can reply in one mail.
>>If we want to write out a warning to the kernel log, then we should
>>but that in the if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE
>>pkt->buf_size)) from cmdq_pkt_append_command to make it consistent
>>between cmdq_pkt_write, cmdq_pkt_write_mask and cmdq_pkt_finalize.

Thanks, I will move WARN_ON() into cmdq_pkt_append_command() before
returning -ENOMEM.

After your confirmation of the comments above, I will re-send a new
patch.




