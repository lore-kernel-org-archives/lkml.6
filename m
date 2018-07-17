Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B218ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEAE20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEAE20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeGQIJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:09:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55414 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeGQIJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:09:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 318EA20728; Tue, 17 Jul 2018 09:38:39 +0200 (CEST)
Received: from bootlin.com (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id DB6BC208C4;
        Tue, 17 Jul 2018 09:38:01 +0200 (CEST)
Date:   Tue, 17 Jul 2018 09:38:01 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: mvpp2: mvpp2_flow_get_hek_fields()
 can be static
Message-ID: <20180717093801.6bddd5b5@bootlin.com>
In-Reply-To: <20180717011812.GZ10593@intel.com>
References: <201807141506.hlrwYth1%fengguang.wu@intel.com>
        <20180717011812.GZ10593@intel.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 17 Jul 2018 09:18:12 +0800
kbuild test robot <lkp@intel.com> wrote:

>Fixes: d33ec4525007 ("net: mvpp2: add an RSS classification step for each flow")
>Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
>---
> mvpp2_cls.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
>index 723d0ba..fc9ec51 100644
>--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
>+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
>@@ -618,7 +618,7 @@ static int mvpp2_port_rss_hash_opts_set(struct mvpp2_port *port, int flow_type,
> 	return 0;
> }
> 
>-u16 mvpp2_flow_get_hek_fields(struct mvpp2_cls_flow_entry *fe)
>+static u16 mvpp2_flow_get_hek_fields(struct mvpp2_cls_flow_entry *fe)
> {
> 	u16 hash_opts = 0;
> 	int n_fields, i, field;

That was a valid patch since it seems I forgot to make
another function static in the RSS series.

However this function is used in debugfs, so this patch isn't valid
anymore.

Sorry about that, but please don't apply this.

Thanks,

Maxime

-- 
Maxime Chevallier, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
