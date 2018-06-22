Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C77C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896C522BC3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896C522BC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934035AbeFVAet (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:34:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40488 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933379AbeFVAes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:34:48 -0400
Received: from localhost (unknown [119.205.93.152])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1BDFC12128E18;
        Thu, 21 Jun 2018 17:34:45 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:34:44 +0900 (KST)
Message-Id: <20180622.093444.2175011617959103492.davem@davemloft.net>
To:     imbrenda@linux.vnet.ibm.com
Cc:     stefanha@redhat.com, jhansen@vmware.com, cavery@redhat.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] VSOCK: fix loopback on big-endian systems
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1529502711-8028-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1529502711-8028-1-git-send-email-imbrenda@linux.vnet.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Jun 2018 17:34:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Wed, 20 Jun 2018 15:51:51 +0200

> The dst_cid and src_cid are 64 bits, therefore 64 bit accessors should be
> used, and in fact in virtio_transport_common.c only 64 bit accessors are
> used. Using 32 bit accessors for 64 bit values breaks big endian systems.
> 
> This patch fixes a wrong use of le32_to_cpu in virtio_transport_send_pkt.
> 
> Fixes: b9116823189e85ccf384 ("VSOCK: add loopback to virtio_transport")
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

Applied and queued up for -stable, thank you.
