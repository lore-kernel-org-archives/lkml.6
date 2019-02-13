Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A39C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C942085A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qGrkOHz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392041AbfBMU0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:26:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbfBMU0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fuyNjv+gA9Cpq0mS7d0DHpZNnRQ2StHPyhGiej79BQg=; b=qGrkOHz8qJCrWPVjL5jQPDQgS
        USOcI7mUSjEYxD36Eb4n+vEdFCMwhKc4EJKz1DDMC41pa7aa1qsVPetZT1FFYL7dxi59Zx8XHVeC7
        KBVChej3yiTi1dXFRaSPrWwsAH0ArhoXNVBYOuMpLzecL25EQ8+dXWQ16KQgwmAghhqaCImMA4giT
        brascUu2N5+MOPcWY+D4CHjsyvEV39+djsXMMlU3wct/HNkpiV8Nm0xZNzy76PcTGdXKbLDF3oC5P
        oiLhBL6ZAwgqRj0Fd+WyTLfvmLwgAOPtc+PezbKIGXD92zr0GnfTwRqGcndeHl5GoBs0kp7SzGBl6
        VnjE3xRgQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gu16l-0007Kp-LX; Wed, 13 Feb 2019 20:26:16 +0000
Date:   Wed, 13 Feb 2019 12:26:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guroan@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] vmalloc enhancements
Message-ID: <20190213202614.GV12668@bombadil.infradead.org>
References: <20190212175648.28738-1-guro@fb.com>
 <20190212184724.GA18339@cmpxchg.org>
 <20190212123409.7ed5c34d68466dbd8b7013a3@linux-foundation.org>
 <20190212223605.GA15979@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212223605.GA15979@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:36:12PM +0000, Roman Gushchin wrote:
> On Tue, Feb 12, 2019 at 12:34:09PM -0800, Andrew Morton wrote:
> > On Tue, 12 Feb 2019 13:47:24 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > I don't understand what prompted this change to percpu counters.
> 
> I *think*, I see some performance difference, but it's barely measurable
> in my setup. Also as I remember, Matthew was asking why not percpu here.
> So if everybody prefers a global atomic, I'm fine with either.

I was asking why you were using an accessor instead of a direct reference
to the atomic_long_t.

