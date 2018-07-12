Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF54EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BFE20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z7NKZ7q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BFE20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGLNGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:06:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeGLNGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PFqRZSwZuB8PYF+DF55HH4G8rZI5RYctstBRPX3D0Uo=; b=Z7NKZ7q4QFoH9RlXKBpNPyvHY
        8E2yIgwfVZCbbTVhEzRD5EGH4GFUMcL3woMi8iRCmDIUO9Xonq13f7J3CAt3iRpBNAAIvuhvfKc3Z
        piA+miIiK1q+gqO+MRoNETNrmAOLCe1uHY74lg8tQWVdOZEDeik70T/SI3mYdUZidhS5leGJ103Pj
        pa1gucxrJuseHLdIGdiFOPKQGWSj/MNLoJPgVFSwaoqKCqK09IDycRhtAL7/6w9WhUg8Cfv1ZfRhM
        RN/DoUJydmEN2uM4WA2AGq/m8AeeRS0J//Vs+KCOReKMM+nBgXdeuVqRq/Jql3P6V6ehwSUBGOHbY
        tztHhQgVQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdb9k-0000iK-2F; Thu, 12 Jul 2018 12:57:12 +0000
Date:   Thu, 12 Jul 2018 05:57:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     corbet@lwn.net, christophe.jaillet@wanadoo.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bug-hunting.rst: Clarify bytes sequence format when
 making "Code:" human-readable
Message-ID: <20180712125711.GB15277@bombadil.infradead.org>
References: <153138515186.6379.2711739561825941424.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153138515186.6379.2711739561825941424.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:46:25AM +0300, Kirill Tkhai wrote:
> Bytes have to be separated commas, and this is not obvious
> for a person, who does not write in pure ".byte" assembler.
> Let's clarify this and make visible for people.

Can we delete the entire section and say "run ./scripts/decodecode"
instead?
