Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB8EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427E82081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cenVLebd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427E82081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeKJSQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:16:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeKJSQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wlCZ+b1ljFhJ2+uL9tO+zuVq6Ia9kFGbq98AjIrLC/A=; b=cenVLebdmUUm6SXGovt2Fk594
        +7/rBDEog17WEB+s++ImqW6lVSBhHBxscpDDqvvsduvMClI5R27fFp3d93/V5nxn6F6fbJjb+e4A5
        AIVfu6NdQMjTXVqVcyM1WrlE3Cc69IdseI0M97dsoiUWJwKDlazp2y727y0cmt0p7aHS+vkOktlsu
        eoTx6jTfDfq1pyNsr3TMtPYvNcq4tfkim0WV7Y3+f8vuDRKopCmlw4r0Y3uPdWAb4WK9Qk8EgWLKQ
        6aR4YLcXBFbf8B3u/6c1pswq83Vus7lL8zVH1rz71/DCORydsQ34PkkKzFHWh27eeGWB9ymrYNS/p
        lFiUAsd3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLOgX-0007TT-3L; Sat, 10 Nov 2018 08:32:05 +0000
Date:   Sat, 10 Nov 2018 00:32:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] sysv: return 'err' instead of 0 in
 __sysv_write_inode
Message-ID: <20181110083204.GA28614@infradead.org>
References: <1541823204-45068-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541823204-45068-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Al, can you queue it up?
