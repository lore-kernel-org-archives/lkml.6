Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EBEC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7908B2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7908B2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeGZJWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:22:12 -0400
Received: from verein.lst.de ([213.95.11.211]:35245 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbeGZJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:22:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7CE8768D64; Thu, 26 Jul 2018 10:10:15 +0200 (CEST)
Date:   Thu, 26 Jul 2018 10:10:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com
Subject: Re: [PATCH 1/6] RISC-V: simplify software interrupt / IPI code
Message-ID: <20180726081015.GA22702@lst.de>
References: <20180725093649.32332-2-hch@lst.de> <mhng-03f673cd-5779-44c6-98b3-657e5c4b9d39@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-03f673cd-5779-44c6-98b3-657e5c4b9d39@palmer-si-x1c4>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 02:44:32PM -0700, Palmer Dabbelt wrote:
> I think it's probably easier to have the whole patch set go through the IRQ
> tree, so I won't put these in the RISC-V tree unless someone says something.

No matter where it goes it probably makes sense to keep the whole
series together..
