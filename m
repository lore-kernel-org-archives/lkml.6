Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8AFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B21525DC9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMrryhMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B21525DC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeGBNp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:45:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeGBNpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RBPLWCPZWmnWTMJFM42/nqLJcS0qQPCj9uGOkkEVNBw=; b=rMrryhMqciz3/kxpIYOrqXxmY
        HkgZZ2IidmW+K13HMLN1A51QsjC7fVgzqViRalXn0cgXg0jhLvdPPoKn2HRSwUbF/TCmRc67QNrhm
        1K9JhCG8g5aFV8Ps9+h861k0e5TLGX0J5nwpSI5j/RtbSUuB6UX7VDWkfc9bzNegmHb7ibFclbQYD
        IMvzaLjavGch+Cad8S+8bVkPtWxDQqERLgtqpsryblTK2xyWaTrnrGwr7Ek50ZnkALfmyMGhtEWNH
        cQHFgiI/K3Ff1XUYsBL7vj0pqvS0xLW6DLqh8lRj23nUp+jtSy3XEs52iUWb2+nyLLbq4IpesETzq
        t2cOzqCZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZytH-0004Cl-RU; Mon, 02 Jul 2018 13:29:15 +0000
Date:   Mon, 2 Jul 2018 06:29:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 07/19] csky: MMU and page table management
Message-ID: <20180702132915.GA6578@infradead.org>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <d07f919cb41ebb500c2e6f6defa6ea5760c22dc5.1530465326.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07f919cb41ebb500c2e6f6defa6ea5760c22dc5.1530465326.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is missing an explanation.

For the dma-mapping code please use the generic kernel/dma/noncoherent.c
code instead of duplicating it.
