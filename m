Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B81C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1174C214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uNXOdNQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1174C214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbeHBN32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:29:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732207AbeHBN31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=As6DSqAO9Sk+K0R3itth7aLPl+xmAVmUZ1oX7MrJn9g=; b=uNXOdNQZapPuVZfZJpQmNQYmE
        OuJL9h+UKqDin7CMhlUbKJbwPJGimumvpTY+8fOowZz3bLO0OE4o8AzrVNw3WrTDav7wEQlaXzCH+
        0YCBH3e2x03dvc95feHqNs3st/7dJkb/nvz/1ndvbiRoL6tP3TzZ36CRNfCYXQB5HImlWVc0U2eif
        T+CUf0+v24a2GLSpHfFbnspDdyvUK43UFGUNef6jOAKzFzd2IFeB5BnFfoBTi4LzGEdXu2DeGflGr
        jQUnoPCOKG2uWMB8m4N98IU/4Xd+xs41rOpbEH+2JUtLdqYsoVnCyEpb0fuNpV+71KHNurF3kNtu2
        oGJ4dMgww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flBwI-0007CI-7S; Thu, 02 Aug 2018 11:38:42 +0000
Date:   Thu, 2 Aug 2018 04:38:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <greentime@andestech.com>
Subject: Re: [PATCH v3 3/4] Cleanup ISA string setting
Message-ID: <20180802113842.GC17108@infradead.org>
References: <1533188391-5932-1-git-send-email-alankao@andestech.com>
 <1533188391-5932-4-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533188391-5932-4-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Aug 02, 2018 at 01:39:50PM +0800, Alan Kao wrote:
> The reason that we cannot follow the review's suggestion in
> https://lkml.org/lkml/2018/6/21/39 is because using "+=" as the
> connector in Makefile introduces blanks bewteen the left-hand
> side alphabets.

That normally goes into the reply to the suggestion, not into the
changelog, so please drop it.

> 
> Note: (Assume that atomic and compressed is on)
> 
> Before this patch, assembler was always given the riscv64imafdc
> MARCH string because there are fld/fsd's in entry.S; compiler was
> always given riscv64imac because kernel doesn't need floating point
> code generation.  After this, the MARCH string in AFLAGS and CFLAGS
> become the same.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
