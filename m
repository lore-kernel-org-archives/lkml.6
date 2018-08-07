Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D4C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B10121654
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p4ZAnfFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B10121654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403913AbeHGUEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:04:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388540AbeHGUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7xISR7QOGxyQECrlqt6pc1xW9EyruhT8m4Iim2nt0kE=; b=p4ZAnfFKX8gONeDPlSl/gfu3C
        ng+1IC3kyJ1P+nKEzyF6J6K5gmVHABtjk1ox5mO4rgplVQ1C1fbNi037KFO4hQ0SgZFD4FSMisv6h
        yYLFMN6oegs3ZCPSykSiaoPdcUZ++6MlJU2RrwIV1TNc8ytrfbJMByQgwyzXk4KpyZCn2Y+knl9bI
        wbCweAUNkiXdmMp1nu43Cld6ZYl2iPFwXKsTGAJ5yT/02yAD5rAZKB+dnGd5wUJnGlUCfr9/HjaeV
        V6S5GXfaYkeoE598BMPhRF+a8I2YiMMx0Ymu6rDKLuIJYLSrnXjc4lzVhOCPMddVctDWM6Rgvk1hF
        9dLTdh2AA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fn66H-0003Ch-8e; Tue, 07 Aug 2018 17:48:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DC922058813B; Tue,  7 Aug 2018 19:48:51 +0200 (CEST)
Date:   Tue, 7 Aug 2018 19:48:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     kan.liang@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
        len.brown@intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
Message-ID: <20180807174851.GJ2494@hirez.programming.kicks-ass.net>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
 <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:35:42AM -0700, Dave Hansen wrote:
> On 08/07/2018 10:17 AM, kan.liang@linux.intel.com wrote:
> > Denverton and Gemini Lake are platform names and should not be used for
> > Processor Family stuff. The microarchitecture codename should be used.
> 
> Why?
> 
> Denverton is the platform.  "Goldmont" is literally the
> microarchitecture, and you are suggesting moving *to* the
> microarchitecture name, which contradicts the description.

All the other (big core) are uarch names. Atom is weird in that it mixes
uarch with platform names.
