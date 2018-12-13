Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E43C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A6020849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YM6QXjkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A6020849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeLMOlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:41:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MuLIODc8lAkCTdglzl626DzKhFKlNDRph8viRI9Of9s=; b=YM6QXjkj+8ShnNwjFjqWhQb1a
        cS+ujdq4KMznS+4cK4PNgdG4qbfd+AZyeW7ZCeE5aaI9SxIkzoaGcOAtfk89MZOI0rfQ4QEzMZfrL
        Gu2XqNosdluoSa0i5rozkgs0aDI1x0Qx9m4+1qT39BldwY0HN4uqvMhcdaH4iYoyN3IC5kuWNyeI1
        Apb0GSIOM1VSPGTekwywVXjhwd/Ieyc9yVSkL/NQ+ozSj7ffnIUjX1wGAONTWH/BY76mK4t34hGja
        BK9yZ9aJXhcaqis8s/5qdQ6IdfQYdSPVIoqQg3n2noDn38fJVIFKVFlkYIBpkOiNVv1PgXwGPRenO
        LD0vjy1+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSAp-0002yV-Eg; Thu, 13 Dec 2018 14:41:11 +0000
Date:   Thu, 13 Dec 2018 06:41:11 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     kent.overstreet@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        dave.hansen@intel.com, davem <davem@davemloft.net>,
        Neil Horman <nhorman@tuxdriver.com>,
        Oleg Babin <obabin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 6/6] Drop flex_arrays
Message-ID: <20181213144111.GO6830@bombadil.infradead.org>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-7-kent.overstreet@gmail.com>
 <CADvbK_ccPYY5jGRV+cLNc5Nzcfv0mq0eNMeU-ALvepax0ZSizQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_ccPYY5jGRV+cLNc5Nzcfv0mq0eNMeU-ALvepax0ZSizQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 09:30:47PM +0900, Xin Long wrote:
> On Sat, Sep 8, 2018 at 1:57 AM Kent Overstreet
> <kent.overstreet@gmail.com> wrote:
> >
> > All existing users have been converted to generic radix trees
> NAK, SCTP is still using flex_arrays,
> # grep flex_array net/sctp/*
> 
> This patch will break the build.

sctp added that user after this patch was sent.  Please stop adding
flexarray users!

This particular user should probably have just used kvmalloc.
