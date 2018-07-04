Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D0FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23761241E8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F3sHjP26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23761241E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeGDWyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 18:54:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbeGDWyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 18:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FV8oA7HHGjL2Zbs2ukEX47uvEE/59qQicEYRYK6EcQ0=; b=F3sHjP26IDNrXNlHTAdUk7Lc0
        aYqms8YR75NfgYeAy5sNexJOzuC1bMFhfAkuwNU/YN5f0/pGWJ6ApbYtZgfQDGKYXRRybgnvOSUAy
        Bw/xxkcUa7EIoNVjU0GwiDc0fqBkIkbzCSsWHBbDq/sso1rR81izzneJ4ctyBbgOE1hTqiV7AEQZK
        Tst/ca+tYezVBw+ozGXnpljydeGeMeyht+Vg0TMn57YlcXRLO33NI/YzZ15QG+nuzjZmvpeyFphoI
        5b5L9MtIU5qjeOaJzYqw4khaqh0AhXdcY3yL8osH2ZrEUpuQHwAA5khJ1lmtqRi0G/8lLl7nSTMkD
        nn+Ya3sIQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faqfP-0007wO-I0; Wed, 04 Jul 2018 22:54:31 +0000
Date:   Wed, 4 Jul 2018 15:54:31 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: XArray -next inclusion request
Message-ID: <20180704225431.GA16309@bombadil.infradead.org>
References: <20180617021521.GA18455@bombadil.infradead.org>
 <20180617134104.68c24ffc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617134104.68c24ffc@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 01:41:04PM +1000, Stephen Rothwell wrote:
> Hi Willy,
> 
> On Sat, 16 Jun 2018 19:15:22 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Please add
> > 
> > git://git.infradead.org/users/willy/linux-dax.git xarray
> > 
> > to linux-next.  It is based on -rc1.  You will find some conflicts
> > against Dan's current patches to DAX; these are all resolved correctly
> > in the xarray-20180615 branch which is based on next-20180615.
> 
> Added from tomorrow.

Thanks!  I have some additional patches for the IDA that I'd like to
send to Linus as a separate pull request.  Unfortunately, they conflict with
the XArray patches, so I've done them as a separate branch in the same tree:

git://git.infradead.org/users/willy/linux-dax.git ida

Would you prefer to add them as a separate branch to linux-next (to be
pulled after xarray), or would you prefer to replace the xarray pull
with the ida pull?  Either way, you'll get the same commits as the ida
branch is based off the xarray branch.
