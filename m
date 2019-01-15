Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10BAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671DB20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lh8ktPr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfAON6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:58:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfAON6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uDKXgjscMjxoCfhA1dyJMUTOnVjtaXxTIVf4pXUW+W8=; b=Lh8ktPr04a+insU4wEueL0Xn+
        3/CNkIoXmhCATb0yrYIi6kNUQQi4jAWfF8T1978II/J2sXMbew8JOicGMDzeA2lsyrttxp4jhfadn
        TiOP3C5Cx+hK6T0ChUXR4M6ghIAOMJc7kPEVrpVxjy8W46noWVFr3zqR1dEeIFib0ScklcPTVLdc5
        p57pNaqxEFdjKjKBM/vVPqsequHFOJl+z3uugfqPRkgblM1lI2wAs7vP+FDDgMyf9LfyMNJhOXvVW
        383DDC6H6cjDM1iWTmQQ3r3GmPIjXmKUtFZ6eCFNmLF+JWdLit9+hQZ/Rd1OPLoj59T0JBztMq7TX
        eO+TfUSDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjPER-0005Sn-Ti; Tue, 15 Jan 2019 13:58:19 +0000
Date:   Tue, 15 Jan 2019 05:58:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/2] sh: mm: make use of new memblocks_present() helper
Message-ID: <20190115135819.GK28946@infradead.org>
References: <20190109203911.7887-1-logang@deltatee.com>
 <20190109203911.7887-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109203911.7887-2-logang@deltatee.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:39:10PM -0700, Logan Gunthorpe wrote:
> Cleanup the open coded for_each_memblock() loop that is equivalent
> to the new memblocks_present() helper.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Probably no need to keep this in a series with the RISC-V code, this can
be queued up by the sh folks independently.
