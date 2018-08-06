Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2010C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A8921A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W++yPtxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A8921A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbeHFSbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:31:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732552AbeHFSbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mY6N3i18Md8e7Exm6+Y+fP+dGAmHF4nb1uxOP7DEhrM=; b=W++yPtxZskQ2Qc8Zq+fsXGS1X
        1YRr+/aaxDRpIqnWtp4e+blb7i60Z596KutBw7rlXM/BnKWpcFlYNtHnMwJiyLAyk5hFXVlEKa5bf
        IOVACohfFaMbVSyjDSCwtatTK3XLnON3L6KyAQBegRJHXRnGwM7pZxfYiGDSRGjqP5MLuO9w2C+7m
        tFcLfFKFF8a/jE12Cw6a/X1XQxIa2eKEFcGKhRBj1Lw5XSgzqpkbJO7k6zjz08SOQ1aNIHVzAANGg
        DBLnNu/1RRPtePlNwMNu6P+G0AXxskQC4lYG3MQf9Ua0T0lepdeH+kzDIit5TYIZHsCorPS8dBmt/
        c6mE6lHYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmiGX-0007Pt-Iw; Mon, 06 Aug 2018 16:21:53 +0000
Date:   Mon, 6 Aug 2018 09:21:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Petr Oros <poros@redhat.com>
Cc:     netdev@vger.kernel.org, ivecera@redhat.com,
        Sathya Perla <sathya.perla@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use Kconfig flag to remove support of deprecated BE2/BE3
 adapters
Message-ID: <20180806162153.GA22040@infradead.org>
References: <20180806121230.23690-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806121230.23690-1-poros@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:12:28PM +0200, Petr Oros wrote:
>   Add flags to remove support of deprecated BE2/BE3 adapters.
>   BE2 disable will reduce .ko size by 2kb and BE3 by 3kb.
>   Disable both will reduce .ko size by 9kb.
> 
>   With dissabled support is also removed coresponding PCI IDs
>   and codepath with [BE2|BE3|BEx]_chip checks.

deprecated seems like a really odd world for hardware.

Are they just old?  Did they never ship in large numbers?

If you just make some cards optional why not also add options
for families of newer cards for those who only have the older ones
in their systems?
