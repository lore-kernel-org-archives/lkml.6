Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DCB2083C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DCB2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeGNLje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 07:39:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51812 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeGNLjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 07:39:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B9AC2207AB; Sat, 14 Jul 2018 13:20:47 +0200 (CEST)
Received: from bootlin.com (ABordeaux-654-1-198-104.w90-55.abo.wanadoo.fr [90.55.201.104])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6791B203EC;
        Sat, 14 Jul 2018 13:20:47 +0200 (CEST)
Date:   Sat, 14 Jul 2018 13:20:47 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 4/5] net: mvpp2: debugfs: add entries for
 classifier flows
Message-ID: <20180714132047.43a03fab@bootlin.com>
In-Reply-To: <20180713161344.19872-5-maxime.chevallier@bootlin.com>
References: <20180713161344.19872-1-maxime.chevallier@bootlin.com>
        <20180713161344.19872-5-maxime.chevallier@bootlin.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 18:13:43 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:


>+static int mvpp2_dbgfs_flow_id_show(struct seq_file *s, void *unused)
>+{
>+	struct mvpp2_dbgfs_flow_entry *entry = s->private;
>+	struct mvpp2_cls_flow *f;
>+
>+	f = mvpp2_cls_flow_get(entry->flow);

This won't compile with commit
9cee8c437543 ("net: mvpp2: mvpp2_cls_flow_get() can be static")

I should have seen that missing static in the RSS series, now that
it's fixed I'll send a V2 of that debugfs series, to make that function
non static for the right reason this time.

Thanks,

Maxime
