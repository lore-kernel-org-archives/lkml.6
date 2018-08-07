Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4534216EE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DvhdA5Ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4534216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbeHGTt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:49:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbeHGTt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1+livEpu000xNh/S+ZwF2RKwU3FaSOHghrFP/yUsZFM=; b=DvhdA5IxLcstZ9sWa3WJ8dgAA
        +dbJoq7Qa0F53kJ1m/gao6Lr8nNBIJGb8CbPBAGvoXcf9Op/p7dX9tDLmZhuFRPQu1DQTK3sexB56
        BD0ec6kiDgOqtnUj8eMS9kfOq1dN/f3Z5N5sA7Do2WE7L3IhmAz/zZMuWDxNqVCEJjlc8JZLiFKG1
        sDXlBI2ugLz+pL28fpiPOQPEKP23+xW1EKCZ3kTJ3BMtZ+RV1vUod9xFbvw2T8pRAYt5uvzjoQXiC
        /WNuCVsyn2cHWujEomo7TQdrqqr6k5Xrf6wqaGdmpgV/p5KuVZbjokPY/oJ/Wdleb6hFRkY9xbPyY
        ouJGiuxDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fn5sI-0001ng-5s; Tue, 07 Aug 2018 17:34:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2A782058813C; Tue,  7 Aug 2018 19:34:24 +0200 (CEST)
Date:   Tue, 7 Aug 2018 19:34:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        len.brown@intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
Message-ID: <20180807173424.GH2494@hirez.programming.kicks-ass.net>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:17:27AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Denverton and Gemini Lake are platform names and should not be used for
> Processor Family stuff. The microarchitecture codename should be used.
> 
> DENVERTON is Goldmont server SoC. Rename DENVERTON to GOLDMONT2, similar
> to SILVERMONT2 being the silvermont server SoCs.
> 
> Rename GEMINI_LAKE to GOLDMONT_PLUS.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Thanks! the alternative to 2 is _X like we have with the big cores to
denote server chips, but this is already a nice improvement.
