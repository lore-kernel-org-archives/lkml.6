Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B307C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E82A21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E82A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeJRM6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:58:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54582 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeJRM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:58:37 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8977B13AE1A86;
        Wed, 17 Oct 2018 21:59:30 -0700 (PDT)
Date:   Wed, 17 Oct 2018 21:59:30 -0700 (PDT)
Message-Id: <20181017.215930.2300105767161105738.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        zhaochen6@huawei.com, tony.qu@huawei.com, yin.yinshi@huawei.com,
        luoshaokai@huawei.com, fy.wang@huawei.com, luoxianjun@huawei.com
Subject: Re: [PATCH 1/1] net-next/hinic: add checksum offload and TSO
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181016111234.20492-1-xuechaojing@huawei.com>
References: <20181016111234.20492-1-xuechaojing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Oct 2018 21:59:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Tue, 16 Oct 2018 11:12:34 +0000

> +static void get_inner_l4_info(struct sk_buff *skb, union hinic_l4 *l4,
> +			      enum hinic_offload_type offload_type, u8 l4_proto,
> +			      enum hinic_l4_offload_type *l4_offload,
> +			      u32 *l4_len, u32 *offset)
> +{
> +	*offset = 0;
> +	*l4_len = 0;
> +	*l4_offload = OFFLOAD_DISABLE;

Please order local variables from longest to shortest line.

> +static int offload_csum(struct hinic_sq_task *task, u32 *queue_info,
> +			struct sk_buff *skb)
> +{
> +	union hinic_l3 ip;
> +	union hinic_l4 l4;
> +	enum hinic_l3_offload_type l3_type;
> +	enum hinic_l4_offload_type l4_offload;
> +	u32 offset, l4_len, network_hdr_len;
> +	u8 l4_proto;

Likewise.

> @@ -184,9 +458,9 @@ netdev_tx_t hinic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
>  	unsigned int wqe_size;
>  	struct hinic_txq *txq;
>  	struct hinic_qp *qp;
> -	u16 prod_idx;
> +	u16 prod_idx, q_id = skb->queue_mapping;

Likewise.
