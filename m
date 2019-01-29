Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EE0C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E69214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfA2JaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:30:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44474 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725298AbfA2JaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:30:06 -0500
X-UUID: adc0166cf5a74512bb7db5198f21d048-20190129
X-UUID: adc0166cf5a74512bb7db5198f21d048-20190129
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 667881208; Tue, 29 Jan 2019 17:29:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 17:29:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 17:29:50 +0800
Message-ID: <1548754190.11055.7.camel@mtksdaap41>
Subject: Re: [PATCH 04/10] soc: mediatek: clear the event in cmdq initial
 flow
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "YT Shen" <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Date:   Tue, 29 Jan 2019 17:29:50 +0800
In-Reply-To: <1548747128-60136-5-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
         <1548747128-60136-5-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Tue, 2019-01-29 at 15:32 +0800, Bibby Hsieh wrote:
> GCE hardware stored event information in own internal sysram,
> if the initial value in those sysram is not zero value
> it will cause a situation that gce can wait the event immediately
> after client ask gce to wait event but not really trigger the
> corresponding hardware.
> 
> In order to make sure that the wait event function is
> exactly correct, we need to clear the sysram value in
> cmdq initial flow.

If MT8173 has the same problem, add a fix tag.

Regards,
CK

> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c       | 5 +++++
>  include/linux/mailbox/mtk-cmdq-mailbox.h | 2 ++
>  include/linux/soc/mediatek/mtk-cmdq.h    | 3 ---
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index f6174ca..2b5febd 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -33,6 +33,7 @@
>  #define CMDQ_THR_END_ADDR		0x24
>  #define CMDQ_THR_WAIT_TOKEN		0x30
>  #define CMDQ_THR_PRIORITY		0x40
> +#define CMDQ_SYNC_TOKEN_UPDATE		0x68
>  
>  #define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
>  #define CMDQ_THR_ENABLED		0x1
> @@ -103,8 +104,12 @@ static void cmdq_thread_resume(struct cmdq_thread *thread)
>  
>  static void cmdq_init(struct cmdq *cmdq)
>  {
> +	int i;
> +
>  	WARN_ON(clk_enable(cmdq->clock) < 0);
>  	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
> +	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
> +		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
>  	clk_disable(cmdq->clock);
>  }
>  
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index ccb7342..911475da 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -19,6 +19,8 @@
>  #define CMDQ_WFE_UPDATE			BIT(31)
>  #define CMDQ_WFE_WAIT			BIT(15)
>  #define CMDQ_WFE_WAIT_VALUE		0x1
> +/** cmdq event maximum */
> +#define CMDQ_MAX_EVENT			0x3ff
>  
>  /*
>   * CMDQ_CODE_MASK:
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 54ade13..4e88999 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -13,9 +13,6 @@
>  
>  #define CMDQ_NO_TIMEOUT		0xffffffffu
>  
> -/** cmdq event maximum */
> -#define CMDQ_MAX_EVENT				0x3ff
> -
>  struct cmdq_pkt;
>  
>  struct cmdq_client {


