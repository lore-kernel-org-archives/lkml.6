Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5DFECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB132151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qpV2h9Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB132151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJQQtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:49:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeJQQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G6SwurhQdUCTexTiBt8HGTR2VUSICdTmVYz7GqD1foc=; b=qpV2h9OdIkVTjgRI1u9iJh+Mr6
        Hn8UL/aT7upkQ18XKB9uBuSQTNtVGHJ9fkCoMjghD8LqhREj+DWwf4yzSPFEuNRL7NWzpDXVEpbPL
        nux7IxfZZlye6I8231fk2J40gms9ijjK7ObQnqgZf+qc8MpAtd3l6fDdLws2SfYg60X9dMFPQH7AQ
        M2m43UU4Ahwkah/O+CgE1/HBstQ9/McobWrnwH8BO0BGLm0KMZR4WUvd6UiGObOAztzUGCt71Ipzy
        ef+yxhUIky0/XL1hDZnGKUrzFPN2L+h8rtCD32ayvMV+mUxpWQy1Y5k8rW9wnBaJDWj53gScfy1ae
        +hWwjcbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gChbR-0001FO-Vx; Wed, 17 Oct 2018 08:54:54 +0000
Date:   Wed, 17 Oct 2018 01:54:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Woodruff, Robert J" <robert.j.woodruff@intel.com>
Cc:     james harvey <jamespharvey20@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nikhil Rao <nikhil.rao@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: rdma-core doesn't install driver.h, broke libibscif
Message-ID: <20181017085453.GA30496@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9C6B67F36DCAFC479B1CF6A967258A8CAB401945@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 05:53:44PM +0000, Woodruff, Robert J wrote:
> James Harvey wrote,
> 
> >Short: Is libibscif dead, and should OS repositories remove it?
> 
> Libibscif is for an old product,  Intel's KNC, that is no longer sold and the S/W is frozen. The open source libibscif is no longer maintained. 
> It has already been removed from the latest community OFED distribution. The individual package on the OFA downloads is for archive purposed only.

Does this mean we can kill the kernel scif code as well?  It is a
pretty horrible codebase that gets in the way a lot (and hasn't really
seen updates since the initial merge).
