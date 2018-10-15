Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D771C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7B42064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+POn9Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7B42064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeJORht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:37:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJORhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mTQ6pZ4l1uU8DzauFutWz38JLjbfCNiYq45hQdIbylI=; b=p+POn9Sq3u8TH0eBS7I0wK6/T
        pDnCVLZoUZoUUT7VlIVfqco0yNaURUjB1jwb7/TaG2DOzA0kEhtjzMlHRi44WVuDfQAUQd4jZ0gHM
        lzqRPQwYhZAQufa53ZYgBRHKwSGgsjUwuP+Z3FpOIDiW1WikEqDfpMnW2THyxA1tG9QSuvKWhTV2d
        VaE8IXIq9OK5aeGQPJ93Sw3DsyJ4HAHjPBM1c9gZt0t7UlF2nZ4xZAtmD3369gs1Q9tY48pRLPYSm
        g2GZKfMFyheVSyjR2A5c689F61KFIVlv/m1Yv6rccFj6DmmTpNoUYcpGEcfLDIKguMczw3FB5izD0
        Q3MKDoWAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBzYo-0005ui-TB; Mon, 15 Oct 2018 09:53:14 +0000
Date:   Mon, 15 Oct 2018 02:53:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 1/2] LICENSES: Add note to CDDL-1.0 license that it
 should not be used
Message-ID: <20181015095314.GA14428@infradead.org>
References: <20181010110540.22468-1-hdegoede@redhat.com>
 <alpine.DEB.2.21.1810101518050.15060@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810101518050.15060@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:23:07PM +0200, Thomas Gleixner wrote:
> I'd rather replace the 'GPL-2.0' with something like '$GPL-COMPATIBLE-ID'
> and say explicitely in the prosa text that CCDL can only be used with OR
> and not with AND.

Maybe we should take the whole thing to a higher level, and split
the other folder into

legacy/
 - for licenses that exist but should never be used for new code

and

dual/
 - for licenses that should only be used for dual licensing with
   something from preferred/
