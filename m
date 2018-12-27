Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7616BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A6218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fCrt/flw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbeL0IHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:07:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbeL0IHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=slO9quz+S2uPeebro6tFtxNIF0siAxfD0oAKEXiXNMc=; b=fCrt/flwy59kcUZvcdPMRRYgw
        FnQUE9JPoDxgd80IlEML9zTcKWDzUc0ESEzt7VWr9OzhH6q4d1d8YBwZ/PZKeFYYC9PVqZ3sRsSgo
        jjnx5gLht0A5WMuo2n8qVeuHsQJD50G+tqw49jr7AG9giTyzfoJVmjR9VudH764hOcO6T2ZNgloyY
        6ALQtubvZBvd97Ux390IkzBij5EXsc9Ar9hNwwty64glxokvFkY4BH6OAYCc90JBL8nUaCr3TctcS
        QSPJJ2W0t4tCf5VNMyNyBycAvnxIiPr4JkspMDq1I6rJ6IWETExTZWbqKT9OO72+QTYI0NZbxUhDR
        srT31SKFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcQhV-0003Bs-Au; Thu, 27 Dec 2018 08:07:29 +0000
Date:   Thu, 27 Dec 2018 00:07:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: add a check for xfs_trans_commit
Message-ID: <20181227080728.GA12171@infradead.org>
References: <20181226060516.75103-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226060516.75103-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 12:05:16AM -0600, Kangjie Lu wrote:
> xfs_trans_commit could fails. The checks issues an error message upon
> its failure.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Please take a close look at what could fail in xfs_trans_commit, and how
those failures are logged inside the implementation.
