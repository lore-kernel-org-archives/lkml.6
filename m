Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45530C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86E325E4C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VbzXGfv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86E325E4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeGBOGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:06:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbeGBOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vLXJcKZ7qK0qNmmFV1O42QGe7yw+pnqEC00aODFEyAU=; b=VbzXGfv9lISi7/lsV+yf4wD8Q
        uT8KjUjrJNWg7cytRbNj6L7yWhEP+h7ZHFJDC6WDHbe+IUsAh9o8TKfLjEkmpgDti3Gwm21aTvdjs
        u+x4U8wilseqJWs0h07cd114uUlrsjy5lXExY8fgasc5JhnZqBww+3zyKtBubnlZpyo+IDtK86Gqt
        Ag3oAJjw7aQ+8PtVjVflbeB/T7yXkGl/DZkxV5X8gVNP+IWoezKY9hx41wZuFdoLYV+w/4owAyuQl
        OQ5/0JuBfu4N2b21BZn8qQJD/x9UyWcVlE7RqAXvIQcQ3bF2y/yw59GtVbeDUref+82xVpj5yylbU
        46GfKXfuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZzT3-00043t-C9; Mon, 02 Jul 2018 14:06:13 +0000
Date:   Mon, 2 Jul 2018 07:06:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH] x86: make Memory Management options more visible
Message-ID: <20180702140612.GA7333@infradead.org>
References: <af12c83d-2533-ae00-b53c-1fc1a9d8e9ce@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af12c83d-2533-ae00-b53c-1fc1a9d8e9ce@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 07:48:38PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Currently for x86, the "Memory Management" kconfig options are
> displayed under "Processor type and features."  This tends to
> make them hidden or difficult to find.
> 
> This patch makes Memory Managment options a first-class menu by moving
> it away from "Processor type and features" and into the main menu.
> 
> Also clarify "endmenu" lines with '#' comments of their respective
> menu names, just to help people who are reading or editing the
> Kconfig file.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Hmm, can you take off from this for now and/or rebase it on top of
this series:

	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/kconfig-cleanups
