Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F44C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618332082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ehl6k560"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618332082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbeH3Snv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:43:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbeH3Snv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oBjh73xdK+1xKBhBT/0qQW89epLyeb2+PbngDQMd5vo=; b=ehl6k560IhZqZJgQ2O+UegwBV
        i4ACbCmES7wqFaZsDO2pwVJjjGrZzHWLTh3/aldKEUoLHHYUYP0E2RK1NYjKnYprgX5HZskkMr2eU
        1b7OaqQ3LtSfVpGYc4gxObV11yc45n2rm2EbmwHBuXykcFJB/Ps8x2sed3luRtOLuVhZKUzVMneGO
        evbnOz5sm2u0doeLVm7K2Zec9P1dykB+UCKzmNaJhwcsHvPmB2zM7KmW+HZnpB1XhJC5ovuZn3081
        wbwzGCCyc9nqVRfe5f8nwCG4ZNESJbCpo/El/DII+HsWbj1Q24rVeK6JJk9Y6OM2LN764r9lMbKLl
        mqjC6WkAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvO8M-0007Mb-TM; Thu, 30 Aug 2018 14:41:18 +0000
Date:   Thu, 30 Aug 2018 07:41:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        dmitriy@oss-tech.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, Greg KH <gregkh@linuxfoundation.org>,
        tglx@linutronix.de
Subject: Re: [PATCH 5/8] RISC-V: Rename im_okay_therefore_i_am to
 found_boot_cpu
Message-ID: <20180830144118.GA27233@infradead.org>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-6-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827184243.25344-6-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	struct device_node *dn = NULL;
> -	int hart, im_okay_therefore_i_am = 0;
> +	int hart, found_boot_cpu = 0;

If you rename this anyway please switch to use a bool.
