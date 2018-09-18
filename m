Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592CDC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DE821471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ToIvolc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DE821471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbeISDNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:13:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeISDNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DT3wOG3prE7zQb9z8i8/h87pN19VlPRMs+N0iXOUrIw=; b=ToIvolc/rS8M0q/UVAmvFG+6D
        gNT+VwSU7O7YJ1iW7qjne1t9jPhAUFcRpHhshL4dg+vT35NWmnBz9TVi1Dy5slauEeSRWok//7UXq
        8NG6m2fZHtfz1Z/iPp0783feU3cElCjhVWbvFY3tsm+nxK5z4inE0rSBnJvJuU6GVE8PxLA9jnDI2
        YaOrol3m7dIEcIpnuqmO0ixG+Ppj1ulM9TongAiedvz4bRsqOVFD1rmW7mwYlCc5RypAoPRh2oLj1
        GKP85gW76Bi+6dYWmwmrFRPaOz1Crv1+Gaus3Re1C9CE9baa0UhhMgOtule8FHDL6YZ0t/KXQTaod
        GoNqgYGSw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2Nhb-0000UB-Rb; Tue, 18 Sep 2018 21:38:35 +0000
Date:   Tue, 18 Sep 2018 14:38:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     adobriyan@gmail.com, ganeshgr@chelsio.com,
        rahul.lakkireddy@chelsio.com, davem@davemloft.net,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc/vmcore.c: Convert to use vmf_error()
Message-ID: <20180918213835.GA1203@bombadil.infradead.org>
References: <20180918145945.GA11392@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918145945.GA11392@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 08:29:46PM +0530, Souptick Joarder wrote:
> This code can be replaced with vmf_error() inline function.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
