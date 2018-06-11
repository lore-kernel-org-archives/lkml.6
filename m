Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4nnwNseiHlsLUgAAmS7hNA
	; Mon, 11 Jun 2018 16:27:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 92C5B60792; Mon, 11 Jun 2018 16:27:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fPPryOmX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2B756601C3;
	Mon, 11 Jun 2018 16:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B756601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeFKQ1X (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:27:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933516AbeFKQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ihGRt8QxCTlIlzeUYpX6t/h6/j616goijrmy5fzrXC4=; b=fPPryOmXISmRWDFmLLCDSnAfg
        x4OCWocx/mEQJCMMtVqoKS8Hal8W4/mY5LV/RPzgaab8DuCyHhV1j1v7pZgRws4ty3XoO7bTMzSVN
        R18iZPRUNLrMuQSaEsTHnHnuxBpCIgeO8J0T0NdJRdgNf7JpA0hAnzKmqMEeGFpOC5Ws+41QOjI01
        Kdb9P0dvbBzmxBhB28l6mMBPOp4Mx0MMNNMuxVL42G+kC/4+E5eL5xZ2dNR9x0oVRpoQOJx8+rntC
        vVVf1Tkb4T0ijg/9oHD8EDJ28FNo8prC4dfI+N2Hy7RJJloIxadSd+JgVmtyrcTKgkpLuS0eMBPdP
        5TXlvaoXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSPf5-0005sw-PF; Mon, 11 Jun 2018 16:27:19 +0000
Date: Mon, 11 Jun 2018 09:27:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180611162719.GA18821@infradead.org>
References: <20180608121330.GG23785@veci.piliscsaba.redhat.com>
 <20180609065208.GA31572@infradead.org>
 <20180610055326.GR30522@ZenIV.linux.org.uk>
 <CAJfpeguG9urECaKoeiOBQLNyEFRFieg484ixWhaqtzhrGsASgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguG9urECaKoeiOBQLNyEFRFieg484ixWhaqtzhrGsASgQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:41:29AM +0200, Miklos Szeredi wrote:
> Linus, would you still pull if Al's satisfied with that resolution?
> I can post the fixes (just few liners) after the merge window.

Please repost all changes outside overlayfs itself to -fsdevel so
that we can improve them for merging in the next merge window instead
of hasting them in now.
