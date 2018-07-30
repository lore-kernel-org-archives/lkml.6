Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3243B16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA46020881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/FYh55w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA46020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeG3SKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:10:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbeG3SKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Os0b2N9hRHycYOwMSb/TRHUR2HY9sOWC+U+ltxkAiog=; b=U/FYh55wHhk4U0AJfaMhUzqPf
        BkDdcvW+xMAX45zC2mCopBJ0jtRhfHSC1OGhtkpXTemLU2ggUEwjNWDn9iU54LVHWES252u4kFVvm
        ZxQwq7PcLcVTv6LD5xMMzEKmJWlR04A9HDsA8lXV7xZIJPgys4FdbEB9NlOAwRFoL3wWxHDeRA+42
        EoWoArBGYnQNW1nYVnh4w/X+Uy/578/Tz5el3gDy4CVzxp5BdiILeFniNpHi/mRglJZMkGm06NIWx
        M8I8SaXbyShanescHZvzs3TcG8+5aBg17SJKGSuHoFnZV/PDGFTtp3HCbykjtM81WDQdu8HaTwz1S
        lDoWwjHXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkB8G-0005rB-Iy; Mon, 30 Jul 2018 16:34:52 +0000
Date:   Mon, 30 Jul 2018 09:34:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arve@android.com, tkjos@android.com,
        maco@android.com, rlove@google.com, ben@decadent.org.uk
Subject: Re: [RFC PATCH 0/4] file: export functions for binder module
Message-ID: <20180730163452.GE27761@infradead.org>
References: <20180730143710.14413-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730143710.14413-1-christian@brauner.io>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:37:06PM +0200, Christian Brauner wrote:
> Hey,
> 
> We currently plan on turning the Android binder and ashmem driver into a
> module. We have seen more and more requests by users to be able to use
> the binder and ashmem features without wanting to convince each distro
> to enable it by default in their kernel. Debian already started to carry
> patches for turning them into modules.

Yikes.  I really wish Debian would stick more to upstream rather than
picking random crap like this up.
