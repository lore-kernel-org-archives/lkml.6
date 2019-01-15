Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B46AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90F220645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D4aGkYoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbfAORFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:05:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbfAORFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PiUSEofLeKAKH5ekAwvRkbYzT8UI2LxWuQLcx8FQJO4=; b=D4aGkYoHWiU+bzexICpieEe0U
        J3dfa6tB61Xa5qQeRDodcETMCeHPUbEbQMYY1mavkVSfJ483JONrU+/p8MqgsiSzEUy51z9DOlKMt
        sFiUtFQs+avZqLT2uPpgmx/N0kpWKyqqcHqFLRZWVqNmzI8Q0hDkY5BPHDhsUDfTQQPUFCnD0asVV
        eEnM6OcJtt+VG7Y6J+TSGz9Bcfs+nZc+IZv0W7LVzUDIKXunMAd2o/nkv+Ym547tdENUt8QsxtDIx
        bA9DW8Bejun8twFbQee2Lu+mljw39do/XoVaA5DVVndEsYJoOZb/Q0oUJX6SGRiB8i+NzDzC39Gvw
        En6Fvuthw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjS9G-0002hi-Tn; Tue, 15 Jan 2019 17:05:10 +0000
Date:   Tue, 15 Jan 2019 09:05:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm: Make CONFIG_FRAME_VECTOR a visible option
Message-ID: <20190115170510.GA4274@infradead.org>
References: <20190115164435.8423-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115164435.8423-1-olof@lixom.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 08:44:35AM -0800, Olof Johansson wrote:
> CONFIG_FRAME_VECTOR was made an option to avoid including the bloat on
> platforms that try to keep footprint down, which makes sense.
> 
> The problem with this is external modules that aren't built in-tree.
> Since they don't have in-tree Kconfig, whether they can be loaded now
> depends on whether your kernel config enabled some completely unrelated
> driver that happened to select it. That's a weird and unpredictable
> situation, and makes for some awkward requirements for the standalone
> modules.
> 
> For these reasons, give someone the option to manually enable this when
> configuring the kernel.

NAK, we should not confuse kernel users for stuff that is out of tree.
