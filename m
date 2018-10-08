Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208F5C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A4620882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A4620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJHJif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:38:35 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:51979 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725760AbeJHJif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:38:35 -0400
X-UUID: 763574578d224a5fb2f1997172f0b3f9-20181008
X-UUID: 763574578d224a5fb2f1997172f0b3f9-20181008
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1584730236; Mon, 08 Oct 2018 10:29:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 8 Oct
 2018 10:29:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Oct 2018 10:29:06 +0800
Message-ID: <1538965746.4271.20.camel@mhfsdcap03>
Subject: Re: [PATCH v25 2/2] soc: mediatek: Add Mediatek CMDQ helper
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
Date:   Mon, 8 Oct 2018 10:29:06 +0800
In-Reply-To: <7040427b-f580-ec33-8afa-35dcf5735abb@gmail.com>
References: <1538212903-14331-1-git-send-email-houlong.wei@mediatek.com>
         <1538212903-14331-3-git-send-email-houlong.wei@mediatek.com>
         <7040427b-f580-ec33-8afa-35dcf5735abb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-09-29 at 20:50 +0800, Matthias Brugger wrote:
> 
> On 29/09/2018 11:21, Houlong Wei wrote:
> [...]
> 
> > +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> > +				   u32 arg_a, u32 arg_b)
> > +{
> > +	u64 *cmd_ptr;
> > +
> > +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> > +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
> 
> Can you plesae provide some example code of a driver that will use this API, I
> still don't understand why you need to update the cmd_buf_size here.

In our previous design, when appending a new command to buffer and the
buffer gets overflow, we will re-allocate a larger buffer to use.
CK.Hu had concern about the performance of buffer re-allocation. Please
refer:
http://lists.infradead.org/pipermail/linux-mediatek/2018-June/013797.html
One of his suggestions is that the consumer dynamically allocates buffer
with a initial size. Because the consumer doesn't know how to calculate
the buffer size. So we increase cmdq_buf_size here, that will help the
consumer get the buffer size in developing phase. In release driver
code, consumer passes a constant value to function call
cmdq_pkt_create(client, cmdq_buffer_size), cmdq_buffer_size is the
specified command queue buffer size.

> 
> > +		WARN_ON(1);
> 
> can we add some debug information:
> WARN_ON(1, "%s: buffer size too small for the amount of commands", __func__);
> 
> Would it make sense to use WARN_ONCE()?
> 
Yes, I will add debug information and use WARN_ONCE().

> > +		return -ENOMEM;
> > +	}
> > +	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> > +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> > +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> > +
> > +	return 0;
> > +}
> 
> Thanks,
> Matthias


