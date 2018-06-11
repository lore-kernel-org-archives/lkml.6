Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ++9SFVESHltnWQAAmS7hNA
	; Mon, 11 Jun 2018 06:11:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 128F7605A5; Mon, 11 Jun 2018 06:11:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PuhRKnJM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 919EA605A5;
	Mon, 11 Jun 2018 06:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 919EA605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeFKGK6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:10:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753947AbeFKGK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B0Ytr8MdUc7d2tnWcqI3Rwy6q/Sb9E/xp1O8o8Z/lT4=; b=PuhRKnJMhAK5nhnsW8LgKKbCy
        pLLuRZvDTJJ/+dI4CCmnQxymZvCejoQiC/WFt4p4J4+pQVHI5Tpm5NmDgIE4C+43rutHMLFllHxXe
        OF5b6ncJTjLXueoD8M/xF9UWLpoxO93GYa31/FDAi39l4cBX1Bsnm7eVGV3V/i5u8q00ZSdAH9f//
        iZKq6GiFA+JP8K2Kx5kmNzL75kQ67DzXbhHyLYRRAIIaDfTRV5rGd246TpZjcFxEbp3tKvcHn2ac3
        kr122YTFbUZANdKLMqFRjCuQvw79KX3MXZBdk1gn7ZAXZbD3t+1kIoF5eVpScqeOHUJRPpxYVjw9k
        KWP30Sbdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSG2Y-0004i6-SI; Mon, 11 Jun 2018 06:10:54 +0000
Date: Sun, 10 Jun 2018 23:10:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180611061054.GB8048@infradead.org>
References: <20180608121330.GG23785@veci.piliscsaba.redhat.com>
 <20180609065208.GA31572@infradead.org>
 <20180610055326.GR30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610055326.GR30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 06:54:38AM +0100, Al Viro wrote:
> Umm...  The worst of yours had been ->pre_mmap(), right?  He *did* drop that...

Oh, hadn't notied that.  Still odd to change a huge pull request after
the end merge window.
