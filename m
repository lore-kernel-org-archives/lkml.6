Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9694EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E22B2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UXsH13Ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfBUB3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:29:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfBUB3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4HZgtpsrSs4fFKQmQiJSvo6NH/0dfEr00uqHpZ4RjLc=; b=UXsH13KyaXt6Z6tttgx7v5ZFn
        gbY0aTdOq0CcvHthhM9f6lCWrX2B9GC9NDaHGk+bvlW539EjG/3NPcB1zpRRNpIKXbDCsUAf6v2pZ
        3kGvTct28qXMTNMqHLCmKU/0J66KVDUeCwB0yTsDB7D4jqdYwgcTQCCyZsNkZA4kYMC6B2p9XxkjA
        VB+BsMDj7O8V8sAou7L1VXxtGLtHQQ/IFI2TI8caal1apqvCFTLoD/KA4L7yTDqnySchS8ELAgoRy
        UwEW403bqNe4KOhbWs/shEe2XSMK87FEtYvucX6z1UbzrzICbjF8JeQcz1mc9X+Wbr0rCmOnjauQA
        ESZarMRkQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwdBN-0002Oq-3F; Thu, 21 Feb 2019 01:29:49 +0000
Date:   Wed, 20 Feb 2019 17:29:47 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mattias Jacobsson <2pi@mok.nu>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: wmi: fix potential null pointer
 dereference
Message-ID: <20190221012947.GD5838@wrath>
References: <20190130151424.28140-1-2pi@mok.nu>
 <CAHp75VfHDN7Q1YjFd7XM8tFpCcPphaDm0fvOaxHzko5AvF6jEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfHDN7Q1YjFd7XM8tFpCcPphaDm0fvOaxHzko5AvF6jEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 05:43:34PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 30, 2019 at 5:15 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> >
> > In the function wmi_dev_match() the variable id is dereferenced without
> > first performing a NULL check. The variable can for example be NULL if
> > a WMI driver is registered without specifying the id_table field in
> > struct wmi_driver.
> >
> > Add a NULL check and return that the driver can't handle the device if
> > the variable is NULL.
> >
> 
> Good for me, thanks!

Queued for testing, thanks Mattias.

-- 
Darren Hart
VMware Open Source Technology Center
