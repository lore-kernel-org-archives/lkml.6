Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BFE16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46C120870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYSqcDXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46C120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbeG3SIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:08:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeG3SIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bTfDzwZyZnXzpXueRbgYjm/0lnZsq4/nyMfoI+GhAcQ=; b=AYSqcDXXkkc7P7Z1VlKiWG/dE
        ptkxrLOKjMupqYeyvJA9lM+ZtzmExR4nRtwop477hW0fRzLH4TLTzDrw3oS1ebRddovBDKgcvgU8N
        PT14a2bQCT6/mFmF1Lfrsqy6nUW3KW/ju1d2m3DNANtjzF38qWUU3HSKZH29w+9yRdb4/5gMny3im
        5X0zDJ2+pEi7wIrwqx4KS3XIGyozO9Ay4uGqAzUeuxnt98RGha2I3wQfXkO57merWzOHI/UZ3wp+5
        DUrKR7ww/OCSyE5yEuomRa3/Y/kR3fXgl/9UmfjThfBXUweVfrNdIT4ZgdmjyIaYrGKger/sw+2Qa
        iRrSon2bQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkB5z-0001Gj-ST; Mon, 30 Jul 2018 16:32:31 +0000
Date:   Mon, 30 Jul 2018 09:32:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arve@android.com, tkjos@android.com,
        maco@android.com, rlove@google.com, ben@decadent.org.uk
Subject: Re: [PATCH 2/4] file: export __fd_install()
Message-ID: <20180730163231.GB27761@infradead.org>
References: <20180730143710.14413-1-christian@brauner.io>
 <20180730143710.14413-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730143710.14413-3-christian@brauner.io>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:37:08PM +0200, Christian Brauner wrote:
> The Android binder driver will be turned into a module. Since it
> uses __fd_install() we need to export this function.

Same as the previous one.  No driver should be pooking this deep
into fd internals (not even non-modular ones for that matter).
