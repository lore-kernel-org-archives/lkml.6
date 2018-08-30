Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2024CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09F9205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EooD3sNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09F9205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeH3Set (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:34:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeH3Set (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=EooD3sNgpMUoliUDnYouQ+7FA
        Y66NkZau3y8UdnlydVRNfwg0+/gBA9bsLgB3CTS82rA2p3Ko5E34+U16mX6nxmlNeKJVbpXYZe8vW
        BS8skYPeZjEowOtF/AH6Osq0P/pVj/oECPXSzTHOOtKWZPRJitAkJlgvdx53MMrzVw8a/qyPgXPfH
        M+yzQWvRJbuXGHIWhC5nONM+s/9ZtmIf8qB3RNJiFtB9GXCuoJtzegbCFFW71iJhK1e+wW5YZpb6G
        z8EO7fdN/rmZ8jHWndURIcw3VQXsZJpWcPMM22F3RQxGb/Px2OR5oW6YIUkJd+QQYgdGyz0mWHcai
        CwOXU340w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvNzj-000382-Cg; Thu, 30 Aug 2018 14:32:23 +0000
Date:   Thu, 30 Aug 2018 07:32:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, vincentc@andestech.com,
        zong@andestech.com, nickhu@andestech.com, greentime@andestech.com
Subject: Re: [PATCH 5/5] Auto-detect whether a FPU exists
Message-ID: <20180830143223.GB11544@infradead.org>
References: <1535332075-5727-1-git-send-email-alankao@andestech.com>
 <1535332075-5727-6-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535332075-5727-6-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
