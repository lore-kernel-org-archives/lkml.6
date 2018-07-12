Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82207C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C02520BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HEcihj15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C02520BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeGLIfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:35:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeGLIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A3p39y8aA3sVLeA7QmYGcOzlRAS9Lp/mO4/efZWr3Uo=; b=HEcihj15dahPicLcbGy+JKTYr
        EyJ1NkXMYA53qq6/FqV2fmFW4sfayP/A6rWv5hEhTlEuUdkNpAFdVQ7+mmNlBFgY6owaBcyOiXSpR
        AXEc0tHIRDWeKNs2ONI1+fLe89oYFg1T8Hl3bwdO+rtkcmaWLKg/r7j/CxHvQw1dfuhxfy8/3ZWqK
        Uo86QvCiBUmVDeN4yhfLI2VmNtZWd4O1rHvhZE13koQX3gYkUOZpO/Rzip5JWmWUk92jF9Xj+AK6m
        J8SmnSU0Uy3c9kF7mLsEX0xf9gr8OCJj1A+kWjkpssL30YyqkwyJT6O0Ry4oUdwi3rHiNI83BIiLm
        1ByYwgcSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdWwN-0006do-SH; Thu, 12 Jul 2018 08:27:07 +0000
Date:   Thu, 12 Jul 2018 01:27:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, linux-alpha@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/7] timex: use __kernel_timex internally
Message-ID: <20180712082707.GC8802@infradead.org>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
 <20180707054247.19802-7-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707054247.19802-7-deepa.kernel@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:42:46PM -0700, Deepa Dinamani wrote:
> struct timex is not y2038 safe.
> Replace all uses of timex with y2038 safe __kernel_timex.
> 
> Note that struct __kernel_timex is an ABI interface definition.

If it actually is an ABI interface it should probably have a different
name.
